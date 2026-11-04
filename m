Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811534;
	b=qfTt6xuC8LINtNtpSoYo7uYKrgUvM6Qa66z7832mBo9ouvpOywK4naKI44zNJQFc0nEX
	 6cQJ7HNfKWqibMKNZc7+Gr2fuD0h88fsSoUA1V1SITBgK2qoa4mR0iva76KNaIBhnigSl
	 ISfVXtMJiwRWWci7VJUCBKWmJKnF8mnMKW0DXtgLjHFsRaAuavCxahpp+D4sK6cLwEXLK
	 WPwfCU6JBu9kxMc1KKmBGOxJK5iMm2d7gC8Y5AbKmNWwf2XvSdxrtfclzpxI6ScvCaHwl
	 GhOUHWA29HWGHIt7ZsspQGtxVeso1Pe/Y4nKIQtKEX9oT0KBjbE+J6jt6i7L0xRqa4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mOm43uVjDHc2zReKMHzQN6iIWpo1wHm4zcoGnRZJRRg=;
	b=XbF0rkq7iiHct8nAgnHz5E/a5OYS+U17qWuT2WzpTOYDOKieH4CTZB0xzjN+Ra0Q4oGY
	 gl/02QETeKtUgPOrirb0IfXXoKAkDVoeqXBjuCRCNHKJ+aoQmEHQGvqmlTywC01143RfG
	 qCzmEBk4cVyVRdWwsNSEYpgsvT1i/oVEDAbClnDq5zbC4GevwMdifqDSk+bp5q78NT8j3
	 QUArsu4x0lj23RDfnV/QGTJ++lw0+/lZkD1H0NR5nANXHnD9/Hyt3CCUWFjb5VlvgF7Hg
	 iUMnxJvN8j5G4biunng6rDhgyroRQfcj0+vjtRZi4zbcIB4ASB/A56nLyIGNePm88Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ANygCtmE;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC1606A332
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5FAC1606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ANygCtmE
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3550c917fd3so1345504eec.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811532; x=1794416332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mOm43uVjDHc2zReKMHzQN6iIWpo1wHm4zcoGnRZJRRg=;
        b=ANygCtmEabL2DlL1vQlsQM2V0AtBPyADMKMlCJWmID9fbbwmQs5upuFgx6EU3yvhKo
         6caM3e2hkkYO5GJr7HHs+Js9ExbyddYDzxIlemrd8dAXA7Zu9APdFA1UHE8diifgdk8a
         lmdBb0VWG5nNoMzfJrINFe2jSCYp+laLzbezywwABqXJTWGEic2IdMbDjiSu5RV0+CVJ
         eIqDGjL4iNpOnsFQO7sePrDbbe2pzXFrEn6oNowXFyvwpyOWoIVbsF52+leys0IMgc2l
         DNaM0njeFmPb1ZBzxYZ6tHpA5QdzerC11YzE4j+NaXlXjJhySqwp7mgr6wcLnzJmPe3C
         ukow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811532; x=1794416332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mOm43uVjDHc2zReKMHzQN6iIWpo1wHm4zcoGnRZJRRg=;
        b=jrUfDBzawUth59CKADAj7exYxEpZwlWI5ILV1soExI55WsRRyeMoOZeLM63e2K7wBv
         2HkEtP3CfVoKz5a08WhZBKI+LWv8H7SP8sVru9asJC4u4Xi7g2ByAXrT7gKNE2J3yX+q
         aqXwov4PQE5wYV8nK7V2f/LAvvvDPFUrjY8YRGTqCicXpYKZT7Y8iyvH+6MgfISxu1ll
         YnC3Z5G5xPKg4CjFIh5lWq/Rt11t5gLh+EvTXJqrIFng4DZALQ64ffwXsemRgP4Q3jJQ
         XRsYrcH5NTANAg6FHm5RTn7MJsfy4cgcG3XI5UjNCStvsTs8goulw74MTQx4AhehE+Oi
         tMcQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5h8eb9ilf+ciWNz25LWEPRxC4Bl+m0fFIH6SBvq9EFYwoO/1zfGECBm8uwxHHQYTRerzS2EPfA6ol@vger.kernel.org
X-Gm-Message-State: APuU4Z+vRrXgqvQL5HWnhdJp2KRZ75CSiy8jt1i23VIOPoMww0SpArFi
	ocu0bt0kYRk76M160QFTKWm2hk0CFCRsQriTToKb+em0jMn2dXBURq/d
X-Gm-Gg: AYBFou1ugQYWdbreFrx9dT2B1gPUiBa4PTgT26nFjWo5XT0zZv56JimMzaddIXOHaj2
	1FxlyHkJhFgUkN2CE8Qw17jc5Cp8xxT30FxoVMGt211COEg98a48JfcH6SLSTLTkmJSZe125KkJ
	7yRdpYPfMNLNr9YKhAOrs2vsz5qegYE6lGXNWJfloAmq8lxYRBkmB5fpP5fK89bR80wDoQFcAsJ
	HnvxTS9ru3Km479j8wOFfMkJ07YLf1BHaRL+FWcSE4MvosSq5gUeBhRZSR5KDqbxdx5egc1mRGA
	bKVFKktwKzOU7EhoYwOQYjn68YWWua5WXPGEwq8aw0iC8WpUbdagr89XevErdsvoAvlClctzOlZ
	i+PezTcztbEafXGMy/hl2x7ySQmFQy5NCM1CN1t3UWhPhNQCZzNB/uhhMzTZFk/oZbYTKhitx40
	/M1h0y0gDUIzAym5U5yvJKMcd2vSdQq0ZTc+yJgG5Bd4TZTVej4uvCDrarjTPnVE/s9ZBUAwEKT
	kz9ifV4un2QN/HC1emTzr6geu9MkIDMkVGxaWKgCHlDkfF6V1Joxz92WYMkxCzAWR1Y5L79+0tu
	nKJyD6rOSqGYHZRnwk7tv6GVtmlM4iO8fOyIoj7iO2xkizzBGuhQrbaiB4RZ
X-Received: by 2002:a05:7300:5b89:b0:36a:1732:1e7 with SMTP id 5a478bee46e88-36a424c7b7dmr37599893eec.31.1793811531717;
        Wed, 04 Nov 2026 08:58:51 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:58:51 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
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
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 23/28] rcuscale: Add hazptr scale type
Date: Thu,  5 Nov 2026 00:54:41 +0800
Message-ID: <20261104165504.2430480-24-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a hazptr scale type for per-writer hazptr_synchronize()
cost and per-reader hazptr_acquire()/hazptr_release() overhead.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/rcuscale.c | 67 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 5659eaebc5c0..6e3e3f296f85 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -40,6 +40,7 @@
 #include <linux/vmalloc.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/sched/debug.h>
+#include <linux/hazptr.h>
 
 #include "rcu.h"
 
@@ -460,6 +461,71 @@ static struct rcu_scale_ops tasks_tracing_ops = {
 
 #endif // #else // #ifdef CONFIG_TASKS_TRACE_RCU
 
+#if IS_ENABLED(CONFIG_HAZPTR_TORTURE_TEST)
+
+#define HAZPTR_SCALE_NR_OBJS 8
+static int hazptr_scale_obj[HAZPTR_SCALE_NR_OBJS];
+static atomic_t hazptr_scale_sync_idx = ATOMIC_INIT(0);
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
+	int idx = smp_processor_id() % HAZPTR_SCALE_NR_OBJS;
+	void *ptr = &hazptr_scale_obj[idx];
+
+	state->addr = hazptr_acquire(&state->ctx, &ptr);
+	return 0;
+}
+
+static void hazptr_scale_read_unlock(int idx)
+{
+	struct hazptr_scale_state *state = this_cpu_ptr(&hazptr_scale_state);
+
+	hazptr_release(&state->ctx, state->addr);
+}
+
+static unsigned long hazptr_scale_completed(void)
+{
+	return 0;
+}
+
+static void hazptr_scale_sync(void)
+{
+	int idx = atomic_fetch_inc(&hazptr_scale_sync_idx) % HAZPTR_SCALE_NR_OBJS;
+
+	hazptr_synchronize(&hazptr_scale_obj[idx]);
+}
+
+static void hazptr_scale_sync_exp(void)
+{
+	int idx = atomic_fetch_inc(&hazptr_scale_sync_idx) % HAZPTR_SCALE_NR_OBJS;
+
+	hazptr_synchronize(&hazptr_scale_obj[idx]);
+}
+
+static struct rcu_scale_ops hazptr_scale_ops = {
+	.ptype		= 0,
+	.readlock	= hazptr_scale_read_lock,
+	.readunlock	= hazptr_scale_read_unlock,
+	.get_gp_seq	= hazptr_scale_completed,
+	.gp_diff	= NULL,
+	.exp_completed	= hazptr_scale_completed,
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
@@ -1140,6 +1206,7 @@ rcu_scale_init(void)
 	static struct rcu_scale_ops *scale_ops[] = {
 		&rcu_ops, &srcu_ops, &srcua_ops, &srcud_ops,
 		TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
+		HAZPTR_SCALE_OPS
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
-- 
2.43.0

