From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 15/19] csky: Build infrastructure
Date: Mon, 19 Mar 2018 23:45:23 +0800
Message-ID: <CAK8P3a1rzS+MmubYqTE-8H89QnULcGbKth=eWTA5mJ5VLRNL0Q@mail.gmail.com>
References: <cover.1521399976.git.ren_guo@c-sky.com> <c15b1fce07d0a19616026dfb927bfcbd88102b12.1521399976.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c15b1fce07d0a19616026dfb927bfcbd88102b12.1521399976.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
List-Id: linux-arch.vger.kernel.org

On Mon, Mar 19, 2018 at 3:51 AM, Guo Ren <ren_guo@c-sky.com> wrote:
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> new file mode 100644
> index 0000000..694c1f8
> --- /dev/null
> +++ b/arch/csky/Kconfig
> @@ -0,0 +1,203 @@
> +config CSKY
> +       bool
> +       default y
> +       select ARCH_USE_BUILTIN_BSWAP
> +       select ARCH_WANT_IPC_PARSE_VERSION

Drop ipc_parse_version here, it's only for old architectures.

> +       select HAVE_OPROFILE
> +       select HAVE_PERF_EVENTS

Do you still need oprofile when you have perf?

> +       select MODULES_USE_ELF_REL if MODULES
> +       select MODULES_USE_ELF_RELA if MODULES

You should only need one of these two.

> +       select OLD_SIGACTION
> +       select OLD_SIGSUSPEND3

These should not be needed.

> +config CPU_HAS_CACHEV2
> +       bool
> +       default n
> +
> +config CPU_HAS_HILO
> +       bool
> +       default n
> +
> +config CPU_HAS_TLBI
> +       bool
> +       default n

'default n' is redundant and can be dropped.

> +config GENERIC_CALIBRATE_DELAY
> +       bool
> +       default y

Does your architecture provide a reliable high-reslution clocksource?
If yes, you
could use that for the delay, rather than a calibrated loop.

> +choice
> +        prompt "CPU MODEL"
> +        default CPU_CK610
> +
> +config CPU_CK610
> +        bool "CSKY CPU ck610"
> +       select CPU_NEED_TLBSYNC
> +       select CPU_NEED_SOFTALIGN
> +
> +config CPU_CK810
> +        bool "CSKY CPU ck810"
> +       select HIGHMEM
> +       select CPU_HAS_HILO
> +       select CPU_NEED_TLBSYNC
> +
> +config CPU_CK807
> +        bool "CSKY CPU ck807"
> +       select HIGHMEM
> +       select CPU_HAS_HILO
> +
> +config CPU_CK860
> +        bool "CSKY CPU ck860"
> +       select HIGHMEM
> +       select CPU_HAS_TLBI
> +       select CPU_HAS_CACHEV2
> +endchoice

Why select 'HIGHMEM' based on the CPU type? You should only need it
when you have more than 1GB of RAM, and it can be a performance
problem when it's enabled without need.

Usually the kernel should allow multiple CPU types to be selected
together, or ask for a "minimum architecture" level to be selected
by allow newer cores to be used as a superset.

> +config CPU_TLB_SIZE
> +       int
> +       default "128"   if(CPU_CK610 || CPU_CK807 || CPU_CK810)
> +       default "1024"  if(CPU_CK860)
> +
> +config L1_CACHE_SHIFT
> +       int
> +       default "4"     if(CPU_CK610)
> +       default "5"     if(CPU_CK807 || CPU_CK810)
> +       default "6"     if(CPU_CK860)

I think you then need to reverse the order of the list here: When e.g. CK860
and CK810 are both enabled, L1_CACHE_SHIFT should be the largest
possible size.

> +config SSEG0_BASE
> +       hex "Direct mapping physical address"
> +       default 0x0
> +       help
> +         There are MSAx regs can be used to change the base physical address
> +         of direct mapping. The default base physical address is 0x0.
> +
> +config RAM_BASE
> +       hex "DRAM base address offset from SSEG0_BASE, it must be the same with dts memory."
> +       default 0x08000000

To allow one kernel to run on multiple boards, it's better to detect
these two at runtime.

> +config CSKY_NR_IRQS
> +       int "NR_IRQS to max virtual interrupt numbers of the whole system"
> +       range 64 8192
> +       default "128"
> +endmenu

This should no longer be needed, with the IRQ domain code, any number
of interrupts
can be used without noticeable overhead.

> +menu "Power management options"
> +
> +source "kernel/power/Kconfig"
> +
> +config ARCH_SUSPEND_POSSIBLE
> +       bool y
> +       default y

Make it either

            def_bool y

or

           bool
           default y


> +config CSKY_BUILTIN_DTB
> +       bool "Use kernel builtin dtb"
> +       default n
> +
> +config CSKY_BUILTIN_DTB_NAME
> +       string "kernel builtin dtb name"
> +       depends on CSKY_BUILTIN_DTB

It's generally better not to use a builtin dtb, but use the bootloader
to pass a dtb.

If you need to support existing bootloaders, the best way is to allow
appending the dtb to the kernel.

> +ifeq ($(VERSION)_$(PATCHLEVEL), 4_9)
> +COMPAT_KERNEL_4_9 = -DCOMPAT_KERNEL_4_9
> +endif

Should not be needed

> +KBUILD_CFLAGS +=       -ffreestanding \

-ffreestanding usually results in worse code and should not be needed

> +                       -fno-tree-dse \
> +                       -pipe \
> +                       -Wno-uninitialized \

For -Wno-uninitialized, better fix the bugs properly. Can you explain
why you want
-fno-tree-dse?

> +++ b/arch/csky/abiv1/Makefile
> @@ -0,0 +1,8 @@
> +obj-y +=       src/bswapdi.o
> +obj-y +=       src/bswapsi.o
> +obj-y +=       src/cacheflush.o
> +obj-y +=       src/memcpy.o
> +obj-y +=       src/mmap.o
> +
> +obj-$(CONFIG_CPU_NEED_SOFTALIGN) +=    src/alignment.o

Better not use subdirectories like that.

Can you explain why you need the alignement fixups?

            Arnd
