Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7273D51CF56
	for <linux-arch@vger.kernel.org>; Mon,  5 Oct 2026 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220711; cv=none; b=Y9l5vumXp67vKjcQF/F4mhvQBS8nzv26Rbt9q/OjGTKLwrBZ/6Wxajy3q7o/DNSNjrg7Lw7q9UCiKIlTXzeWepi/uuGroSSezkeTGXTp2aL5thxWF3SbcEKL8tbdCV/R5wmWivq5a5hhRdnLveX4HDZdx6MyNbzYY7w+MhGnxgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220711; c=relaxed/simple;
	bh=VRRvq3zLEbjKyIt2UhIB5bfMCL6WQ+2ygOmVvN1KkXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqK5pnu8sumpujFzaG+Po4LMahPshSYSd+gfIqP/k2y8W2D16JgbLyrea2A8GBB9dqv/EHcqvsNhBTLD0T7gSHd3PzrodnB6/7Gzkod9SR+0fCuK7ip9El9yo0PAYPc17KMrNuwWxI+peg5d+79+Vhg+b9wI0TMoZkh2UH3FVPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZI6elm2; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZI6elm2"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso1052875a91.0
        for <linux-arch@vger.kernel.org>; Mon, 05 Oct 2026 10:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791220709; x=1791825509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQJb7vr8ZMuFWHiL+RnTPMV3r43UUmwaGCJuJ+OyJv4=;
        b=eZI6elm2ZWLe1z4EUhPXxPUuRWeyQ/T3QgF+iNd4qtEBgDAzb2HTJYrf59DX/nw8FQ
         X19RbX693PaJwIgsX75DmJEaJpfTrh5fv//S51rijQFmw5XeffUjf7zaAM3bWekOUPWE
         0gu8vWfbshp1mwy9aoqCV6/xVw+Fmh86nsg6b9gO8+o09QQERfnNJ9SVCfIviHKeySQ+
         bK+fXcxo83sh9iFrAOM/QzS3mHx+h8SY9sxkgt2bijktpgkeSFwr/Zvi6U7nW+eh0VLR
         KIl+LT8cHfi9WY6ajIbLO5KrxPemNK46ByOLotl1BWBfHU8GdCEOIiYIYtpzbfmPluAF
         BoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791220709; x=1791825509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQJb7vr8ZMuFWHiL+RnTPMV3r43UUmwaGCJuJ+OyJv4=;
        b=DuJPsJAQCc6NXd209tcqEGLlT9u1GyOvS+N/muz1tYoibLZIWPKAsAPo5CQis2PLua
         UnbSQtSAZdaCyy2QPMuEkUX0JaWFR9y8q4f5Kv1KRc9+5CXS2LxJUTMaESDq0QwcLvTR
         fM9TqwsElKNrOHknJT21Zg/WBiqBPWzUAgjBYtqqtulwpx3EdZTzB0wBuppD2q49pOgv
         sxmjPVKZazOLw5FwNalrp/nBVlJ2c0q3uY3ZU70XAsCp/Lp9Jg8CiNXaMJgjfBKSgl3f
         114CxkYXFYtwstnO63iNqY9YioV+m3D+LuOtNJvaQj0IFOmlsyznRJm7tvJ2fUlmGmXB
         ZdCg==
X-Forwarded-Encrypted: i=1; AKwUvBz0LnDiWzfsJGP9PZInGsXqazYinMPPK/hEC2r6goGRrJGCXN4QKWytCMRMBK2rqu6iMTYlJZMD3Sz4@vger.kernel.org
X-Gm-Message-State: AFq9FYIExckSwFqa9y5jVg2ub1gfSIhMgP49568IIfa4TBBdtH3UHv/A
	Zes6Ai+qF7/OxAbBrjOZYY1f7Sd2EVjFVdhwn6SVqWAJowtQKgVYhy34
X-Gm-Gg: AYBFou1Ih26RCoa/nqFa2dFUwPAKiEj7wGIJCrJzL1ijtjNloRhaS/AWQtyPxiis+uq
	MFNQwUWAHgdLa9SwzpSur/pFk8mjJOi7UYih6GW6gS3H4ZbTp87IrBGKK3ywwLQEZ3Gz9BOiykm
	H0itN0IUhtISeZj/RPD867W2ugITk/aU3qcjmSPfTDoj/OM0DTAQP1xhV0WbjUv7E7Alaj3LNr5
	h7SQPdHd3AHnSxKmTTraciw+smVC11072SJescGpsrgAoOYvQe5c5TmQ9EzqDEquE+szqDisLGv
	w23LMyyoSCWtRzROGewfQTqwRQMaHrczQ3mhD9OQSJuB1Xr2M4FcHsiniP1JJ5JaWp6g4GRNoBI
	/t5YGbrCHUK3hjHwnQvrOs34kPPItyHhqPLHptToedZT1Hw5Dj4GXnUU9Px8RpLNrQ96KXFIcVx
	dvPj8pr54Jlnb1PuMm7D7X/1bBUMQyLBUTgNEzqGvbpkBbxCNk4iGEO+taifWgKEXvjvvNJIo5f
	0yfv2HmgXJKVMkokBvlVFNcezZt6w==
X-Received: by 2002:a17:90b:270d:b0:3a4:97ea:f0d8 with SMTP id 98e67ed59e1d1-3a6ced37137mr10733555a91.51.1791220708564;
        Mon, 05 Oct 2026 10:18:28 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cafddesm406910a91.10.2026.10.05.10.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:18:28 -0700 (PDT)
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
Subject: [PATCH RFC v3 11/15] Documentation/litmus-tests: add hazptr acquire-before-scan test
Date: Tue,  6 Oct 2026 01:15:25 +0800
Message-ID: <20261005171529.1378809-12-kunwu.chan@gmail.com>
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

Add an LKMM test for the hazard-pointer publication protocol used
by the lockdep conversion.

The test checks that a scan cannot miss a hazard-pointer
publication while the reader still observes the pre-unpublish
pointer.  The smp_mb() pair provides the required ordering.

This covers the resolved-publication case.  The in-flight wildcard
window of the wildcard-flip scan is covered by
hazptr-wildcard-flip-escape.litmus.

Verified with herd7: Never 0 3.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
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

