Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794347598;
	b=ON5yWVE/tr3yrfuK2h/XLVcPO9HvCBbYVNwQuyOSMSKOyYfoL7M9pAP1wIE0JQooa5dM
	 9XM2OaBh32frp6oPQPq/NVzWYr3JkIDtat1Kfv+pgrwTjnqbNY9NcN/KHYj1oHcWlv157
	 pcuWA24yLIssZzrD71m5IWbeiGVrcN76b3GyQt0J+XfPoOE+momfZW7JK7zLVG2gKTsQW
	 bCDHHSSp9oOijhJFn7rzVaPMfcQtOlOSXw8QuFmMhgm3+71TBHnf2AvM9jFzTgZ2UBffc
	 beN2mpN8BdHlPjvv+ZdhiygC/9sODyk3jpE8XM5ouGf8L3IErVpQHZ6IxK4u9LGP4PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794347598;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=J3Tm3LfocnilDHyhWuC7rkIy8QOYHrv2ikEgku1d61s=;
	b=PJyFcJVhpAtIaEJZdyfnmsR785lW+zA+pHnAzxu52BhDwQd7IS8VJjZotrvd29WSSfjC
	 aSUqLnL5EziuMYxAwYHpwS28HDE/4xtQvpoGW0H+32fzlsIFvPvXe3p5TRlbwwPXuqoq3
	 o1Hnsy/qTfNrZO8fleLE8ldbgUjniK3o0pV2gcdd6k3fYNkVK4pR1ARmLpAv90liznTSx
	 ctdPbnJelZ0Bv3P4l88mRmY1Lk7yK8GglGBR83QnV+tro3FTnGaCattRmMhQ80BaL3MHX
	 JxJf8E8yZ79GqXMvwxtHnqrNn8FsYupfdvCevSX8g24oO/jUQMv3YMljCT3FUKyUlug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isEOLsUL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19E4606A321;
	Tue, 10 Nov 2026 21:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isEOLsUL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA2F51F0089F;
	Tue, 10 Nov 2026 21:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794347597;
	bh=J3Tm3LfocnilDHyhWuC7rkIy8QOYHrv2ikEgku1d61s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=isEOLsUL2XzmjViGWI8oo5zrxqHPb2U826zuow3M6oaeEgyxoCJ7p1ug0+HtJQu4L
	 69Dzjv9vx91IVXFT23h6s7S0zLXn9V/YG3Sh+TeVIfohJySWVyXoxjI4KdTQPcnEzG
	 gJv5Hp4Ozuvajs5mRCsnTWRLoI05Fa0AS/hH74Fq7CwuXHjDbdzMuvpYnmzNDtdbwL
	 DRwO4t8Fv470GAq251YGMW2vZ+4xzfsgs/KARNuWz3ZTar6wzovCFzhd2DouX3XTF/
	 QSomk7EFNaGcH/fx7U7cxJiikqAIvcD3QqmOjemJuyaMcC6Z35ehnQgy77FhLOon0D
	 IpF1A6gBIbQ8g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6BB19CE0AD8; Tue, 10 Nov 2026 13:53:17 -0800 (PST)
Date: Tue, 10 Nov 2026 13:53:17 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: boqun@kernel.org, mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com, corbet@lwn.net, mingo@redhat.com,
	frederic@kernel.org, neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org, urezki@gmail.com, dave@stgolabs.net,
	stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
	dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
	akiyks@gmail.com, dlustig@nvidia.com, joelagnelf@nvidia.com,
	skhan@linuxfoundation.org, rdunlap@infradead.org,
	longman@redhat.com, rostedt@goodmis.org, qiang.zhang@linux.dev,
	brads@mainlining.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org, rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 21/28] hazptrtorture: Add HOTADDR and LONGHOLD scenarios
Message-ID: <7b19da25-076a-439d-b365-5e881f0f7d84@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-22-kunwu.chan@gmail.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104165504.2430480-22-kunwu.chan@gmail.com>

On Thu, Nov 05, 2026 at 12:54:39AM +0800, Kunwu Chan wrote:
> HOTADDR: stages the sticky-address forward-progress scenario.
> LONGHOLD: validates legitimate long-held references.
> 
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Continuing on the register_trace_*() point, one approach would be to make
the module parameters needing this to be under "#ifdef CONFIG_TRACING"
and provide no-op functions as needed.

							Thanx, Paul

> ---
>  kernel/rcu/hazptrtorture.c                    | 384 +++++++++++++++++-
>  .../rcutorture/configs/hazptr/CFLIST          |   2 +
>  .../rcutorture/configs/hazptr/HOTADDR         |  18 +
>  .../rcutorture/configs/hazptr/HOTADDR.boot    |   1 +
>  .../rcutorture/configs/hazptr/LONGHOLD        |  18 +
>  .../rcutorture/configs/hazptr/LONGHOLD.boot   |   1 +
>  6 files changed, 419 insertions(+), 5 deletions(-)
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR.boot
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD.boot
> 
> diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
> index fe09280d063c..5dbe04af7515 100644
> --- a/kernel/rcu/hazptrtorture.c
> +++ b/kernel/rcu/hazptrtorture.c
> @@ -24,6 +24,7 @@
>  #include <linux/hazptr.h>
>  #include <linux/rcupdate.h>
>  #include <linux/workqueue.h>
> +#include <trace/events/hazptr.h>
>  
>  #include "rcu.h"
>  
> @@ -54,6 +55,15 @@ torture_param(int, stutter, 5, "Number of seconds to run/halt test");
>  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
>  torture_param(bool, wq_churn, false,
>  	      "Churn workqueues to exercise lockdep dynamic keys");
> +torture_param(int, nhotreaders, 0,
> +	      "Hot-addr hammer readers, 0 disables Lai-scenario");
> +torture_param(int, hot_hold_us, 20000,
> +	      "Hammer reader hold (us)");
> +torture_param(int, hot_hammer_ms, 3000, "Hammer window (ms)");
> +torture_param(int, hot_longhold_ms, 0,
> +	      "Long-hold round duration (ms), 0 disables; R0 holds past the stall timeout, no hammer");
> +torture_param(bool, starve_expected, false,
> +	      "Starvation episodes are expected (documenting mode)");
>  
>  static char *torture_type = "hazptr";
>  module_param(torture_type, charp, 0444);
> @@ -66,6 +76,22 @@ static struct task_struct **reader_tasks;
>  static struct task_struct *do_pending_task;
>  static struct task_struct *stats_task;
>  static struct task_struct *wq_churn_task;
> +static struct task_struct *hot_stage_task;
> +static struct task_struct *hot_r0_task;
> +static struct task_struct **hot_reader_tasks;
> +static int hot_target_storage;
> +static void *hot_addr = &hot_target_storage;
> +static atomic_t n_hot_syncs;
> +static atomic_t n_hot_starves;
> +static atomic_t n_hot_in_seq;
> +static atomic_t hot_live_syncs;		/* transient sync kthreads alive */
> +static atomic_t hot_hammer_holding;	/* hammer readers currently holding */
> +static atomic_t hot_r0_gate;		/* 1: R0 may acquire for this round */
> +static DECLARE_COMPLETION(hot_enqueued);
> +static DECLARE_COMPLETION(hot_sync_done);
> +static DECLARE_COMPLETION(r0_held);
> +static DECLARE_COMPLETION(r0_release);
> +static bool hot_hammer_active;
>  
>  #define HAZPTR_TORTURE_PIPE_LEN 10
>  
> @@ -87,13 +113,13 @@ static atomic_t n_hazptr_torture_alloc;
>  static atomic_t n_hazptr_torture_alloc_fail;
>  static atomic_t n_hazptr_torture_free;
>  static atomic_t n_hazptr_torture_error;
> -static atomic_t n_hazptr_torture_wq_churn;
>  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_acquires);
>  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases);
>  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_acquires_irq);
>  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases_irq);
>  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases_defer);
>  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases_undefer);
> +static atomic_t n_hazptr_torture_wq_churn;
>  static struct list_head hazptr_torture_removed;
>  
>  // State for a deferred (AKA pending) hazard pointer
> @@ -681,6 +707,10 @@ hazptr_torture_stats_print(void)
>  		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_defer),
>  		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_undefer),
>  		atomic_read(&n_hazptr_torture_wq_churn));
> +	pr_cont(" hotsync: %d hotstarve: %d hotseq: %d",
> +		atomic_read(&n_hot_syncs),
> +		atomic_read(&n_hot_starves),
> +		atomic_read(&n_hot_in_seq));
>  
>  	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
>  	if (i > 1) {
> @@ -752,7 +782,8 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
>  		 "nest_acquire=%d "
>  		 "onoff_interval=%d onoff_holdoff=%d "
>  		 "preempt_duration=%d preempt_interval=%d "
> -		 "reader_sleep_us=%d "
> +		 "reader_sleep_us=%d wq_churn=%d "
> +		 "nhotreaders=%d hot_hold_us=%d hot_hammer_ms=%d "
>  		 "shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d "
>  		 "verbose=%d\n",
>  		 torture_type, tag, nrealreaders, nwriters,
> @@ -760,7 +791,8 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
>  		 nest_acquire,
>  		 onoff_interval, onoff_holdoff,
>  		 preempt_duration, preempt_interval,
> -		 reader_sleep_us,
> +		 reader_sleep_us, wq_churn,
> +		 nhotreaders, hot_hold_us, hot_hammer_ms,
>  		 shuffle_interval, shutdown_secs, stat_interval, stutter,
>  		 verbose);
>  }
> @@ -801,10 +833,14 @@ static void hazptr_torture_wq_churn_fn(struct work_struct *work)
>  /*
>   * Repeatedly create and destroy workqueues.  Each workqueue creation
>   * registers a lockdep dynamic key and each destruction unregisters it,
> - * which exercises both is_dynamic_key() and lockdep_unregister_key().
> + * which exercises both is_dynamic_key() and lockdep_unregister_key(),
> + * the two lockdep paths that use hazptr.  Most useful in kernels with
> + * CONFIG_PROVE_LOCKING=y and CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH=y.
>   */
>  static int hazptr_torture_wq_churn(void *unused)
>  {
> +	DEFINE_TORTURE_RANDOM(rand);
> +
>  	VERBOSE_TOROUT_STRING("hazptr_torture_wq_churn task started");
>  	do {
>  		struct workqueue_struct *wq;
> @@ -812,7 +848,7 @@ static int hazptr_torture_wq_churn(void *unused)
>  
>  		wq = alloc_workqueue("hazptr-torture-churn", WQ_PERCPU, 1);
>  		if (!wq) {
> -			torture_hrtimeout_ms(10, 10, NULL);
> +			torture_hrtimeout_ms(10, 10, &rand);
>  			continue;
>  		}
>  		INIT_WORK(&churn_work, hazptr_torture_wq_churn_fn);
> @@ -826,6 +862,271 @@ static int hazptr_torture_wq_churn(void *unused)
>  	return 0;
>  }
>  
> +/*
> + * Hot-addr staged scenario --- Lai's forward-progress test.
> + *
> + * Three persistent kthreads plus a per-round transient sync kthread:
> + *   hot_r0_task      old reader: acquires hot_addr, signals, waits
> + *                    for release command, then releases.
> + *   hot_reader_tasks hammer readers: tight acquire/release loops on
> + *                    hot_addr, long hold, near-zero gap, no stutter,
> + *                    kthread_bind'd to distinct CPUs.
> + *   hot_stage_task   orchestrator: drives the staged sequence round
> + *                    by round, recording starvation episodes.
> + *   hot_do_sync      transient per-round: hazptr_synchronize(hot_addr).
> + *
> + * A tracepoint on waiter-enqueue confirms the waiter is on
> + * hazptr_scan.pending before the orchestrator verifies the negative
> + * control (sync must NOT have completed while R0 holds).
> + */
> +
> +static void hot_probe_enqueue(void *__data, void *addr)
> +{
> +	if (addr == hot_addr)
> +		complete(&hot_enqueued);
> +}
> +
> +/* Per-round transient sync kthread.  hot_live_syncs lets the
> + * orchestrator and cleanup wait for exit, so no completion event
> + * from one round can leak into the next.
> + */
> +static int hazptr_torture_hot_do_sync(void *unused)
> +{
> +	hazptr_synchronize(hot_addr);
> +	complete(&hot_sync_done);
> +	atomic_dec(&hot_live_syncs);
> +	return 0;
> +}
> +
> +/* R0: acquires hot_addr, signals orchestrator, waits for release cmd.
> + * The release wait is timeout-bounded so kthread_stop() at cleanup can
> + * always join; the hazard pointer is always released before exit.
> + * The one-shot gate ensures R0 does not re-acquire immediately after
> + * releasing: re-acquisition is reserved for a new round, so a draining
> + * waiter is never blocked by R0 itself.
> + */
> +static int hazptr_torture_hot_r0(void *unused)
> +{
> +	struct hazptr_ctx ctx;
> +	void *p;
> +
> +	VERBOSE_TOROUT_STRING("hot_r0 task started");
> +	do {
> +		while (!atomic_read(&hot_r0_gate) && !torture_must_stop())
> +			schedule_timeout_interruptible(1);
> +		if (torture_must_stop())
> +			break;
> +		atomic_set(&hot_r0_gate, 0);
> +		p = hot_addr;
> +		(void)hazptr_acquire(&ctx, &p);
> +		complete(&r0_held);
> +		while (!wait_for_completion_timeout(&r0_release, HZ)) {
> +			if (torture_must_stop())
> +				break;
> +		}
> +		hazptr_release(&ctx, p);
> +	} while (!torture_must_stop());
> +	torture_kthread_stopping("hot_r0");
> +	return 0;
> +}
> +
> +/* Hammer reader: parks while not hammering (hot_hammer_active false),
> + * so it persists across rounds.  hot_hammer_holding counts live holds
> + * and lets the orchestrator hand off R0 only once a hammer reader
> + * actually holds the address -- no coverage gap at the seam.
> + */
> +static int hazptr_torture_hot_reader(void *arg)
> +{
> +	int cpu = (long)arg;
> +	struct hazptr_ctx ctx;
> +	void *p;
> +	DEFINE_TORTURE_RANDOM(rand);
> +
> +	set_cpus_allowed_ptr(current, cpumask_of(cpu));
> +	for (;;) {
> +		while (!READ_ONCE(hot_hammer_active) && !torture_must_stop())
> +			schedule_timeout_interruptible(1);
> +		if (torture_must_stop())
> +			break;
> +		p = hot_addr;
> +		p = hazptr_acquire(&ctx, &p);
> +		atomic_inc(&hot_hammer_holding);
> +		torture_hrtimeout_us(hot_hold_us, 100, &rand);
> +		hazptr_release(&ctx, p);
> +		atomic_dec(&hot_hammer_holding);
> +		torture_hrtimeout_us(1, 1, &rand);
> +	}
> +	torture_kthread_stopping("hot_reader");
> +	return 0;
> +}
> +
> +/*
> + * Orchestrator: one round per loop iteration.  All waits are
> + * timeout-bounded so cleanup can always join this task.
> + *
> + * Phase   Action
> + *  boot   Wait for R0's initial hold.
> + *   P2    Launch transient sync kthread; wait for tracepoint
> + *         confirmation (hot_enqueued).
> + *   P3    Negative control (non-consuming completion_done()): sync
> + *         must NOT be done while R0 still holds.
> + *   P4    Handoff: start hammer, wait until a hammer reader holds
> + *         (hot_hammer_holding > 0), then release R0 -- no gap.
> + *   P5    Hammer window: poll sync for hot_hammer_ms.
> + *         -> completes in window: n_hot_in_seq++.
> + *         -> still pending:       n_hot_starves++ (episode; counts
> + *            as test error only when !starve_expected).
> + *   P6    Positive control: stop hammer, sync must drain within 5 s
> + *         (skipped when P5 already observed completion).
> + *  bottom  Drain this round's sync kthread (hot_live_syncs), wait for
> + *          R0's next hold; jitter; loop unless must_stop.
> + */
> +static int hazptr_torture_hot_stage(void *unused)
> +{
> +	unsigned long round = 0;
> +	DEFINE_TORTURE_RANDOM(rand);
> +
> +	VERBOSE_TOROUT_STRING("hot_stage task started");
> +
> +	/* If the system is still booting, let it finish (same as the
> +	 * classic writer): a busy boot would make staged rounds record
> +	 * false starvation episodes and false stall splats. */
> +	while (!torture_must_stop() && !rcu_inkernel_boot_has_ended())
> +		schedule_timeout_interruptible(HZ);
> +
> +	do {
> +		u64 t_sync_start;
> +		int done_in_window = 0, positive_done;
> +		struct task_struct *sync_task;
> +
> +		reinit_completion(&r0_held);
> +		reinit_completion(&r0_release);
> +		reinit_completion(&hot_sync_done);
> +		reinit_completion(&hot_enqueued);
> +		WRITE_ONCE(hot_hammer_active, false);
> +
> +		/* Gate R0 into a fresh hold and wait for it. */
> +		atomic_set(&hot_r0_gate, 1);
> +		while (!wait_for_completion_timeout(&r0_held, HZ)) {
> +			if (torture_must_stop())
> +				goto out;
> +		}
> +
> +		/* P2: launch sync; confirm waiter enqueued. */
> +		t_sync_start = ktime_get_ns();
> +		atomic_inc(&hot_live_syncs);
> +		sync_task = kthread_run(hazptr_torture_hot_do_sync, NULL,
> +					"hot_do_sync");
> +		if (IS_ERR(sync_task)) {
> +			atomic_dec(&hot_live_syncs);
> +			pr_alert("%shot: sync kthread alloc failed r%lu\n",
> +				 TORTURE_FLAG, round);
> +			goto skip_round;
> +		}
> +		if (!wait_for_completion_timeout(&hot_enqueued, HZ)) {
> +			pr_alert("%shot: enqueue not confirmed r%lu\n",
> +				 TORTURE_FLAG, round);
> +			goto skip_round;
> +		}
> +
> +		/* P3 NEGATIVE CONTROL: sync must still be pending. */
> +		if (completion_done(&hot_sync_done)) {
> +			pr_alert("%shot: completed before R0 released r%lu\n",
> +				 TORTURE_FLAG, round);
> +			atomic_inc(&n_hazptr_torture_error);
> +		}
> +
> +		/*
> +		 * LONGHOLD variant: no hammer.  R0 legitimately holds
> +		 * past the stall timeout; the detector should report
> +		 * (observation, not interruption), and after release the
> +		 * sync must drain normally.  Validates that long-lived
> +		 * references -- an hazptr feature -- do not break the
> +		 * machinery and are not treated as errors.
> +		 */
> +		if (hot_longhold_ms) {
> +			torture_hrtimeout_ms(hot_longhold_ms, 100, &rand);
> +			complete(&r0_release);
> +			done_in_window = wait_for_completion_timeout(
> +				&hot_sync_done, 5 * HZ);
> +			if (!done_in_window) {
> +				pr_alert("%shot: longhold: sync did not drain after release r%lu\n",
> +					 TORTURE_FLAG, round);
> +				atomic_inc(&n_hazptr_torture_error);
> +			}
> +			atomic_inc(done_in_window ? &n_hot_in_seq
> +						  : &n_hot_starves);
> +			positive_done = done_in_window;
> +			{
> +				u64 dt = ktime_get_ns() - t_sync_start;
> +
> +				atomic_inc(&n_hot_syncs);
> +				pr_alert("%shot r%lu: longhold drain=%d dt_ns=%llu\n",
> +					 TORTURE_FLAG, round,
> +					 !!done_in_window, dt);
> +			}
> +			goto skip_round;
> +		}
> +
> +		/* P4: handoff -- hammer holds before R0 releases. */
> +		WRITE_ONCE(hot_hammer_active, true);
> +		while (!atomic_read(&hot_hammer_holding) &&
> +		       !torture_must_stop())
> +			schedule_timeout_interruptible(1);
> +		complete(&r0_release);
> +
> +		/* P5 HAMMER WINDOW. */
> +		done_in_window = wait_for_completion_timeout(
> +			&hot_sync_done, msecs_to_jiffies(hot_hammer_ms));
> +		if (done_in_window) {
> +			atomic_inc(&n_hot_in_seq);
> +		} else {
> +			atomic_inc(&n_hot_starves);
> +			if (!starve_expected)
> +				atomic_inc(&n_hazptr_torture_error);
> +		}
> +
> +		/* P6 POSITIVE CONTROL. */
> +		WRITE_ONCE(hot_hammer_active, false);
> +		if (done_in_window) {
> +			positive_done = 1;
> +		} else {
> +			positive_done = wait_for_completion_timeout(
> +				&hot_sync_done, 5 * HZ);
> +			if (!positive_done) {
> +				pr_alert("%shot: positive control timed out r%lu (machinery fault?)\n",
> +					 TORTURE_FLAG, round);
> +				atomic_inc(&n_hazptr_torture_error);
> +			}
> +		}
> +
> +		{
> +			u64 dt = ktime_get_ns() - t_sync_start;
> +
> +			atomic_inc(&n_hot_syncs);
> +			pr_alert("%shot r%lu: starve=%d in_seq=%d pos=%d dt_ns=%llu\n",
> +				 TORTURE_FLAG, round, !done_in_window,
> +				 !!done_in_window, positive_done, dt);
> +		}
> +
> +	skip_round:
> +		/* Release R0 (harmless if already released) so an
> +		 * orphan sync from a skipped round can drain. */
> +		complete(&r0_release);
> +		/* Drain this round's sync kthread: no completion event
> +		 * may cross the round boundary. */
> +		while (atomic_read(&hot_live_syncs) && !torture_must_stop())
> +			schedule_timeout_interruptible(1);
> +		/* R0 parks on the gate after its release; the next round
> +		 * opens the gate and waits for its fresh hold above. */
> +		round++;
> +		torture_hrtimeout_ms(500, 200, &rand);
> +	} while (!torture_must_stop());
> +out:
> +	torture_kthread_stopping("hot_stage");
> +	return 0;
> +}
> +
>  static void
>  hazptr_torture_cleanup(void)
>  {
> @@ -840,6 +1141,34 @@ hazptr_torture_cleanup(void)
>  
>  	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
>  	torture_stop_kthread(hazptr_torture_preempt, preempt_task);
> +	torture_stop_kthread(hazptr_torture_wq_churn, wq_churn_task);
> +
> +	/* Hot scenario: stop hammer readers first so pending syncs drain. */
> +	if (nhotreaders > 0 || hot_longhold_ms > 0) {
> +		int wait_ms = 5000;
> +
> +		WRITE_ONCE(hot_hammer_active, false);
> +		if (hot_reader_tasks) {
> +			for (i = 0; i < nhotreaders; i++)
> +				torture_stop_kthread(hazptr_torture_hot_reader,
> +						     hot_reader_tasks[i]);
> +			kfree(hot_reader_tasks);
> +			hot_reader_tasks = NULL;
> +		}
> +		torture_stop_kthread(hazptr_torture_hot_r0, hot_r0_task);
> +		torture_stop_kthread(hazptr_torture_hot_stage, hot_stage_task);
> +		/* Wait for any transient sync kthreads to exit so no
> +		 * module code is executing at unload. */
> +		while (atomic_read(&hot_live_syncs) && wait_ms > 0) {
> +			schedule_timeout_uninterruptible(msecs_to_jiffies(50));
> +			wait_ms -= 50;
> +		}
> +		if (atomic_read(&hot_live_syncs))
> +			pr_alert("%shot: %d sync kthread(s) still alive at exit\n",
> +				 TORTURE_FLAG, atomic_read(&hot_live_syncs));
> +		unregister_trace_hazptr_waiter_enqueue(hot_probe_enqueue, NULL);
> +	}
> +
>  	torture_stop_kthread(hazptr_torture_writer, writer_task);
>  
>  	if (reader_tasks) {
> @@ -873,6 +1202,8 @@ static int __init hazptr_torture_init(void)
>  	int firsterr = 0;
>  	static struct hazptr_torture_ops *torture_ops[] = { &hazptr_ops, &hazptr_stack_ops, };
>  
> +	if (!strcmp(torture_type, "none"))
> +		return 0;
>  	if (!torture_init_begin(torture_type, verbose))
>  		return -EBUSY;
>  
> @@ -919,6 +1250,10 @@ static int __init hazptr_torture_init(void)
>  	atomic_set(&n_hazptr_torture_free, 0);
>  	atomic_set(&n_hazptr_torture_error, 0);
>  	atomic_set(&n_hazptr_torture_wq_churn, 0);
> +	atomic_set(&n_hot_syncs, 0);
> +	atomic_set(&n_hot_starves, 0);
> +	atomic_set(&n_hot_in_seq, 0);
> +	atomic_set(&hot_r0_gate, 0);
>  	for (i = 0; i < HAZPTR_TORTURE_PIPE_LEN + 1; i++)
>  		atomic_set(&hazptr_torture_wcount[i], 0);
>  	for_each_possible_cpu(cpu) {
> @@ -1004,6 +1339,45 @@ static int __init hazptr_torture_init(void)
>  		if (torture_init_error(firsterr))
>  			goto unwind;
>  	}
> +	if (nhotreaders > 0 || hot_longhold_ms > 0) {
> +		int cpu = 0, j;
> +
> +		firsterr = register_trace_hazptr_waiter_enqueue(hot_probe_enqueue, NULL);
> +		if (firsterr) {
> +			pr_alert("%shot: tracepoint registration failed: %d\n",
> +				 TORTURE_FLAG, firsterr);
> +			goto unwind;
> +		}
> +
> +		if (nhotreaders > 0) {
> +			hot_reader_tasks = kcalloc(nhotreaders,
> +						  sizeof(hot_reader_tasks[0]),
> +						  GFP_KERNEL);
> +			if (!hot_reader_tasks) {
> +				firsterr = -ENOMEM;
> +				goto unwind;
> +			}
> +			for (j = 0; j < nhotreaders; j++) {
> +				cpu = cpumask_next(cpu % num_online_cpus(),
> +						   cpu_online_mask);
> +				if (cpu >= nr_cpu_ids)
> +					cpu = cpumask_first(cpu_online_mask);
> +				firsterr = torture_create_kthread(
> +					hazptr_torture_hot_reader,
> +					(void *)(long)cpu, hot_reader_tasks[j]);
> +				if (torture_init_error(firsterr))
> +					goto unwind;
> +			}
> +		}
> +		firsterr = torture_create_kthread(hazptr_torture_hot_r0, NULL,
> +						  hot_r0_task);
> +		if (torture_init_error(firsterr))
> +			goto unwind;
> +		firsterr = torture_create_kthread(hazptr_torture_hot_stage,
> +						  NULL, hot_stage_task);
> +		if (torture_init_error(firsterr))
> +			goto unwind;
> +	}
>  
>  	torture_init_end();
>  	return 0;
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
> index 90ef09b0e654..b3f6137ce8ab 100644
> --- a/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
> @@ -6,3 +6,5 @@ SLOWPATH
>  LOCKDEP
>  CPU128
>  CPU256
> +HOTADDR
> +LONGHOLD
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR b/tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR
> new file mode 100644
> index 000000000000..6f4d6746b63c
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR
> @@ -0,0 +1,18 @@
> +CONFIG_SMP=y
> +CONFIG_NR_CPUS=16
> +CONFIG_PREEMPT_NONE=n
> +CONFIG_PREEMPT_VOLUNTARY=n
> +CONFIG_PREEMPT=y
> +CONFIG_HZ_PERIODIC=n
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_NO_HZ_FULL=n
> +CONFIG_HOTPLUG_CPU=y
> +CONFIG_SUSPEND=n
> +CONFIG_HIBERNATION=n
> +CONFIG_PROVE_LOCKING=n
> +CONFIG_DEBUG_LOCK_ALLOC=n
> +CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> +CONFIG_DEBUG_KERNEL=y
> +CONFIG_HAZPTR_DEBUG=y
> +CONFIG_HAZPTR_STALL_DETECTOR=y
> +CONFIG_HAZPTR_STALL_TIMEOUT=1000
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR.boot b/tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR.boot
> new file mode 100644
> index 000000000000..878b588e2e39
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/HOTADDR.boot
> @@ -0,0 +1 @@
> +hazptrtorture.nreaders=0 hazptrtorture.nwriters=0 hazptrtorture.nhotreaders=4 hazptrtorture.hot_hold_us=20000 hazptrtorture.starve_expected=1 hazptrtorture.shutdown_secs=20
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD b/tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD
> new file mode 100644
> index 000000000000..fe293638bbe2
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD
> @@ -0,0 +1,18 @@
> +CONFIG_SMP=y
> +CONFIG_NR_CPUS=16
> +CONFIG_PREEMPT_NONE=n
> +CONFIG_PREEMPT_VOLUNTARY=n
> +CONFIG_PREEMPT=y
> +CONFIG_HZ_PERIODIC=n
> +CONFIG_NO_HZ_IDLE=y
> +CONFIG_NO_HZ_FULL=n
> +CONFIG_HOTPLUG_CPU=y
> +CONFIG_SUSPEND=n
> +CONFIG_HIBERNATION=n
> +CONFIG_PROVE_LOCKING=n
> +CONFIG_DEBUG_LOCK_ALLOC=n
> +CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> +CONFIG_DEBUG_KERNEL=y
> +CONFIG_HAZPTR_DEBUG=y
> +CONFIG_HAZPTR_STALL_DETECTOR=y
> +CONFIG_HAZPTR_STALL_TIMEOUT=2000
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD.boot b/tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD.boot
> new file mode 100644
> index 000000000000..cbe30b6a09cc
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/LONGHOLD.boot
> @@ -0,0 +1 @@
> +hazptrtorture.nreaders=0 hazptrtorture.nwriters=0 hazptrtorture.hot_longhold_ms=8000 hazptrtorture.shutdown_secs=40
> -- 
> 2.43.0
> 
