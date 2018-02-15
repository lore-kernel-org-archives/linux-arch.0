From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v13 7/9] ACPI: Translate the I/O range of non-MMIO devices
 before scanning
Date: Thu, 15 Feb 2018 14:55:37 +0200
Message-ID: <CAHp75Vec1vXxuo9i5G-og1cQre1AYm=0_61u+DK1690FpY17bQ@mail.gmail.com>
References: <1518543933-22456-1-git-send-email-john.garry@huawei.com>
 <1518543933-22456-8-git-send-email-john.garry@huawei.com> <20180214161635.GA13849@e107981-ln.cambridge.arm.com>
 <65185a4d-c712-4486-d713-3fa9de14e35d@huawei.com> <e3fb78b3-5f5c-fe96-9f02-e96092963c17@huawei.com>
 <CAHp75VfFKcnUVQwPUxynzp88RXWdV8VEqtXxd0=_Q_GJKO6UpQ@mail.gmail.com> <f7b3de31-46fb-f80e-511e-651fa815bddf@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f7b3de31-46fb-f80e-511e-651fa815bddf-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Dann Frazier <dann.frazier-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linuxarm <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Corey Minyard <minyard-HInyCGIudOg@public.gmane.org>devicetree <d>
List-Id: linux-arch.vger.kernel.org

On Thu, Feb 15, 2018 at 2:52 PM, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:
> On 15/02/2018 12:22, Andy Shevchenko wrote:
>> On Thu, Feb 15, 2018 at 1:19 PM, John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org> wrote:

>>> +static const struct acpi_device_id indirect_io_hosts[] = {
>>> +    {"HISI0191", 0},    /* HiSilicon LPC host */
>>> +    {},
>>
>>
>> Just a nit.
>>
>
> I noticed that I have this in the LLDD also. I think that this may be a
> force of habit.


>> It seems lately this happens more often than usual, I mean a comma in
>> the terminator line.
>>
>> If we remove it. we terminate not only at runtime, but at compile
>> time, which is slightly better.
>
>
> I grepped for "{}," in the drivers folder and it gives many results (I do
> accept that some are not sentinels):

Yes, in old code it might be, but why to cargo-culting bad (okay, less
worth) practices?

>>grep -R "{}," * | tail

Btw, `git grep ...` is much faster.

> watchdog/gef_wdt.c:    {},
> watchdog/asm9260_wdt.c:    {},
> watchdog/bcm2835_wdt.c:    {},
> watchdog/digicolor_wdt.c:    {},
> watchdog/bcm7038_wdt.c:    {},
> watchdog/ath79_wdt.c:    {},
> watchdog/riowd.c:    {},
> watchdog/sbsa_gwdt.c:    {},
> watchdog/sbsa_gwdt.c:    {},
> watchdog/bcm_kona_wdt.c:    {},



-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
