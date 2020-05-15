From: Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH v3 23/23] arm64: mte: Add Memory Tagging Extension
 documentation
Date: Fri, 15 May 2020 13:53:32 +0100
Message-ID: <20200515125332.GF27289@arm.com>
References: <20200430162316.GJ2717@gaia>
 <20200504164617.GK30377@arm.com>
 <20200511164018.GC19176@gaia>
 <20200513154845.GT21779@arm.com>
 <20200514113722.GA1907@gaia>
 <20200515103839.GA22393@gaia>
 <20200515111359.GC27289@arm.com>
 <20200515112740.GB22393@gaia>
 <20200515120433.GE27289@arm.com>
 <20200515121343.GC22393@gaia>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-eopbgr10084.outbound.protection.outlook.com ([40.107.1.84]:47921
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726226AbgEOMx6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 08:53:58 -0400
Content-Disposition: inline
In-Reply-To: <20200515121343.GC22393@gaia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org, Richard Earnshaw <Richard.Earnshaw@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, nd@arm.com

The 05/15/2020 13:13, Catalin Marinas wrote:
> On Fri, May 15, 2020 at 01:04:33PM +0100, Szabolcs Nagy wrote:
> > The 05/15/2020 12:27, Catalin Marinas wrote:
> > > Thanks Szabolcs. While we are at this, no-one so far asked for the
> > > GCR_EL1.RRND to be exposed to user (and this implies RGSR_EL1.SEED).
> > > Since RRND=1 guarantees a distribution "no worse" than that of RRND=0, I
> > > thought there isn't much point in exposing this configuration to the
> > > user. The only advantage of RRND=0 I see is that the kernel can change
> > 
> > it seems RRND=1 is the impl specific algorithm.
> 
> Yes, that's the implementation specific algorithm which shouldn't be
> worse than the standard one.
> 
> > > the seed randomly but, with only 4 bits per tag, it really doesn't
> > > matter much.
> > > 
> > > Anyway, mentioning it here in case anyone is surprised later about the
> > > lack of RRND configurability.
> > 
> > i'm not familiar with how irg works.
> 
> It generates a random tag based on some algorithm.
> 
> > is the seed per process state that's set up at process startup in some
> > way? or shared (and thus effectively irg is non-deterministic in
> > userspace)?
> 
> The seed is only relevant if the standard algorithm is used (RRND=0).

i wanted to understand if we can get deterministic
irg behaviour in user space (which may be useful
for debugging to get reproducible tag failures).

i guess if no control is exposed that means non-
deterministic irg. i think this is fine.
