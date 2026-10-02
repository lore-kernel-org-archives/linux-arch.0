Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDC75038F7
	for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2026 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961092; cv=none; b=isYwSJDWoVXLpQR8VemOmyPcMMKmhRkvQXjDA4vESdT6pW5reRqTeyIVV5Zg83WhSI6mJAMkeDhlCyqxltvVUdbZMUGxASMxXOioVFcDqV8J8LU0oQXFdW2autJNwABGrGIRZGbGO0rxYMVLxIdXIIeLb8WL7OtCFwKL3Uqx84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961092; c=relaxed/simple;
	bh=C2wOzyIOv3PKV0kqXDjtVyjEqQMMN4LevJPzrcZB1UU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8bmIDkuw/DrhxmAjUuvSKh4tRmgEVyDZKVs67G5z2vTPeQLPDC25Ct8Oy4CDMIQh+Qv7y6/HcGf51hslYHC5XU5rMzUSG18XiykUbtBabBpyrwOSlExShUg1QlH2kXj+f9VLJCPPvH/isvFieu1SjxM6BavN+aAinICdrv/QWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASvxaxjH; arc=none smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASvxaxjH"
Received: by mail-pj2-f38.google.com with SMTP id 98e67ed59e1d1-3a4b4770191so2002976a91.2
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2026 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790961083; x=1791565883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W8wrdTJQlbRjUn5NpoPjM6vdB6JwNJfV9JGCjAJWWp8=;
        b=ASvxaxjHrUuw/OaROMnM4z/BDq9TDEjFyYwTL6WhjxRPrVgHSKk0A069P6fsfGbeAh
         eGYwffdTKIM/9IKv5kuGIWR846b5ldwdvTeWa95jBpahIRlKNW6NeFzTvWT8RFu7J9rq
         xNvjHnzWDop3GyUu0yHft9Wxj6U6Uk9PgR9xH2eGDfpe07vfDwW6Tw2AYPhW2IxT5ZHR
         DWNU8YilNT2RI8U8vVCno0vuZIxJft/hxqjToOw5Xi/vK9v9XQMHnSOe9I+ODHWk4X1Y
         shUIM2qYWDaMtxYo2ZVFFiaU2lwKYPAMlRDe2b/cdZetjmJ3zbRGWS+85qNabxKYRwHn
         cDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961083; x=1791565883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W8wrdTJQlbRjUn5NpoPjM6vdB6JwNJfV9JGCjAJWWp8=;
        b=GUFIWeaW1wDW+jRjaj1QebBHyswZZdv781Abv0wxQEFQZ+Ae7TMg9i1Zis6FqMMPwS
         aO8hv6kVK0SfMe1G0u/MO/5ErAVIQzgYJYLbVVpDwlZLRcPoFCt5o3P6JoeAzuP0NdvT
         JK1ipjpy/EonPUnWAvUgr38MRhIEDlSWO9Gzjhvov9p/JLWqWuPwW/LDaLMdS9fq5FlX
         lu0/jrh61VjWChmYqrYhWTWqZzTSSjYnpASoXK4MzkWOZwNNMlK2WkXXVysoxkOufxmX
         +6z94F3PI08xNVFftczJDz06y5wEcSRpQCLK0M7zQS1T82oO50zjoUehLEatYhu5P7NJ
         PSjg==
X-Forwarded-Encrypted: i=1; AKwUvBy91FYRKQAL6Kk036O9ISFSyRPPY18hy2L+WGkIgU+3HuAyIfXR0tNPz+9zeEixeOeVcg0WQ8Vybj6W@vger.kernel.org
X-Gm-Message-State: AFq9FYKvp/O3eGiBt9Paxzi6R/nq5ygdV4Og59J7jFq2ATtRaOc//r4i
	yOPTkuy6C0MxpzcN3cOOwMFaCbAQu5eMC4B0Ed8yfGfxwdiYyUr9fpzE
X-Gm-Gg: AYBFou07xGciE1bH+wXYmd+s6KkoB9Er9nqIgEQA3bGcgQQC2vEbr1uW+BIcsFN/2p2
	qy/bO5CNmabYtH/y0mJ2yhNpzFqapEi/kAv1j34qW42Ui1/4gN1pokyVrR2EuW+8uwinPmlDQbm
	akSP1YTgxzmKLGxI89kpZOnjVlXjnwCXKG+glv2UrDzIoKf8z7J82VPDEbtujHWt2kPPVRezbfg
	4HqvWWeCNN1IGZ0emNvoqnEFcyuUVA4WXz25T59ym2xoyxGAobr7KqrcWRs87T/mmTrNEWjBnxO
	XMsda9txiV35s5xXl2+DaogdH0SXB//W9XY6j8lF5nFGvEKY7x/nyKutGhZvmPoUlM8EH2AYGgv
	BP/grxwfmMYrAbvMFthpXDaFhpqvMWKvvogEqeO2AV8YGIEwU+nQKxzjSLo0V98Cbp/MhgaIg5D
	Rejr8Pqs7e75R3/5o4ACyu2SevKS725McT2Jy0/NySOC4JT0XSAoR+2uy6pKJ5rBSg0QzB7yOyU
	btXlBzneG61vbnLIQ==
X-Received: by 2002:a17:90a:d64b:b0:3a0:97ba:cc05 with SMTP id 98e67ed59e1d1-3a6ce96a91emr2884642a91.22.1790961082582;
        Fri, 02 Oct 2026 10:11:22 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7024d0f5fsm1597719a91.0.2026.10.02.10.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:11:22 -0700 (PDT)
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
Subject: [PATCH RFC v2 12/15] hazptrtorture: add slowpath and lockdep scenarios
Date: Sat,  3 Oct 2026 01:08:44 +0800
Message-ID: <20261002170847.3653663-13-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002170847.3653663-1-kunwu.chan@gmail.com>
References: <20261002170847.3653663-1-kunwu.chan@gmail.com>
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

