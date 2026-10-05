Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303EC52F299
	for <linux-arch@vger.kernel.org>; Mon,  5 Oct 2026 17:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791220755; cv=none; b=SIV4xzWD2rCR7YkEhn4GT9NdUocLa18prtWiXgie0CCaiUf74q995hjB4F419e6joVjTGD8lHb4iDN0ADkgqbJ+vHFWCAVGujC5S5LQyd3jbJ95ll3QJBy3y7WJRO9OqujcqbGHQMS9Hop2tL3TzN2OYQSQH40j1dSawWvOYXFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791220755; c=relaxed/simple;
	bh=c7ckEYnsoc8lY6bepSRx0MX3kspdeIxVPo6r8T3T7fY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZywJSHldxgb/0z0bnGRXFi6/PaZIiwwDO97iYeEKffPZOLtE9rRoKX7nHFGfyf3qF2qkV+IRsj0OKzf4/JSqsZbZH66zv+DU9E/U3t+CxsWbjiagRKjnoBoHdCewLi2wrvALFQTfeEjB6Mjhp/dXVxL3OvwXyETgB/9Wzk7f9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gpb852/k; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gpb852/k"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccc02279so1229640a91.1
        for <linux-arch@vger.kernel.org>; Mon, 05 Oct 2026 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791220753; x=1791825553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bU/Grob0sdS1Fvpq0qkYiAVVEirXYMwyKGEgxNCUeKM=;
        b=Gpb852/kZNQzKwMkCSt6i9I8zSYwCJziA3DHzw/GkdUYIfkHutSzFg7Kr3knnFjUo4
         2KdZW+tvKqe4nU87yo4dIeML84p0jQx0rUth/NQn4zwU5ItUue6iWKUJAtpZ54WktieS
         pBirJqWa7ULs50NYRbspvw8UR6qe77zOApTXPgH2iCSnz2WTUDELXOd4XrYl55x3+Im6
         AqSzdJhtVAT0nanKU1EjvEheFgTX2JZAU3gAPeL0OoLl37jKF6ZGF+PHz2+aqe/zKZv8
         1EZuI0V/nLLtVPO/75Rkle7+dLEZb9dvCOSbH+TvVdYXqlP7n1IRK7uOFY3zWd5UtEFy
         /++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791220753; x=1791825553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bU/Grob0sdS1Fvpq0qkYiAVVEirXYMwyKGEgxNCUeKM=;
        b=jMjEJUxY5aMitMtAz8BL/l0AnlhJW3iMpsRl4JCjUwgf705DEqclkksVfAytUs5tuD
         aV4X3H6nh9xgxfmn/Hzh24isqv+AV0AAoXCqiJdaOltbcuwq8HKtrK62YnExKGtgQTnQ
         abg03VmW50zQgfBBu9i9NIP70q9rOujHDVTWEV7QkMccvJtTo+dpr64sYjSeBUxjjlM9
         R9S8jpalDvqRCX47ET55/nIVSU/TTCCTkbBLpyCgvolPnVoo4S2AGQ/vC7V2hD6QlEGh
         3e+foI55lsy1KOww9rKLmtmCUPbDm9TiPwpTyDGvZRqRhrJL+7v22sMiD2Ujzxw1GKCK
         lfQg==
X-Forwarded-Encrypted: i=1; AKwUvByQH1As/ugA9dMcIOZocJZzeQ0t50slKW/hhf+YfxmaWS5q8hpiycsG+4youiuzGrA8OAFPkKLfsYAi@vger.kernel.org
X-Gm-Message-State: AFq9FYLb/VGcoBdQGbupsuyYWc2TNoJiG/4CEQbU7Rei0t0y8uWar7iB
	5x+UbLQX3a7Bntq/L9NnxY6CU77uXboOl4/g5tl5FZAA5DFJG2i1XcNP
X-Gm-Gg: AYBFou3+TjmCkZcq+L3CqXHaqWhEgVvdnpTweXkr7UsffFdnQHuyMvAkDjcTc9/fK4e
	Zp2oOZ+PglEkcfuCMGvLXm0D20uCa8naS9iQolpYaWHgagDM19Q1Ln5csDAabwsCWyRXNNNolhc
	PxfPBoO3nPjV9gEaDZz7xSvP1TsQSHs6t24F1vqITWVkvIpK5RrAQWs6i9H0DpFoCv6xHAoD5IJ
	qQZHqBELshF5eaDNu8n+2Vq9POWZpzT/NbjA3hg0I6xoL4L0CCa121PacqCyD7PmjEK7rLgR7lS
	iKcMyDP9Kd/l4GQthMHpxmDE3kl/7sfJseOZLtitXa+UV58a9FC2P8YipI72PnPnY9q7WbeByg2
	7bnvPcTYOa6bzt5BhRKSoFScUZcuYCh1R9qK3WivaLX8YkeDwRPhDS2s8Zc6bQADv7Ly7nWR2vu
	UupajWSlNluXPVjzOYw6w7jNSaiP/lmchBaVfAW+E0GHAS6iFc/acz60SgH2hYFZScjkYerkH+0
	pqGdjpFyt1asZmDrlFTfwnlsweTqzI=
X-Received: by 2002:a17:90b:3c07:b0:3a7:9adb:2a0e with SMTP id 98e67ed59e1d1-3a79adb32ecmr5763152a91.33.1791220752112;
        Mon, 05 Oct 2026 10:19:12 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([216.195.201.24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a853cafddesm406910a91.10.2026.10.05.10.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 10:19:11 -0700 (PDT)
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
Subject: [PATCH RFC v3 14/15] hazptrtorture: add 128- and 256-CPU configs
Date: Tue,  6 Oct 2026 01:15:28 +0800
Message-ID: <20261005171529.1378809-15-kunwu.chan@gmail.com>
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

