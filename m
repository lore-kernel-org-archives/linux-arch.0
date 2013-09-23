From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC 0/5] New descriptor-based GPIO interface
Date: Mon, 23 Sep 2013 13:21:35 +0300
Message-ID: <20130923102134.GB28875@intel.com>
References: <1378294169-22661-1-git-send-email-acourbot@nvidia.com>
 <CACRpkdYjkDf7c9VxfDTHtFx_upWWRAK8vpXTkrkrRsMjErq1dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYjkDf7c9VxfDTHtFx_upWWRAK8vpXTkrkrRsMjErq1dQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 20, 2013 at 08:06:00PM +0200, Linus Walleij wrote:
> On Wed, Sep 4, 2013 at 1:29 PM, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
> 
> > Here is a first RFC for the new GPIO interface.
> 
> I'm quite happy with this, and given that all DT-implementations will start
> to use it from day 1 I'll happily merge it when you think it's tested enough.
> 
> On my wishlist is to also switch over the ACPI GPIO driver:
> drivers/gpio/gpiolib-acpi.c to use the descriptors directly, so
> I'd like one of the ACPI folks to have a look at this patch set
> and see how it looks from their angle.
> 
> Mika, Rafael, Mathias, and either of you guys have a look
> at this?

Apart from the con_id thing I commented, I don't see huge problems
converting the ACPI GPIO helpers to this new interface.

One thing that is special to ACPI is that we have two kind of GPIO
"connections":

	GpioIo - a normal GPIO that the driver can toggle or read values

	GpioInt - this is specifically used as a GPIO interrupt

The drivers should be able to distinguish between the two. Currently we
have an extra parameter in acpi_get_gpio_by_index(..., &info) that can be
used for this. However, with the new gpiod_get() I'm not sure how we are
supposed to do this now?

Anyway, that shouldn't prevent merging this patch set. I'm sure that we can
come up with some working solution :-)
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
