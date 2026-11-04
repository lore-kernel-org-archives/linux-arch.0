Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811377;
	b=eIaYqd1UBfaNq7eve1lA60LSK8mu5rZulnCP2GvdCuIP+3rQIvpCD63xKciOADC6kK+j
	 gwQCUwNbIOd6VV4ccuDTrwYAwbvDOZzLC+lgxjwvL65Q/2ZASLU9sqhh+XYBjUsDZK+7+
	 wTsDUCBiTJqswqfCL8mTXavv0PIuxQ++TolwHIOgbFYxePEjLBaQ4izN61On334Lj+KzF
	 19AbWHtoED2+m1LfcKUlMf3V1j2UCS9c6lPldKR6j/LdiNR1FwZ0ypimS1+CENk9jnkTr
	 7wE3+oP/3bBKmjmRd0K6tToV4iZn2TuVx/qDNqFiRX/s1IexC7BrIPmi7OFcNVnRbvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811377;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nKRyKe5HAwN5rnftg1fZEx1NjIirnpES4D9l2YLy3Hc=;
	b=cPmFfpp8719l1V1QNzC1TxFeGvUq9r2TgMY6uGoMjEWowy0edajZFdji3zoB4lFy6fzN
	 M8Dek6VLWyahf+7nzlj9N2PXV112YafLhTkD4S201LxfXxwVD0GIT1dSOhOXbKRmxF9uZ
	 5ITaxhWTtVS3kN/LAOG2ipRrnssx6+u0KATCSZlXIgE8E4nx+LyMwc9rWNbk3FgFzgGli
	 WeSVkMmW5G/yz1uF/i+7OoK2LtTsH40aSoFm/zSkQfyvT642HDqVMAIXooMYHSa9J83LF
	 dSH17LmrFGVu0d7m+fNAURuOtCooj5Jc+46cKbc7VEZZ8Te7xZy8moPg9uGGoQ3flrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HJx8CYfD;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC663606D80E
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC663606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HJx8CYfD
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-36a315ed211so918462eec.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811376; x=1794416176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nKRyKe5HAwN5rnftg1fZEx1NjIirnpES4D9l2YLy3Hc=;
        b=HJx8CYfDIWJR5BxeLKAMWOYvIZbEog2kUXnrtJDRdSpUfdmh0HmTSZ19XuvWLXrCAe
         Ky0i5oMjyTdDQEQi/vWkK7LRip7d0uc22R2FwngdRvNmVlH/BrjpALMLN37dEdQI05BR
         qWg6LOJlanVMuZ3EEIj4K1+hiJy5rPEstLhpVNZD4crGuuwmzechnuz8MK7pYnU0mnDC
         RPut3X2Iik9HLYXsIPq+9uxxAKsWBv/wIZbfkvNzPtTlqQWfialaDUaamzNlZcOO0dqk
         yZ35EIhmitWCvoDair+nYT7gGgqD97EiaPStAb4/gM6Hy4brt9vcDlHdzBnZNwf6OUU3
         39dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811376; x=1794416176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nKRyKe5HAwN5rnftg1fZEx1NjIirnpES4D9l2YLy3Hc=;
        b=p3EgYlXfgSbAYkF8JMYaRPll5TDtctrO/XOuRDOWhykI/L+S7IS20ZEiNvEYjE8hQL
         kdbyM1i1rrazyYaownMCjbH+xOs9HCV9JcYIP+qKGXj8gGsShq0gDuAuhtdeyJh8tZpJ
         LvNxmgd9Pnv7tiQkqWmaMvExzclbVLxg/NKThBrnX0GnaRX0nnbOEfUxYCDwwMyaPfS1
         vRtxLh+pC27DI9/yypzpeuT4/jWCiV3jA0RcRNvf13/tMUDM25wOPYf1YlU77aqNCj3+
         n5J2h7vXdPcKwkGv4iS51ToDSyQBgHBbTMlK4oCa1uxAuqV9BPzF7r+0qH7mtZ49R1lY
         i6xg==
X-Forwarded-Encrypted: i=1; AKwUvByfwU0BjQiPwJmF1Pj1ImwJHI3Ghnu3+BEM+pKZmadmphKyTqhCSyD2Dvt19tMx2Cgepmn2+hUBEfer@vger.kernel.org
X-Gm-Message-State: APuU4Z+r3O7iRz5hQJALY+n4rGtpPO2b2oNj6gy5D0vrXSEdOlxbAb4h
	QI6VCL+Rpk/u2pYoiHU17XzIHbTwAgUhiho3icattzProNi6tjG5axcn
X-Gm-Gg: AYBFou3k7Mpdg7vfEVUH+WJBlD8LRtXxigiOh1kulII2TdpNRL7jVCVe9CtfuG1SSvE
	i7cxAtLe3hwmJCSYBbT5o01arJTzlVr7B0DGf28FYtcZeQkj1P1wxzRydOpsrrjvBKOpSyup40d
	96gYxDgO3IdCDwl16baSnWtK0999OLryCcL5O19IHSdLwDw6mwSa7F74sPZdjQfJNCzfku0JWIP
	gp7jbpQZXH/Nnq07bcOoIWv+ryypPXvYmYzDjxdxWrVEhzLrASCmwCrrTvV9C2X1fx6CDcPmkbB
	I3LoPxoW9a9CEKxgZE94YSytTFbAdu1U1lchIaywDWW9kZqrlhxv8Sv+STuLj6CiLV+0JR9LbW5
	+xu81OW+unIoSkqqsGgNRlx2I7+NihALIsJTnDOBCnmU3cMFpK+ShaMQKPkW7dV4UTiJ0Ppi4Qk
	XuV5o5mu6U/uOTgkKfPLkF0V0v0iAdimKZ/dae+tYdF3/FLWO04NiibwLpirUDhp7iRf2sktvbn
	SdvlGFJf0xrGn9isHHNgQ15ZHZAZJlXBTCWf1cEHUPoVU2Saj62ujRNTphyDm0OlSklPitc5XcX
	DXRlgK9l2iIoYNGEpi1SXDwo+4qMwV99eyZ/Ctg=
X-Received: by 2002:a05:7301:781:b0:36c:a351:fb31 with SMTP id 5a478bee46e88-36de5f6fa87mr70409eec.7.1793811375449;
        Wed, 04 Nov 2026 08:56:15 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:56:14 -0800 (PST)
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
Subject: [PATCH 06/28] Documentation/litmus-tests: Add hazptr acquire-before-scan test
Date: Thu,  5 Nov 2026 00:54:24 +0800
Message-ID: <20261104165504.2430480-7-kunwu.chan@gmail.com>
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

Add a two-process litmus test for the hazard-pointer publication
protocol: the reclaimer unpublishes the pointer, executes smp_mb(),
then scans; the reader publishes the hazard pointer, executes
smp_mb(), then loads the pointer.  The smp_mb() pair forbids the
reclaimer from missing the publication while the reader still
observes the pre-unpublish pointer.

This is the publication protocol used by the lockdep
is_dynamic_key()/lockdep_unregister_key() conversion.

Verified with herd7: Never 0 3.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Bradley Morgan <brads@mainlining.org>
---
 Documentation/litmus-tests/README             | 13 ++++++
 .../hazptr/hazptr-acquire-before-scan.litmus  | 45 +++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 4d4ec9c6f2cc..c2bf20fa4092 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -97,3 +97,16 @@ SRCU-fastpath-scan-before-anchor.litmus
     period, violating the SRCU grace-period guarantee.  See
     SRCU-fastpath-anchor-before-scan.litmus for the opposite
     ordering.
+
+
+hazptr (/hazptr directory)
+--------------------------
+
+hazptr-acquire-before-scan.litmus
+    Test the resolved-publication ordering between hazard-pointer
+    publication and the scan.
+
+hazptr-wildcard-flip-escape.litmus
+    Test the in-flight wildcard window of the single-pass wildcard-flip
+    scan: a straggling acquire that published the old wildcard after
+    the final walk cannot still load the unpublished object.
diff --git a/Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus b/Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus
new file mode 100644
index 000000000000..6dc13830c07c
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus
@@ -0,0 +1,45 @@
+C hazptr-acquire-before-scan
+
+(*
+ * Result: Never
+ *
+ * The reclaimer unpublishes the pointer, executes smp_mb(), then
+ * scans the hazard-pointer slot.  The reader publishes the
+ * protected address, executes smp_mb(), then loads the pointer.
+ *
+ * The smp_mb() pair forbids the reclaimer from missing the
+ * publication while the reader still observes the pre-unpublish
+ * pointer.
+ *
+ * This is the publication protocol used by the lockdep
+ * is_dynamic_key()/lockdep_unregister_key() conversion.
+ *
+ * This models the resolved-publication case.  The in-flight
+ * wildcard window of the wildcard-flip scan is covered by
+ * hazptr-wildcard-flip-escape.litmus.
+ *)
+
+{
+int ptr = 1;
+int hp = 0;
+}
+
+P0(int *ptr, int *hp)
+{
+	int r0;
+
+	WRITE_ONCE(*ptr, 0);	/* Unpublish. */
+	smp_mb();
+	r0 = READ_ONCE(*hp);	/* Scan. */
+}
+
+P1(int *ptr, int *hp)
+{
+	int r0;
+
+	WRITE_ONCE(*hp, 1);	/* Publish. */
+	smp_mb();
+	r0 = READ_ONCE(*ptr);	/* Load pointer. */
+}
+
+exists (0:r0=0 /\ 1:r0=1)
-- 
2.43.0

