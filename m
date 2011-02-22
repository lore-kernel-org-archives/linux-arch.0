From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 09/12] unicore32 machine related files: hardware registers
Date: Tue, 22 Feb 2011 15:19:03 +0100
Message-ID: <201102221519.03423.arnd@arndb.de>
References: <015301cbcdae$55cdb7e0$016927a0$@mprc.pku.edu.cn> <201102181142.42614.arnd@arndb.de> <018601cbd29a$118b27c0$34a17740$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <018601cbd29a$118b27c0$34a17740$@mprc.pku.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 'Greg KH' <greg@kroah.com>
List-Id: linux-arch.vger.kernel.org

On Tuesday 22 February 2011, Guan Xuetao wrote:
> > > diff --git a/arch/unicore32/include/mach/hardware.h b/arch/unicore32/include/mach/hardware.h
> > > index 3fb7236..ebce7de 100644
> > > --- a/arch/unicore32/include/mach/hardware.h
> > > +++ b/arch/unicore32/include/mach/hardware.h
> > > @@ -17,19 +17,14 @@
> > >
> > >  #include "PKUnity.h"
> > >
> > > -#define io_p2v(x)  ((x) - PKUNITY_IOSPACE_BASE)
> > > -#define io_v2p(x)  ((x) + PKUNITY_IOSPACE_BASE)
> > > +#define io_p2v(x)  ((x) - PKUNITY_MMIO_BASE)
> > > +#define io_v2p(x)  ((x) + PKUNITY_MMIO_BASE)
> > >
> I apply the patch as following:
> 
> @@ -22,8 +22,7 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -# define __REG(x)      (*((volatile unsigned long *)io_p2v(x)))
> -# define __PREG(x)     (io_v2p((unsigned long)&(x)))
> +# define __REG(x)      (void __iomem *)io_p2v(x)

The patch looks correct, but if you make the the definition for
PKUNITY_MMIO_BASE contain the cast to (void __iomem *), you no
longer need another cast.

> __REG reserved only for all registers prefix.
> And all using for __REG converted to readl/writel.

Fair enough.

	Arnd
