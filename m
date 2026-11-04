Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811349;
	b=bva3+D8sJzgWfhvKknuzIgbEo7cV1/m288o11eTtqpNqVeRXxTDF/7Z4QLtEIZ7Gq5iR
	 13G3VLZNNkHfR0t81SzQqcE2e4WbKarI/FeEIttsv+3OWZnorh56ngyVz+JyWD957cWvQ
	 4nJFe7coZV4MY1ZO1wxVsctwOwA2IBFLIAKkzAjXmURnTr10bV3BX4v3GyoJpReHCryv3
	 W9n427DA5TTgwAFvGmMCSK+usi5q5icnrVgNz6dK+Dp7tQHCfx75dh0c1G8ORg2O9a8Tx
	 5b1G2KmzTp+d/yZ4u7qkmMa+slJfOKvEnzUL2g+lUKTr6t6qGRKIcjvBqY+qSyub4hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=zN0OMa6DsitFd0I63/8rm5wsSSArSxIu8WmzT7WDGsU=;
	b=gdl7E1eSYHiByliWXptma3f+fm4q/RxdLwqfFzQW5RkQeli3F+wNzkhz66SXvtZbzpmJ
	 dc41V3mYSxOjS+GNZDSsoldcuANXwXI65lrIKBRB4nRtWzzTJ5wxw5ROiIu6vhcLXEIud
	 /T2Gmbyto5Vp6cRtxQ+EGVqjrHTh5rzWmxLZS83XZnmW1PfukBLX5d9GD2LH76aQ9x82E
	 2fm3hqcki/8qiprksiSW3mSU4GBF2bJVT0CvXL/b4e3QwWX3rhAaNWO2CV/6XebzZvEzC
	 59x4KVZYFUoj+QZGXHnK3BB+zbvyNkgVuCCMIYMNkYC1RaabGh2Ya7vI2lSlp+9D9PQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GfhIGsI1;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D57606A332
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13D57606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GfhIGsI1
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35b2c599f43so1894197eec.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811348; x=1794416148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zN0OMa6DsitFd0I63/8rm5wsSSArSxIu8WmzT7WDGsU=;
        b=GfhIGsI1A79J7jj8MJAkxgJjudxW5sb6BpufeqVLWo4k5o9TBPAOkoCPeNcDs2elCb
         91bVJsIm83LcNhiO5mYbF39oD7VEjY9BiK+zk6u8gqDTaVdUFDv0uslgPSVOPnH1Kwk0
         hW0fpiJUPDSulT9sjmuAXODm7KaVFn2/qcZ5VCjidr1u9VELGD6xVErSX1p9jDOreK11
         c0wqkNvo4FFRBO0j78kT2Pted/n+mcjMpXtVQKHfEYds8sVK4NeBEAWete0R+fJr2Z8Q
         gVmU+4MLZBzoKT47koTB0I9kNjDp1iWCjikr7bMtNUnkLsmXm+5nFGPVV+slNHi8wJzC
         BIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811348; x=1794416148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zN0OMa6DsitFd0I63/8rm5wsSSArSxIu8WmzT7WDGsU=;
        b=z1r6kn6fM43FiwLnpSlONehgUgfK3+GlywyO6TgleFxRt4EZL+5ccD1NUrg3Qf31/X
         Cw39DBWu0/Wz3Fi1H/DwZUgVg0qdtTq/oj2FyffHDCHCHcXeH33HDoyXeL6g2ixll/BZ
         1uy6zf/QXkHSEMEyrz3gQdcw/g9kra7iM4LVQZg6l/5dAe4SulEiMp+z1wu/Lj99D4+j
         8JbamV3ZJ5CQzZWrvVxzDgJBE1oK/5FiX9OZhGFxbtymdqXLidIElLVT4l6MCP+9YZVF
         Ypxz6w3i3zAY2GQzNXaJ6QeyzAeeQ978X3+hUi/cAcgyzRteew6zba/Ue6BCLArHVYRO
         4LFg==
X-Forwarded-Encrypted: i=1; AKwUvBzGUmtDGQsmneoeEeUikSgJfZXLdtvtg4b2828w+Skv+cDVrbhoCbJrrr6FYi3Jq8uke4xcbbxiws1F@vger.kernel.org
X-Gm-Message-State: APuU4Z+GIkwjLGT11ItT8BFnbn2h9kMYzg5xrs6wchG7DzBzmodxyGhL
	QRtu+8dKFBAvPziZBelh39SsEeC602EAQljX7U6Ijmf6HpY9hfOPX2EC
X-Gm-Gg: AYBFou0XJuI6g1cvOf9yUCExyQpABxW0jkXxNq4wwM67rfIQEbGtdfOl4Uia3kX2xG/
	bdaQqprXCYWXv5e0rwMlDczb+0O2XduK8EooEM9LdKJZ7NSp5lr3R9Oztbm0GKGP3BLQxOTgRJT
	FkQQLSaKKqPo4TfCGJHKeGazI9lCMpI83TT7vpvdEtvPewx6g9p/xuIGNwWSi/Fa24zlWOdIdag
	pPlre0cdaF1gxCd/jKjDGAWIZ4BIs4rvzS/kWbZ1HhFk5sWYxbn81U/WRduzgSgstD/1MBWrRD0
	cmUBAUu31s+5FLKYuPcgpNNdgFBFc14Fwcr1XI+2EkYm3ai8Z5PzQSY0EEblCWIibLfjEJD7G3x
	PfUtDu1YFneRANb3SZQ2aD1BLP/BG84e0YQs+pDTl0zoUkyAauoVZMHiesMkt4RsTo9yLoykigr
	0aQ2uJYkE+gnHSrGrjQ6un3DtI9XNp4wsHJLBt728+OcVemhb53Cs4IV8RzBL7KOhAJk3YzAjzj
	gFNwYzBKLGtKA/W2+MWdJQ9+xM0xlnJWqt164YVxnwkOVVHImE/Bc1l0nZDoOGdY9806uVwPjJ+
	UMWBtPzr9P1lluZ5PeYCk5wYWGTBRpqvQIWuplDnbApFIx+nwWD+IczOB6v8
X-Received: by 2002:a05:693c:6092:b0:369:1084:8ee3 with SMTP id 5a478bee46e88-36a423e52c8mr29321886eec.23.1793811347548;
        Wed, 04 Nov 2026 08:55:47 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:55:47 -0800 (PST)
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
Subject: [PATCH 03/28] hazptr: Add scoped_guard() support
Date: Thu,  5 Nov 2026 00:54:21 +0800
Message-ID: <20261104165504.2430480-4-kunwu.chan@gmail.com>
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

Add a scoped_guard() class for hazptr so that callers can pair
hazptr_acquire() with hazptr_release() on scope exit.

The guard holds a pointer to a caller-provided hazptr_ctx rather
than embedding it.  The ctx must remain at a stable address while
the hazard pointer is held because the slow path can chain its
backup slot into the overflow list by address.

Suggested-by: Boqun Feng <boqun@kernel.org>
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Bradley Morgan <brads@mainlining.org>
---
 include/linux/hazptr.h | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/include/linux/hazptr.h b/include/linux/hazptr.h
index d37792af3493..3372b1cdbee6 100644
--- a/include/linux/hazptr.h
+++ b/include/linux/hazptr.h
@@ -341,6 +341,43 @@ void hazptr_release(struct hazptr_ctx *ctx, void *addr)
 		hazptr_unchain_backup_slot(ctx);
 }
 
+
+/**
+ * struct hazptr_guard - cleanup.h guard for a single hazard pointer
+ *
+ * @ctx: Pointer to the caller-provided hazard-pointer context.
+ * @addr: The address returned by the matching hazptr_acquire().
+ */
+struct hazptr_guard {
+	struct hazptr_ctx *ctx;
+	void *addr;
+};
+
+/**
+ * hazptr_guard_acquire - Acquire a hazard pointer for scoped_guard() use
+ *
+ * @ctx: The caller-provided hazard-pointer context.
+ * @addr_p: Pointer to the pointer that is to be hazard-pointer protected.
+ *
+ * Acquire a hazard pointer using @ctx and return a guard that
+ * cleanup.h releases via hazptr_release() on scope exit.
+ */
+static inline struct hazptr_guard
+hazptr_guard_acquire(struct hazptr_ctx *ctx, void * const *addr_p)
+{
+	struct hazptr_guard g;
+
+	g.ctx = ctx;
+	g.addr = hazptr_acquire(ctx, addr_p);
+	return g;
+}
+
+DEFINE_CLASS(hazptr, struct hazptr_guard,
+	     hazptr_release(_T.ctx, _T.addr),
+	     hazptr_guard_acquire(ctx, addr_p),
+	     struct hazptr_ctx *ctx, void * const *addr_p)
+DEFINE_CLASS_IS_UNCONDITIONAL(hazptr)
+
 void hazptr_init(void);
 
 #endif /* _LINUX_HAZPTR_H */
-- 
2.43.0

