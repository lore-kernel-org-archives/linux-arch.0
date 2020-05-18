From: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v3 23/23] arm64: mte: Add Memory Tagging Extension
 documentation
Date: Mon, 18 May 2020 17:52:23 +0100
Message-ID: <20200518165223.GB5031@arm.com>
References: <20200504164617.GK30377@arm.com>
 <20200511164018.GC19176@gaia>
 <20200513154845.GT21779@arm.com>
 <20200514113722.GA1907@gaia>
 <20200515103839.GA22393@gaia>
 <20200515111359.GC27289@arm.com>
 <20200515112740.GB22393@gaia>
 <20200515120433.GE27289@arm.com>
 <20200515121343.GC22393@gaia>
 <20200515125332.GF27289@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:44338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERQw1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 12:52:27 -0400
Content-Disposition: inline
In-Reply-To: <20200515125332.GF27289@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-arch@vger.kernel.org, Richard Earnshaw <Richard.Earnshaw@arm.com>, nd@arm.com, Will Deacon <will@kernel.org>, Andrey Konovalov <andreyknvl@google.com>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Vincenzo Frascino <vincenzo.frascino@arm.com>, Peter Collingbourne <pcc@google.com>, linux-arm-kernel@lists.infradead.org

On Fri, May 15, 2020 at 01:53:32PM +0100, Szabolcs Nagy wrote:
> The 05/15/2020 13:13, Catalin Marinas wrote:
> > On Fri, May 15, 2020 at 01:04:33PM +0100, Szabolcs Nagy wrote:
> > > The 05/15/2020 12:27, Catalin Marinas wrote:
> > > > Thanks Szabolcs. While we are at this, no-one so far asked for the
> > > > GCR_EL1.RRND to be exposed to user (and this implies RGSR_EL1.SEED).
> > > > Since RRND=1 guarantees a distribution "no worse" than that of RRND=0, I
> > > > thought there isn't much point in exposing this configuration to the
> > > > user. The only advantage of RRND=0 I see is that the kernel can change
> > > 
> > > it seems RRND=1 is the impl specific algorithm.
> > 
> > Yes, that's the implementation specific algorithm which shouldn't be
> > worse than the standard one.
> > 
> > > > the seed randomly but, with only 4 bits per tag, it really doesn't
> > > > matter much.
> > > > 
> > > > Anyway, mentioning it here in case anyone is surprised later about the
> > > > lack of RRND configurability.
> > > 
> > > i'm not familiar with how irg works.
> > 
> > It generates a random tag based on some algorithm.
> > 
> > > is the seed per process state that's set up at process startup in some
> > > way? or shared (and thus effectively irg is non-deterministic in
> > > userspace)?
> > 
> > The seed is only relevant if the standard algorithm is used (RRND=0).
> 
> i wanted to understand if we can get deterministic
> irg behaviour in user space (which may be useful
> for debugging to get reproducible tag failures).
> 
> i guess if no control is exposed that means non-
> deterministic irg. i think this is fine.

Hmmm, I guess this might eventually be wanted.  But it's probably OK not
to have it to begin with.

Things like CRIU restores won't be reproducible unless the seeds can be
saved/restored.

Doesn't seem essential from day 1 though.

Cheers
---Dave
