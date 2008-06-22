From: Adrian Bunk <bunk@kernel.org>
Subject: Re: architectures with ARCH_SUPPORTS_AOUT but no binfmt_aout
Date: Sun, 22 Jun 2008 12:49:07 +0300
Message-ID: <20080622094907.GF27069@cs181133002.pp.htv.fi>
References: <1213565555.26255.522.camel@pmac.infradead.org> <1213604973-7073-1-git-send-email-jacmet@sunsite.dk> <1213617663.26255.708.camel@pmac.infradead.org> <20080616121727.GB10854@cs181133002.pp.htv.fi> <1213619214.26255.721.camel@pmac.infradead.org> <20080617084235.GA20169@cs181133002.pp.htv.fi> <1213696004.26255.960.camel@pmac.infradead.org> <20080617101112.GE20169@cs181133002.pp.htv.fi> <1213702113.26255.996.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-parisc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1213702113.26255.996.camel@pmac.infradead.org>
Sender: linux-parisc-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, linux-kernel@vger.kernel.org, sam@ravnborg.org, dhowells@redhat.com, andi@firstfloor.org, "Kirill A. Shutemov" <k.shutemov@gmail.com>, ysato@users.sourceforge.jp, takata@linux-m32r.org, linux-m32r@ml.linux-m32r.org, kyle@mcmartin.ca, matthew@wil.cx, grundler@parisc-linux.org, linux-parisc@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, gerg@uclinux.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 17, 2008 at 12:28:33PM +0100, David Woodhouse wrote:
> On Tue, 2008-06-17 at 13:11 +0300, Adrian Bunk wrote:
> > The pattern for this stuff is to provide a HAVE_AOUT kconfig variable 
> > that gets select'ed by these architectures.
> 
> http://git.infradead.org/users/dwmw2/aout-2.6.git?a=commitdiff;h=a5db5179
> 
> Subject: [PATCH] Introduce HAVE_AOUT symbol to remove hard-coded arch list for BINFMT_AOUT
> 
> HAVE_AOUT doesn't quite do the same thing as the recently removed
> ARCH_SUPPORTS_AOUT config option. That was set even on platforms where
> binfmt_aout isn't supported, although it's not entirely clear why.
> 
> So it's best just to introduce a new symbol, handled consistently with
> other similar HAVE_xxx symbols; with a simple 'select' the arch Kconfig.
> 
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>
> ---
>  arch/alpha/Kconfig |    1 +
>  arch/arm/Kconfig   |    1 +
>  arch/m68k/Kconfig  |    1 +
>  arch/x86/Kconfig   |    1 +
>  fs/Kconfig.binfmt  |    5 ++++-
>  5 files changed, 8 insertions(+), 1 deletions(-)
>...
> --- a/fs/Kconfig.binfmt
> +++ b/fs/Kconfig.binfmt
> @@ -59,9 +59,12 @@ config BINFMT_SHARED_FLAT
>  	help
>  	  Support FLAT shared libraries
>  
> +config HAVE_AOUT
> +       def_bool n
> +
>  config BINFMT_AOUT
>  	tristate "Kernel support for a.out and ECOFF binaries"
> -	depends on (X86_32 || ALPHA || ARM || M68K)
> +	depends on HAVE_AOUT
>  	---help---
>  	  A.out (Assembler.OUTput) is a set of formats for libraries and
>  	  executables used in the earliest versions of UNIX.  Linux used

What about m68knommu?

I don't know whether it was intentionally available there, but the 
removal in your patch does not seem to be intentional.

> dwmw2

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

