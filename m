Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F2E48122C
	for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 14:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396814; cv=none; b=C7rwBuK9cMOIjjQtM1bDNgVRfutABV6cqCCaOvNln7T+sNbrF+CHtMY5rAq3kXfWO5fMGl6J+oQ6lkeGzySKAwfCDrkszCVfAlUf+RYd14L0vzxIU9vJIz5DlS3S98VFFzVVmgIXZrT2lIyCVHoRK5kVbsjh7+5+8fGDDE6zV5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396814; c=relaxed/simple;
	bh=PchcDlD3Npn6+8wPRM9VRYzNcIBmakxNDUNZLTTsXSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrGfAb+AC9SUyV1PQP9Dv8+wmt7FSamkE4gsKufG/Ad6QobO6PCWW/wyPx93S35MyqVPM1kMMwvOzKhsgRdKUzB96s9PHJW8aGsDGwU7m8qOMuSqAFEXVb6B0USrLvHsfLIwWAAfIiyEgIPSiN11zFWAUYomq6U4VUj7S/oh7fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ov0r6epr; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov0r6epr"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc4c7fab7b6so3950587a12.0
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 07:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789396811; x=1790001611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/kBzFP/HpzVRM8R641fR3ZeSCydIAXhP1zBP9Whsejw=;
        b=Ov0r6eprPvy5QIg7aXFGexQt7qTAriSmaBWATxy4Hh21HAuE+6xqi2/GyTSgJYCSl4
         jMyGe6Gh7XfR//RWndf7ZJ+jl1/x5D8G5vsD37O4c4BH9+IIVqhaeIjzbvrsnf2VwO1f
         A2kO+k+NrcWt9xFCuMMKu9i1Pdep0F5v18C6lPs6YPvXInVCLZ2rHMK8CLWXRqq+hn+H
         5SnDb9Xde0En3NWVatWPp+sHv+mEJ5WVeoq+WV2cNn5lRBAQM5uYrrxGtpkCjN836+fw
         L1LwZGedZSFoyFU1lBTx/HYGGXO7QAG9DyW1NrZYwxGk+VUaqYXbAoj/7Xotqk5K2+44
         VscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789396811; x=1790001611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/kBzFP/HpzVRM8R641fR3ZeSCydIAXhP1zBP9Whsejw=;
        b=tS9J+kXbud7HyxPldskg9JfQaZIJyJHHgva5WY0TnJ5eDrm1V0/xOFlTyS3hVtPlum
         skv2fg8/ricEP0G/+nl2g40ZH95gLBrlCnbbADZQ/rGciHtatIMvJ3WnSX+Wk3f/lg3u
         hiHvPHpZGJQvQGHvvaoat1/6uPBVYteIMGwzJkQKuXD7L71Im9eBV1VaInau/6l9ANqe
         fpXLPEWUKPuRf3WV9UiRdGqjY9WTyL7Aah1hqEiJgjWb/Nv2x4hvMc/hZqFlgcUNUT4X
         cmo82jORtRCjhKyX6f3cxEzTCnOI4gFqrgRBn+NGF+7PhYLZV+R46jJikN1pIgCvZpOD
         UaWA==
X-Forwarded-Encrypted: i=1; AKwUvBwj43Cd0oD8HWLxbqij35nG3N9hY8kiHEMSUCSQKvl6ndxoKkTwv5UxCWFYTj5HpoKszvTJFAP5T1R7@vger.kernel.org
X-Gm-Message-State: AFuF++mNlmwcwHEzP/vsgiQnKO1YmQ05XOMjG2CJm/SOsflGR82dslAF
	RmfuONgSxo9UmtM8gPzCwKCpBstjvr1M5tHUnph8GHGkG1PIhb2yVTqg
X-Gm-Gg: AYBFou2BhAb2xQJGU60eonzyyl+WOzxictMi1PnrAvFZhfp+A6nKEi9YBPbb5OjhI8w
	iPlzHMT2lYCqcn1VdWSm/koiwoS8RZ4XQtmsm6dykr5qzbxbG8ytMfLO2sxInkVlpA+vWfyPeio
	qCivR8iQUamVlSXJjnOUC9PFE8jW2bpN7OMdbdAVDgmy/AABmqnhE/TgowBiFEBRYYnKlcyQufk
	8Fev0wPOOKjoLfvgbo/kHPop6wESq5KmEkKaGvS+lhQ51Y3uhZeX9AGearqvee+pgG7txzuUI4+
	BNaPFnnqTe7mAxhsvY+VjOg2WmhSAD2Ey65+u1mbMtZSDqz32sw0e/JFpA+MeFoLFq4uIpVNcdg
	Gku84QeChDFRNrzBYhabsb9JDGnPGCnNzBE7gcoxrL6fab4lBn6txZRFiHwvtQm3zSNRTT8KIRm
	zDGwyeiZh1dni6/GrskX0Jg+3WqT67t+wf8ayktXu8sGXCy/IivS/zwdFe2Yvl8IaMa8ARL6mQq
	Qxgd+zjS6IfWgzZdQ==
X-Received: by 2002:a05:6a21:4d06:b0:3da:e1b5:2baa with SMTP id adf61e73a8af0-3db404b4e1dmr6402183637.2.1789396811120;
        Mon, 14 Sep 2026 07:40:11 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6572ecasm5149444a12.22.2026.09.14.07.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:40:10 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	corbet@lwn.net,
	akiyks@gmail.com,
	luc.maranget@inria.fr,
	j.alglave@ucl.ac.uk,
	dhowells@redhat.com,
	npiggin@gmail.com,
	boqun@kernel.org,
	peterz@infradead.org,
	will@kernel.org,
	parri.andrea@gmail.com,
	stern@rowland.harvard.edu
Cc: linux-doc@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH v3 2/2] Documentation/litmus-tests: Add SRCU fastpath scan-before-anchor test
Date: Mon, 14 Sep 2026 22:39:42 +0800
Message-ID: <20260914143943.1503066-3-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914143943.1503066-1-kunwu.chan@gmail.com>
References: <20260914143943.1503066-1-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the synchronize_srcu_atomic() fastpath instead places its lock scan
before the grace-period anchor, the scan can miss a reader whose
increment was already visible before the anchor.  That reader already
existed when the grace period started, so completing the grace period
without waiting for it would violate the SRCU grace-period guarantee.

This litmus test models the reversed ordering, with the lock scan placed
before the grace-period anchor.  "seq" models the grace-period anchor in
->srcu_gp_seq and "ctr" models the per-CPU ->srcu_ctrs[].srcu_locks
counter.  P0 scans the lock counter before writing the anchor, with an
smp_mb() between them.  P1 models the reader-side counter increment and
its smp_mb() from __srcu_read_lock(), which orders the increment against
subsequent critical-section access.  P2 models an observer that sees the
reader's increment before seeing the anchor.

The same outcome is allowed with this ordering, and herd7 reports
"Sometimes".  The litmus-tests README is also updated to describe both
SRCU fastpath tests.

Tested with herd7 7.58 using linux-kernel.cfg.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 Documentation/litmus-tests/README             | 21 +++++++
 .../SRCU-fastpath-scan-before-anchor.litmus   | 56 +++++++++++++++++++
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/litmus-tests/srcu/SRCU-fastpath-scan-before-anchor.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 6c666f3422ea..f96eeacb002b 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -78,3 +78,24 @@ RCU+sync+read.litmus
 RCU+sync+free.litmus
     Both the above litmus tests demonstrate the RCU grace period guarantee
     that an RCU read-side critical section can never span a grace period.
+
+
+SRCU (/srcu directory)
+----------------------
+
+SRCU-fastpath-anchor-before-scan.litmus
+    This models the synchronize_srcu_atomic() fastpath with the
+    grace-period anchor ordered before the lock-counter scan.  This
+    ordering prevents readers that existed before the grace period
+    from being missed by the scan.  See
+    SRCU-fastpath-scan-before-anchor.litmus for the reversed
+    ordering.
+
+SRCU-fastpath-scan-before-anchor.litmus
+    This models the synchronize_srcu_atomic() fastpath with the
+    lock-counter scan ordered before the grace-period anchor.  This
+    permits the scan to miss readers that existed before the grace
+    period, violating the SRCU grace-period guarantee.  See
+    SRCU-fastpath-anchor-before-scan.litmus for the opposite
+    ordering.
+
diff --git a/Documentation/litmus-tests/srcu/SRCU-fastpath-scan-before-anchor.litmus b/Documentation/litmus-tests/srcu/SRCU-fastpath-scan-before-anchor.litmus
new file mode 100644
index 000000000000..d8808571063f
--- /dev/null
+++ b/Documentation/litmus-tests/srcu/SRCU-fastpath-scan-before-anchor.litmus
@@ -0,0 +1,56 @@
+C SRCU-fastpath-scan-before-anchor
+
+(*
+ * Result: Sometimes
+ *
+ * If the synchronize_srcu_atomic() fastpath instead places its lock
+ * scan before the grace-period anchor, the scan can miss a reader whose
+ * increment was already visible before the anchor.  That reader already
+ * existed when the grace period started, so completing the grace period
+ * without waiting for it would violate the SRCU grace-period guarantee.
+ *
+ * This litmus test models the reversed ordering, with the lock scan
+ * placed before the grace-period anchor.  "seq" models the grace-period
+ * anchor in ->srcu_gp_seq and "ctr" models the per-CPU
+ * ->srcu_ctrs[].srcu_locks counter.  P0 scans the lock counter before
+ * writing the anchor, with an smp_mb() between them.  P1 models the
+ * reader-side counter increment and its smp_mb() from
+ * __srcu_read_lock(), which orders the increment against subsequent
+ * critical-section access.  P2 models an observer that sees the
+ * reader's increment before seeing the anchor.
+ *
+ * The same outcome is allowed with this ordering, and herd7 reports
+ * "Sometimes".  See SRCU-fastpath-anchor-before-scan.litmus for the
+ * opposite ordering, which forbids this outcome.
+ *)
+
+{}
+
+P0(int *seq, int *ctr)
+{
+	int r2;
+
+	r2 = READ_ONCE(*ctr);
+	smp_mb();
+	WRITE_ONCE(*seq, 1);
+}
+
+P1(int *ctr, int *x)
+{
+	WRITE_ONCE(*ctr, 1);
+	smp_mb();
+	WRITE_ONCE(*x, 1);
+}
+
+P2(int *seq, int *ctr)
+{
+	int r3;
+	int r4;
+
+	r3 = READ_ONCE(*ctr);
+	smp_mb();
+	r4 = READ_ONCE(*seq);
+}
+
+filter (0:r2 = 0)
+exists (2:r3 = 1 /\ 2:r4 = 0)
-- 
2.43.0

