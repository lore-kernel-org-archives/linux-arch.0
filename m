From: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch] mutex: optimise generic mutex implementations
Date: Thu, 23 Oct 2008 09:02:08 +0200
Message-ID: <20081023070207.GA30765@wotan.suse.de>
References: <20081012054634.GA12535@wotan.suse.de> <20081022155923.GM23060@elte.hu> <1224737038.7654.385.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48283 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750785AbYJWHCK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Oct 2008 03:02:10 -0400
Content-Disposition: inline
In-Reply-To: <1224737038.7654.385.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, Peter Zijlstra <a.p.zijlstra@chello.nl>

On Thu, Oct 23, 2008 at 03:43:58PM +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2008-10-22 at 17:59 +0200, Ingo Molnar wrote:
> > * Nick Piggin <npiggin@suse.de> wrote:
> > 
> > > Speed up generic mutex implementations.
> > > 
> > > - atomic operations which both modify the variable and return something imply
> > >   full smp memory barriers before and after the memory operations involved
> > >   (failing atomic_cmpxchg, atomic_add_unless, etc don't imply a barrier because
> > >   they don't modify the target). See Documentation/atomic_ops.txt.
> > >   So remove extra barriers and branches.
> > >   
> > > - All architectures support atomic_cmpxchg. This has no relation to
> > >   __HAVE_ARCH_CMPXCHG. We can just take the atomic_cmpxchg path unconditionally
> > > 
> > > This reduces a simple single threaded fastpath lock+unlock test from 590 cycles
> > > to 203 cycles on a ppc970 system.
> > > 
> > > Signed-off-by: Nick Piggin <npiggin@suse.de>
> > 
> > no objections here. Lets merge these two patches via the ppc tree, so 
> > that it gets testing on real hardware as well?
> > 
> > Acked-by: Ingo Molnar <mingo@elte.hu>
> 
> Allright but in that case it will be after -rc1 unless I manage to sneak
> something in tomorrow before linux closes the merge window.
> 
> I can't get an update today.

Fine with me.

Thanks,
Nick
