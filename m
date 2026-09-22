Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F744FDA59
	for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2026 07:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061048; cv=none; b=T/z2xdU0YxqPFDq2i3Pv8sBQBZRLbAP0zaIWzK+j9sI1CDfirKiV7Pu3M29RPBZIgIc3kxblbNOYvi6VUQGN0VHu6oD+jG2BVBOZjY0Hk2pSMOgTvmj1HtXUeGH+uxzlNh+APACtJ3SMWYdHLaiCtnzJz5hN2GUrmgfNPUce52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061048; c=relaxed/simple;
	bh=JeXul2Nkf2zeS2OWaaoOg5njiRzZPTKUOP2PjjDjokQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/YLwmyvjhJymnzZDFLfw3JIPRm2HAmf6kVgdciT8OcxYMEebu1ypcHa2BwTMsm5iUtBKx+wfuhHSU0HdydJBKeICqQ83SKcnnsfz2tnzkQjDXzE1MQKlGxqs1YYpgWb9afn8ntRwbU2Dvxj2Vb84BI57x0LbnyJQZHODUTalRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdTPOEdm; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdTPOEdm"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea4c7a0so2061126a12.1
        for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2026 00:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790061046; x=1790665846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fM25rpREpN0YJ4vGmgefvM6EGacbAogSR9saanUz1wI=;
        b=sdTPOEdmJXwieL/77+UQ5ZopnJVY8eQ0VbwKBd42xXAxXLTxn2xTYQVnWxnlv+6hqT
         IA+Mo5NUhqX95i1TSjolIymQh0ErsvyY524YmOXfToegh7Vi6zoGjeAWDN+1AqdikQ9n
         3dWFm8++MfBftbgcwdOYspdJcpWwPNw9f5GSSMH5hFqxyuGcWjdeaRQkVjAvhgkaqpMb
         8JubUW3fyaVu+fndevBZuwVwyg6xLgaQKP1JeNtkqJnKyuU04XcP5gzcymUafxfgtrPG
         rkaOt7IzFSiHRsEplM6gvhDMcierdgdoGWStAh4KyXZSv09Yn7SGr2tua18MqTC9/D68
         mf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061046; x=1790665846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fM25rpREpN0YJ4vGmgefvM6EGacbAogSR9saanUz1wI=;
        b=Ibrd3Ojmw5AG/Z/DIP8edxrhGcrHxdnVYBPnBrLFJS9yCMDiFY9m8Jc0bfg0acoDCm
         KEfKizRS7dRDm4HsvmaApyQZ2+oSN7IaeC2QHdny2wqC2/VoAmcbh0PYsUxyIcYG2yRQ
         bDT74ZjQAyq+6e18eghe8Bq+BNpvuPvZqFwmj4nBfDEeZDDqUcXHiefaZzexOcrWOqt7
         jmhwhE1XeK0RRhvj1NzQtRPSv/BAVaizb0CZfs7WQpHc2bd6XYeKA3FiAyvmARAiL7ym
         pSRUU/BSyRJqsU7RA2p5I4h2JYzKM3sYGWL/Zh39bHDb6xc6qOj+f2I0wXv8CE7l4cHa
         ku2Q==
X-Forwarded-Encrypted: i=1; AKwUvBwK7zrV6vURt4yXO91pOyhBccl/+Qyy31Ca6STxsLT/0D22hMfuZW8Y7ujVaBjL4JBRbnTLCwpMpmmE@vger.kernel.org
X-Gm-Message-State: AFuF++mSf+FzV5eGhR8vb1A74X0Lv9lHvxGo2v75Mdng1aLBwzl//aWx
	sCMMcT3hfXUQdMPLyL/VBNDCzWZA03KyUZUET891Sn05g6kgSqXwy4jg
X-Gm-Gg: AYBFou1IuwXjJHt3YsrVeavYtMmDaktGQxgFEx7Jp3rjA/9hMjt3Y1n0YS10yn/W90B
	yZF7A+FE4HrAVL9Qca5KhwzxEVLwVZd30F0gu+vuuLzIEdrMubOyO+UAobV6mjD093MXgqETF8S
	6CoE7x8d08TcvhUQM6pvp553MpLtnpIfYc5EcFpAc8PWraH4/WewuWdGPpAz3Rjm6YocKXeEVuY
	FprOifS/gz8nL8nxG0nUm1b3Sg3undwaBZ78flbrGpKEwZVCeUD/JSMgQcFTj2ZzTWi9R5rbpaA
	oY8uwknFpUL79pVCmoEzWvTEJmCZXTEwBvA71TStP/Ue9vRFum6WPcMI6qQ30M/7lXmaoeX/c6Y
	Y4OXG77w4dKlt6P0TkKVgfRBupXncMhVL58dbgec9Sw9/z2h/t/K1W4B9vpDMN06cQK8wweNAI3
	ia2Gk+SlZgJHJTEMYY5p9xcZ4nKOQKmfmmQrDrEdmTAJ2vd6NpgbyaP1ah/2EBLALaCPMbvt4o7
	1U3HPe+imjA1CHl/A==
X-Received: by 2002:a17:90b:58d0:b0:3a0:4668:4cb0 with SMTP id 98e67ed59e1d1-3a07322a5bfmr239358a91.47.1790061045855;
        Tue, 22 Sep 2026 00:10:45 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a067409854sm3079414a91.7.2026.09.22.00.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:10:45 -0700 (PDT)
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
Subject: [RFC/WIP PATCH 4/4] Documentation/litmus-tests: add hazptr acquire-before-scan test
Date: Tue, 22 Sep 2026 15:09:50 +0800
Message-ID: <20260922070950.4173245-5-kunwu.chan@gmail.com>
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

Add an LKMM test for the hazard-pointer publication protocol used
by the lockdep conversion.

The test checks that the reclaimer cannot miss a reader hazard
pointer publication while the reader still observes the
pre-unpublish pointer.  The smp_mb() pair provides the required
ordering.

Models the resolved-publication case; the in-flight wildcard window
is covered by the two-phase wildcard scan of the v3 implementation.

Verified with herd7: Never 0 6.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 .../hazptr/hazptr-acquire-before-scan.litmus  | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus

diff --git a/Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus b/Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus
new file mode 100644
index 000000000000..19df97f1c3b2
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-acquire-before-scan.litmus
@@ -0,0 +1,49 @@
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
+ * Models the resolved-publication case; the in-flight wildcard
+ * window is covered by the two-phase wildcard scan of the v3
+ * implementation.
+ *)
+
+{
+int ptr = 1;	(* 1: points to the object, 0: unpublished. *)
+int hp = 0;	(* Hazard-pointer slot: 0: empty, 1: holds the addr. *)
+int data = 1;	(* Object payload; 0: reclaimed. *)
+}
+
+P0(int *ptr, int *hp, int *data)
+{
+	int r0;
+
+	WRITE_ONCE(*ptr, 0);	/* Store A: unpublish. */
+	smp_mb();
+	r0 = READ_ONCE(*hp);	/* Load B: scan. */
+	WRITE_ONCE(*data, 0);	/* Reclaim. */
+}
+
+P1(int *ptr, int *hp, int *data)
+{
+	int r0;
+	int r1;
+
+	WRITE_ONCE(*hp, 1);	/* Store B: publish. */
+	smp_mb();
+	r0 = READ_ONCE(*ptr);	/* Load A: load pointer. */
+	r1 = READ_ONCE(*data);	/* Access object. */
+}
+
+exists (0:r0=0 /\ 1:r0=1)
-- 
2.43.0

