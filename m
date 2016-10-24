From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] kbuild: provide include/asm/asm-prototypes.h for ARM
Date: Mon, 24 Oct 2016 17:04:31 +0200
Message-ID: <3446653.W8FbGAKSeQ@wuerfel>
References: <20161017065131.GA27863@angband.pl> <20161019153159.GQ1041@n2100.armlinux.org.uk> <20161020150814.42951f61@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:49728 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941097AbcJXPFt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2016 11:05:49 -0400
In-Reply-To: <20161020150814.42951f61@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, Michal Marek <mmarek@suse.com>, Adam Borowski <kilobyte@angband.pl>, Omar Sandoval <osandov@osandov.com>, Linus Torvalds <torvalds@linux-foundation.org>, adobriyan@gmail.com, sfr@canb.auug.org.au, viro@zeniv.linux.org.uk, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday, October 20, 2016 3:08:14 PM CEST Nicholas Piggin wrote:
> On Wed, 19 Oct 2016 16:32:00 +0100 Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
> > I'm not in favour of this.
> > 
> >    +extern void mmioset(void *, unsigned int, size_t);
> >    +extern void mmiocpy(void *, const void *, size_t);
> >    +
> >     #ifndef __ARMBE__
> >     static inline void memset_io(volatile void __iomem *dst, unsigned c,
> >            size_t count)
> >     {
> >    -       extern void mmioset(void *, unsigned int, size_t);
> >            mmioset((void __force *)dst, c, count);
> >     }
> > 
> > The reason they're declared _within_ memset_io() is to prevent people
> > from using them by hiding their declaration.  Moving them outside is
> > an open invitation to stupid people starting to use them as an "oh it
> > must be an official API".
> > 

I've split out that change from the other ones now, and will follow
up with the patch to address all the other ones first.

> Fair point, what about leaving those as they are, and also adding
> them to asm-prototypes.h protected with GENKSYMS ifdef? It's not
> beautiful, but still better than armksyms.c before Al's patches (or
> at least no worse).

I'm trying this one, and an alternative patch that moves the
export into arch/arm/kernel/io.h. Let's see if we can agree
on one of these.

	Arnd
