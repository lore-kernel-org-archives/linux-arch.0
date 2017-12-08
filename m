From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH v3 17/33] nds32: VDSO support
Date: Fri, 8 Dec 2017 12:29:36 +0000
Message-ID: <f58c7052-c2fe-5704-a03b-41bf2e3b20b9@arm.com>
References: <cover.1512723245.git.green.hu@gmail.com>
 <921ccfa97c4c13f12c7b22b9554f52dcce51f87e.1512723245.git.green.hu@gmail.com>
 <20171208102149.iqiieszktwzorkuw@lakrids.cambridge.arm.com>
 <CAEbi=3e9Ep4_DL4SSwp15as1t7ALvw-s2gqv+NsuRZiebNGFAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:38048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbdLHM3l (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Dec 2017 07:29:41 -0500
In-Reply-To: <CAEbi=3e9Ep4_DL4SSwp15as1t7ALvw-s2gqv+NsuRZiebNGFAQ@mail.gmail.com>
Content-Language: en-GB
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>, Mark Rutland <mark.rutland@arm.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, netdev <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Geert Uytterhoeven <geert.uytterhoeven@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Greg KH <greg@kroah.com>, Vincent Chen <vincentc@andestech.com>

On 08/12/17 11:54, Greentime Hu wrote:
> Hi, Mark:
> 
> 2017-12-08 18:21 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
>> On Fri, Dec 08, 2017 at 05:12:00PM +0800, Greentime Hu wrote:
>>> From: Greentime Hu <greentime@andestech.com>
>>>
>>> This patch adds VDSO support. The VDSO code is currently used for
>>> sys_rt_sigreturn() and optimised gettimeofday() (using the SoC timer counter).
>>
>> [...]
>>
>>> +static int grab_timer_node_info(void)
>>> +{
>>> +     struct device_node *timer_node;
>>> +
>>> +     timer_node = of_find_node_by_name(NULL, "timer");
>>
>> Please use a compatible string, rather than matching the timer by name.
>>
>> It's plausible that you have multiple nodes called "timer" in the DT,
>> under different parent nodes, and this might not be the device you
>> think it is. I see your dt in patch 24 has two timer nodes.
>>
>> It would be best if your clocksource driver exposed some stuct that you
>> looked at here, so that you're guaranteed to user the same device.
> 
> We'd like to use "timer" here because there are 2 different timer IPs
> and we are sure that they won't be in the same SoC.
> We think this implementation in VDSO should be platform independent to
> get cycle-count register.
> Our customer or other SoC provider who can use "timer" and define
> cycle-count-offset or cycle-count-down then we can get the correct
> cycle-count.
> 
> We sent atcpit100 patch last time along with our arch, however we'd
> like to send it to its sub system this time and my colleague is still
> working on it.
> He may send the timer patch next week.
> 
> 
>>> +     of_property_read_u32(timer_node, "cycle-count-offset",
>>> +                          &vdso_data->cycle_count_offset);
>>> +     vdso_data->cycle_count_down =
>>> +         of_property_read_bool(timer_node, "cycle-count-down");
>>
>> ... and then you'd only need to parse these in one place, too.
>>
>> IIUC these are proeprties for the atcpit device, which has no
>> documentation or driver in this series.
>>
>> So I'm rather confused as to what's going on here.
>>
> 
> These properties are defined in dts which can provide the cycle count
> register offset address of that timer, so that we can get cycle-count.
> 
>>> +     return of_address_to_resource(timer_node, 0, &timer_res);
>>> +}
>>
>>> +int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
>>> +{
>>
>>> +     /*Map timer to user space */
>>> +     vdso_base += PAGE_SIZE;
>>> +     prot = __pgprot(_PAGE_V | _PAGE_M_UR_KR | _PAGE_D |
>>> +                     _PAGE_G | _PAGE_C_DEV);
>>> +     ret = io_remap_pfn_range(vma, vdso_base, timer_res.start >> PAGE_SHIFT,
>>> +                              PAGE_SIZE, prot);
>>> +     if (ret)
>>> +             goto up_fail;
>>
>> Maybe this is fine, but it looks a bit suspicious.
>>
>> Is it safe to map IO memory to a userspace process like this?
>>
>> In general that isn't safe, since userspace could access other registers
>> (if those exist), perform accesses that change the state of hardware, or
>> make unsupported access types (e.g. unaligned, atomic) that result in
>> errors the kernel can't handle.
>>
>> Does none of that apply here?
> 
> We only provide read permission to this page so hareware state won't
> be chagned. It will trigger exception if we try to write.
> We will check about the alignment/atomic issue of this region.

It still feels a bit odd. A hostile userspace could potentially find out
about what the kernel is doing. For example, if the deadline of the next
timer is accessible by reading that page, userspace could infer a lot of
things that we'd normally want to keep hidden. Not knowing this HW, I
cannot answer that question, but maybe you can.

Another question: MMIO accesses can be quite slow. How much do you gain
by having a vdso compared to executing a system call?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
