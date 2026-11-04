Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811404;
	b=nN98BdCgxmgYJI0+6NtzrtCfKRRnvurdY8VIOuHfI7RKuO7aH2okWlcyC2lGaDqeCQ6w
	 OIB88P/cOBS9/XIr8m3fc8w1r1BFQnx9GV3TgIDttvR8VgGOj4yzJWpKX3Sk0TF1X+zgo
	 NI1Ck+1W87KcRClrPZllJchUcb6LbF5PrXulUNeDDbGDcJTQZFbhEXP7WlxFAA+0aEt5q
	 wbeD5Frr7SKikvGdyH+7fuhucsksw60bJO5OVYGn9byw+xRnyZcLHsJqA380LgQHHB7SI
	 4tlm2Jh0rz54MZR3fepGyVk2g2qJgAn/gBr+tvIKCeUwXi5KXu6MUndEBNzzZKypWlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811404;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QREUsxQO+WlzAGZqj6P+b11EFcbYycJK2BqXbXpSFQw=;
	b=Osjge/JGyI/OK8TRnd0MNlNa9oGFXgXZTAh+aQAN8d+nADPRyazffqRud2JONmvSlQ8M
	 +7zu61CNPbU3mD6scwknyez9D77qCFFMOBmkE1FEgMRWfeQ5Gd5TgeBRSuQrcpznkY09Y
	 fnS856mJSiV2TSNTGBRB9E6O9V3lBZVrxmc87e0kDZwvXHIGW5cp2kpXzSP7aS+nQ/LZc
	 lpKwuTfn5b5auOztDlkmZnpDMRBqaEhnupWa2IlNhipwVmZlCkF7tNIyNq5iYheDy8LvQ
	 DecERCxCQvkCvmfix3yjpp7DyrZnqeSuQqmzswtM3MCS4LB0z4e+DoZXy/jrKH/dNRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fE8WH1MK;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A279606D805
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A279606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fE8WH1MK
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3535a54bed9so1229010eec.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811403; x=1794416203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QREUsxQO+WlzAGZqj6P+b11EFcbYycJK2BqXbXpSFQw=;
        b=fE8WH1MKci4/tbOVBnJedYZrGTpUWQYU6L/1iUfnHKTUHhPapsG5ksuKHGAOT0+Bul
         d/z+dGRxCJ6aamcS0zzHgcwDJ4MdPZWqjDLr2gnttF6MZhzB2QHkR7BVrMWu+yuGWJGQ
         IxhmUZCVKxbCWS2ZDY2bXZq0SMCPMiZpxg7n3hu/lOfaAvfXIKTrbdcgrBS9ZfFUVPPU
         dce4azDrVK9nu70VUB9+o0C/rGPtu3O0JwvR2EbeLw1mVBViSDmD3QruVjqeIPbbKtma
         8ZQ/vQ4iY4whe4/9hwWcx6tOOnyEubAyxtgnmfbAuvrSlFsSucoq5Qgv+UgLhx9So5Da
         E1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811403; x=1794416203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QREUsxQO+WlzAGZqj6P+b11EFcbYycJK2BqXbXpSFQw=;
        b=pEy+se8xnPwVBUDsY1oKfP7hOBFM2hiovIlWrYruKJKGANcJubaFW7vtkiju98wRRm
         hiYWVA6Ps3Q+L+pNIbm2ATULKSvZK6yHF/l/tMMWXZtgJW4rsOCRlQG8i/hlWlKtMSNb
         H7zvjw0S0vqn+LNvcmxkwDji7GB9zamOF4tC6QidLqcrAHz35WwByrqgYKZwIYwPAf7O
         +okvaTlxXPPnqKj0wOjKiEWZsEhmoIRwLSGAyU7gTjSPyFYx8cc1pPMOYTBm/dEo9iFA
         wOD4CObVnVX7dJ2WIzumlKOnwVrGwvMa4SzXb8zXBF0ZUx8YYtcNkUrn9b2X7iCnd1ue
         Fz3A==
X-Forwarded-Encrypted: i=1; AKwUvBzyQOHBvqy+U+matC6rfYcRzN4E/4tnNARkGMmhZGWVXn8rEhgynwJIsO1GMAVRuPfy1G8/Do3bmvgr@vger.kernel.org
X-Gm-Message-State: APuU4Z/SyHCOqiBM72+tL/6IxPMgGjz+sIQhiYxqiGuYx2JfPw3Ys5du
	hq2gn/UxrpK9X+sHChreYXHvrSVh/3YtG9neon5yXWIMGLe4pmjRhOX8
X-Gm-Gg: AYBFou06pU6uDyDM7EuY0VjcagjIXzMjJMthPDk154e/aBfsFfq2C4UqzrBdA1dPMld
	l5ZrbiDdkYkEUvblJLKMwpcGl6ns2d7++09rE8W1Nwciccfu5g7l+8f0DgW3IjvhrqOstWVEX6s
	XxU2Eg1TkJHeP8eY4O+6743DXnUPT4grZrevAkS+w2WU4EJbRwLdiulmZD+fFcPVeAIYPdHRpOQ
	SP0GkwRsLsGzSfkVqK2/x0QME3T2SZlg5uq6B/Pdwyq3d3OKJ61jH7tMtIcnKZVpHFkFNMf7TTP
	RkG7o27vJEEqBrkoRUc9qMZVRxfTFvKboFGWMnPZohGhFgnU0h6iyofYModyhSmRmJUnMgUoY0d
	Kzg2pNvea6VoQ7/BLaB6mdkcSP9Hvt9AQt9eYcH7JtEQJwnlhGwsSJoqITj/5MKFPIvGgEPIabD
	UqaaVHpeuL86X/gGC5OsJJ25PsRXeeE81G4f4aqURab4YYTk/YZp5vyO8SJCmV+1sg4ojG+o/+J
	5bqyYQS851L8igvpm8cs0429Z5DMU7kYwucRH5pFlS11jnzyvjYqPiIQSVHmcPPgE14+hdvK4eT
	n5KCraolLPVjzq2mKyX0/kCemGioDPagZ0+tgiI=
X-Received: by 2002:a05:693c:41d9:20b0:368:4acb:f8a with SMTP id 5a478bee46e88-36a4242f5fdmr24794481eec.17.1793811402488;
        Wed, 04 Nov 2026 08:56:42 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:56:41 -0800 (PST)
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
Subject: [PATCH 09/28] hazptrtorture: Add READERS4 and READERS0 torture configs
Date: Thu,  5 Nov 2026 00:54:27 +0800
Message-ID: <20261104165504.2430480-10-kunwu.chan@gmail.com>
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

Add READERS4 and READERS0 configs to cover reader-active and
reader-free synchronize paths.

Both use the PREEMPT baseline and hazptr-stack torture type,
with four readers for READERS4 and no readers for READERS0.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Bradley Morgan <brads@mainlining.org>
---
 .../selftests/rcutorture/configs/hazptr/READERS0 | 16 ++++++++++++++++
 .../rcutorture/configs/hazptr/READERS0.boot      |  2 ++
 .../selftests/rcutorture/configs/hazptr/READERS4 | 16 ++++++++++++++++
 .../rcutorture/configs/hazptr/READERS4.boot      |  2 ++
 4 files changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot

diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS0 b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0
new file mode 100644
index 000000000000..c5b12f3bef74
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0
@@ -0,0 +1,16 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=16
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_HOTPLUG_CPU=y
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
new file mode 100644
index 000000000000..f5564c218902
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
@@ -0,0 +1,2 @@
+hazptrtorture.nreaders=0
+hazptrtorture.torture_type=hazptr-stack
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS4 b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4
new file mode 100644
index 000000000000..c5b12f3bef74
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4
@@ -0,0 +1,16 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=16
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_HOTPLUG_CPU=y
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
new file mode 100644
index 000000000000..0d0df3f7dca4
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot
@@ -0,0 +1,2 @@
+hazptrtorture.nreaders=4
+hazptrtorture.torture_type=hazptr-stack
-- 
2.43.0

