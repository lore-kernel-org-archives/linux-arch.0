From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: [PATCH] asm-generic/io.h: remove unnecessary include of
 linux/vmalloc.h
Date: Tue, 5 Sep 2017 17:21:35 +0200
Message-ID: <20170905152134.GB5028@distanz.ch>
References: <20170905112727.13668-1-tklauser@distanz.ch>
 <CAK8P3a3R_12CdsL85tW+Y9cWMuQ0E-CMU9TyseLjj9GczbwnhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:56121 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751480AbdIEPVi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Sep 2017 11:21:38 -0400
Content-Disposition: inline
In-Reply-To: <CAK8P3a3R_12CdsL85tW+Y9cWMuQ0E-CMU9TyseLjj9GczbwnhA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 2017-09-05 at 17:11:50 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Sep 5, 2017 at 1:27 PM, Tobias Klauser <tklauser@distanz.ch> wrote:
> > Including linux/vmalloc.h in asm-generic/io.h isn't necessary since none
> > of the definitions are used in the header itself. Remove the include in
> > order to avoid potential header dependency problems if other headers
> > rely on implict inclusion of linux/vmalloc.h which means that changes
> > there could break unrelated parts.
> >
> > Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> > ---
> >  include/asm-generic/io.h | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> > index b4531e3b2120..d2d3bd163f5f 100644
> > --- a/include/asm-generic/io.h
> > +++ b/include/asm-generic/io.h
> > @@ -764,7 +764,6 @@ static inline void iowrite64_rep(volatile void __iomem *addr,
> >
> >  #ifdef __KERNEL__
> >
> > -#include <linux/vmalloc.h>
> >  #define __io_virt(x) ((void __force *)(x))
> >
> >  #ifndef CONFIG_GENERIC_IOMAP
> 
> This seems like a good idea in principle, but I think it needs to be tested
> well before we apply it, to avoid breaking random drivers that forgot to
> add their own includes of that header.

Yes, this certainly needs extensive testing. I already did several
randconfig builds on multiple platforms locally. Also, I sent the same
patch a while ago to LKML already as a fix (which wasn't sufficient) [1]
in order to get the kbuild test bot to test it ;)

  [1] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1392578.html

And indeed, the kbuild test bot failed on multiple drivers as a result
of me submitting this patch back then and I successively sent patches to
fix the fallout. Now all of them are merged.

> I've added your patch to my testing queue, but not to the asm-generic
> tree now. We should see if it leads to any randconfig build regressions
> on the architectures I normally test.

Thanks!

> Did you run into a specific problem with the #include, or did it just occur
> to you that it might help in general?

See above. Sorry, I should have mentioned it in the original patch
submission but I forgot about the full history and only tried to
reconstruct it now that you asked ;)

Tobias
