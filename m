Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90631481641
	for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 14:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396809; cv=none; b=MMozrlSyKEnL8dW0ar1fTbHDgnm/6xX1CIYnMEyfDBQ78XXfgFCblogEVNXNaUkHBbmpweSD+AgwnzJT+GZTh/gtq/2xY3MpVFjQZB2AWBp4MjHS2NJmstvGQtFF04SB1c0VbrmyUvYxec4TZdkbA/H30SVaDaTdBbgjadXxJ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396809; c=relaxed/simple;
	bh=OxFt4akoNsEexOq08kiv4ugMYoiwz392oGi34kiEw08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=io5iEa4ZHzguIMalHvUe5fHKbZ9hAo3bhgSnmiC0N2/0ElfLUpD4iApQ6ltsNkRAlbwYLi9pzKYpHFtoqxN/lOchemnZt3qEUfl6ITlRGOJAnd+pbQtJbym3LwJ7xjMgwD+iPioR6naEoGh9o4Qe4fn/aGIGJNpLMoQV2Yu1Dqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUPWXjlb; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUPWXjlb"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4bfd1so1595862a12.0
        for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 07:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789396805; x=1790001605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kn6DJj3lF06ye8TRKy/PBnP78dAx6rrnR2CCLvj5EOE=;
        b=jUPWXjlbXyfnIsDWNG1k9Cge3aIMcHyHJSDyIte5jQCUXBFgyzUld1wBr1xZYCKvy+
         ioVW4sQyUcLxvEr5GGq5saR0wHyrEos2xv8xLwbC4NJN8jWoUG51mmC+xhxZv47heaZA
         MIxGGKdIoN9bjgS95P/UjJMVpzmV9yOxWS5UNKvdOFkHUov6cv2RiuWrmaFlbSgCIP+t
         5gjk3rFpOsoUnxXJNNwYvPWOjzqRcTqNmg2AJQHp8jA6kCR6U4sStl7qCU/OTLWHLrBU
         2XD2STkNEQHbM3XDgzTlasXMK6adcux94i67d5fAT2wWf/lYp0ExxfvepWh6RBfFLqxa
         yGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789396805; x=1790001605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kn6DJj3lF06ye8TRKy/PBnP78dAx6rrnR2CCLvj5EOE=;
        b=Gl5l/TJjA2WbK9o3KDQmRVCR8L1QEaZNGnK4iHJGdDDVZb4QAdN48q/iNr3J0mOWPa
         DhH9NzA0mK3B9o5VJwjDKxYeM/DzHP600qjLMctqyA9n/KBE19767R0JL82bGYtLH6sF
         RjFNB/Lj6iRcol0yZ0IYonREr0l1OtQLnL9MoJR9GaIVbWmvkVNWtfjpp1vgGK7YcQdC
         nZuBX1pK5npm2xv7Wtgo058HCFHIsC5oF/v46MFH/s/f8QI27HP8LYYU6Gu68iEplugd
         ZRFsW9UToTeEAf/fI/zQJzyYWMyVTGtcEgxKPiqfz4wDEvkpgv0OHQ9GyxE1nhyEb9SF
         Rvgg==
X-Forwarded-Encrypted: i=1; AKwUvBxAurFzF05CZ30bfNoCBeJn8IBVqGT/45gShUqD6vawBF0pnUmmcur9osycS5o1C+qsva2IDJ/6tMrD@vger.kernel.org
X-Gm-Message-State: AFuF++llU4gXxiDR5khJPt9u8pXt4Zv6i8aSuTYjEkOQJ5ZK8izH/spL
	bPprcGrkbSN8YVeyVT2kqErmwdUWK8qT1hjJqRLgkG57M0Hd3ZFuvm9F
X-Gm-Gg: AYBFou2qzrRKG1gDbG0DXrCNelZV4cfaxoFEnetitHiL4Wim70TSuksjenyifDehMVe
	LK6GU71m4MVcY2/j4lwopC+CkYG9QDxDM9YSlIZUhVCPfvCxu70W3DeKC0w8jvmqyKqcJ6Vrpjx
	a10/DePB2MeMO15zRO5l7h3X/ZcGWnyRzpuiyRhtEsqJZcDh8s4BzH8LcZAwX7BFJzMBh3ADw/M
	VSfDS3DWFqOjQtTB3ZEvC9K5mbHMnV/Ee3Z8RAe2J+DYCf37ji/Svr6n464Wwl67Qx61/n01oqQ
	431b3nDbNzZvEddtm+ccK3o7g10t4x+6LVrfD/GEUxHJZbQ97FklvYdnQM/wkVswMtDArkAo6c3
	NkxohipYazeMUfgS3v8+kSM03rzpLSfR6CSy0nbF4K0xeQ9DcX+kpyYtdHRjG1yJ7xEg54K6PWw
	AVag8mBM/coc5aUa4+Rod77I6BU7ITnMiRZ1y65V8FI60myEbKqI5pFv+Q2zeTwcTnadcZaOWS7
	lIhMTYsAe1Wtdp+VZ+6tiWgMr9MTA==
X-Received: by 2002:a05:6a20:728e:b0:3bf:63af:855 with SMTP id adf61e73a8af0-3db404486dfmr6684782637.1.1789396804818;
        Mon, 14 Sep 2026 07:40:04 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6572ecasm5149444a12.22.2026.09.14.07.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:40:04 -0700 (PDT)
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
Subject: [PATCH v3 1/2] Documentation/litmus-tests: Add SRCU fastpath anchor-before-scan test
Date: Mon, 14 Sep 2026 22:39:41 +0800
Message-ID: <20260914143943.1503066-2-kunwu.chan@gmail.com>
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

synchronize_srcu_atomic() may end its grace period immediately when
its scan of the per-CPU lock counters finds no readers.  Correctness
requires the grace-period anchor written by srcu_gp_start() to precede
the smp_mb() ordering the lock scan.  This ordering ensures that any
reader whose lock increment is missed by the scan cannot have
incremented its lock counter before the grace-period anchor, and
therefore cannot be a pre-existing reader of this grace period.

This litmus test models the key ordering between the grace-period
anchor and the lock counter scan, where "seq" models the
grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
smp_mb() and the lock scan.  P1 models the reader-side counter
increment and its smp_mb() from __srcu_read_lock(), which orders
the increment against subsequent critical-section access.  P2 models
an observer that sees the reader's increment before seeing the
anchor.

The outcome is forbidden by LKMM, and herd7 reports "Never".  See
SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
which permits this outcome.

Tested with herd7 7.58 using linux-kernel.cfg.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 .../SRCU-fastpath-anchor-before-scan.litmus   | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus

diff --git a/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus b/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus
new file mode 100644
index 000000000000..e0492a4d8e07
--- /dev/null
+++ b/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.litmus
@@ -0,0 +1,58 @@
+C SRCU-fastpath-anchor-before-scan
+
+(*
+ * Result: Never
+ *
+ * The synchronize_srcu_atomic() fastpath may end its grace period
+ * immediately when its scan of the per-CPU lock counters finds no
+ * readers.  Correctness requires the grace-period anchor written by
+ * srcu_gp_start() to precede the smp_mb() ordering the lock scan.
+ * This ordering ensures that any reader whose lock increment is missed
+ * by the scan cannot have incremented its lock counter before the
+ * grace-period anchor, and therefore cannot be a pre-existing reader
+ * of this grace period.
+ *
+ * This litmus test models the key ordering between the grace-period
+ * anchor and the lock counter scan, where "seq" models the
+ * grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
+ * ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
+ * smp_mb() and the lock scan.  P1 models the reader-side counter
+ * increment and its smp_mb() from __srcu_read_lock(), which orders the
+ * increment against subsequent critical-section access.  P2 models an
+ * observer that sees the reader's increment before seeing the anchor.
+ *
+ * The outcome is forbidden by LKMM, and herd7 reports "Never".  See
+ * SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
+ * which permits this outcome.
+ *)
+
+{}
+
+P0(int *seq, int *ctr)
+{
+	int r2;
+
+	WRITE_ONCE(*seq, 1);
+	smp_mb();
+	r2 = READ_ONCE(*ctr);
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

