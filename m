From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/19] csky: Build infrastructure
Date: Mon, 26 Mar 2018 15:00:00 +0200
Message-ID: <CAK8P3a06MVAT35ZbG=gRkR1EDVdWPoT3bhwL+9fZSkmTHaDVBw@mail.gmail.com>
References: <cover.1521399976.git.ren_guo@c-sky.com> <c15b1fce07d0a19616026dfb927bfcbd88102b12.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a1rzS+MmubYqTE-8H89QnULcGbKth=eWTA5mJ5VLRNL0Q@mail.gmail.com>
 <20180320131342.GA31542@guoren> <CAK8P3a3pat6wQ+9gbf_wtp6+dur_h=Zp1896rogZHnehVnqVNA@mail.gmail.com>
 <20180321124137.GA21320@guoren>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180321124137.GA21320@guoren>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Wed, Mar 21, 2018 at 1:41 PM, Guo Ren <ren_guo@c-sky.com> wrote:
> Hi arnd,
>
> On Wed, Mar 21, 2018 at 03:36:43PM +0800, Arnd Bergmann wrote:
>> If the clocksource depends on a driver rather than a feature of the
>> architecture,
>> this may not be worth optimizing though, so maybe leave it as it is for now.
>>
> Ok, I'll keep it.
>
>> >> Usually the kernel should allow multiple CPU types to be selected
>> >> together, or ask for a "minimum architecture" level to be selected
>> >> by allow newer cores to be used as a superset.
>> > No, I need keep them seperate.
>>
>> Can you explain? What is it that makes them all incompatible?
> ck610 is abiv1 and its gcc is different from abiv2, they are:
>  - csky-linux-abiv1-gcc
>  - csky-linux-abiv2-gcc
>
> ck807/810/860 use the same csky-linux-abiv2-gcc, but their instruction-sets
> and pipeline schedule are different. So our gcc must&only use '-mcpu=' to
> determine which cpu series is. They are different cpu series.
>
>     ck610 only  have: ck610
>     ck807 could have: ck807 ck807f ck807vf ck807ef
>     ck810 could have: ck810 ck810f ck810vf ck810ef
>     ck860 could have: ck860 ck860f ck860vf
>   f: means FPU co-processor
>   v: means VDSP co-processor just like "ARM-NEON"
>   e: is our old DSP co-processor which use HI-LO regs for operation. In
>   current ck807/ck810 they default have HI-LO regs, so ck807&ck807e is
>   the same for me.
>
> For this patch-set, we support:
>    ck610
>   (ck807/ck807f/ck807ef)
>   (ck810/ck810e/ck810ef)

Ok, I understand the part about ck610 being incompatible, but I'm
still not sure about the 8xx ones: Do you mean it's impossible to
have one kernel that runs across all of them for some other reason,
or is it something you haven't allowed because you see no use for it?

>> >> > +config CPU_TLB_SIZE
>> >> > +       int
>> >> > +       default "128"   if(CPU_CK610 || CPU_CK807 || CPU_CK810)
>> >> > +       default "1024"  if(CPU_CK860)
>> >> > +
>> >> > +config L1_CACHE_SHIFT
>> >> > +       int
>> >> > +       default "4"     if(CPU_CK610)
>> >> > +       default "5"     if(CPU_CK807 || CPU_CK810)
>> >> > +       default "6"     if(CPU_CK860)
>> >>
>> >> I think you then need to reverse the order of the list here: When e.g. CK860
>> >> and CK810 are both enabled, L1_CACHE_SHIFT should be the largest
>> >> possible size.
>> > No, I use L1_CACHE_SHIFT to determine the size of cache_line.
>> > When I flush cache for a range of memory, I need the size to loop flush cache line.
>>
>> This is still relatively easy to fix, you just need a cpu specific loop
>> that uses the actual line size rather than the maximum size.
> Here is my cacheflush code in mm/cachev2.c:
>         #define L1_CACHE_BYTES (1<<L1_CACHE_SHIFT)
>         for(i=start; i<end; i+=L1_CACHE_BYTES)
>                 asm volatile("dcache.cval1 %0\n"::"r"(i));
>         asm volatile("sync.is\n");
>
> I use L1_CACHE_BYTES as the loop element to increase. So it must be the
> current CPU cache line size for "correct&performance". Each of our CPU-series
> has a fixed cache line size:
> ck610 is 16Bytes
> ck807/ck810 is 32Bytes
> ck860 is 64Bytes
> So I don't need determine them in .dts or detect on boot, just define them in Kconfig.

This is basically the same question as above: For c610, using the fixed
value is sufficient, because it's incompatible with the others. But if you want
to run the same kernel on both ck810 and ck860, then it needs some form
of runtime detection.

On other architectures, the L1_CACHE_BYTES constant is the maximum
possible cache line size, and the cache flush function uses the actual size

>> >> > +config SSEG0_BASE
>> >> > +       hex "Direct mapping physical address"
>> >> > +       default 0x0
>> >> > +       help
>> >> > +         There are MSAx regs can be used to change the base physical address
>> >> > +         of direct mapping. The default base physical address is 0x0.
>> >> > +
>> >> > +config RAM_BASE
>> >> > +       hex "DRAM base address offset from SSEG0_BASE, it must be the same with dts memory."
>> >> > +       default 0x08000000
>> >>
>> >> To allow one kernel to run on multiple boards, it's better to detect
>> >> these two at runtime.
>> > CK-CPUs have a mips-like direct-mapping, and I use the macros to calculate the virtual-addr
>> > in headers.
>>
>> On many architectures, we detect the offsets at boot time and pass
>> them as variables. On
>> ARM, we go as far as patching the kernel at boot time to have constant
>> offsets, but usually
>> it's not worth the effort.
> I know it's duplicate setting with dts for users. But now, I still want
> to keep them. I'll consider your advices in future.

Ok. Just make sure that the DT always has this information as well,
so this can be changed in the future when desired, without having to
make incompatible changes to the devicetree binary files.

       Arnd
