From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [patch] mutex: optimise generic mutex implementations
Date: Thu, 23 Oct 2008 15:43:58 +1100
Message-ID: <1224737038.7654.385.camel@pasglop>
References: <20081012054634.GA12535@wotan.suse.de>
	 <20081022155923.GM23060@elte.hu>
Reply-To: benh@kernel.crashing.org
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:44111 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275AbYJWEo3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 23 Oct 2008 00:44:29 -0400
In-Reply-To: <20081022155923.GM23060@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Nick Piggin <npiggin@suse.de>, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, Peter Zijlstra <a.p.zijlstra@chello.nl>

On Wed, 2008-10-22 at 17:59 +0200, Ingo Molnar wrote:
> * Nick Piggin <npiggin@suse.de> wrote:
> 
> > Speed up generic mutex implementations.
> > 
> > - atomic operations which both modify the variable and return something imply
> >   full smp memory barriers before and after the memory operations involved
> >   (failing atomic_cmpxchg, atomic_add_unless, etc don't imply a barrier because
> >   they don't modify the target). See Documentation/atomic_ops.txt.
> >   So remove extra barriers and branches.
> >   
> > - All architectures support atomic_cmpxchg. This has no relation to
> >   __HAVE_ARCH_CMPXCHG. We can just take the atomic_cmpxchg path unconditionally
> > 
> > This reduces a simple single threaded fastpath lock+unlock test from 590 cycles
> > to 203 cycles on a ppc970 system.
> > 
> > Signed-off-by: Nick Piggin <npiggin@suse.de>
> 
> no objections here. Lets merge these two patches via the ppc tree, so 
> that it gets testing on real hardware as well?
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

Allright but in that case it will be after -rc1 unless I manage to sneak
something in tomorrow before linux closes the merge window.

I can't get an update today.

Cheers,
Ben.
