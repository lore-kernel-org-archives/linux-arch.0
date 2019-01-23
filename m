From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 2/4] locking/qspinlock_stat: Track the no MCS node
 available case
Date: Wed, 23 Jan 2019 09:23:40 +0000
Message-ID: <20190123092339.GD15019@brain-police>
References: <1548215351-18896-1-git-send-email-longman@redhat.com>
 <1548215351-18896-3-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1548215351-18896-3-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Waiman Long <longman@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, Zhenzhong Duan <zhenzhong.duan@oracle.com>, James Morse <james.morse@arm.com>, SRINIVAS <srinivas.eeda@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Jan 22, 2019 at 10:49:09PM -0500, Waiman Long wrote:
> Track the number of slowpath locking operations that are being done
> without any MCS node available as well renaming lock_index[123] to make
> them more descriptive.
> 
> Using these stat counters is one way to find out if a code path is
> being exercised.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/qspinlock.c      |  3 ++-
>  kernel/locking/qspinlock_stat.h | 21 +++++++++++++++------
>  2 files changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 0875053..21ee51b 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -422,6 +422,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	 * simple enough.
>  	 */
>  	if (unlikely(idx >= MAX_NODES)) {
> +		qstat_inc(qstat_lock_no_node, true);
>  		while (!queued_spin_trylock(lock))
>  			cpu_relax();
>  		goto release;
> @@ -432,7 +433,7 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	/*
>  	 * Keep counts of non-zero index values:
>  	 */
> -	qstat_inc(qstat_lock_idx1 + idx - 1, idx);
> +	qstat_inc(qstat_lock_use_node2 + idx - 1, idx);
>  
>  	/*
>  	 * Ensure that we increment the head node->count before initialising
> diff --git a/kernel/locking/qspinlock_stat.h b/kernel/locking/qspinlock_stat.h
> index 42d3d8d..31728f6 100644
> --- a/kernel/locking/qspinlock_stat.h
> +++ b/kernel/locking/qspinlock_stat.h
> @@ -30,6 +30,13 @@
>   *   pv_wait_node	- # of vCPU wait's at a non-head queue node
>   *   lock_pending	- # of locking operations via pending code
>   *   lock_slowpath	- # of locking operations via MCS lock queue
> + *   lock_use_node2	- # of locking operations that use 2nd percpu node
> + *   lock_use_node3	- # of locking operations that use 3rd percpu node
> + *   lock_use_node4	- # of locking operations that use 4th percpu node
> + *   lock_no_node	- # of locking operations without using percpu node
> + *
> + * Subtraccting lock_use_node[234] from lock_slowpath will give you
> + * lock_use_node1.

Typo: "subtraccting"

Will
