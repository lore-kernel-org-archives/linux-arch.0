From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 7/7] ARM: atomics: define our SMP atomics in terms of
 _relaxed operations
Date: Thu, 16 Jul 2015 23:08:21 +0200
Message-ID: <20150716210821.GC19282@twins.programming.kicks-ass.net>
References: <1437060758-10381-1-git-send-email-will.deacon@arm.com>
 <1437060758-10381-8-git-send-email-will.deacon@arm.com>
 <55A816A3.1000502@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55A816A3.1000502@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <waiman.long@hp.com>
Cc: Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, paulmck@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

On Thu, Jul 16, 2015 at 04:40:03PM -0400, Waiman Long wrote:
> On 07/16/2015 11:32 AM, Will Deacon wrote:
> >@@ -117,6 +115,8 @@ static inline unsigned long __xchg(unsigned long x, volatile void *ptr, int size
> >  #error "SMP is not supported on this platform"

             ^^^^^^^^^^^^^

> >  #endif
> >
> >+#define xchg xchg_relaxed
> 
> Is that a typo? I think xchg() needs to be a full memory barrier.

Pointless on UP.
