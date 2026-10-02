Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B542835A38C
	for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2026 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961117; cv=none; b=pUO/A5o7e4Nh66FATng9gKRAPecM1dHpgQ/IRKl/OS3/+SBCrAEGYPyfQpqCG/7SZqayz/1fSrfUS00UaVvlM9iIeAcbWCeml5OSahnBqWMRhH7CqlEC/4KgXb1BeYYyTMUEnoV5pH28tLytcxWWb0HMRtfkX1joAj45wXf6j9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961117; c=relaxed/simple;
	bh=c7ckEYnsoc8lY6bepSRx0MX3kspdeIxVPo6r8T3T7fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9dhEz0HLFf0o+IOuEn6foAIFwzfUaAiVSLh1CfIQKuQUQ/koiDhDgdMafbp87Tbd/jTMmttxaZtRAcAD1mk7fCpQjoFdgK4IoBEbw4YtxUIctWxPxYVNwFaL2OBP4OBlJYBPtxgQmg24XBcLI/INnQEG/vvGC0rxzKOH5HAdmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=et5jNYEn; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="et5jNYEn"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so112740a91.2
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2026 10:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790961105; x=1791565905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bU/Grob0sdS1Fvpq0qkYiAVVEirXYMwyKGEgxNCUeKM=;
        b=et5jNYEnRjFgMtTgxmbQKLyPtRY6+zKJzAnn+F/zA7U5sJ/MODnWgoIGviLqzly2o3
         IccUsYTT7Jf0u5LsoSlm/gL/LX6zgMD4ZaN+YW1wFLq2m05UwrWCJzpqLywP8+51ieoH
         sKuHC73BiU+9GzZGD39y1cCmxIcBxlpJp8DDpp/Ot5lDGHGnzgSAjZ3FZ+lVIvrPfgVh
         +inTzZggE/DtWmkS5J0mez4GQC1kWVsqpppwu3kztgArWRkh6bZDmwz151sAHiI1dFGZ
         RyjjvDKG2iJIlf2V7z+ITXU8Yeaf8BtfbjsAEOC5zQbQSCqSoKviRefuWBB3VYIeaTpv
         UP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961105; x=1791565905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bU/Grob0sdS1Fvpq0qkYiAVVEirXYMwyKGEgxNCUeKM=;
        b=wZRjuAfFs3uTGfVsm1HHiLeRwQwBIXHxCse6twoU5aqAji3dm0e3YRo22dRKo0xvZt
         VcvW98dHfaEgP1EWS3tw0YZcE08PLbikoXVBgqqTgeqBw8BK5SCSiF18uhn3v0kctUrv
         82st+IyCv3rjJZhzjssdBz3+VaKu4bb2xEOsqqdVfPe0Rejwe5qawwfA2NGjU0Rnu9QZ
         xFMlsEywnThaP5yFKFixhQdCTx8CYQEiEsRUHNMUxKCTxsTUarnPiMt8FiE+s47f9ONs
         IiH27ICSw/8C0ivcxlDMvGzq5G3yXfBGbvtOZI7skRQ+eVeaDRAHzWuyNi2vmRBguFpA
         uL9w==
X-Forwarded-Encrypted: i=1; AKwUvBzD6evKA2fpjgoOiNpAyEcvpRZOeWxLj3e6fcOdIDlYk7tdK5s/4yB8LDd1OushqsZMb7JDBQ6JEGJt@vger.kernel.org
X-Gm-Message-State: AFq9FYKEXKFWskuXVrZzrigqImut46Bz66Z+uxuvUXyXMXFV/Ia6vNps
	6QsH/ubzm3JwN4UgIToHutGtw24xTgfwMgeYnzvS9CfNRd3UJezJPufq
X-Gm-Gg: AYBFou2XRzH0GGRlzCG4eMYyI87Y1vEu3nEw53NhsC3rgpfq0HZ9z+MvQxel+trhRN4
	JeW6douvvDtmsb1oXgkNAIh1H+uzoPsCjJYBGBVCHPKfuOHplumdwrhkNLRZOY5hJ4KXSTr6tCQ
	pgX2vvU3PtaWThpHjGhVIQXXILQgJSJ4GTiXxtF9FOKvvqVsuab71SuXDQaX8ihZQuhTQce8Ixp
	Q856Sjt7uRFxRCKlX2SpENmCUGCZRxlE+iSi91QcNN4yXmcoWSWSnasvrQkCnprLjfyo1Rd9rED
	5/R3HwV7N7Gdo7FsPrFa6Hrb5g1ym+6+6kYRpvl/jlbi1g3GMLiFG0/WbpuiVAKwlQh6CGVHj1f
	2wuu3S9mOKJHUlFZC0HuwAbidnxz/pN0hdotHVypNCXmj2C86oLsjIkre+iPYCBrjpUYSF1z/zZ
	Ju14iGUbrTSIHq/QVetG5epzBXzBWS/+b5zMRaUqkW69Sjsp+XFcEu3hiGGNk75xqhZaw6YIxHC
	+UsnmkejBJvM45QHwYdEjyihQ7G
X-Received: by 2002:a17:90b:3d84:b0:3a6:c7e8:1e3f with SMTP id 98e67ed59e1d1-3a6ce34d7edmr3083622a91.3.1790961104965;
        Fri, 02 Oct 2026 10:11:44 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7024d0f5fsm1597719a91.0.2026.10.02.10.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:11:44 -0700 (PDT)
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
Subject: [PATCH RFC v2 14/15] hazptrtorture: add 128- and 256-CPU configs
Date: Sat,  3 Oct 2026 01:08:46 +0800
Message-ID: <20261002170847.3653663-15-kunwu.chan@gmail.com>
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

Add CPU128 and CPU256 configs for hazptr-stack torture testing.

These configs exercise the shared-scan path at larger CPU counts.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 .../selftests/rcutorture/configs/hazptr/CFLIST   |  2 ++
 .../selftests/rcutorture/configs/hazptr/CPU128   | 16 ++++++++++++++++
 .../rcutorture/configs/hazptr/CPU128.boot        |  1 +
 .../selftests/rcutorture/configs/hazptr/CPU256   | 16 ++++++++++++++++
 .../rcutorture/configs/hazptr/CPU256.boot        |  1 +
 5 files changed, 36 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU128
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU256
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot

diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
index 1826be30c066..90ef09b0e654 100644
--- a/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
@@ -4,3 +4,5 @@ READERS0
 READERS4
 SLOWPATH
 LOCKDEP
+CPU128
+CPU256
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU128 b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128
new file mode 100644
index 000000000000..079b463607e8
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128
@@ -0,0 +1,16 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=128
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
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
new file mode 100644
index 000000000000..1d09a6446080
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
@@ -0,0 +1 @@
+hazptrtorture.torture_type=hazptr-stack
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU256 b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256
new file mode 100644
index 000000000000..b00a984977f3
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256
@@ -0,0 +1,16 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=256
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
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
new file mode 100644
index 000000000000..1d09a6446080
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
@@ -0,0 +1 @@
+hazptrtorture.torture_type=hazptr-stack
-- 
2.43.0

