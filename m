From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/5] locking/qspinlock: Safely handle > 4 nesting levels
Date: Mon, 21 Jan 2019 10:12:34 +0100
Message-ID: <20190121091234.GG27931@hirez.programming.kicks-ass.net>
References: <1548038994-30073-1-git-send-email-longman@redhat.com>
 <1548038994-30073-2-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548038994-30073-2-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 20, 2019 at 09:49:50PM -0500, Waiman Long wrote:
> +/**
> + *  acquire_lock_no_node - acquire lock without MCS node
> + *  @lock: Pointer to queued spinlock structure
> + *
> + *  It is extremely unlikely that this function will ever be called.
> + *  Marking it as noinline to not mess with the slowpath code. This
> + *  function is for native qspinlock only. The PV qspinlock code has
> + *  its own simpler version.
> + *
> + *  -----          -----  |   ----      -----          -----
> + * |Tail2| <- ... |Head2| |  |Node| <- |Tail1| <- ... |Head1|
> + *  -----          -----  |   ----      -----          -----
> + *                   |                                   |
> + *                   V                                   V
> + *             Spin on waiting                     Spin on locked
> + *
> + * The waiting and the pending bits will be acquired first which are now
> + * used as a separator for the disjointed queue shown above.
> + *
> + * The current CPU will then be inserted into queue by placing a special
> + * _Q_TAIL_WAITING value into the tail and makes the current tail
> + * point to its own local node. The next incoming CPU will see the special
> + * tail, but it has no way to find the node. Instead, it will spin on the
> + * waiting bit. When that bit is cleared, it means that all the the
> + * previous CPUs in the queue are gone and current CPU is the new lock
> + * holder. 

I know it's monday morning and I've not had wake-up juice yet, but I
don't think that's true.

Consider there being two CPUs that ran out of nodes and thus we have two
tail fragments waiting on the one waiting bit.

There is no sane wait to recover from this.. and stay fair, why are we
trying?

That is; what's the problem with the below?

Yes it sucks, but it is simple and doesn't introduce 100+ lines of code
that 'never' gets used.

---
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index 8a8c3c208c5e..983b49a75826 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -412,6 +412,12 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
 	idx = node->count++;
 	tail = encode_tail(smp_processor_id(), idx);
 
+	if (idx >= MAX_NODES) {
+		while (!queued_spin_trylock(lock))
+			cpu_relax();
+		goto release;
+	}
+
 	node = grab_mcs_node(node, idx);
 
 	/*
