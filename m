Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811542;
	b=RPMd/7HWcTbM8AqBhAtPjV4GfMGU9g5ggdWSWW9lfIRVoysTkgg+1Obm4KK+Qxwg59Bh
	 BOsp4W7DlaE2xb8R2lAhyycEaCIUm6ofoPC74DOBfIhjlbOf2w4K9cMvZQTNPaQXT/VEi
	 uj/CQeM/4f0FMB+aR12fUsT58oBPHOv7DP87C4xF3+rT6flkW5D0ipdeLFKyiWgFAL6jN
	 TuNv057zddlEq/a2NNiDSmpM3wksJmOJ8tPUVQ4l5GEtRwL1KbkhCFl2W3OjZciwtML/v
	 Qtwl5ZbikHnfY0PEs9wDO4E7hHFiokV9RIrCkJVqqMhbmDsyRD5p3GmQYMU7OVVRnxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Udzi7e2m5bKSaRnWhIT7TQ2xIYgHoxZdlBCHKVgs+XU=;
	b=eEXZopTAhRPBedQ2HogrCq/Mt9pu66DvyxCaT8mzvkkdBy9HnKtUOAf/0rdmz89Kt5K/
	 FPOdfMTivVFwCUU5B+J2P3bZMZfKQdyzVVotgrieX7yTZdRicFLjF14kUW6QArlHSAGsK
	 vZrQOEDwofuuA/NsIiQy9v3hRHKIEFnLtHgLbDDKy3IbGAxbhIZIvfjzjnOqGzCU/ohX6
	 THnTzQggWTt74UA0YNPwV6dta/Ty4B2zaG7Kobhox6tp/P92sWherTHe1lnL6SNdP8oE5
	 1iNgtldIzDsttUuspYxIVZcpTtms4srbuRkhip1Cn+pWAMGJyDsB2SgRg54M3wHvSqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B1Xedtr0;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF36606D832
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BF36606D832
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B1Xedtr0
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36a1947498bso2160966eec.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811541; x=1794416341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Udzi7e2m5bKSaRnWhIT7TQ2xIYgHoxZdlBCHKVgs+XU=;
        b=B1Xedtr0oAKyhCbOYUUZwGHRYObZGkVPHWJPMPMIfuUC5/bUN3NqmzVBJprCraIK40
         JTEK8LzXWQZxf61F0u3tPe4Nm4TEoPGlix7kdAMdgZcySlTtfMApc8UeXuNWP9vxaSIy
         SJO49qL4KJ+8JvhK9XnGNGDQ4ei95PivKYWnLlZvAETNe7Dqh7haPhnmKzz3azpKFVHz
         33Gd8j/nAuVaQSPU10VhOczxcvpukSc/hTfVxRrAzw0DX/c7muQZppleshBl211WxxPt
         GSnHLV0jUNNHql1FgT4Qo5xw7BrVFbQ8LmYadTb7As2JnbPKk/c7h7Nh/1NSBCR9EiOB
         sHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811541; x=1794416341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Udzi7e2m5bKSaRnWhIT7TQ2xIYgHoxZdlBCHKVgs+XU=;
        b=ngUIREs/nm1nL5e8HqJISB64jnh3+GHFnqH61ffufi4uTIQ0ubHGHaXscI5gRcBmK6
         gq+FcBzqBka72QsjHWDDrmHkRqFGFfqfayM4rkXsczd33y8zMVwEL/BOgVQJ9OksQ6ce
         6CWjVwCkIZmw/Tofb+jFRV12pDcEfZYURH/LfVB8fAY0pdmJ0uMZIGsxunEgai/JgzEr
         ohK+NswebrMXcSGCRc9E8UW9JwFp7jtYJVXrgwcpbyVkAaFkN0o9E5GZrNZ3aHdHIJJM
         YWbj5bIMAwBxj/cKt3AkjpIc5/qHHUHADyGpRguZyhRAkRQrRRS3RM7QBmJp+7PZ+EWs
         1ujg==
X-Forwarded-Encrypted: i=1; AKwUvBwDjNDL4oMX9+980msf560JhH0ALWUa9NUPpLN38V3//vZKtAec2JVzmtBs2hWT7YUfwThUGRHpYu92@vger.kernel.org
X-Gm-Message-State: APuU4Z/SooKzqQk4YDHoMwLO6YkGD+/FrY+jcQEbrTgmOkTYlFVa268A
	luoHiWvTW+ilILjTgoJ/8T13/b3kgvCJ1NfuKSqW0aYEe6JAKiXMUAau
X-Gm-Gg: AYBFou0iu4dFCxuw1lUjTAzDfG8GCQQXGNZIYCQJpvKBA9XHcRpctRcZhS5Xo3VueRK
	l6DVHdbn0T0CDMrPc+1oqRio2A+NS/A5Rmfn3U/pqhVRkiJ2eWCRq1rPeVPhfF0AfqoSiH23EDI
	YCqnvA8LnYY6v4urRnAs/xtbweAytKXga4GmVEe7I35p/UrYjUkeaP9lvbhOzpQYNOo5XP1m82d
	3ZAk+90nZTa5O1xbZGOhf+DrfeFp81nMvXoY9+BtcO8ZUQrHt4LNpPaL+bVHGUmph7wedc7S0oj
	h5Wf/jELnxrb37iyli7ou0XdgLz0uwsFDsGbg2bH0DirEmQe0L1wmez/4S8Y4WWZrbKeiTSHLqe
	o984sjAQR2AMva/ylhidloDIDVp79B08xm7xDdaPPz0T/XwTf1DdF1bYsp02T/d9PX+PEiCprHI
	P9l5Cf+Pd3wosN4DI77618x9MqQ/P/yOm32pHaM7Uh7tiPkXukCrf0NL+VUUVyXDfqQ4ikTaL1Y
	cAcy8tzNdn52O2HbmpV5ODazXi0AYOXDN+Hbb9Kp6b3u/fS3vSdhhXf38SGLO6f1KqVGCHV6omz
	AukB1moQXyOXyIswel5xzMNeZQYvyqyaDYQugSA=
X-Received: by 2002:a05:693c:8110:b0:36a:1088:fb2f with SMTP id 5a478bee46e88-36a4236d027mr26652229eec.14.1793811540869;
        Wed, 04 Nov 2026 08:59:00 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:59:00 -0800 (PST)
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
Subject: [PATCH 24/28] hazptr: Add runtime sysfs controls for stall detector
Date: Thu,  5 Nov 2026 00:54:42 +0800
Message-ID: <20261104165504.2430480-25-kunwu.chan@gmail.com>
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

Add writable sysfs attributes that let the administrator adjust
stall-detector behaviour at runtime.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/hazptr.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index 7d4273a44183..66954251c332 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -423,6 +423,10 @@ static struct hazptr_scan_state hazptr_scan;
 
 /* Sysfs counters, cf. RCU's rcu_stall_count. */
 static atomic_t hazptr_stall_count = ATOMIC_INIT(0);
+#ifdef CONFIG_HAZPTR_STALL_DETECTOR
+static unsigned long hazptr_stall_timeout_ms = CONFIG_HAZPTR_STALL_TIMEOUT;
+static int hazptr_stall_suppress;
+#endif
 static atomic_t hazptr_drain_count = ATOMIC_INIT(0);
 
 #ifdef CONFIG_HAZPTR_DRAIN_ASSIST
@@ -1115,8 +1119,12 @@ static void hazptr_waiter_stall_report(struct hazptr_waiter *w)
 static void hazptr_waiter_stall_check(struct hazptr_waiter *w)
 {
 	unsigned long now = jiffies;
-	unsigned long timeout = msecs_to_jiffies(CONFIG_HAZPTR_STALL_TIMEOUT);
+	unsigned long timeout_ms = READ_ONCE(hazptr_stall_timeout_ms);
+	unsigned long timeout;
 	unsigned long deadline;
+	if (READ_ONCE(hazptr_stall_suppress) || !timeout_ms)
+		return;
+	timeout = msecs_to_jiffies(timeout_ms);
 	w->cycles++;
 	deadline = w->reports ? w->last_report + 2 * timeout
 			      : w->enqueue_jiffies + timeout;
@@ -1275,6 +1283,46 @@ void __init hazptr_init(void)
 }
 #ifdef CONFIG_SYSFS
 
+#ifdef CONFIG_HAZPTR_STALL_DETECTOR
+static ssize_t hazptr_stall_timeout_show(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  char *page)
+{
+	return sysfs_emit(page, "%lu\n", READ_ONCE(hazptr_stall_timeout_ms));
+}
+static ssize_t hazptr_stall_timeout_store(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   const char *buf, size_t count)
+{
+	unsigned long val;
+	int ret;
+	ret = kstrtoul(buf, 0, &val);
+	if (ret)
+		return ret;
+	if (val > 3600000)
+		return -EINVAL;
+	WRITE_ONCE(hazptr_stall_timeout_ms, val);
+	return count;
+}
+static ssize_t hazptr_stall_suppress_show(struct kobject *kobj,
+					   struct kobj_attribute *attr,
+					   char *page)
+{
+	return sysfs_emit(page, "%d\n", READ_ONCE(hazptr_stall_suppress));
+}
+static ssize_t hazptr_stall_suppress_store(struct kobject *kobj,
+					    struct kobj_attribute *attr,
+					    const char *buf, size_t count)
+{
+	int val, ret;
+	ret = kstrtoint(buf, 0, &val);
+	if (ret)
+		return ret;
+	WRITE_ONCE(hazptr_stall_suppress, !!val);
+	return count;
+}
+#endif /* CONFIG_HAZPTR_STALL_DETECTOR */
+
 static ssize_t hazptr_stall_count_show(struct kobject *kobj,
 					struct kobj_attribute *attr,
 					char *page)
@@ -1291,12 +1339,24 @@ static ssize_t hazptr_drain_count_show(struct kobject *kobj,
 static struct kobj_attribute hazptr_drain_count_attr =
 	__ATTR_RO(hazptr_drain_count);
 
+#ifdef CONFIG_HAZPTR_STALL_DETECTOR
+static struct kobj_attribute hazptr_stall_timeout_attr =
+	__ATTR(hazptr_stall_timeout_ms, 0644,
+	       hazptr_stall_timeout_show, hazptr_stall_timeout_store);
+static struct kobj_attribute hazptr_stall_suppress_attr =
+	__ATTR(hazptr_stall_suppress, 0644,
+	       hazptr_stall_suppress_show, hazptr_stall_suppress_store);
+#endif
 static struct kobj_attribute hazptr_stall_count_attr =
 	__ATTR_RO(hazptr_stall_count);
 
 static struct attribute *hazptr_sysfs_attrs[] = {
 	&hazptr_stall_count_attr.attr,
 	&hazptr_drain_count_attr.attr,
+#ifdef CONFIG_HAZPTR_STALL_DETECTOR
+	&hazptr_stall_timeout_attr.attr,
+	&hazptr_stall_suppress_attr.attr,
+#endif
 	NULL,
 };
 
-- 
2.43.0

