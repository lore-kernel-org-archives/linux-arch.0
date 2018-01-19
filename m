From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 06/36] nds32: Kernel booting and initialization
Date: Fri, 19 Jan 2018 17:41:45 +0100
Message-ID: <CAK8P3a3UCrMbTn1JMOGKCSV4WRw9T9tU+pey1t6Fzitf2V0Bvw@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <5930d2df872116555cc553284b6c111dce29e298.1515766253.git.green.hu@gmail.com>
 <CAK8P3a143yQ72+QGZSxpiFc7p8Hb7PXuCybJBFoLRSBaZ2uw4g@mail.gmail.com> <CAEbi=3dJm=M-1UjUftb5qb0YOOsq92zzF86xeaVOhzULjvT3eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42425 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756058AbeASQlr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jan 2018 11:41:47 -0500
In-Reply-To: <CAEbi=3dJm=M-1UjUftb5qb0YOOsq92zzF86xeaVOhzULjvT3eA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Greg KH <greg@kroah.com>, Guo Ren <ren_guo@c-sky.co>

On Fri, Jan 19, 2018 at 5:34 PM, Greentime Hu <green.hu@gmail.com> wrote:
> Hi, Arnd:
>
> 2018-01-18 18:11 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu@gmail.com> wrote:
>>
>> I had not looked at this patch in enough detail earlier, sorry about
>> that. It should be
>> easy enough to fix though.
>>
>>> +#ifdef CONFIG_VGA_CONSOLE
>>> +struct screen_info screen_info;
>>> +#endif
>>
>> I would assume that you can't ever have a VGA console. Just drop all
>> the references
>> here and instead send a patch to the fbdev maintainer to add the dependency
>> at CONFIG_VGA_CONSOLE to prevent selecting it with nds32.
>
> I found it can be built pass for now because we disable it in defconfig.
> Should I send the patch in v7 series?

yes, I think that would be best.

>>> +
>>> +extern void __init early_init_devtree(void *params);
>>> +extern void __init early_trap_init(void);
>>
>> similarly, these are declared in include/linux/of_fdt.h
>>
>
> early_trap_init is a nds32 function. I will move it to nds32.h

Right, makes sense.

>>> +void calibrate_delay(void)
>>> +{
>>> +       const int *val;
>>> +       struct device_node *cpu = NULL;
>>> +       cpu = of_find_compatible_node(NULL, NULL, "andestech,nds32v3");
>>> +       val = of_get_property(cpu, "clock-frequency", NULL);
>>> +       if (!val || !*val)
>>> +               panic("no cpu 'clock-frequency' parameter in device tree");
>>> +       loops_per_jiffy = be32_to_cpup(val) / HZ;
>>> +       pr_cont("%lu.%02lu BogoMIPS (lpj=%lu)\n",
>>> +               loops_per_jiffy / (500000 / HZ),
>>> +               (loops_per_jiffy / (5000 / HZ)) % 100, loops_per_jiffy);
>>> +}
>>
>> This seems very odd to me: The 'clock-frequency' property in the
>> cpu node should refer to the actual frequency it is running at, but that
>> tends to be different from the bogomips as needed by the ndelay()
>> function. Can you explain what is going on here?
>>
>
> This implementation is referenced from openrisc.
> https://lkml.org/lkml/2017/11/17/228

It's correct on openrisc, because that has a reliable cycle counter,
and that gets used in its delay function:

void __delay(unsigned long cycles)
{
        cycles_t start = get_cycles();
        while ((get_cycles() - start) < cycles)
                cpu_relax();
}

In my review comment that you cited, I assumed that nds32 had similar
hardware.

However, as you explained earlier, the nds32 architecture does not provide
a cycle counter and the clocksource resolution is not high enough to
be a good replacement, so you have to use the traditional delay
calibration.

        Arnd
