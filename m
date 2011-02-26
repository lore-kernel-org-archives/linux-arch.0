From: "Guan Xuetao" <gxt@mprc.pku.edu.cn>
Subject: RE: [PATCH 09/12] unicore32 machine related files: hardware registers
Date: Sat, 26 Feb 2011 20:23:54 +0800
Message-ID: <010f01cbd5b0$09980830$1cc81890$@mprc.pku.edu.cn>
References: <015301cbcdae$55cdb7e0$016927a0$@mprc.pku.edu.cn> <201102181142.42614.arnd@arndb.de> <018601cbd29a$118b27c0$34a17740$@mprc.pku.edu.cn> <201102221519.03423.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:51532 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752062Ab1BZMYH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 26 Feb 2011 07:24:07 -0500
In-Reply-To: <201102221519.03423.arnd@arndb.de>
Content-Language: zh-cn
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Arnd Bergmann' <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 'Greg KH' <greg@kroah.com>



> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Tuesday, February 22, 2011 10:19 PM
> To: Guan Xuetao
> Cc: linux-kernel@vger.kernel.org; linux-arch@vger.kernel.org; 'Greg KH'
> Subject: Re: [PATCH 09/12] unicore32 machine related files: hardware registers
> 
> On Tuesday 22 February 2011, Guan Xuetao wrote:
> > > > diff --git a/arch/unicore32/include/mach/hardware.h b/arch/unicore32/include/mach/hardware.h
> > > > index 3fb7236..ebce7de 100644
> > > > --- a/arch/unicore32/include/mach/hardware.h
> > > > +++ b/arch/unicore32/include/mach/hardware.h
> > > > @@ -17,19 +17,14 @@
> > > >
> > > >  #include "PKUnity.h"
> > > >
> > > > -#define io_p2v(x)  ((x) - PKUNITY_IOSPACE_BASE)
> > > > -#define io_v2p(x)  ((x) + PKUNITY_IOSPACE_BASE)
> > > > +#define io_p2v(x)  ((x) - PKUNITY_MMIO_BASE)
> > > > +#define io_v2p(x)  ((x) + PKUNITY_MMIO_BASE)
> > > >
> > I apply the patch as following:
> >
> > @@ -22,8 +22,7 @@
> >
> >  #ifndef __ASSEMBLY__
> >
> > -# define __REG(x)      (*((volatile unsigned long *)io_p2v(x)))
> > -# define __PREG(x)     (io_v2p((unsigned long)&(x)))
> > +# define __REG(x)      (void __iomem *)io_p2v(x)
> 
> The patch looks correct, but if you make the the definition for
> PKUNITY_MMIO_BASE contain the cast to (void __iomem *), you no
> longer need another cast.
Because the io_p2v(x) calculate x and PKUNITY_IOSPACE_BASE,
all registers should be added with (void __iomem *).
So I prefer to remain the previous patch.

> 
> > __REG reserved only for all registers prefix.
> > And all using for __REG converted to readl/writel.
> 
> Fair enough.
> 
> 	Arnd
