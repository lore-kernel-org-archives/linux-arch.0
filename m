From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [RFC PATCH v2 4/6] arm64: signal: Allocate extra sigcontext
 space as needed
Date: Tue, 6 Jun 2017 17:15:52 +0100
Message-ID: <20170606161552.wgufjtgipdffkmyv@localhost>
References: <1492016239-19511-1-git-send-email-Dave.Martin@arm.com>
 <1492016495-19689-1-git-send-email-Dave.Martin@arm.com>
 <1492016495-19689-4-git-send-email-Dave.Martin@arm.com>
 <20170512165724.GB8387@e104818-lin.cambridge.arm.com>
 <20170515132442.GB3559@e103592.cambridge.arm.com>
 <20170523113019.GB5948@e104818-lin.cambridge.arm.com>
 <20170526113729.GO3559@e103592.cambridge.arm.com>
 <20170605141744.GB9163@e104818-lin.cambridge.arm.com>
 <20170606113739.GF30160@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:49128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751427AbdFFQP5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jun 2017 12:15:57 -0400
Content-Disposition: inline
In-Reply-To: <20170606113739.GF30160@e103592.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Martin <Dave.Martin@arm.com>
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org

On Tue, Jun 06, 2017 at 12:37:53PM +0100, Dave P Martin wrote:
> On Mon, Jun 05, 2017 at 03:17:44PM +0100, Catalin Marinas wrote:
> > On Fri, May 26, 2017 at 12:37:32PM +0100, Dave P Martin wrote:
> > > On Tue, May 23, 2017 at 12:30:19PM +0100, Catalin Marinas wrote:
> > > > BTW, does SIGFRAME_MAXSZ now become ABI? Or the user only needs to
> > > > interrogate the frame size and we keep this internal to the kernel?
> > > 
> > > If the kernel rejects extra_contexts that cause this limit to be
> > > exceeded, then yes -- though it will rarely be relevant except in the
> > > case of memory corruption, or if architecture extensions eventually
> > > require a larger frame.
> > > 
> > > (sve_context could theoretically grow larger then SIGFRAME_MAXSZ all by
> > > itself, but that's unlikely to happen any time soon.)
> > > 
> > > Userspace could hit SIGFRAME_MAXSZ by constructing a valid sequence of
> > > records that is ridiculously large, by padding out the records: common
> > > sense suggests not to do this, but it's never been documented or
> > > enforced.  I didn't feel comfortable changing the behaviour here to be
> > > more strict.
> > > 
> > > So, SIGFRAME_MAXSZ should either be given a larger, more future-proof
> > > value ... or otherwise we should perhaps get rid of it entirely.
> > 
> > If we can, yes, I would get rid of it.
> 
> If the size field is retained I prefer to keep this, but it's
> deliberately not in any header.  This allows the kernel to have a
> stricter idea about what is sane, without it formally being ABI.
> 
> This is supposed to be a deterrent against people writing signal frame
> code manipulation code in a stupid way.  SIGFRAME_MAXSZ should only
> ever be increased during maintenance -- it's probably worth adding a
> comment on that point.

Fine by me.

-- 
Catalin
