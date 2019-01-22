From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/5] locking/qspinlock: Safely handle > 4 nesting levels
Date: Tue, 22 Jan 2019 05:44:19 +0000
Message-ID: <20190122054417.GC6445@brain-police>
References: <1548038994-30073-1-git-send-email-longman@redhat.com>
 <1548038994-30073-2-git-send-email-longman@redhat.com>
 <20190121091234.GG27931@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190121091234.GG27931@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Jan 21, 2019 at 10:12:34AM +0100, Peter Zijlstra wrote:
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 8a8c3c208c5e..983b49a75826 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -412,6 +412,12 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	idx = node->count++;
>  	tail = encode_tail(smp_processor_id(), idx);
>  
> +	if (idx >= MAX_NODES) {
> +		while (!queued_spin_trylock(lock))
> +			cpu_relax();
> +		goto release;
> +	}
> +
>  	node = grab_mcs_node(node, idx);

With an unlikely() and a comment, I /much/ prefer this approach!

Will
