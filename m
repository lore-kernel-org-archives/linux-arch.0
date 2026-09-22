Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E383502D59
	for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2026 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061037; cv=none; b=uqRQgaWFo/ZJfQ5gvHH8fYyivQeJ2S3kXTfaa1QKr2JBeotwc2zNcHU61pIYIXatRF5TTBET/aTO7kR73Flk73nSRz7zxiPe1IH0f9N8+h+7/W3yZqdGGDrKOMgQ73VC/d7zG1FJDO+9sAE/Xo27Gp48eLVsmjdqXSYRHZWDDf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061037; c=relaxed/simple;
	bh=m4OHMwMbzXlh2XQ6c0Igw8Fqh29mNUw6HniKWr6Zo5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S+eDCXcdXbmC+iTJ6x8z8sjrzwylFUZWMFNKJm7IWyGp2OAZZ9KF9OJUSLGTSRmPkVOwsEXNDQDpp+toqwXa2z8tOSATnEvUBIMIQqRjtlq2vxFpbujdRhToljgnEY0PG7D6tepa8Nz/QHe6zSeXLI4jFQtZeMsLffxEcqhum4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyHmGLyN; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyHmGLyN"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so2061030a12.1
        for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2026 00:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790061035; x=1790665835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y92+ar2Zyy71HW4Z81q+yVXNw3aTL5K091H9SB9aDmE=;
        b=RyHmGLyN8QNLpEWO+QQfYWhuCr2Qu9gBT3fJLDRzl9vgw/+nwS6Eh931FXXl9WiFX2
         C9OWnKIabkV8FlgrFoofY1OrcMr273G+PzaHpT8WxheKgvLPo7AqY9YnNrowYprQmFK2
         UGd6/m8fUbzSYiWCfxaORTKEcfsXnOX5w9DSeUS+dbJVpYQZl/dxatY+xZHY+u16SnnT
         Ovv+bEwZeGPv/B3HShGKwCUeYqOV+p892oMWxRcGCZApaUe6f/QGLp7cDx3NRmTwfBQY
         FOswVRT2HNxPoXJpCeIaJ77TBXh3RJkkqC4WuTDaMLIqG7LdeLytpm8cBxB0zryyuXst
         ESng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061035; x=1790665835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=y92+ar2Zyy71HW4Z81q+yVXNw3aTL5K091H9SB9aDmE=;
        b=phVQMCHd0BGobCy/X1KzxZiHRVCxmy7Ne4UGReNwCy9mz9IInsa1Iwd8NYC4n3np4B
         RYTb+6U6Yr6dwiT3rWY3dza72sByzS7ZgY910gLLXy1WxPO6Z/z2UgXhHXZDx1Uq0erY
         kfrWhwyorf/I1HOYepRpWofIRz/Dj1bWBDPxNIIPQctHkds/ahyUhHr7T/6cHQyEVZE1
         mkCgXyoBv41WlT2Rz0Zfr/5MkTruYLBRjsg5f8Bogq1KeP2KleaNGovQ1UzXSmegLmUT
         k7x60UoypbzUySZps6ch0UChQWZZsZ22OvMdOVU9JBEcnYhlyROg39xWrAJTOfsaN9pi
         4Usw==
X-Forwarded-Encrypted: i=1; AKwUvBz9yISF6XFomupKHciujjCJ6KxSeAFPV9ACR+JUOacF3637uvCYwuJpUARF5GxPvGU2XVL4ZYYCBjTD@vger.kernel.org
X-Gm-Message-State: AFuF++lQH8Dq767rxlTMBExKHAJfVTmwFUk7ZEpfeDISsaHrvB81BO90
	gL3vz4LZuk4fscYSqGRak4zY9/ieloW9qpAjfW0/T/Zt3N27OrpAIVCv
X-Gm-Gg: AYBFou1NUbbcWIDk8FDcQ4ta0RJar/v0Bxyoa6e0ntM3e3jcMfT3SU5HLpx6CZQGSlD
	Ji8YdHtXf1251y1DFE/ebqMZZJYh3xLmE6NfBvSDNcKNrN2zHLt4IbhsCvSMXy8Oz3nlbBCFiRE
	nAKYSVIMWs27QIqlzjRYxXW7WBdRjQ3iCauTRUoSTtzwK6ukWawBVSfZD1npd6fzAOiH4umtFVT
	h5EC8+h+1TRahHhXRJLSv5sbtgz8TQuBraW8F0ZIn7XwTtqshJWr5ue5c77oGhsGQAE7T3xV9FZ
	vwTSLv/3cXnif9Di4XbxsbDeS4MAYJT5c97bqmCbn5Twx7NrJBTh/lPuDwugnchouW/D3SJTNKD
	mTteC92H5DVa2UF4FvHwQ2z8aCvHkaQxtR/mRUJMbK47D3Hf/U86ik5vNeUK43D02nqwAvJwiYq
	goJPy2ErG5R2VrPjEyhJ/ozeceXFLvJ7QpM0UstJAYoFQjiZy/b6Ylu91dZ0Q52xPX6/bQXSOFr
	EIHJSBcSCbUG9XJKw==
X-Received: by 2002:a17:90b:3806:b0:39e:6c6a:2091 with SMTP id 98e67ed59e1d1-3a073235b91mr260254a91.50.1790061035059;
        Tue, 22 Sep 2026 00:10:35 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a067409854sm3079414a91.7.2026.09.22.00.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:10:34 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	boqun@kernel.org,
	npiggin@gmail.com,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	paulmck@kernel.org,
	corbet@lwn.net,
	mingo@redhat.com,
	dave@stgolabs.net,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	urezki@gmail.com
Cc: akiyks@gmail.com,
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
	include@grrlz.net,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	lianux.mm@gmail.com
Subject: [RFC/WIP PATCH 3/4] rcuscale: add hazptr scale type
Date: Tue, 22 Sep 2026 15:09:49 +0800
Message-ID: <20260922070950.4173245-4-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922070950.4173245-1-kunwu.chan@gmail.com>
References: <20260922070950.4173245-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add hazptr reader and synchronize operations so that synchronize
latency can be measured alongside RCU and SRCU.

The read side acquires the hazard pointer in readlock() and holds
it until readunlock(), matching the RCU/SRCU reader model.  The
address of a static object serves as the synchronize target, which
is stable and never reclaimed.  Both normal and expedited sync map
to hazptr_synchronize(), since hazptr has no expedited concept.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/rcuscale.c | 65 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 1097ec15879c..072ddf9526c3 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -39,6 +39,7 @@
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
 #include <linux/rcupdate_trace.h>
+#include <linux/hazptr.h>
 #include <linux/sched/debug.h>
 
 #include "rcu.h"
@@ -418,6 +419,66 @@ static struct rcu_scale_ops tasks_tracing_ops = {
 
 #endif // #else // #ifdef CONFIG_TASKS_TRACE_RCU
 
+#if IS_ENABLED(CONFIG_HAZPTR_TORTURE_TEST)
+
+static int hazptr_scale_obj;	/* Stable, non-NULL, never reclaimed. */
+static void *hazptr_scale_ptr = &hazptr_scale_obj;
+
+struct hazptr_scale_state {
+	struct hazptr_ctx ctx;
+	void *addr;
+};
+static DEFINE_PER_CPU(struct hazptr_scale_state, hazptr_scale_state);
+
+static int hazptr_scale_read_lock(void)
+{
+	struct hazptr_scale_state *state = this_cpu_ptr(&hazptr_scale_state);
+
+	preempt_disable();
+	state->addr = hazptr_acquire(&state->ctx, &hazptr_scale_ptr);
+	return 0;
+}
+
+static void hazptr_scale_read_unlock(int idx)
+{
+	struct hazptr_scale_state *state = this_cpu_ptr(&hazptr_scale_state);
+
+	udelay(10);
+	hazptr_release(&state->ctx, state->addr);
+	preempt_enable();
+}
+
+static unsigned long hazptr_scale_completed(void)
+{
+	return 0;
+}
+
+static void hazptr_scale_sync(void)
+{
+	hazptr_synchronize(hazptr_scale_ptr);
+}
+
+static void hazptr_scale_sync_exp(void)
+{
+	hazptr_synchronize(hazptr_scale_ptr);
+}
+
+static struct rcu_scale_ops hazptr_scale_ops = {
+	.ptype		= 0,
+	.readlock	= hazptr_scale_read_lock,
+	.readunlock	= hazptr_scale_read_unlock,
+	.get_gp_seq	= hazptr_scale_completed,
+	.gp_diff	= NULL,
+	.sync		= hazptr_scale_sync,
+	.exp_sync	= hazptr_scale_sync_exp,
+	.name		= "hazptr",
+};
+
+#define HAZPTR_SCALE_OPS &hazptr_scale_ops,
+#else
+#define HAZPTR_SCALE_OPS
+#endif
+
 static unsigned long rcuscale_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -1110,7 +1171,9 @@ rcu_scale_init(void)
 	long i;
 	long j;
 	static struct rcu_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
+		&rcu_ops, &srcu_ops, &srcud_ops,
+		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
+		HAZPTR_SCALE_OPS
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.43.0

