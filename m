From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v12 7/9] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
Date: Mon, 5 Feb 2018 15:16:03 +0200
Message-ID: <CAHp75VfXoAHNH2BnfNLbFfdCqUk3rxU_QWfxTx7ZyLgV0qxotQ@mail.gmail.com>
References: <1516725385-24535-1-git-send-email-john.garry@huawei.com>
 <1516725385-24535-8-git-send-email-john.garry@huawei.com> <0a30452f-34eb-d0b5-2001-ab6b866c53e2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0a30452f-34eb-d0b5-2001-ab6b866c53e2-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Corey Minyard <minyard-HInyCGIudOg@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Randy
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 1, 2018 at 1:32 PM, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:


I'm not going through all patch, by one thing I would like you to pay
attention on, i.e.
printing resource_size_t and struct resource

>> +               dev_err(dev, "translate bus-addr(0x%llx) fail!\n",
>> +                       resource->start);

resource_size_t is dynamic width type, you will see a compiler
warning. For this we have
%pap specifier.

Moreover, in some cases it's useful to print struct resource via %pR or %pr.

Consider reading kernel documentation about these (printk-formats.rst).

>> +struct acpi_indirectio_host_data {
>> +       resource_size_t io_size;
>> +       resource_size_t io_start;
>> +};

Why not utilize struct resource?

If it's coming from platform / firmware it should *never* have types
like size_t, unsigned long, resource_size_t, etc.

>> +/* All the host devices which apply indirect-IO can be listed here. */
>> +static const struct acpi_device_id acpi_indirect_host_id[] = {
>> +       {""},
>> +};

The idea of terminator is to be such (remove comma there). And it's
basically redundant to have an empty string there. Moreover, it's a
waste of resources in ro section.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
