From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Date: Wed, 8 Jul 2020 10:41:06 +0200
Message-ID: <20200708084106.GE597537@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-ppc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1594101082.hfq9x5yact.astroid@bobo.none>
Sender: kvm-ppc-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Waiman Long <longman@redhat.com>, Anton Blanchard <anton@ozlabs.org>, Boqun Feng <boqun.feng@gmail.com>, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, virtualization@lists.linux-foundation.org, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Jul 07, 2020 at 03:57:06PM +1000, Nicholas Piggin wrote:
> Yes, powerpc could certainly get more performance out of the slow
> paths, and then there are a few parameters to tune.

Can you clarify? The slow path is already in use on ARM64 which is weak,
so I doubt there's superfluous serialization present. And Will spend a
fair amount of time on making that thing guarantee forward progressm, so
there just isn't too much room to play.

> We don't have a good alternate patching for function calls yet, but
> that would be something to do for native vs pv.

Going by your jump_label implementation, support for static_call should
be fairly straight forward too, no?

  https://lkml.kernel.org/r/20200624153024.794671356@infradead.org
