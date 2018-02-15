From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v13 7/9] ACPI: Translate the I/O range of non-MMIO
 devices before scanning
Date: Thu, 15 Feb 2018 12:36:42 +0000
Message-ID: <20180215123642.GA28256@e107981-ln.cambridge.arm.com>
References: <1518543933-22456-1-git-send-email-john.garry@huawei.com>
 <1518543933-22456-8-git-send-email-john.garry@huawei.com>
 <20180214161635.GA13849@e107981-ln.cambridge.arm.com>
 <65185a4d-c712-4486-d713-3fa9de14e35d@huawei.com>
 <e3fb78b3-5f5c-fe96-9f02-e96092963c17@huawei.com>
 <CAJZ5v0jGvo+cutmvi3WSe1JNvQ1UvZhJr1mQ76=8=1E5Gq+iRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jGvo+cutmvi3WSe1JNvQ1UvZhJr1mQ76=8=1E5Gq+iRg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Dann Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Corey Minyard <minyard-HInyCGIudOg@public.gmane.org>, devicet
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 15, 2018 at 12:47:25PM +0100, Rafael J. Wysocki wrote:
> On Thu, Feb 15, 2018 at 12:19 PM, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:
> >> Nothing apart from only being used by arm64 platforms today, which is
> >> circumstantial.
> >>
> >>>
> >>> I understand you need to find a place to add the:
> >>>
> >>> acpi_indirect_io_scan_init()
> >>>
> >>> to be called from core ACPI code because ACPI can't handle probe
> >>> dependencies in any other way but other than that this patch is
> >>> a Hisilicon ACPI driver - there is nothing generic in it (or at
> >>> least there are no standard bindings to make it so).
> >>>
> >>> Whether a callback from ACPI core code (acpi_scan_init()) to a driver
> >>> specific hook is sane or not that's the question and the only reason
> >>> why you want to add this in drivers/acpi/arm64 rather than, say,
> >>> drivers/bus (as you do for the DT driver).
> >>>
> >>> I do not know Rafael's opinion on the above, I would like to help
> >>> you make forward progress but please understand my concerns, mostly
> >>> on FW side.
> >>>
> >>
> >> I did mention an alternative in my "ping" in v12 patch 7/9 (Feb 1), but
> >> no response to this specific note so I kept on the same path.
> >>
> >> Here's what I then wrote:
> >> "I think another solution - which you may prefer - is to avoid adding
> >> this scan handler (and all this other scan code) and add a check like
> >> acpi_is_serial_bus_slave() [which checks the device parent versus a list
> >> of known indirectIO hosts] to not enumerate these children, and do it
> >> from the LLDD host probe instead (https://lkml.org/lkml/2017/6/16/250)"
> >>
> >
> > Hi Rafael, Lorenzo,
> >
> > I can avoid adding the scan handler in acpi_indirectio.c by skipping the
> > child enumeration, like with this change in scan.c:
> >
> > +static const struct acpi_device_id indirect_io_hosts[] = {
> > +    {"HISI0191", 0},    /* HiSilicon LPC host */
> > +    {},
> > +};
> > +
> > +static bool acpi_is_indirect_io_slave(struct acpi_device *device)
> > +{
> 
> Why don't you put the table definition here?
> 
> > +    struct acpi_device *parent = dev->parent;
> > +
> > +    if (!parent || acpi_match_device_ids(parent, indirect_io_hosts))
> > +        return false;
> > +
> > +    return true;
> 
> return parent && !acpi_match_device_ids(parent, indirect_io_hosts);
> 
> > +}
> > +
> >  static bool acpi_is_serial_bus_slave(struct acpi_device *device)
> >  {
> >      struct list_head resource_list;
> >      bool is_serial_bus_slave = false;
> >
> > +    if (acpi_is_indirect_io_slave(device))
> > +        return true;
> > +
> >      /* Macs use device properties in lieu of _CRS resources */
> >
> >
> > This means I can move all this scan code into the LLDD.
> >
> > What do you think? Please let me know.
> 
> If Lorenzo agrees, that will be fine by me modulo the above remarks.

I agree and I thank you for accepting this in core ACPI code, I think
that's much cleaner than a driver specific scan hook.

It is a shame we do not have a generic identifier for such bus in ACPI
but that won't happen overnight anyway (if ever, I think a binding for
LPC in the ACPI specs is hard to justify).

Thank you,
Lorenzo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
