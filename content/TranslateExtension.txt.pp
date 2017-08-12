﻿using System;
using System.ComponentModel;
using System.Reflection;
using System.Resources;
using Plugin.Multilingual;
using Xamarin.Forms;
using Xamarin.Forms.Xaml;

namespace $rootnamespace$.Helpers
{
	[ContentProperty("Text")]
	public class TranslateExtension : IMarkupExtension
	{
		const string ResourceId = "$rootnamespace$.AppResources";

		public string Text { get; set; }

        public object ProvideValue(IServiceProvider serviceProvider)
		{
			if (Text == null)
				return "";

			ResourceManager temp = new ResourceManager(ResourceId, typeof(TranslateExtension).GetTypeInfo().Assembly);
			var ci = CrossMultilingual.Current.CurrentCultureInfo;
			var translation = temp.GetString(Text, ci);
			if (translation == null)
			{
#if DEBUG
				throw new ArgumentException(
					String.Format("Key '{0}' was not found in resources '{1}' for culture '{2}'.", Text, ResourceId, ci.Name),
					"Text");
#else
                translation = Text; // HACK: returns the key, which GETS DISPLAYED TO THE USER
#endif
			}
			return translation;
		}
	}
}