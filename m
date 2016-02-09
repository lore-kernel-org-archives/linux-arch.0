Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:40667 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075AbcBIOgh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 9 Feb 2016 09:36:37 -0500
Date: Tue, 9 Feb 2016 14:35:54 +0000
From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: linux-next: Tree for Feb 9
Message-ID: <20160209143554.GA9332@leverpostej>
References: <20160209164104.4ecaa0ce@canb.auug.org.au>
 <20160209073428.GA24863@sudip-pc>
 <20160209120032.GB19840@leverpostej>
 <CAMuHMdWLk10EovfQdyVodpw98_MiNOgGBxpVO-WPXShdvff94g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWLk10EovfQdyVodpw98_MiNOgGBxpVO-WPXShdvff94g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next <linux-next@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Linux-Arch <linux-arch@vger.kernel.org>, Laura Abbott <labbott@fedoraproject.org>
Message-ID: <20160209143554.nK89PXJiJvuTi6u-ASdmuMKErcek0yrHx_rwI4KvV0k@z>

On Tue, Feb 09, 2016 at 02:48:26PM +0100, Geert Uytterhoeven wrote:
> On Tue, Feb 9, 2016 at 1:00 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Feb 09, 2016 at 01:04:28PM +0530, Sudip Mukherjee wrote:
> >> On Tue, Feb 09, 2016 at 04:41:04PM +1100, Stephen Rothwell wrote:
> >> > Changes since 20160208:
> >>
> >> tilepro, tilegx, mips defconfig build fails with the error:
> >> ../include/asm-generic/fixmap.h: In function '__set_fixmap_offset':
> >> ../include/asm-generic/fixmap.h:77:2: error: implicit declaration of
> >> function '__set_fixmap' [-Werror=implicit-function-declaration]
> >>
> >> caused by:
> >> commit ac4c0ac73485 ("asm-generic: make __set_fixmap_offset a static inline")
> >>
> >> Reverting the commit fixes the issue.
> >
> > Sorry about this.
> >
> > Is seems any arch without its own __set_fixmap may be adversely
> > affected.
> >
> > I can't easily stub __set_fixmap as it's not implemented as a macro.
> 
> But you can add a forward declaration?

Good point. That seems to work (tested on arm64, mips, tilegx).

Arnd, Catalin, happy with the bloew fixup to the original patch?

Mark.

---->8----
