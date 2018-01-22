From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 06/36] nds32: Kernel booting and initialization
Date: Mon, 22 Jan 2018 17:49:30 +0800
Message-ID: <CAEbi=3dF-ekx8oz0vjd3WfM7qO755rW46Q=+i-MnQC=4N1=EMA@mail.gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com> <5930d2df872116555cc553284b6c111dce29e298.1515766253.git.green.hu@gmail.com>
 <CAK8P3a143yQ72+QGZSxpiFc7p8Hb7PXuCybJBFoLRSBaZ2uw4g@mail.gmail.com>
 <CAEbi=3dJm=M-1UjUftb5qb0YOOsq92zzF86xeaVOhzULjvT3eA@mail.gmail.com> <CAK8P3a3UCrMbTn1JMOGKCSV4WRw9T9tU+pey1t6Fzitf2V0Bvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAK8P3a3UCrMbTn1JMOGKCSV4WRw9T9tU+pey1t6Fzitf2V0Bvw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Networking <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Guo Ren <ren_guo-Y+KPrCd2zL4@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

2018-01-20 0:41 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
> On Fri, Jan 19, 2018 at 5:34 PM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Hi, Arnd:
>>
>> 2018-01-18 18:11 GMT+08:00 Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>:
>>> On Mon, Jan 15, 2018 at 6:53 AM, Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>
>>> I had not looked at this patch in enough detail earlier, sorry about
>>> that. It should be
>>> easy enough to fix though.
>>>
>>>> +#ifdef CONFIG_VGA_CONSOLE
>>>> +struct screen_info screen_info;
>>>> +#endif
>>>
>>> I would assume that you can't ever have a VGA console. Just drop all
>>> the references
>>> here and instead send a patch to the fbdev maintainer to add the dependency
>>> at CONFIG_VGA_CONSOLE to prevent selecting it with nds32.
>>
>> I found it can be built pass for now because we disable it in defconfig.
>> Should I send the patch in v7 series?
>
> yes, I think that would be best.
>
>>>> +
>>>> +extern void __init early_init_devtree(void *params);
>>>> +extern void __init early_trap_init(void);
>>>
>>> similarly, these are declared in include/linux/of_fdt.h
>>>
>>
>> early_trap_init is a nds32 function. I will move it to nds32.h
>
> Right, makes sense.
>
>>>> +void calibrate_delay(void)
>>>> +{
>>>> +       const int *val;
>>>> +       struct device_node *cpu = NULL;
>>>> +       cpu = of_find_compatible_node(NULL, NULL, "andestech,nds32v3");
>>>> +       val = of_get_property(cpu, "clock-frequency", NULL);
>>>> +       if (!val || !*val)
>>>> +               panic("no cpu 'clock-frequency' parameter in device tree");
>>>> +       loops_per_jiffy = be32_to_cpup(val) / HZ;
>>>> +       pr_cont("%lu.%02lu BogoMIPS (lpj=%lu)\n",
>>>> +               loops_per_jiffy / (500000 / HZ),
>>>> +               (loops_per_jiffy / (5000 / HZ)) % 100, loops_per_jiffy);
>>>> +}
>>>
>>> This seems very odd to me: The 'clock-frequency' property in the
>>> cpu node should refer to the actual frequency it is running at, but that
>>> tends to be different from the bogomips as needed by the ndelay()
>>> function. Can you explain what is going on here?
>>>
>>
>> This implementation is referenced from openrisc.
>> https://lkml.org/lkml/2017/11/17/228
>
> It's correct on openrisc, because that has a reliable cycle counter,
> and that gets used in its delay function:
>
> void __delay(unsigned long cycles)
> {
>         cycles_t start = get_cycles();
>         while ((get_cycles() - start) < cycles)
>                 cpu_relax();
> }
>
> In my review comment that you cited, I assumed that nds32 had similar
> hardware.
>
> However, as you explained earlier, the nds32 architecture does not provide
> a cycle counter and the clocksource resolution is not high enough to
> be a good replacement, so you have to use the traditional delay
> calibration.
>

Hi, Arnd:

Thank you for your explanation.
Will it be ok if I code it like this?

config GENERIC_CALIBRATE_DELAY
       def_bool y
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
