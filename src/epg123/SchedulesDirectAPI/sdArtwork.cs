﻿using System;
using System.Collections.Generic;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace epg123.SchedulesDirectAPI
{
    public class sdArtworkResponse
    {
        [JsonProperty("programID")]
        public string ProgramId { get; set; }

        [JsonProperty("data")]
        [JsonConverter(typeof(SingleOrArrayConverter<sdImage>))]
        public IList<sdImage> Data { get; set; }
    }

    public class sdImage
    {
        [JsonProperty("width")]
        public int Width { get; set; }

        [JsonProperty("height")]
        public int Height { get; set; }

        [JsonProperty("uri")]
        public string Uri { get; set; }

        [JsonProperty("size")]
        public string Size { get; set; }

        [JsonProperty("aspect")]
        public string Aspect { get; set; }

        [JsonProperty("category")]
        public string Category { get; set; }

        //[JsonProperty("text")]
        //public string Text { get; set; }

        //[JsonProperty("primary")]
        //public string Primary { get; set; }

        [JsonProperty("tier")]
        public string Tier { get; set; }
    }

    class SingleOrArrayConverter<T> : JsonConverter
    {
        public override bool CanConvert(Type objectType)
        {
            return (objectType == typeof(List<T>));
        }

        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            var token = JToken.Load(reader);
            return token.Type == JTokenType.Array ? token.ToObject<List<T>>() : new List<T> { token.ToObject<T>() };
        }

        public override bool CanWrite => false;

        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            throw new NotImplementedException();
        }
    }
}
