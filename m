Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57764 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733301AbfBMRZg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Feb 2019 12:25:36 -0500
Date: Wed, 13 Feb 2019 17:25:30 +0000
From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 2/2] arm64: io: Hook up __io_par() for inX() ordering
Message-ID: <20190213172528.GI6346@brain-police>
References: <20190211174544.4302-1-will.deacon@arm.com>
 <20190211174544.4302-3-will.deacon@arm.com>
 <CAMuHMdWFOvrZ5JwgWnx9ujg3dS-75PnjGRqn-vzGmFi295Sb=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWFOvrZ5JwgWnx9ujg3dS-75PnjGRqn-vzGmFi295Sb=A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, andrew.murray@arm.com, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>
Message-ID: <20190213172530.rcXaPpx33vaOAOsdBlT4X6dFPd6lQAWGJMyv3qtEnt4@z>

On Tue, Feb 12, 2019 at 11:42:44AM +0100, Geert Uytterhoeven wrote:
> On Mon, Feb 11, 2019 at 9:34 PM Will Deacon <will.deacon@arm.com> wrote:
> > Ensure that inX() provides the same ordering guarantees as readX()
> > by hooking up __io_par() so that it maps directly to __iormb().
> >
> > Reported-by: Andrew Murray <andrew.murray@arm.com>
> > Signed-off-by: Will Deacon <will.deacon@arm.com>
> 
> Thanks for your patch!
> 
> > --- a/arch/arm64/include/asm/io.h
> > +++ b/arch/arm64/include/asm/io.h
> > @@ -121,6 +121,7 @@ static inline u64 __raw_readq(const volatile void __iomem *addr)
> >                      : "memory");                                       \
> >  })
> >
> > +#define __io_par               __iormb
> 
> I think it makes sense to make the parameter passing explicit, for
> documentation purposes:
> 
>     #define __io_par(v)        __iormb(v)

Thanks, I'll make that change for v2.

Will
