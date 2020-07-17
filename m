Return-Path: <SRS0=028w=A4=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:32944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbgGQU0W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 17 Jul 2020 16:26:22 -0400
Date: Fri, 17 Jul 2020 15:26:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH 11/22] pci: lto: fix PREL32 relocations
Message-ID: <20200717202620.GA768846@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624203200.78870-12-samitolvanen@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Message-ID: <20200717202620._IQNT6VXNHUkvA1fgRrIO_dGyxvV4j3Ky3mC_4PKnx8@z>

OK by me, but please update the subject to match convention:

  PCI: Fix PREL32 relocations for LTO

and include a hint in the commit log about what LTO is.  At least
expand the initialism once.  Googling for "LTO" isn't very useful.

  With Clang's Link Time Optimization (LTO), the compiler ... ?

On Wed, Jun 24, 2020 at 01:31:49PM -0700, Sami Tolvanen wrote:
> With LTO, the compiler can rename static functions to avoid global
> naming collisions. As PCI fixup functions are typically static,
> renaming can break references to them in inline assembly. This
> change adds a global stub to DECLARE_PCI_FIXUP_SECTION to fix the
> issue when PREL32 relocations are used.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index c79d83304e52..1e65e16f165a 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -1909,19 +1909,24 @@ enum pci_fixup_pass {
>  };
>  
>  #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
> -#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
> -				    class_shift, hook)			\
> -	__ADDRESSABLE(hook)						\
> +#define ___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
> +				    class_shift, hook, stub)		\
> +	void stub(struct pci_dev *dev) { hook(dev); }			\
>  	asm(".section "	#sec ", \"a\"				\n"	\
>  	    ".balign	16					\n"	\
>  	    ".short "	#vendor ", " #device "			\n"	\
>  	    ".long "	#class ", " #class_shift "		\n"	\
> -	    ".long "	#hook " - .				\n"	\
> +	    ".long "	#stub " - .				\n"	\
>  	    ".previous						\n");
> +
> +#define __DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
> +				  class_shift, hook, stub)		\
> +	___DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
> +				  class_shift, hook, stub)
>  #define DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
>  				  class_shift, hook)			\
>  	__DECLARE_PCI_FIXUP_SECTION(sec, name, vendor, device, class,	\
> -				  class_shift, hook)
> +				  class_shift, hook, __UNIQUE_ID(hook))
>  #else
>  /* Anonymous variables would be nice... */
>  #define DECLARE_PCI_FIXUP_SECTION(section, name, vendor, device, class,	\
> -- 
> 2.27.0.212.ge8ba1cc988-goog
> 
