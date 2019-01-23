From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/4] locking/qspinlock: Handle > 4 slowpath nesting
 levels
Date: Wed, 23 Jan 2019 21:40:38 +0100
Message-ID: <20190123204038.GL13777@hirez.programming.kicks-ass.net>
References: <1548215351-18896-1-git-send-email-longman@redhat.com>
 <1548215351-18896-2-git-send-email-longman@redhat.com>
 <20190123093424.GE15019@brain-police>
 <63131030-bd24-34bf-10dc-b5e7c7c177be@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <63131030-bd24-34bf-10dc-b5e7c7c177be@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 23, 2019 at 03:11:19PM -0500, Waiman Long wrote:
> On 01/23/2019 04:34 AM, Will Deacon wrote:
> > On Tue, Jan 22, 2019 at 10:49:08PM -0500, Waiman Long wrote:

> >> @@ -412,6 +412,21 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
> >>  	idx = node->count++;
> >>  	tail = encode_tail(smp_processor_id(), idx);

> >> +	if (unlikely(idx >= MAX_NODES)) {
> >> +		while (!queued_spin_trylock(lock))
> >> +			cpu_relax();
> >> +		goto release;
> >> +	}

> So the additional code checks the idx value and branch to the end of the
> function when the condition is true. There isn't too much overhead here.

So something horrible we could do (and I'm not at all advocating we do
this), is invert node->count. That is, start at 3 and decrement and
detect sign flips.

That avoids the additional compare. It would require we change the
structure layout though, otherwise we keep hitting that second line by
default, which would suck.
