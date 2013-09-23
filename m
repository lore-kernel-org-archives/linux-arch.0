From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [RFC 4/5] gpiolib: add gpiod_get() and gpiod_put() functions
Date: Mon, 23 Sep 2013 12:31:27 +0300
Message-ID: <20130923093127.GA28875@intel.com>
References: <1378294169-22661-1-git-send-email-acourbot@nvidia.com>
 <1378294169-22661-5-git-send-email-acourbot@nvidia.com>
 <52279082.5010105@wwwdotorg.org>
 <CACRpkdY70r8mL8PSDmexr+_0Ddi-Y8x0RaDF-WWucZM9V8n=yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdY70r8mL8PSDmexr+_0Ddi-Y8x0RaDF-WWucZM9V8n=yw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mathias Nyman <mathias.nyman-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Sep 20, 2013 at 08:40:48PM +0200, Linus Walleij wrote:
> On Wed, Sep 4, 2013 at 9:56 PM, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
> > On 09/04/2013 05:29 AM, Alexandre Courbot wrote:
> >> Add gpiod_get() and gpiod_put() functions that provide safer handling of
> >> GPIOs.
> >>
> >> These functions put the GPIO framework in line with the conventions of
> >> other frameworks in the kernel, and help ensure every GPIO is declared
> >> properly and valid while it is used.
> >
> >> diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
> >
> >> +struct gpio_desc *__must_check gpiod_get(struct device *dev,
> >> +                                      const char *con_id);
> >> +void gpiod_put(struct gpio_desc *desc);
> >
> > It might be nice to add an "int index" parameter to this function. For
> > example, a bit-banged parallel bus protocol driver might have 1
> > chip-select GPIO, 1 clock GPIO, and 8 data GPIOs. gpiod_get(dev, "bus",
> > 0)..gpiod_get(dev, "bus", 7) might be nicer than gpiod_get(dev,
> > "bus0")..gpiod_get(dev, "bus7")? Possibly for client-simplicity,
> > implement both gpiod_get(dev, con_id) (as an inline wrapper for ...) and
> > gpiod_get_index(dev, con_id, index)?
> >
> > In DT terms, this would map to:
> >
> > cs-gpios = <&gpio 3 0>;
> > clock-gpios = <&gpio 5 0>;
> > bus-gpios = <&gpio 10 0 ... &gpio 17 0>;
> >
> > ... and with the mapping table registration mechanism, we could
> > presumably add "int index" to struct gpiod_lookup.
> 
> This is an interesting usability aspect of the API, so I'd especially
> like some input from the ACPI people on this as well.

The index fits well with ACPI as that's the only way we can use to
distinguish different GPIOs.

However, in ACPI world the con_id doesn't have any correspondence. For
example given a DT description:

	power-gpios = <&gpio 28 GPIO_ACTIVE_LOW>;

would be something like this in the ACPI ASL code:

	GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionNone,
        	"\\_SB.PCI0.GPI0", 0x00, ResourceConsumer,,)
        {   
                28
        }

I'm thinking that in order to get ACPI implementation work with this we can
do something like:

	gpiod_get_index(dev, "bus", 0)

	  Here we ignore the con_id and use only the index.

	gpiod_get(dev, "bus")

	  Since we can't map the "bus" to anything, we default to index 0.

We have pretty much similar in the DMA slave helpers where passing "tx"
gives us the first DMA channel and "rx" the second.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
