From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH v2] memory-barriers: remove
 smp_mb__after_unlock_lock()
Date: Mon, 13 Jul 2015 17:56:06 +0200
Message-ID: <20150713155606.GC19282@twins.programming.kicks-ass.net>
References: <1436789704-10086-1-git-send-email-will.deacon@arm.com>
 <55A3B89E.7060708@hurleysoftware.com>
 <20150713142418.GF2632@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:57460 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbbGMP4P (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 13 Jul 2015 11:56:15 -0400
Content-Disposition: inline
In-Reply-To: <20150713142418.GF2632@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>

On Mon, Jul 13, 2015 at 03:24:18PM +0100, Will Deacon wrote:
> On Mon, Jul 13, 2015 at 02:09:50PM +0100, Peter Hurley wrote:
> > On 07/13/2015 08:15 AM, Will Deacon wrote:
> > > smp_mb__after_unlock_lock is used to promote an UNLOCK + LOCK sequence
> > > into a full memory barrier.
> > >
> > > However:
> > >
> > >   - This ordering guarantee is already provided without the barrier on
> > >     all architectures apart from PowerPC
> > >
> > >   - The barrier only applies to UNLOCK + LOCK, not general
> > >     RELEASE + ACQUIRE operations
> > 
> > I'm unclear what you mean here: do you mean
> > A) a memory barrier is not required between RELEASE M + ACQUIRE N when you
> >    want to maintain distinct order between those operations on all arches
> >    (with the possible exception of PowerPC), or,
> > B) no one is using smp_mb__after_unlock_lock() in that way right now.
> 
> My understanding is (B), but Peter and I don't seem to agree yet!
> I'll tighten up the text once we reach a conclusion.

I'm fairly sure (but I've not looked) that nobody does in fact rely on
this.

So I'm in agreement with B, and I'm quibbling on what exactly A means
;-)
