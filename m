Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811497;
	b=ppAduTxtKp0JqzmlztFnLc5n0ssrL0J6BG4skzVYMh6jGgvQdXGsIDh+4JIa/rcbdlfX
	 IYsu6rCualG3tJPIXTdJChGgD+hsRCJ+LBisUSFXhfVvu9UnsIjFH+t2FmQpaTvlp/NWG
	 QI/uluTOkGRzZ7E2B8pbZynrAqMZM6ZZ8MSUTMqoN6iyNlopmYLB13N/EoLRram9eWSKX
	 mPdSIL8VmucQZkJPIutpHdZ4qTyU1KLI2YH1cj0Iq9f4Av3q2ZbZHS9CbHASI8MvyWdNs
	 fOBjHhGYWFCGwMpuE/yBqQylfGnNXXHkWI+IAwh6EFFhHzuItDcInU5ml6MM7tq6BAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Y7w9zIZGwFreJVwPOaTuHd6p4ZAf4hMC78IhCBOO/FI=;
	b=WZawlCQggQ8wgiArHcX2n2K1D5JnmN/Fb38vqiFS5zO2jlwiryN9LlTUDsDoqRfc5oDB
	 s34r8zjVWmkmfE8SkvVJ97mcUgTQdjy5s/j3i7YPRDnlyes6EMDw225//XSUe7ID9Lfsu
	 ZFeQWRQfTJphnCPUs/gXdWdKM2AFUF06cQxkqRPGJTjUNxzgc58hHemJyXm1aLR91jDTW
	 fGG2Q4shLGwGEhCVX6NBXY/ECY9P2c0qTk1IVdYScrGGwr8yDHt5ZcJZF6oS9qF2QXCfu
	 fH7cdH7TOLYsQmwnI9A0bkPryaNxZiMjqZsrV6bLb0l8Qsffe0eB4Cp9paXjqJHrHQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hNr3tUus;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852A606D817
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1852A606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hNr3tUus
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36cad25b8b0so1364246eec.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811495; x=1794416295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y7w9zIZGwFreJVwPOaTuHd6p4ZAf4hMC78IhCBOO/FI=;
        b=hNr3tUusaaErjUitu2I6XbppO/tHcSXKdcNOfa5cTRenOkzbAShzlYf+Vh6lhhHcnU
         tV0j2CjmKzhKKOb88naSBWlsm7UMSz+rFmaMbHHVVo52UBAQUQqzpBCnbhekDTbeMHdu
         m2HGm/OC5cbaC5EsFBwb01g0ztwO9qcrVtWW/Gy5r5WiqyNKkT4Fnrid+ZtOZGerKzfs
         i5yhjeAtyPa/dnKRefMUtTmhyXApUGDjfd1Rt/xYYyIFeKFYslG1vZ7fTtcF5bzZh99e
         yUQCBLmrELZusND1vAwkU7lxXMR4LlihbNcRhxjtalepwnGQ6X6xc8qKK1tJvFak4VpN
         STow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811495; x=1794416295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y7w9zIZGwFreJVwPOaTuHd6p4ZAf4hMC78IhCBOO/FI=;
        b=gAU2NjbGfDtjlu3D3niGbz3zVmRPgu413lVudCUc9ltffwC5bsbdQUkhe/Q0xdHHam
         Cgjbyija9fuNdmmnuxEMkPI6jDaKk+EClRylAl3fxZyECxrbY9K7dKP/MseILLv7EoGl
         UFiYLQO+qZcbmDkKj9MYPtCmlRpwZQdDx0cjToMbF6HRz3To+nr4AhDOQW9RQd6/VCF1
         p0GRjeuGht5eQlu0lm3z07uomESQX69G0MxJaFdx7/BITNRmcrSezXcjnIbzBg6IrVAf
         Uh1iyoifbCIAxUssl0zIofQAKQZGjKITJmkZoKPcFdRdwc5sHt7c/NjEEFLWI3vuStwf
         mhiw==
X-Forwarded-Encrypted: i=1; AKwUvBz/94abbqAtQRnXXb57Gws6+7ZbCZqkfVaBOP84iLM9t44x7UXlFr8EpfX0/mQAu6c2mfsNBYyXJDul@vger.kernel.org
X-Gm-Message-State: APuU4Z/0y1nCcQlQG8AF1ZAcI0YtJjkvEx+7DCtGPTKFndqKG0qLzcXq
	VOu+x3gbsUMarZD3HeozVIeFC/1Jky9HFHm6eyclORVs1dP5Sd/McHr2
X-Gm-Gg: AYBFou3ECoEal3OKBWc0naDrS9LsHzZGxicGNGFMECW6Q4byhmjhQLlctqnfLXfqkYX
	ecw859z1Ciuj3iZaiB6qCT7FGxrZ/4A0hu1X6/X3dUF1h6US5/ZTZZs/FwCb9wvSiASyrWFoFmQ
	kkw1ZyFcDzzKiX5SCBfnB23bLUCUBruimjTC/AEWv18aY+lHbbFiO5R+HaoZiv/JLvLgPGMjEbA
	WcxRMIKgSLYmFO16ErHsH72DDJe7DeTWyFuvJd1VTwI2dcio7w3+ku5e6K6sgJwibKIng9V918t
	Eyil1hkuhnYuBQJ3x9CeUR+ffHVXMqCamjJSbEmwUBbmgPLmT2ga6UkBaQaT0uCIZhsUnkNv6kL
	BAxwtYVEqr83I5FAAJwwvzLXo+unEsYUeMut83RUixsEndgC9zYnF94M0zhgJnphubH+8xZ+qs+
	jDcwIuWJn0zjwhuPj2QvwCmS82mgFNwIM8+oMpoC1VU7SU4LQeI/9q6cAbt6NmIjmVE22obqCRB
	TSeXghu/vcFQaY6oao7HyA26knSjJAZyK8wNGUpJnNS/yRV5w6BTxqqniblytdG3ICTUJnHcWjK
	fLtwXT91q6b7Al7I52YgLUfnqXdJ8XbmqZv+53U=
X-Received: by 2002:a05:7301:fc81:b0:36c:d29e:668f with SMTP id 5a478bee46e88-36cd29e694cmr3306314eec.6.1793811494826;
        Wed, 04 Nov 2026 08:58:14 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:58:14 -0800 (PST)
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
Subject: [PATCH 19/28] Documentation/litmus-tests: Add hazptr drain generation-visibility test
Date: Thu,  5 Nov 2026 00:54:37 +0800
Message-ID: <20261104165504.2430480-20-kunwu.chan@gmail.com>
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

Prove that the drain engage's smp_mb() publication ordering is
correct: a release hook that observes the new drain address also
observes the new generation counter (herd7: Never).

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 Documentation/litmus-tests/README             |  4 ++
 .../hazptr-drain-generation-visibility.litmus | 41 +++++++++++++++++++
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/litmus-tests/hazptr/hazptr-drain-generation-visibility.litmus

diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
index 604c2c0025d9..79b0634ddb13 100644
--- a/Documentation/litmus-tests/README
+++ b/Documentation/litmus-tests/README
@@ -123,3 +123,7 @@ hazptr-drain-resnapshot-slot-race.litmus
 hazptr-drain-safety.litmus
     Test the engage snapshot race: the engage can miss an in-flight
     slow-path acquire, so completion must defer on wildcards.
+
+hazptr-drain-generation-visibility.litmus
+    Test the drain generation ordering: a release hook that observes
+    the new drain address also observes the new generation.
diff --git a/Documentation/litmus-tests/hazptr/hazptr-drain-generation-visibility.litmus b/Documentation/litmus-tests/hazptr/hazptr-drain-generation-visibility.litmus
new file mode 100644
index 000000000000..d5c1ca247d71
--- /dev/null
+++ b/Documentation/litmus-tests/hazptr/hazptr-drain-generation-visibility.litmus
@@ -0,0 +1,41 @@
+C hazptr-drain-generation-visibility
+
+(*
+ * Result: Never
+ *
+ * Drain generation visibility: the engage publishes the
+ * generation counter before the drain address (separated by
+ * smp_mb()).  The release hook reads the address with
+ * smp_load_acquire().  If it observes the new address, the
+ * subsequent generation read must also observe the new value,
+ * so the cmpxchg compares against the correct round.
+ *
+ * If this were not the case, a release could read a stale
+ * generation (from the previous drain round) while the address
+ * already belongs to the new round, causing the cmpxchg to
+ * succeed against the wrong round's marker and falsely
+ * decrement the new round's backup_outstanding.
+ *)
+
+{
+	gen = 5;
+	addr = 0;
+}
+
+P0(int *gen, int *addr)
+{
+	WRITE_ONCE(*gen, 6);
+	smp_mb();
+	WRITE_ONCE(*addr, 1);
+}
+
+P1(int *addr, int *gen)
+{
+	int r0;
+	int r1;
+
+	r0 = smp_load_acquire(addr);
+	r1 = READ_ONCE(*gen);
+}
+
+exists (1:r0=1 /\ 1:r1=5)
\ No newline at end of file
-- 
2.43.0

