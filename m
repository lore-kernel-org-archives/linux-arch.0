From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 17/33] nds32: VDSO support
Date: Fri, 8 Dec 2017 20:46:17 +0800
Message-ID: <CAEbi=3cAk25w2JECTEfZccRnaWxy76CO_MyNvzb35knnomZZpg@mail.gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com> <921ccfa97c4c13f12c7b22b9554f52dcce51f87e.1512723245.git.green.hu@gmail.com>
 <20171208102149.iqiieszktwzorkuw@lakrids.cambridge.arm.com>
 <CAEbi=3e9Ep4_DL4SSwp15as1t7ALvw-s2gqv+NsuRZiebNGFAQ@mail.gmail.com> <f58c7052-c2fe-5704-a03b-41bf2e3b20b9@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f58c7052-c2fe-5704-a03b-41bf2e3b20b9-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Greentime <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, netdev <netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Vincent Chen <deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, DTML <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert.uytterhoeven-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, Vincent Chen <vincentc-MUIXKm3OiriV7V7JEmyr7g@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

Hi, Marc:

2017-12-08 20:29 GMT+08:00 Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>:
> On 08/12/17 11:54, Greentime Hu wrote:
>> Hi, Mark:
>>
>> 2017-12-08 18:21 GMT+08:00 Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>:
>>> On Fri, Dec 08, 2017 at 05:12:00PM +0800, Greentime Hu wrote:
>>>> From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
>>>>
>>>> This patch adds VDSO support. The VDSO code is currently used for
>>>> sys_rt_sigreturn() and optimised gettimeofday() (using the SoC timer counter).
>>>
>>> [...]
>>>
>>>> +static int grab_timer_node_info(void)
>>>> +{
>>>> +     struct device_node *timer_node;
>>>> +
>>>> +     timer_node = of_find_node_by_name(NULL, "timer");
>>>
>>> Please use a compatible string, rather than matching the timer by name.
>>>
>>> It's plausible that you have multiple nodes called "timer" in the DT,
>>> under different parent nodes, and this might not be the device you
>>> think it is. I see your dt in patch 24 has two timer nodes.
>>>
>>> It would be best if your clocksource driver exposed some stuct that you
>>> looked at here, so that you're guaranteed to user the same device.
>>
>> We'd like to use "timer" here because there are 2 different timer IPs
>> and we are sure that they won't be in the same SoC.
>> We think this implementation in VDSO should be platform independent to
>> get cycle-count register.
>> Our customer or other SoC provider who can use "timer" and define
>> cycle-count-offset or cycle-count-down then we can get the correct
>> cycle-count.
>>
>> We sent atcpit100 patch last time along with our arch, however we'd
>> like to send it to its sub system this time and my colleague is still
>> working on it.
>> He may send the timer patch next week.
>>
>>
>>>> +     of_property_read_u32(timer_node, "cycle-count-offset",
>>>> +                          &vdso_data->cycle_count_offset);
>>>> +     vdso_data->cycle_count_down =
>>>> +         of_property_read_bool(timer_node, "cycle-count-down");
>>>
>>> ... and then you'd only need to parse these in one place, too.
>>>
>>> IIUC these are proeprties for the atcpit device, which has no
>>> documentation or driver in this series.
>>>
>>> So I'm rather confused as to what's going on here.
>>>
>>
>> These properties are defined in dts which can provide the cycle count
>> register offset address of that timer, so that we can get cycle-count.
>>
>>>> +     return of_address_to_resource(timer_node, 0, &timer_res);
>>>> +}
>>>
>>>> +int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>>>> +{
>>>
>>>> +     /*Map timer to user space */
>>>> +     vdso_base += PAGE_SIZE;
>>>> +     prot = __pgprot(_PAGE_V | _PAGE_M_UR_KR | _PAGE_D |
>>>> +                     _PAGE_G | _PAGE_C_DEV);
>>>> +     ret = io_remap_pfn_range(vma, vdso_base, timer_res.start >> PAGE_SHIFT,
>>>> +                              PAGE_SIZE, prot);
>>>> +     if (ret)
>>>> +             goto up_fail;
>>>
>>> Maybe this is fine, but it looks a bit suspicious.
>>>
>>> Is it safe to map IO memory to a userspace process like this?
>>>
>>> In general that isn't safe, since userspace could access other registers
>>> (if those exist), perform accesses that change the state of hardware, or
>>> make unsupported access types (e.g. unaligned, atomic) that result in
>>> errors the kernel can't handle.
>>>
>>> Does none of that apply here?
>>
>> We only provide read permission to this page so hareware state won't
>> be chagned. It will trigger exception if we try to write.
>> We will check about the alignment/atomic issue of this region.
>
> It still feels a bit odd. A hostile userspace could potentially find out
> about what the kernel is doing. For example, if the deadline of the next
> timer is accessible by reading that page, userspace could infer a lot of
> things that we'd normally want to keep hidden. Not knowing this HW, I
> cannot answer that question, but maybe you can.
>
> Another question: MMIO accesses can be quite slow. How much do you gain
> by having a vdso compared to executing a system call?
>

I think the rest of the timer registers should be fine to be read.
Anyway we will discuss about the security issue.

Based on our previous experiments.

Decrease 4,519,021 (47%)  cycle count for executing gettimeofday()
with: without vDSO(using syscall) =  5,091,342 : 9,610,363

The cycle count was get by CPU performance monitor.

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
