Received: from mail-pz2-f13.google.com (mail-pz2-f13.google.com [74.125.228.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2C440A945
	for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2026 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961037; cv=none; b=ZtAbLtNWulv/wspOP1KGF0SP1ESMkre2HaMJn2HsVhtpMYUIrd4nr68TUp93ui9ikEv09tYFJv6W9dz8Nc2KVdtKWvbw2SgT641fuIgl+NEpn2z+hw9lAjzeFSDcKg8WxYPqy2vrr/Cs+Ie4cOmTgOhrrc2XC5f7KifSYCInnEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961037; c=relaxed/simple;
	bh=+3MpZXZDrpG3qLkvzfnf9AFNVYrh8OCkchmfy1w7NKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6xn31khefF6s79oVTOqZvzppH3N95RJU0KyfWnc7j8NIuf6018zI40+VFud8PmgtjMRPLM1Ccc55AqHImHIol7REm1BA30lC6Vx12U1oafIiCxoDFEp4CzpSZ40PYva/7iBilBPkllfPaYTIdfeUh2w5LENn3NDqB8nKonnptQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MUGeeCcU; arc=none smtp.client-ip=74.125.228.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUGeeCcU"
Received: by mail-pz2-f13.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so3512956a12.3
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2026 10:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790961019; x=1791565819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fgimI6/+2euHwRm1MdlOUoQLnXLe8HSbpGa41J2vK6A=;
        b=MUGeeCcUXiDbMAHxZ/HyZlqYCMmo1ZTm3sKrqlRw5cDpxTglM8LD3v7Hj6zLg/ZZ5y
         8x86JxX9c/SAFGzB8HVoFgUcNWFDSdrpaRzrPRZvNlttlvLC6IP/ifyAPwy0GfY/Rzdm
         UzvS9rX9HE2xYJnlYPATXqymU2I1t6sANqs7p36M1AyIos/41xVkKchlSPXzkwEOZF1P
         74TExR6xH4DJJlaXm0O56Pj0D10kWr5Byl61FPGfSSauon/6Oe0W8Kr1zkE+zFy9FQBl
         UUEhEpevoAO/RVD58Tz8hohKZvZic+ERB6izJkZK1Mnyd8/2roSmWo6ggBGT+Gkkr9h1
         O3lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961019; x=1791565819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fgimI6/+2euHwRm1MdlOUoQLnXLe8HSbpGa41J2vK6A=;
        b=eT9if/URSaQAd77MA/RrdebjXKv1VrvJYxRGRPyfYUfFRPQ5y0G0ykHBU/w66on7kK
         CMSk3nmo12s9P59U8ixJ+w32TNPxT2Ib5FwRf3zcU18hryw5SgdEWocDhjI6YVj0susd
         iagar8J0ULMI3pqjPG/S7n1jMnjhKdcfpaXd96GxE8iS8lngiTgQnHKBiVS2ktjOAc24
         mD6I39u8ww1vad+2JlfRtV6HGrHwIfgoswSH7dAlwMaEI3QqCFazYnq/lw9vNPSHCI8z
         aYvcl9Gd+WVJ2MZFgrIHj5/hheHqAJMYi2CtRDEXhA2Uyv0y6WTHjPsu1+gXtrU1wgur
         fK9w==
X-Forwarded-Encrypted: i=1; AKwUvBxCTsplGz3PwFWpbBQ2esNHurEXD1eRCfJV28KRNC5V/kZoWn2xAL2J/xMUkNSZlppUwG3rU1d0lCS+@vger.kernel.org
X-Gm-Message-State: AFq9FYIOtsRjJ/9LsQK1GxVYGgIc8sc6EErFI4cGGloWIE+lohbJXJah
	9C2eNydbbUzm2/d64tZMc7QaAsLZHtBMQYC0NX6CFNZnOBmY0FyUVq1T
X-Gm-Gg: AYBFou16Kk7znGrJ50mFNTk48gdQ5HYISCTCuZtQ9R3D63+j9g1IlKRNtuagjNHVVxa
	qIUCsAIOzLHGKy/PVgO9OWkdCToU4SK3vRG/4KVjfO7XQS0t0W83l/ZC7II01z5aFUgSMGJCOyu
	piWXVggVN8srwAs7nulw04cfBRDp6QCjHkJ84dpYILpZHbye8huVEAnjX+Ot9z5iykNQuL1XjaG
	g+GJSVbPrZ31+jmfVyIznJP9UhtoaVPJ1+O3SN+fsK2ifMBZIoJe89Hk2UVub8pwe2Zcz/CbaRW
	eN9ElyHdPmv0PLRSkcc3sqXMw73RRUnvldLM3n8jNFkXSwdzFA0dRJeRf+fBy84TdLS3A8Ny786
	6HVg57Sj5VJSCbGrXYyI9+CcCmhk7o/NCHePcfqemuHlUM3O4vJVKdbHw6E6llXCXG8HpxQEHco
	rKM7Nu5kwORVD7Q0p/AU/5LT0UqHdwNTuce8SiLFEKBchz198ie8H6z0eu9Yl8T5TtT8Y+08Rly
	E7CrEO1+rg5Cs0XOg==
X-Received: by 2002:a17:90b:1dce:b0:3a4:6f38:f2a2 with SMTP id 98e67ed59e1d1-3a6ce959345mr2937077a91.25.1790961018501;
        Fri, 02 Oct 2026 10:10:18 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7024d0f5fsm1597719a91.0.2026.10.02.10.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:10:18 -0700 (PDT)
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
Subject: [PATCH RFC v2 07/15] Documentation/litmus-tests: add hazptr wildcard-flip escape test
Date: Sat,  3 Oct 2026 01:08:39 +0800
Message-ID: <20261002170847.3653663-8-kunwu.chan@gmail.com>
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

