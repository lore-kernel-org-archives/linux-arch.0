From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 09/12] unicore32 machine related files: hardware registers
Date: Sat, 26 Feb 2011 14:16:09 +0100
Message-ID: <201102261416.10050.arnd@arndb.de>
References: <015301cbcdae$55cdb7e0$016927a0$@mprc.pku.edu.cn> <201102221519.03423.arnd@arndb.de> <010f01cbd5b0$09980830$1cc81890$@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49654 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751227Ab1BZNQR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 Feb 2011 08:16:17 -0500
In-Reply-To: <010f01cbd5b0$09980830$1cc81890$@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 'Greg KH' <greg@kroah.com>

On Saturday 26 February 2011, Guan Xuetao wrote:
> > >  #ifndef __ASSEMBLY__
> > >
> > > -# define __REG(x)      (*((volatile unsigned long *)io_p2v(x)))
> > > -# define __PREG(x)     (io_v2p((unsigned long)&(x)))
> > > +# define __REG(x)      (void __iomem *)io_p2v(x)
> > 
> > The patch looks correct, but if you make the the definition for
> > PKUNITY_MMIO_BASE contain the cast to (void __iomem *), you no
> > longer need another cast.
>
> Because the io_p2v(x) calculate x and PKUNITY_IOSPACE_BASE,
> all registers should be added with (void __iomem *).
> So I prefer to remain the previous patch.

The problem with the definition of io_p2v is that it gives you
an type that is impossible to use correctly, except in assembly
code. Linux assumes that MMIO registers in virtual space
are __iomem pointers, and we like that to be consistent.

If you have a function that returns a virtual address, it should
really have the same type as any other function that uses a virtual
address.

	Arnd
