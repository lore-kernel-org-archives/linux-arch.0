Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C3D51EDF7
	for <linux-arch@vger.kernel.org>; Mon,  5 Oct 2026 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220725; cv=none; b=tpiizbArsznEehfczxy3hwSM9/wnN9BvqP5e40HoykX1kICA20LG1hoF4ZyDdmAME37WGHWKuYQJrHAkvEIlB50fOwxiB2TOB6iiPgPOm9Sm7agDLBNSekD5AQr4qdM8t3hn6p2XM9fg2x/Syq4lW0hS2FqkfSbJVqxIpnXtSgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220725; c=relaxed/simple;
	bh=C2wOzyIOv3PKV0kqXDjtVyjEqQMMN4LevJPzrcZB1UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DuB/9HaqTFRi65dRDd1nYDUMJxwbwJVz6iMLPdXbjpKD8LN9gFBraC98v7p8HRAVQQKeKfB34f2EaTxhsErNgrHih035eT7trEWPTHo2CFRXmCX7VzaQn6DgYZngoo9L141cwYYDS7Jm6O577YWot9EN2cGyIlUGJQz3/xGvt4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aLE5dfsj; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLE5dfsj"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a82eab3fb0so446880a91.1
        for <linux-arch@vger.kernel.org>; Mon, 05 Oct 2026 10:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791220722; x=1791825522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W8wrdTJQlbRjUn5NpoPjM6vdB6JwNJfV9JGCjAJWWp8=;
        b=aLE5dfsjKYwur/GumgLWARhWG3wDCJ1unCTqKpUlcWU5/I+v+p4rN8XKd2+b2W1Ip8
         YAxwwsGqrYU62d6LUVIhXSRxxsG9T2n0Eei5v95XGrEokv4UHju2Lat2nXK201D8Gflk
         xdkGzQ/KlaOoJ1CAGsMTwmpigUmuABmmV0L7rw6qTLC+S6CWpdhBZNrbKz2jjmIF8chu
         /FbcDhdXvdjQeTkFKvYTFyEg7ZuxNN6QFmD6FU/nhWo3lfO/zx8XOt5EmwwhtGl4MqjK
         p0ny8OOhWIHCLNvmrpK/tE0HYOaVd7k2GI+rsxH4q1g+3aIJ7MAtZ8QZkb5wEu8Rg1I9
         F4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791220722; x=1791825522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W8wrdTJQlbRjUn5NpoPjM6vdB6JwNJfV9JGCjAJWWp8=;
        b=zTxJjQuIyj94kWsBoLMrV0EE51z/mPsHldjuXth4TWODLpt9D2esWnsulQfmLTXe6q
         RSeUXSvJlyv/HiA8z4eBkHzYQIpCXQAEZ1XRxHyTysPMIOyr44y4pVmR9/65X3g8L0j8
         BHxtqm4I7MqZsMwL7sbrOov23Lq2W4EvPVxXag6egq5zIjRmHdeHOFEXgUL7F92yfoAy
         BB5jUfFGGXCYtZkB0cJd41kZ1K2HHCkFFsLXuQMhLWHbEbwYPVZ57sDD1Do0IOhVrYmP
         gX6ACCPDQk8s/tYByJbGUl/cc05UEK70oOJS9afdPmIWjHT5PAQIK27qX+xiat27rcxk
         lvSw==
X-Forwarded-Encrypted: i=1; AKwUvBxoy96VaBjYnpo9Zz8fMX6XbNrOF7+ujDVuy0aTr0p97i8dlpZ6HN9/VhKFSUOtqjODatxwyjtbg9rd@vger.kernel.org
X-Gm-Message-State: AFq9FYI6FlJYIEJRWXdf5Z2C3NP4yUbTpL4bn9VUu/s7EWHhYW0mbucO
	rA796wMihV70QMPXocmtBw6Yr6wkG0YP0k83vgZBL2so2OKCbngMUVnS
X-Gm-Gg: AYBFou0ApfeHAagNE8plYXoLHY1VD/4D5XRHzxdCrmn0w2EOf/7rD1d/HJqGaQ6Q0Ov
	GO3TVHevsPTZ36eiZt0UCGs/u6A50tzYGCOzgSGkjBGujClUONeDk0lILECEgl8NXKuSJZoRw7K
	hHlNDeeSGOsE6/MFbnJNa9ZLuHfL/FraXPy7HKAVSDYnwbu55lRSJdzpGmiBpt9nsOVKIhm9N+Q
	ZOmZ27ZpYZETi2BjXQYpkl75kqYdl5pKfv1l8sjBji2Fbg79fJWuFj8jRN/JtIW8ly2MOkSyoyD
	+PWo5SAvyLcnl0bNq6LmRcTdLXLAxVKF//q0uOp6wniwJwSk0iZMawz7EqjjkvBxKOj+/V/mVQj
	KF6uzjaiRxHEmxd9ngZibB2Vc2uasKo2thdBSL2iq9+tkR3x8woDH/ieCgvz9HNOeHlmOU23ybp
	wf9EyWHliHbkMVBJ8Tj06g4whKaIj4Tw1LjPHe2bXJIpUhbGY2hVVfmpNPajNEeUNK4ctArbsXo
	Ckq4+O7ze5FxgCmzB5+y9eiEYJMRw==
X-Received: by 2002:a17:90b:6c5:b0:3a0:809b:1972 with SMTP id 98e67ed59e1d1-3a6ce7916bbmr8589810a91.26.1791220721836;
        Mon, 05 Oct 2026 10:18:41 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cafddesm406910a91.10.2026.10.05.10.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:18:41 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net,
	lianux.mm@gmail.com
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun@kernel.org,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH RFC v3 12/15] hazptrtorture: add slowpath and lockdep scenarios
Date: Tue,  6 Oct 2026 01:15:26 +0800
Message-ID: <20261005171529.1378809-13-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005171529.1378809-1-kunwu.chan@gmail.com>
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a wq_churn kthread and module parameter to exercise lockdep
dynamic-key handling by repeatedly creating and destroying
workqueues.  Each workqueue creation registers a dynamic lock
class key and each destruction unregisters it, exercising both
is_dynamic_key() and lockdep_unregister_key().

Add SLOWPATH and LOCKDEP torture scenarios to exercise the
hazptr acquire slow path, including its use by lockdep under
CONFIG_PROVE_LOCKING.

Add both scenarios to CFLIST so that torture.sh --do-hazptr
includes them.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/hazptrtorture.c                    | 57 +++++++++++++++++--
 .../rcutorture/configs/hazptr/CFLIST          |  2 +
 .../rcutorture/configs/hazptr/LOCKDEP         | 17 ++++++
 .../rcutorture/configs/hazptr/LOCKDEP.boot    |  1 +
 .../rcutorture/configs/hazptr/SLOWPATH        | 16 ++++++
 5 files changed, 89 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH

diff --git a/kernel/rcu/hazptrtorture.c b/kernel/rcu/hazptrtorture.c
index 7c8b5899fb01..7c144b9bca6a 100644
--- a/kernel/rcu/hazptrtorture.c
+++ b/kernel/rcu/hazptrtorture.c
@@ -23,6 +23,7 @@
 #include <linux/torture.h>
 #include <linux/hazptr.h>
 #include <linux/rcupdate.h>
+#include <linux/workqueue.h>
 
 #include "rcu.h"
 
@@ -49,6 +50,8 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (s), <= zero to disable.");
 torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s");
 torture_param(int, stutter, 5, "Number of seconds to run/halt test");
 torture_param(int, verbose, 1, "Enable verbose debugging printk()s");
+torture_param(bool, wq_churn, false,
+	      "Churn workqueues to exercise lockdep dynamic keys");
 
 static char *torture_type = "hazptr";
 module_param(torture_type, charp, 0444);
@@ -60,6 +63,7 @@ static struct task_struct *preempt_task;
 static struct task_struct **reader_tasks;
 static struct task_struct *do_pending_task;
 static struct task_struct *stats_task;
+static struct task_struct *wq_churn_task;
 
 #define HAZPTR_TORTURE_PIPE_LEN 10
 
@@ -87,6 +91,7 @@ static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_acquires_irq);
 static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases_irq);
 static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases_defer);
 static DEFINE_PER_CPU(atomic_long_t, hazptr_torture_releases_undefer);
+static atomic_t n_hazptr_torture_wq_churn;
 static struct list_head hazptr_torture_removed;
 
 // State for a deferred (AKA pending) hazard pointer
@@ -643,13 +648,14 @@ hazptr_torture_stats_print(void)
 		atomic_read(&n_hazptr_torture_alloc_fail),
 		atomic_read(&n_hazptr_torture_free));
 	torture_onoff_stats();
-	pr_cont("acq: %lld rel: %lld acqirq: %lld relirq: %lld reldefer: %lld relundefer %lld\n",
+	pr_cont("acq: %lld rel: %lld acqirq: %lld relirq: %lld reldefer: %lld relundefer %lld wqchurn: %d\n",
 		torture_sum_pcpu_atomic_long(&hazptr_torture_acquires),
 		torture_sum_pcpu_atomic_long(&hazptr_torture_releases),
 		torture_sum_pcpu_atomic_long(&hazptr_torture_acquires_irq),
 		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_irq),
 		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_defer),
-		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_undefer));
+		torture_sum_pcpu_atomic_long(&hazptr_torture_releases_undefer),
+		atomic_read(&n_hazptr_torture_wq_churn));
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (i > 1) {
@@ -720,14 +726,14 @@ hazptr_torture_print_module_parms(struct hazptr_torture_ops *cur_ops, const char
 		 "defer_modulus=%d irq_acquire=%d irq_release=%d kthread_do_pending_ms=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
 		 "preempt_duration=%d preempt_interval=%d "
-		 "reader_sleep_us=%d "
+		 "reader_sleep_us=%d wq_churn=%d "
 		 "shuffle_interval=%d shutdown_secs=%d stat_interval=%d stutter=%d "
 		 "verbose=%d\n",
 		 torture_type, tag, nrealreaders, nwriters,
 		 defer_modulus, irq_acquire, irq_release, kthread_do_pending_ms,
 		 onoff_interval, onoff_holdoff,
 		 preempt_duration, preempt_interval,
-		 reader_sleep_us,
+		 reader_sleep_us, wq_churn,
 		 shuffle_interval, shutdown_secs, stat_interval, stutter,
 		 verbose);
 }
@@ -761,6 +767,42 @@ static int hazptr_torture_preempt(void *unused)
 	return 0;
 }
 
+static void hazptr_torture_wq_churn_fn(struct work_struct *work)
+{
+}
+
+/*
+ * Repeatedly create and destroy workqueues.  Each workqueue creation
+ * registers a lockdep dynamic key and each destruction unregisters it,
+ * which exercises both is_dynamic_key() and lockdep_unregister_key(),
+ * the two lockdep paths that use hazptr.  Most useful in kernels with
+ * CONFIG_PROVE_LOCKING=y and CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH=y.
+ */
+static int hazptr_torture_wq_churn(void *unused)
+{
+	DEFINE_TORTURE_RANDOM(rand);
+
+	VERBOSE_TOROUT_STRING("hazptr_torture_wq_churn task started");
+	do {
+		struct workqueue_struct *wq;
+		struct work_struct churn_work;
+
+		wq = alloc_workqueue("hazptr-torture-churn", WQ_PERCPU, 1);
+		if (!wq) {
+			torture_hrtimeout_ms(10, 10, &rand);
+			continue;
+		}
+		INIT_WORK(&churn_work, hazptr_torture_wq_churn_fn);
+		queue_work(wq, &churn_work);
+		flush_work(&churn_work);
+		destroy_workqueue(wq);
+		atomic_inc(&n_hazptr_torture_wq_churn);
+		stutter_wait("hazptr_torture_wq_churn");
+	} while (!torture_must_stop());
+	torture_kthread_stopping("hazptr_torture_wq_churn");
+	return 0;
+}
+
 static void
 hazptr_torture_cleanup(void)
 {
@@ -775,6 +817,7 @@ hazptr_torture_cleanup(void)
 
 	torture_stop_kthread(hazptr_torture_do_pending, do_pending_task);
 	torture_stop_kthread(hazptr_torture_preempt, preempt_task);
+	torture_stop_kthread(hazptr_torture_wq_churn, wq_churn_task);
 	torture_stop_kthread(hazptr_torture_writer, writer_task);
 
 	if (reader_tasks) {
@@ -853,6 +896,7 @@ static int __init hazptr_torture_init(void)
 	atomic_set(&n_hazptr_torture_alloc_fail, 0);
 	atomic_set(&n_hazptr_torture_free, 0);
 	atomic_set(&n_hazptr_torture_error, 0);
+	atomic_set(&n_hazptr_torture_wq_churn, 0);
 	for (i = 0; i < HAZPTR_TORTURE_PIPE_LEN + 1; i++)
 		atomic_set(&hazptr_torture_wcount[i], 0);
 	for_each_possible_cpu(cpu) {
@@ -928,6 +972,11 @@ static int __init hazptr_torture_init(void)
 		if (torture_init_error(firsterr))
 			goto unwind;
 	}
+	if (wq_churn) {
+		firsterr = torture_create_kthread(hazptr_torture_wq_churn, NULL, wq_churn_task);
+		if (torture_init_error(firsterr))
+			goto unwind;
+	}
 
 	torture_init_end();
 	return 0;
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
index 4d62eb4a39f9..380b8402ccc9 100644
--- a/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
@@ -1,2 +1,4 @@
 NOPREEMPT
 PREEMPT
+SLOWPATH
+LOCKDEP
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP b/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP
new file mode 100644
index 000000000000..129769e2e32e
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP
@@ -0,0 +1,17 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=16
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_HOTPLUG_CPU=y
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
+CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH=y
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.boot b/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.boot
new file mode 100644
index 000000000000..7b16720214bd
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/LOCKDEP.boot
@@ -0,0 +1 @@
+hazptrtorture.wq_churn=1
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH b/tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH
new file mode 100644
index 000000000000..4d13028ca84c
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/SLOWPATH
@@ -0,0 +1,16 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=16
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_HOTPLUG_CPU=y
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
+CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH=y
-- 
2.43.0

