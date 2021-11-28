﻿using System;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Windows.Forms;
using System.Xml;
using System.Xml.Serialization;
using epg123;
using epg123Client.SatMxf;
using Microsoft.MediaCenter.Guide;

namespace epg123Client
{
    public partial class frmSatellites : Form
    {
        public frmSatellites()
        {
            InitializeComponent();
        }

        private void btnCreateDefault_Click(object sender, EventArgs e)
        {
            Cursor = Cursors.WaitCursor;
            var mxf = new Mxf();
            foreach (MergedChannel mergedChannel in WmcStore.WmcMergedLineup.UncachedChannels)
            {
                if (mergedChannel.UserBlockedState > UserBlockedState.Enabled && cbEnabled.Checked) continue;
                mxf.AddChannel(mergedChannel, cbRadio.Checked, cbEncrypted.Checked);
            }

            // create the temporary mxf file
            using (var stream = new StreamWriter(Helper.DefaultSatellitesPath, false, Encoding.UTF8))
            using (var writer = XmlWriter.Create(stream, new XmlWriterSettings { Indent = true }))
            {
                var serializer = new XmlSerializer(typeof(Mxf));
                var ns = new XmlSerializerNamespaces();
                ns.Add("", "");
                serializer.Serialize(writer, mxf, ns);
            }
            Cursor = Cursors.Arrow;
        }

        private void btnTransponders_Click(object sender, EventArgs e)
        {
            Cursor = Cursors.WaitCursor;
            WmcUtilities.UpdateDvbsTransponders(true);
            Cursor = Cursors.Arrow;
        }

        private void btnImport_Click(object sender, EventArgs e)
        {
            Cursor = Cursors.WaitCursor;
            WmcUtilities.UpdateDvbsTransponders();
            Cursor = Cursors.Arrow;
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            linkLabel1.LinkVisited = true;
            Process.Start("http://satellites-xml.org");
        }
    }
}
