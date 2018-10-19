Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42429 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeJTCZe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Oct 2018 22:25:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id i4-v6so16090142pgq.9
        for <linux-arch@vger.kernel.org>; Fri, 19 Oct 2018 11:18:23 -0700 (PDT)
Date: Fri, 19 Oct 2018 11:18:22 -0700 (PDT)
Subject: Re: [PATCH 6/9] PCI: consolidate PCI config entry in drivers/pci
In-Reply-To: <20181019120952.32763-7-hch@lst.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-153e4e0b-8fe9-4712-849f-f01455ef56f4@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: yamada.masahiro@socionext.com, mporter@kernel.crashing.org, alex.bou9@gmail.com, linux@dominikbrodowski.net, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-ID: <20181019181822.W1gM-nQwy2yiL_fUJxNK7zebdOQVfjT5l6N0Po1szIw@z>

On Fri, 19 Oct 2018 05:09:49 PDT (-0700), Christoph Hellwig wrote:
> There is no good reason to duplicate the PCI menu in every architecture.
> Instead provide a selectable HAVE_PCI symbol that indicates availability
> of PCI support and the handle the rest in drivers/pci.
>
> Note that for powerpc we now select HAVE_PCI globally instead of the
> convoluted mess of conditional or or non-conditional support per board,
> similar to what we do e.g. on x86.  For alpha PCI is selected for the
> non-jensen configs as it was the default before, and a lot of code does
> not compile without PCI enabled.  On other architectures with limited
> PCI support that wasn't as complicated I've left the selection as-is.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

...

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a344980287a5..071952cd4cae 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -39,8 +39,10 @@ config RISCV
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	select HAVE_ARCH_TRACEHOOK
> +	select HAVE_PCI
>  	select MODULES_USE_ELF_RELA if MODULES
>  	select THREAD_INFO_IN_TASK
> +	select PCI_MSI if PCI
>  	select RISCV_TIMER
>  	select GENERIC_IRQ_MULTI_HANDLER
>  	select ARCH_HAS_PTE_SPECIAL
> @@ -216,28 +218,12 @@ source "kernel/Kconfig.hz"
>
>  endmenu
>
> -menu "Bus support"
> -
> -config PCI
> -	bool "PCI support"
> -	select PCI_MSI
> -	help
> -	  This feature enables support for PCI bus system. If you say Y
> -	  here, the kernel will include drivers and infrastructure code
> -	  to support PCI bus devices.
> -
> -	  If you don't know what to do here, say Y.
> -
>  config PCI_DOMAINS
>  	def_bool PCI
>
>  config PCI_DOMAINS_GENERIC
>  	def_bool PCI
>
> -source "drivers/pci/Kconfig"
> -
> -endmenu
> -
>  menu "Power management options"
>
>  source kernel/power/Kconfig

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I'm assuming this will go in via PCI tree of some sort, so I'm not going to 
touch it any further.

Thanks for cleaning this up!
