From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 15/19] csky: Build infrastructure
Date: Wed, 21 Mar 2018 20:41:37 +0800
Message-ID: <20180321124137.GA21320@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <c15b1fce07d0a19616026dfb927bfcbd88102b12.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a1rzS+MmubYqTE-8H89QnULcGbKth=eWTA5mJ5VLRNL0Q@mail.gmail.com>
 <20180320131342.GA31542@guoren>
 <CAK8P3a3pat6wQ+9gbf_wtp6+dur_h=Zp1896rogZHnehVnqVNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a3pat6wQ+9gbf_wtp6+dur_h=Zp1896rogZHnehVnqVNA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

Hi arnd,

On Wed, Mar 21, 2018 at 03:36:43PM +0800, Arnd Bergmann wrote:
> If the clocksource depends on a driver rather than a feature of the
> architecture,
> this may not be worth optimizing though, so maybe leave it as it is for now.
>
Ok, I'll keep it.

> >> Usually the kernel should allow multiple CPU types to be selected
> >> together, or ask for a "minimum architecture" level to be selected
> >> by allow newer cores to be used as a superset.
> > No, I need keep them seperate.
> 
> Can you explain? What is it that makes them all incompatible?
ck610 is abiv1 and its gcc is different from abiv2, they are:
 - csky-linux-abiv1-gcc
 - csky-linux-abiv2-gcc

ck807/810/860 use the same csky-linux-abiv2-gcc, but their instruction-sets
and pipeline schedule are different. So our gcc must&only use '-mcpu=' to
determine which cpu series is. They are different cpu series.

    ck610 only  have: ck610
    ck807 could have: ck807 ck807f ck807vf ck807ef
    ck810 could have: ck810 ck810f ck810vf ck810ef
    ck860 could have: ck860 ck860f ck860vf
  f: means FPU co-processor
  v: means VDSP co-processor just like "ARM-NEON"
  e: is our old DSP co-processor which use HI-LO regs for operation. In
  current ck807/ck810 they default have HI-LO regs, so ck807&ck807e is
  the same for me.

For this patch-set, we support:
   ck610
  (ck807/ck807f/ck807ef)
  (ck810/ck810e/ck810ef)

> >> > +config CPU_TLB_SIZE
> >> > +       int
> >> > +       default "128"   if(CPU_CK610 || CPU_CK807 || CPU_CK810)
> >> > +       default "1024"  if(CPU_CK860)
> >> > +
> >> > +config L1_CACHE_SHIFT
> >> > +       int
> >> > +       default "4"     if(CPU_CK610)
> >> > +       default "5"     if(CPU_CK807 || CPU_CK810)
> >> > +       default "6"     if(CPU_CK860)
> >>
> >> I think you then need to reverse the order of the list here: When e.g. CK860
> >> and CK810 are both enabled, L1_CACHE_SHIFT should be the largest
> >> possible size.
> > No, I use L1_CACHE_SHIFT to determine the size of cache_line.
> > When I flush cache for a range of memory, I need the size to loop flush cache line.
> 
> This is still relatively easy to fix, you just need a cpu specific loop
> that uses the actual line size rather than the maximum size.
Here is my cacheflush code in mm/cachev2.c:
	#define L1_CACHE_BYTES (1<<L1_CACHE_SHIFT)
	for(i=start; i<end; i+=L1_CACHE_BYTES)
		asm volatile("dcache.cval1 %0\n"::"r"(i));
	asm volatile("sync.is\n");

I use L1_CACHE_BYTES as the loop element to increase. So it must be the
current CPU cache line size for "correct&performance". Each of our CPU-series
has a fixed cache line size:
ck610 is 16Bytes
ck807/ck810 is 32Bytes
ck860 is 64Bytes
So I don't need determine them in .dts or detect on boot, just define them in Kconfig.

> >> > +config SSEG0_BASE
> >> > +       hex "Direct mapping physical address"
> >> > +       default 0x0
> >> > +       help
> >> > +         There are MSAx regs can be used to change the base physical address
> >> > +         of direct mapping. The default base physical address is 0x0.
> >> > +
> >> > +config RAM_BASE
> >> > +       hex "DRAM base address offset from SSEG0_BASE, it must be the same with dts memory."
> >> > +       default 0x08000000
> >>
> >> To allow one kernel to run on multiple boards, it's better to detect
> >> these two at runtime.
> > CK-CPUs have a mips-like direct-mapping, and I use the macros to calculate the virtual-addr
> > in headers.
> 
> On many architectures, we detect the offsets at boot time and pass
> them as variables. On
> ARM, we go as far as patching the kernel at boot time to have constant
> offsets, but usually
> it's not worth the effort.
I know it's duplicate setting with dts for users. But now, I still want
to keep them. I'll consider your advices in future.

> >> > +config CSKY_NR_IRQS
> >> > +       int "NR_IRQS to max virtual interrupt numbers of the whole system"
> >> > +       range 64 8192
> >> > +       default "128"
> >> > +endmenu
> >>
> >> This should no longer be needed, with the IRQ domain code, any number
> >> of interrupts
> >> can be used without noticeable overhead.
> > Not I use it, some of our users need it to expand the GPIO irqs. Because
> > they don't use irq domain code properly. I move it to Kconfig.debug, OK?
> 
> It sounds like your GPIO driver should get fixed to use irq domains right,
> it should not be too hard. The number of GPIOs is typically a compile
> time constant today, but we also try to turn it into a dynamic allocation
> that we have for IRQs on most targets.
Got it, remove the CSKY_NR_IRQS.

> What I meant here is that you can get the same behavior by
> appending the dtb to the kernel rather than linking it into the
> kernel. The reason for preferring the appended one is that you
> can more easily use the same kernel binary across boards with
> different bootloaders.
Ok, got it. I'll use the dtb passed by bootloader first.

> I'd say it's better to get rid of it for the upstream port, more importantly
> getting rid of the code that checks for this symbol. Usually what happens
> with version checks like this one is that they get out of sync quickly
> as a new kernel version does things differently and diverges more
> from the old release you were comparing against. In device drivers,
> we tend to remove all those checks.
Ok, follow the rules.

> 
> >> -fno-tree-dse?
> > This is from "gcc-4.5 compile linux-4.7" and it will cause wrong code without
> > -fno-tree-dse for list.h. Now we use gcc-6.3, so I will try to remove it.
> 
> You can also use the cc-ifversion Makefile macro to apply it on
> the old compiler. That way you can still use gcc-4.5 as long as
> that remains relevant but don't get worse code generation on
> modern versions.
Thx for advice, but we don't need support gcc-4.5 now. I'll just remove
them.

> >> Can you explain why you need the alignement fixups?
> > For abiv1 ck610 couldn't handle the unalignment address access, so we
> > need soft-alignment exception to fixup. There is no problem in abiv2 cpus.
> 
> Ok. Generally speaking, architectures that don't allow unaligned access
> should have all code built in a way that uses aligned access (gcc normally
> falls back to byte access when it encounters an unaligned pointer at
> compile time), but if this is just for old CPUs that are not used in future
> products, having the fixup does sound simpler, as it allows you to still
> run new binaries on the old machines. I haven't looked at the implementation
> for the fixup here, but I remember the same thing from the nds32 port.
> In that case, we ended up keeping the fixup as an option for old
> user space, but disabled to softalign fixups for kernel code. Can you do
> the same thing here?
Ok. I got it, I'll do the same as nds32.

Best Regards
  Guo Ren
