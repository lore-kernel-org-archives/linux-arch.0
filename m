From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: Generic section maintainers
Date: Wed, 3 Aug 2016 22:25:13 +0200
Message-ID: <20160803202513.GU3296@wotan.suse.de>
References: <CAB=NE6VpHJLicvrKhPhQD4p+hNRCpvPJU7AXFAQdxXeDWfPLJQ@mail.gmail.com>
 <4940990.NJeuzLZEL9@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54769 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932589AbcHCUpT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 3 Aug 2016 16:45:19 -0400
Content-Disposition: inline
In-Reply-To: <4940990.NJeuzLZEL9@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joe Perches <joe@perches.com>

On Wed, Aug 03, 2016 at 10:11:48PM +0200, Arnd Bergmann wrote:
> On Wednesday, August 3, 2016 12:56:22 PM CEST Luis R. Rodriguez wrote:
> > Arnd, Josh,
> > 
> > In my linker table work [0], other than the linker table work and
> > section ranges stuff, I'm adding:
> > 
> > o include/linux/sections.h
> > o include/asm-generic/section-core.h (not in RFC v3 but it is in my
> > RFC v4 series not yet posted, splitting this up fixes compilation on
> > powerpc which otherwise creates a header issue nightmare to resolve)
> > 
> > I extend include/asm-generic/sections.h to then include
> > <asm-generic/section-core.h>, and furthermore provide the beginning of
> > a central place to document in a central place all common sections.
> > 
> > As per checkpatch complaints I'll be adding myself to MAINTAINERS for
> > the linker table headers, section ranges, but noticed then we don't
> > have anyone in particularly looking carefully after
> > include/asm-generic/sections.h other than the default which is Arnd.
> > Given this work on streamlining the section stuff, I'd like to help so
> > am considering adding a specific entry on MAINTAINRERS for generic
> > sections and adding myself to it along with Arnd. Wanted to check if
> > this is OK. While at it, it occurred to me that you might be
> > interested in this a swell Josh, given your work with objtool. Would
> > anyone else like to help with active maintenance / review of these ?
> 
> I'd rather not be listed separately for this file, I'm not really
> an expert on linker scripts, and checkpatch.pl will pick up my
> address anyway.

I'm definitely not an expert on linker scripts, nor do I think many folk are, I
just need to get work done and by chance have gotten involved into dark creepy
corners.

> With my name removed from the entry, please add
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

OK I'll fold the changes into the patch provided Josh is also OK
with it, but will keep the ACK out given that the patch has other
changes, I'd hope for a review upon the next respin.

> If you want, I can still merge the patches for these files through
> my asm-generic git tree, but then I'd rely on you to pick them
> up and forward them after review.

Sure.

  Luis
