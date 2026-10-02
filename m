Received: from mail-pz2-f21.google.com (mail-pz2-f21.google.com [74.125.228.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C83F4FE2FA
	for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2026 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961018; cv=none; b=Ze5NnnGCTCa781Nx3rD98/oqmU43zHTLLhenPPNjiqNm5pMo7blQQ1QTO9PwuqwLbh5c6T3qM4855oSeO5tGaR+OsQaEJxXQPitSvTJdp/8D8emOUYx/vI36db0JP0G4AUCJ3lbQd2xXk251t4Z0UurCm9EuEXYGLswb0os5JDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961018; c=relaxed/simple;
	bh=qSkRi8XlT4WUuuM/Vrnlxa70Aiw5xHXCcH5kKxR3bV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QgH1W336A7BCQcAZhDGoJIK3D0f42TBcx1MZS5bAplwtlAZwgkICH/OKhOuStGKVqgJUeuDNY5AD6wc7RfB+O5qGBash6EyqD5vCwUiElHhfjYPRq2zg6xgNijFQLaN/OMcjQnPKElRQu3mAusYQfIPPe/4uL7lCfTPjOjY2r24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNNhhxi+; arc=none smtp.client-ip=74.125.228.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNNhhxi+"
Received: by mail-pz2-f21.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so4722077a12.2
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2026 10:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790961008; x=1791565808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qdf2Dycggm4mT6sPheIXdhrke0YZJhuYFMLF05Xnp3s=;
        b=MNNhhxi+/9V9cBpSzrQ9rBUps92aDYFjhe4ajkPoz7rBNWRHx9SUVUM3Jjl3EmknDE
         LJArFrEOqpNWBD3gNM3u1083or6Oy6Ufp4YeZ628XudtUIri2nxGwONHW3Rr7eXQlAH8
         7IlasPHjm52GV1ylWvkeeYMKId4daxOgHLoIg80h2sMdS6RuTxGGXGYvw2hbi3De4o3S
         I1C2UdEdHgUcw0pWoMTfvIN5l312iBEkfZE8ju/MFTEvCkKk7O8oDsr9vuknlxKCmRok
         bl/M19KGiCWwnqfwKTKvtJBNLCEaUyApH2vR2vHcMP4Fx3hYnk5Sp6z/y2zPaTFNAloZ
         LLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961008; x=1791565808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qdf2Dycggm4mT6sPheIXdhrke0YZJhuYFMLF05Xnp3s=;
        b=uwzocMuZLGH1wNc8QyOS7356pbjkQ6F0L0w0/1lklmTqwc4rdEKzf8iO279lsO56fN
         uWb0jsDWhK9ly1oZhSnr3/V+hKSFTQ2FjsaydVtlonQXObS/WIlQ3op+MbvteZYinKVY
         mUXh27Vm1myFLPJSpDRqo3J8LncAbIVhkaTw9kVYJ5TKyQtcllb0UMi7XTy0MfvkamSu
         pnnGb4egmfDIn/mZ4CsWfN8BtBQMYHq4wEgTmMdAJCauvkf1fZ3f4XasAWCFaaReXGd0
         DIyJv6qbgaISspInR/g3rZMwMixMXnCT55J3XrC6g1lHsvtT+MVnpdUz1tVLE1O6NBKm
         qXVw==
X-Forwarded-Encrypted: i=1; AKwUvBxb0yXcDCGnTqVrJ18LZBcgW9Cbo+5eNOcWAoTRDYSIUhnP9HcAImGD6FN8c/X0Xbchhs6To2UZaKPb@vger.kernel.org
X-Gm-Message-State: AFq9FYLuDhh4Iz05dU39+JEDIuucMLU/DOE7nMEmoK6/8yjZI6N+DsoV
	T5Nv2SzbTBMZiWcR2ny5xa8FA0CgLxeTK+Yn2h7I5cDZjd6FdcOFcpwu
X-Gm-Gg: AYBFou3dzSiwsstSE14QQCCjv5XhpH5N3P9600dA/Y82SrgshaoBhpOT8PvTM51qpmW
	9Aq3px1ttljGo0o1Se2ImIWiJkKyDIC4i2wh26lo1CfujQNlFwz3mVapD6Cs5N4eR7jCg7yOD9Y
	nU1WLpujc/Kk2yERvfa4whbPv7E9j7W2++zVzGuVoSHJU+Cqfj5gf9MqpP26zAv0VPFqJwAWG1M
	mRPpFeTtAsbod2qK8JZD7qt4DRdkqp+rZgP7nep9qmLgpR3jaCvabbstHq2UJw5wi2i5XHh/TsO
	g4JeFmvWHM//0kWZq7CEmCM5F20SarojYSjOez2CfLrMZW/dPDBKnBhtk6rNdnSbzFIX1E3YAPL
	7mylUqWm3Yc93uzCbe24S7aXKQ54lLPxiP0w+mq2LT24U0eTGhonLU9zNib0mnYBtOEBzizUH1G
	ANjMVJFvXm4K9w6iTSx3jcyj7+Qujd69qPVXKThzzUfFrBDfc/Kd4Bm1tAj4PmWIBxIbIfbs6vA
	q5DTRcu3LAwLbT9yQ==
X-Received: by 2002:a17:90b:134e:b0:3a4:aa26:21c7 with SMTP id 98e67ed59e1d1-3a6ceae5a45mr3036272a91.25.1790961007656;
        Fri, 02 Oct 2026 10:10:07 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7024d0f5fsm1597719a91.0.2026.10.02.10.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:10:07 -0700 (PDT)
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
Subject: [PATCH RFC v2 06/15] hazptr: elide redundant first drain pass
Date: Sat,  3 Oct 2026 01:08:38 +0800
Message-ID: <20261002170847.3653663-7-kunwu.chan@gmail.com>
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

Each scan cycle drained both wildcard generations: the
unpublished "other" generation (pass 1) and the pre-flip current
generation (pass 2).  Pass 1 is not needed for correctness, so
flip the wildcard first and drain only the old generation while
building the Bloom filter.

An acquire that read the old wildcard before the flip may publish
it into its slot after the drain has passed that slot.  Such a
straggling acquire cannot have loaded the pre-unpublish pointer;
see the following LKMM test for the ordering argument.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/hazptr.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/kernel/hazptr.c b/kernel/hazptr.c
index 799784f698ed..86336f229f57 100644
--- a/kernel/hazptr.c
+++ b/kernel/hazptr.c
@@ -365,24 +365,19 @@ static bool hazptr_scan_walk(void *watch, struct hazptr_bloom *bloom)
 }
 
 /*
- * Wait until no per-CPU slot or overflow-list slot holds @wc.
- * Callers must ensure that the wildcard value in use by new acquires
- * differs from @wc, so that the set of slots holding @wc only
- * shrinks, which guarantees forward progress.
- */
-static void hazptr_drain_wildcard(void *wc)
-{
-	while (hazptr_scan_walk(wc, NULL))
-		cond_resched();
-}
-
-/*
- * Move pending waiters to ->scanning and perform a two-phase
- * wildcard scan shared by all waiters.
+ * Move pending waiters to ->scanning, flip the wildcard, then
+ * drain the old generation while collecting observed addresses
+ * into the Bloom filter.  New acquires use the new generation,
+ * so old-generation slots normally only drain.
+ *
+ * An acquire that read the old wildcard before the flip may
+ * publish it after the scanner has passed its slot, but cannot
+ * have loaded the pre-unpublish pointer.  See
+ * Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus.
  */
 static void hazptr_scan_do_cycle(void)
 {
-	void *scan_wildcard, *old_wildcard;
+	void *old_wildcard;
 	struct hazptr_waiter *w, *n;
 	LIST_HEAD(done);
 
@@ -397,16 +392,11 @@ static void hazptr_scan_do_cycle(void)
 		return;
 	}
 
-	/* Pass 1: drain the unpublished wildcard. */
-	scan_wildcard = flip_wildcard(READ_ONCE(hazptr_wildcard));
-	hazptr_drain_wildcard(scan_wildcard);
-
-	/* Flip so new acquires use the new generation. */
-	WRITE_ONCE(hazptr_wildcard, scan_wildcard);
-	old_wildcard = flip_wildcard(scan_wildcard);
+	old_wildcard = READ_ONCE(hazptr_wildcard);
+	WRITE_ONCE(hazptr_wildcard, flip_wildcard(old_wildcard));
 
 	/*
-	 * Pass 2: drain the old wildcard while collecting observed
+	 * Drain the old wildcard while collecting observed
 	 * addresses into the Bloom filter.
 	 */
 	while (hazptr_scan_walk(old_wildcard, &hazptr_scan.bloom))
-- 
2.43.0

