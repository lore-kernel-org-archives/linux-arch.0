Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5058A4E13E8
	for <linux-arch@vger.kernel.org>; Mon,  5 Oct 2026 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220644; cv=none; b=ceEqQUWvuzST7HalTUCCEOGJOw+vklaREPGQPAA03nLfM4vUQ7kq+VGEtYSds/0MOlCqF5PJM/PsCIQmXy4A8XaK5Uh3+NKO2ecAJTWQYogAvUiSZt/jYAqtQh+GRHTlgaZq84ycsJdBHlrSGhgLgRspyJDMvi0HxJqMJaKrQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220644; c=relaxed/simple;
	bh=+3MpZXZDrpG3qLkvzfnf9AFNVYrh8OCkchmfy1w7NKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbW4htIqrA1wI3yr8/VUNHrBbjbVJ/xB//8udmJVzyw1LYZ8WSTvmMZ/4uaRcDu+ENwJZiJ9PXw8gLLdN3VNl3IHVLfN7Ise7+N35G8fao9wUMiaRXvHMJIc7y7dytVFNMwDqBO20hcH4Pr61YISTg5SkozjKkul7AnePQ81v4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Smt9EFxv; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Smt9EFxv"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccda24afso757407a91.3
        for <linux-arch@vger.kernel.org>; Mon, 05 Oct 2026 10:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791220642; x=1791825442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fgimI6/+2euHwRm1MdlOUoQLnXLe8HSbpGa41J2vK6A=;
        b=Smt9EFxvekpVrMOMqaRC5TFTpCRG74WHzK5c6xcGumUvBjmUfPtWC8jJZ1kKJGBZeb
         L2m4RTt3eAqpw1RM0U7HrzSAnzSGVfxcpcyRvfGVH3fRpQYvWAplmT08ajhkuA6alUSJ
         BUgGV/o58GiXsdEnmehpVyiEG+o6OPlDh4G5uX86DnOtCzGzIKfi9tZ+gUnvq6Kx++5X
         bKQV3vX96eP71PymYYPR505GVRtITize85QI0vxpkUnEEaLlQoo4FBzPwnBISdIl9xxF
         jMrrSD/MsKMSlbSv9fe9rcBRDeTNGXZaw6Tuc06DTr9SIQzKKQcAS2wEgaR4R5oFG7Qd
         e54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791220642; x=1791825442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fgimI6/+2euHwRm1MdlOUoQLnXLe8HSbpGa41J2vK6A=;
        b=Iv5KZGUirCo+r7Zjaa80zJshMOWXkr5dhuGvFsc66vOlWrKUn7ZWZFn9FBORXiIMED
         wKsB59cAcVgq4uhQagTAKyR0TkSvCuD2LhmVzQWNsIpEqGB4+RsEQBR9jPGZMOaBXK2/
         QenqXltVPhvmwFsCZoiFdTyrPEFMjXd5dgXJY6nQ3h5PQTtEUhKR9GUDBH8BvMzrKZF1
         PnBMpYyklizf8QDSLR5zKtepKmNyA0oBRKtHC47egmzjyPnIFTYIk+LLm6FvIYCBfIct
         9lE1ldE3ohsSDLwF3uecGdXPeGDIcS3920QAMTwzMP8NHq/r1sgAKgXhMBFYr6lvcI7k
         IdFA==
X-Forwarded-Encrypted: i=1; AKwUvBzBYAevSLcF9KBXMeQ4XTYEgoW60N3jLyiIaTijozqs5Pq1B+GrmHSQUoW5RQP/GSbiDXgCHdOcf2Dj@vger.kernel.org
X-Gm-Message-State: AFq9FYIuwDo19IrEb1sjIPTZXYQZczCQovEIZGyXE3T0kO9+P1kN6bdV
	ifCpSJNGvRANZRp07hnT/r1D+Ewh12CV+m7W69t/pgygy8sl17t8Hr+w
X-Gm-Gg: AYBFou2/wgykYvUWlK2FTirGZ3SG8ujYpPRsP4A9D6KrYGZ+w8C+kQT/QMmq2rUyXgt
	+Qo8KnjZyRSReZPry9hcT/UAI2AhH1rel8jBtZY9DpeJPk2oGCcZuFiJPde3N3O/j+zj1XZvzgt
	wmMZE9AZOKm34/C/F8y8MIVDxFWZwkh4j4h8KYjwOexQ/RZsWWfophuLRL7emMUiOeQJySiutrc
	+S6QX60je/b7coPZl2WOaDP394s/0eEFPtRtdTy78EwFvNw3pM96a2P59xgkuksZOpUE+16EH7O
	D6EFzthKbDoewUbrcKMp5OG9zhCFuhm0JwCkOgQzLabpcVNYp52YnD8/SrPjS+EM+n8dOeI3CYI
	/Nc8/nB9nU0hpRRVzJsZ3vBKmFtfawmZygagETlpWIaFm8SMcME7hAEgscLxK+inwEXziynqBzf
	Js/lvHCFHSqC3jEhj1odLMblEwOQZ2lTAPnXFhibEj3h4bJM3KmqRpWXjG9dMsElWo9VWlyw2az
	huE6PMGJr4Bg5GNnqbkUrRZ9Moajw==
X-Received: by 2002:a17:90b:4f84:b0:3a7:ee74:e8d2 with SMTP id 98e67ed59e1d1-3a7ee74eac6mr1974037a91.25.1791220641154;
        Mon, 05 Oct 2026 10:17:21 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cafddesm406910a91.10.2026.10.05.10.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:17:20 -0700 (PDT)
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
Subject: [PATCH RFC v3 07/15] Documentation/litmus-tests: add hazptr wildcard-flip escape test
Date: Tue,  6 Oct 2026 01:15:21 +0800
Message-ID: <20261005171529.1378809-8-kunwu.chan@gmail.com>
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

Add a three-process litmus test for the in-flight wildcard window
of the single-pass wildcard-flip scan.

P0 models hazptr_synchronize(): it unpublishes the object and
enqueues the waiter after its memory barrier.

P1 models the scan kthread: it picks up the waiter, flips the
wildcard, and performs the final hazard-pointer walk.

P2 models a straggling hazptr_acquire(): it reads and publishes
the old wildcard, then loads the object after its publication
barrier.

The forbidden outcome is that the final walk misses the
straggler's slot while the straggler still loads the unpublished
object.

Verified with herd7 (linux-kernel.cfg): Never 0 13.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 .../hazptr/hazptr-wildcard-flip-escape.litmus | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus

diff --git a/Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus b/Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus
new file mode 100644
index 000000000000..de467bb82d20
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-wildcard-flip-escape.litmus
@@ -0,0 +1,46 @@
+C hazptr-wildcard-flip-escape
+
+(*
+ * Result: Never
+ *
+ * Check that a straggling acquire which published the old
+ * wildcard after the final walk cannot still load the
+ * unpublished object.
+ *)
+
+{
+	int ptr = 3;
+	int hp = 0;
+	int wildcard = 1;
+	int enq = 0;
+}
+
+P0(int *ptr, int *enq)
+{
+	WRITE_ONCE(*ptr, 0);
+	smp_mb();
+	smp_store_release(enq, 1);
+}
+
+P1(int *enq, int *wildcard, int *hp)
+{
+	int r1;
+	int r2;
+
+	r1 = smp_load_acquire(enq);
+	WRITE_ONCE(*wildcard, 2);
+	r2 = READ_ONCE(*hp);
+}
+
+P2(int *wildcard, int *hp, int *ptr)
+{
+	int r0;
+	int r3;
+
+	r0 = READ_ONCE(*wildcard);
+	WRITE_ONCE(*hp, r0);
+	smp_mb();
+	r3 = READ_ONCE(*ptr);
+}
+
+exists (1:r1=1 /\ 1:r2=0 /\ 2:r3=3)
-- 
2.43.0

