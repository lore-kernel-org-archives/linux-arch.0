Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794346866;
	b=hjRwvMuxrbRidPAjVkzQtLYCn6Hkr6AglNTXXFhzySUp17DD5MGdJ8awrm3vZHR8D5ro
	 Km0STFH4ElAKcd1UkpcQmzNAwwuC457UbKB1ybSaXgOhyUPWO7kMHo2t2+pDfH1wVsI/E
	 qcCOSbY3rQLf7yds//SR0fxWFOB4E87nVOdkt7yH41Ywt6HMm8tMU2FnQzyyVrQ3ni5fl
	 yAiPXdru8N1QfqdOpsV+sf03A4ECej78oGV8Nih6DHVWcVrZuHk/J36KqjGpss29Ow9nb
	 7MyhnmQafnbkpnr+xz79sBhpwZFg5HSWhULqFR/npn1XNcl8Aur0GK2JWoaDTOG6ycg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794346866;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ixtMpyKuVqmLfVyWTMJcyq03enkowkj0Yu9R7AxinZw=;
	b=Vwv6gapqNScUJt7Ts4aEcaYE9KGCLm+JWH3mzmee5h3+mFflRrdn3xp6Ru46T2UNW26j
	 bnsSRQRKaLuRFr20c/59gmxru2JfNAxOgXRblKlnoarIgCwgR/64NCdXYnOERuSgpdizo
	 Pg22G4plzGwVxnEZfILyaZW2wyORQ2Yny/gyijfMZzZs/6QFmMbxo1BOjyxoNqbwM7Y1Q
	 yyzhIOxPynioMx5QPuGuIgruc//aPwXbkx6dgl6m2USMTxZOw6WENyrb5QDKA1X2/Aah9
	 3yHfUbCDDCrKA7ppplnoopagvqwHi7Lyt1KSBgpLfAfmhlhTJ7BSPXk+SYNftnzhzpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqmIHHbt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CB9606A31C;
	Tue, 10 Nov 2026 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqmIHHbt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACD21F0089F;
	Tue, 10 Nov 2026 21:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794346865;
	bh=ixtMpyKuVqmLfVyWTMJcyq03enkowkj0Yu9R7AxinZw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=KqmIHHbt+4MlcGinjX1CG7dHiX9tx+oK36luFINyilzOaq5cJJApc11n3HySfT7yf
	 zpGRr83a0DNMuyIPmAGLrbJim0iBYy0tsjvszsevhKKEdL/G4/VhqaW35upQeMQU95
	 Kh/KRrwWPYgDMZQDJunIi9JuoPi0aaq/iV/OQ6b4TQOABSIqT11Vd8/DOajxKSJ9K8
	 q+kvvJ0qltSMVaOVuvnfLLh1NZXtwxrxsBxbw2aFHE7v0T79MFvAcNiTixyG2/sV4T
	 Ec8FF0wDq9R3A6LGZ/SQdXKUp/eKTcMpRlcoKKaIlookEGnZ7ylssapLz78U3skVEa
	 m1p5VNVBIM3ag==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 334F8CE0AD8; Tue, 10 Nov 2026 13:41:05 -0800 (PST)
Date: Tue, 10 Nov 2026 13:41:05 -0800
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
Subject: Re: [PATCH 08/28] hazptrtorture: Add slowpath and lockdep scenarios
Message-ID: <3433f88a-027a-4f70-be5b-2c35f9318fd4@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-9-kunwu.chan@gmail.com>
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
In-Reply-To: <20261104165504.2430480-9-kunwu.chan@gmail.com>

On Thu, Nov 05, 2026 at 12:54:26AM +0800, Kunwu Chan wrote:
> Add SLOWPATH and LOCKDEP configs: SLOWPATH enables
> CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH for slow-path stress; LOCKDEP
> combines PROVE_LOCKING with wq_churn=1 so each alloc_workqueue/
> destroy_workqueue pair exercises the lockdep hazptr paths.
> 
> Suggested-by: Boqun Feng <boqun@kernel.org>

Could the --kconfigs and --bootargs kvm.sh parameters be used here
as well?  My concern is the proliferation of almost-identical scenario
files.

							Thanx, Paul

> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> ---
>  kernel/rcu/hazptrtorture.c                    | 48 ++++++++++++++++++-
>  .../rcutorture/configs/hazptr/LOCKDEP         | 16 +++++++
>  .../rcutorture/configs/hazptr/LOCKDEP.boot    |  1 +
>  .../rcutorture/configs/hazptr/SLOWPATH        | 16 +++++++
>  4 files changed, 79 insertions(+), 2 deletions(-)
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.boot
>  create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH
> 
> diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
> index c8b7c208775b..fe09280d063c 100644
> --- a/kernel/rcu/hazptrtorture.c
> +++ b/kernel/rcu/hazptrtorture.c
> @@ -23,6 +23,7 @@
>  #include <linux/torture.h>
>  #include <linux/hazptr.h>
>  #include <linux/rcupdate.h>
> +#include <linux/workqueue.h>
>  
>  #include "rcu.h"
>  
> @@ -51,6 +52,8 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
>  torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s");
>  torture_param(int, stutter, 5, "Number of seconds to run/halt test");
>  torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
> +torture_param(bool, wq_churn, false,
> +	      "Churn workqueues to exercise lockdep dynamic keys");
>  
>  static char *torture_type = "hazptr";
>  module_param(torture_type, charp, 0444);
> @@ -62,6 +65,7 @@ static struct task_struct *preempt_task;
>  static struct task_struct **reader_tasks;
>  static struct task_struct *do_pending_task;
>  static struct task_struct *stats_task;
> +static struct task_struct *wq_churn_task;
>  
>  #define HAZPTR_TORTURE_PIPE_LEN 10
>  
> @@ -83,6 +87,7 @@ static atomic_t n_hazptr_torture_alloc;
>  static atomic_t n_hazptr_torture_alloc_fail;
>  static atomic_t n_hazptr_torture_free;
>  static atomic_t n_hazptr_torture_error;
> +static atomic_t n_hazptr_torture_wq_churn;
>  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_acquires);
>  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases);
>  static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_acquires_irq);
> @@ -668,13 +673,14 @@ hazptr_torture_stats_print(void)
>  		atomic_read(&n_hazptr_torture_alloc_fail),
>  		atomic_read(&n_hazptr_torture_free));
>  	torture_onoff_stats();
> -	pr_cont("acq: %lld rel: %lld acqirq: %lld relirq: %lld reldefer: %lld relundefer %lld\n",
> +	pr_cont("acq: %lld rel: %lld acqirq: %lld relirq: %lld reldefer: %lld relundefer %lld wqchurn: %d\n",
>  		torture_sum_pcpu_atomic_long(&hazptr_torture_acquires),
>  		torture_sum_pcpu_atomic_long(&hazptr_torture_releases),
>  		torture_sum_pcpu_atomic_long(&hazptr_torture_acquires_irq),
>  		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_irq),
>  		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_defer),
> -		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_undefer));
> +		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_undefer),
> +		atomic_read(&n_hazptr_torture_wq_churn));
>  
>  	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
>  	if (i > 1) {
> @@ -788,6 +794,38 @@ static int hazptr_torture_preempt(void *unused)
>  	return 0;
>  }
>  
> +static void hazptr_torture_wq_churn_fn(struct work_struct *work)
> +{
> +}
> +
> +/*
> + * Repeatedly create and destroy workqueues.  Each workqueue creation
> + * registers a lockdep dynamic key and each destruction unregisters it,
> + * which exercises both is_dynamic_key() and lockdep_unregister_key().
> + */
> +static int hazptr_torture_wq_churn(void *unused)
> +{
> +	VERBOSE_TOROUT_STRING("hazptr_torture_wq_churn task started");
> +	do {
> +		struct workqueue_struct *wq;
> +		struct work_struct churn_work;
> +
> +		wq = alloc_workqueue("hazptr-torture-churn", WQ_PERCPU, 1);
> +		if (!wq) {
> +			torture_hrtimeout_ms(10, 10, NULL);
> +			continue;
> +		}
> +		INIT_WORK(&churn_work, hazptr_torture_wq_churn_fn);
> +		queue_work(wq, &churn_work);
> +		flush_work(&churn_work);
> +		destroy_workqueue(wq);
> +		atomic_inc(&n_hazptr_torture_wq_churn);
> +		stutter_wait("hazptr_torture_wq_churn");
> +	} while (!torture_must_stop());
> +	torture_kthread_stopping("hazptr_torture_wq_churn");
> +	return 0;
> +}
> +
>  static void
>  hazptr_torture_cleanup(void)
>  {
> @@ -880,6 +918,7 @@ static int __init hazptr_torture_init(void)
>  	atomic_set(&n_hazptr_torture_alloc_fail, 0);
>  	atomic_set(&n_hazptr_torture_free, 0);
>  	atomic_set(&n_hazptr_torture_error, 0);
> +	atomic_set(&n_hazptr_torture_wq_churn, 0);
>  	for (i = 0; i < HAZPTR_TORTURE_PIPE_LEN + 1; i++)
>  		atomic_set(&hazptr_torture_wcount[i], 0);
>  	for_each_possible_cpu(cpu) {
> @@ -960,6 +999,11 @@ static int __init hazptr_torture_init(void)
>  		if (torture_init_error(firsterr))
>  			goto unwind;
>  	}
> +	if (wq_churn) {
> +		firsterr = torture_create_kthread(hazptr_torture_wq_churn, NULL, wq_churn_task);
> +		if (torture_init_error(firsterr))
> +			goto unwind;
> +	}
>  
>  	torture_init_end();
>  	return 0;
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP b/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP
> new file mode 100644
> index 000000000000..f0ff29925a54
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP
> @@ -0,0 +1,16 @@
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
> +CONFIG_DEBUG_LOCK_ALLOC=y
> +CONFIG_PROVE_LOCKING=y
> +CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> +CONFIG_DEBUG_KERNEL=y
> +CONFIG_HAZPTR_DEBUG=y
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.boot b/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.boot
> new file mode 100644
> index 000000000000..7b16720214bd
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.boot
> @@ -0,0 +1 @@
> +hazptrtorture.wq_churn=1
> diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH b/tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH
> new file mode 100644
> index 000000000000..4d13028ca84c
> --- /dev/null
> +++ b/tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH
> @@ -0,0 +1,16 @@
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
> +CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
> +CONFIG_DEBUG_KERNEL=y
> +CONFIG_HAZPTR_DEBUG=y
> +CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH=y
> -- 
> 2.43.0
> 
