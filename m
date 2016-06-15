Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:38263 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbcFOSkX (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2016 14:40:23 -0400
Date: Wed, 15 Jun 2016 20:40:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH-tip v2 1/6] locking/osq: Make lock/unlock proper
 acquire/release barrier
Message-ID: <20160615184007.GW30921@twins.programming.kicks-ass.net>
References: <1465944489-43440-1-git-send-email-Waiman.Long@hpe.com>
 <1465944489-43440-2-git-send-email-Waiman.Long@hpe.com>
 <20160615165659.GC2094@linux-80c1.suse>
 <20160615171250.GO30921@twins.programming.kicks-ass.net>
 <20160615182724.GD2094@linux-80c1.suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160615182724.GD2094@linux-80c1.suse>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Waiman Long <Waiman.Long@hpe.com>, Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
Message-ID: <20160615184007.hUxCq7TOqaEIEjMiQnNwRCz7EQdH7eqGeHXnFuOjh-Q@z>

On Wed, Jun 15, 2016 at 11:27:24AM -0700, Davidlohr Bueso wrote:
> On Wed, 15 Jun 2016, Peter Zijlstra wrote:
> 
> >In any case, its fairly simple to cure, just add
> >smp_acquire__after_ctrl_dep() at the end. If we bail because
> >need_resched() we don't need the acquire I think.
> 
> I was just considering this for your smp_cond_acquire/smp_cond_load_acquire

Right, so that need_resched break makes that a bit awkward. Not to
mention the cpu_relaxed() vs cpu_relaxed_lowlatency() difference.

> rework, so yeah I guess an smp_acquire__after_ctrl_dep would be a nice
> compromise.
> 
> However, I was always under the impression that races with node->locked were
> rather harmless (as indicated in the mentioned commit) -- which is why ->locked
> are simple load/stores, with the exception of the unqueueing -- but yeah, that's
> not even paired.

Yeah, see a few patches further in this series, where he guards a
variables with the osq_lock.
