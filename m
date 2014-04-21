Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1bbn0102.outbound.protection.outlook.com ([157.56.111.102]:47345
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751284AbaDUDDM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 20 Apr 2014 23:03:12 -0400
Message-ID: <1398049388.7753.6.camel@leyfoon-vm>
Subject: Re: [PATCH 01/28] nios2: Build infrastructure
From: Ley Foon Tan <lftan@altera.com>
Date: Mon, 21 Apr 2014 11:03:08 +0800
In-Reply-To: <20140418143553.GB8589@ravnborg.org>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	 <1397824031-4892-2-git-send-email-lftan@altera.com>
	 <20140418143553.GB8589@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20140421030308.PclBCuwJIC11cR_i-jKXqEhRu2MOI8RD5MeNnkD2-t4@z>

On Jum, 2014-04-18 at 16:35 +0200, Sam Ravnborg wrote:
> It is good practice to add build infrastructure last - so build is not broken.
> But for a new architecture it matters only little.
> 
> Some comments in the following.
> 
> 	Sam
Noted. But, I will keep the patch # for this time for consistency.
Thanks. 
> > 
> > Signed-off-by: Ley Foon Tan <lftan@altera.com>
> > ---
> > 
> > diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> > new file mode 100644
> > index 0000000..2bd0d0d7160f31a5c5890cf8a059b9f53378be6e
> > --- /dev/null
> > +++ b/arch/nios2/Kconfig
> > @@ -0,0 +1,213 @@
> > +config NIOS2
> > +	def_bool y
> > +	select OF
> > +	select OF_EARLY_FLATTREE
> > +	select USB_ARCH_HAS_HCD if USB_SUPPORT
> > +	select ARCH_WANT_OPTIONAL_GPIOLIB
> > +	select GENERIC_IRQ_PROBE
> > +	select GENERIC_IRQ_SHOW
> > +	select GENERIC_CPU_DEVICES
> > +	select GENERIC_ATOMIC64
> > +	select MODULES_USE_ELF_RELA
> > +	select IRQ_DOMAIN
> > +	select SOC_BUS
> > +	select CLKSRC_OF
> If you keep this list sorted then merge issues are less likely.
Noted, will sort this list.

> > +config KERNEL_MMU_REGION_BASE_BOOL
> > +	bool "Set custom kernel MMU region base address"
> > +	depends on ADVANCED_OPTIONS
> > +	help
> > +	  This option allows you to set the virtual address of the kernel MMU region.
> > +
> > +	  Say N here unless you know what you are doing.
> 
> All Nios2 specific options should be prefixed with NIOS2_
> This is what is done for all new arch specific symbols.
Noted, will add NIOS2 prefix to these CONFIGs.
> 
> > diff --git a/arch/nios2/boot/Makefile b/arch/nios2/boot/Makefile

> > +	$(call if_changed,gzip)
> > +
> > +$(obj)/vmImage: $(obj)/vmlinux.gz
> > +	$(call if_changed,uimage)
> > +	@$(kecho) 'Kernel: $@ is ready'
> 
> Add:
> targets += vmlinux.bin vmlinux.gz vmImage
> to make $(call if_changed ... actually work.
Sure, will change to this way.

> 
> 
> > +obj-y += cpuinfo.o insnemu.o irq.o nios2_ksyms.o process.o prom.o ptrace.o \
> > +	 setup.o signal.o sys_nios2.o syscall_table.o time.o traps.o
> 
> In new stuff try to avoid using ... \
> to contatenate lines.
> Use:
> obj-y += xxx
> 
> This is much more readable.
> 
Will fix this.
