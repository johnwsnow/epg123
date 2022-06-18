﻿using System;
using System.Drawing;
using System.IO;
using System.Windows.Forms;
using epg123;

namespace logViewer
{
    public partial class frmViewer : Form
    {
        private long streamLocation;
        private string _filename;
        private string _lastPath;

        public frmViewer(string filename = null)
        {
            _filename = filename;
            InitializeComponent();

            // copy over window size and location from previous version if needed
            if (Properties.Settings.Default.UpgradeRequired)
            {
                Properties.Settings.Default.Upgrade();
                Properties.Settings.Default.UpgradeRequired = false;
                Properties.Settings.Default.Save();
            }

            // restore window position and size
            if ((Properties.Settings.Default.WindowLocation != new Point(-1, -1)))
            {
                Location = Properties.Settings.Default.WindowLocation;
            }

            Size = Properties.Settings.Default.WindowSize;
            if (Properties.Settings.Default.WindowMaximized)
            {
                WindowState = FormWindowState.Maximized;
            }

            richTextBox1.ZoomFactor = Properties.Settings.Default.ZoomFactor;

            Helper.EstablishFileFolderPaths();
        }

        private void OpenLogFileAndDisplay(string logFile)
        {
            this.Cursor = Cursors.WaitCursor;
            richTextBox1.Hide();
            var zoom = richTextBox1.ZoomFactor;
            richTextBox1.Clear();
            richTextBox1.ZoomFactor = 1.0f;
            richTextBox1.ZoomFactor = zoom;
            streamLocation = 0;
            DisplayLogFile(logFile);
            richTextBox1.Show();
            this.Cursor = Cursors.Default;
        }

        private void DisplayLogFile(string logFile)
        {
            var fi = new FileInfo(logFile);
            if (!fi.Exists) return;
            _lastPath = fileSystemWatcher1.Path = fi.DirectoryName;
            fileSystemWatcher1.Filter = fi.Name;

            try
            {
                using (var fs = new FileStream(logFile, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
                using (var sr = new StreamReader(fs))
                {
                    richTextBox1.SuspendLayout();
                    fs.Position = streamLocation;

                    // read the line
                    string line = null;
                    do
                    {
                        line = sr.ReadLine();
                        if (line == null) break;
                        if (line.Length < 2) continue;

                        // determine if within last 24 hours
                        if (!DateTime.TryParse(line.Substring(1, Math.Max(line.IndexOf(']') - 1, 0)), out DateTime dt) && richTextBox1.Text.Length == 0) continue;

                        // add line with color
                        if (line.Contains("[ERROR]") || dt == DateTime.MinValue)
                        {
                            richTextBox1.SelectionColor = Color.Red;
                        }
                        else if (line.Contains("[WARNG]") || line.ToLower().Contains("failed") || line.Contains("SD API WebException") || line.Contains("exception thrown") || line.Contains("SD responded") || line.Contains("Did not receive") || line.Contains("Problem occurred") || line.Contains("*****"))
                        {
                            richTextBox1.SelectionColor = Color.Yellow;
                        }
                        else if (line.Contains("==========") || line.Contains("Activating the") || line.Contains("Beginning"))
                        {
                            richTextBox1.SelectionColor = Color.White;
                        }
                        else if (line.Contains("Entering") || line.Contains("Exiting"))
                        {
                            richTextBox1.SelectionColor = Color.Cyan;
                        }
                        else
                        {
                            richTextBox1.SelectionColor = Color.ForestGreen;
                        }
                        richTextBox1.AppendText($"{line}\n");
                    }
                    while (line != null);

                    if (streamLocation > 0) richTextBox1.ScrollToCaret();
                    streamLocation = fs.Position;
                    richTextBox1.ResumeLayout();
                }
            }
            catch { }
        }

        private void copyToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (richTextBox1.SelectedText.Length == 0) richTextBox1.SelectAll();
            if (richTextBox1.SelectedText.Length > 0)
            {
                Clipboard.SetText(richTextBox1.SelectedText);
            }
        }

        private void richTextBox1_LinkClicked(object sender, LinkClickedEventArgs e)
        {
            System.Diagnostics.Process.Start(e.LinkText);
        }

        private void fileSystemWatcher1_Changed(object sender, FileSystemEventArgs e)
        {
            DisplayLogFile($"{fileSystemWatcher1.Path}\\{fileSystemWatcher1.Filter}");
        }

        private void openToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            openFileDialog1 = new OpenFileDialog()
            {
                FileName = "trace.log",
                Filter = "Log File|*.log",
                Title = "Select a log file to view",
                Multiselect = false,
                InitialDirectory = _lastPath
            };

            if (openFileDialog1.ShowDialog() == DialogResult.OK)
            {
                OpenLogFileAndDisplay(openFileDialog1.FileName);
            }
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            // save the windows size and location
            if (WindowState == FormWindowState.Normal)
            {
                Properties.Settings.Default.WindowLocation = Location;
                Properties.Settings.Default.WindowSize = Size;
            }
            else
            {
                Properties.Settings.Default.WindowLocation = RestoreBounds.Location;
                Properties.Settings.Default.WindowSize = RestoreBounds.Size;
            }
            Properties.Settings.Default.WindowMaximized = (WindowState == FormWindowState.Maximized);
            Properties.Settings.Default.ZoomFactor = richTextBox1.ZoomFactor;
            Properties.Settings.Default.Save();
        }

        private void frmViewer_Shown(object sender, EventArgs e)
        {
            this.Refresh();
            OpenLogFileAndDisplay(_filename ?? Helper.Epg123TraceLogPath);
        }

        private void richTextBox1_Resize(object sender, EventArgs e)
        {
            richTextBox1.ScrollToCaret();
        }

        private void richTextBox1_KeyDown(object sender, KeyEventArgs e)
        {
            if (Control.ModifierKeys == Keys.Control)
            {
                if (e.KeyCode == Keys.Add) { richTextBox1.ZoomFactor += 0.1f; richTextBox1.ScrollToCaret(); }
                if (e.KeyCode == Keys.Subtract) { richTextBox1.ZoomFactor -= 0.1f; richTextBox1.ScrollToCaret(); }
            }
            e.Handled = true;
        }
    }
}