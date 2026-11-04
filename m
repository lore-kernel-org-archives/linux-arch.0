Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811413;
	b=uuSSrsYBu6tt9vnCjYri4FIDlkClD3DahW0mqtCv7oyDU8bF0lA0XBXMF3O6PwIrSXgL
	 67PcJTASvIM0cvJUal3LPtOx0RQ2g9bClMC4W+DxP9TIAeiUxf1VvQ7/fb0f7/jDks8mi
	 YoO3zayhgccCkoYvJyUXW86QhpHxEF218Fp0Rr/KG83Zp4Xd8HMAFM79uT8Pg2IF/NNqB
	 mP7rl6A9mnzJSwvxaNXgvtxGdmNscMfp2kRvJD2VkhvO0TIh5tFvx7BCPCagl902bSRUw
	 Q+ULODVZ6RpViFkLaynEt2fHwWdRdqYPDLjakfQm4biE3jCHv+h6fk0exniZWjkFZBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Gn7Vn4SwsVH+p5VUqdHL4flc2b/Z4fswSqRV+byEjsE=;
	b=1/sYWEmcbZWxmpma9lYoq2zfoM67tu8yWyYDIB8/u2imAddAbNQGO2kdmu59Lz2gU0FC
	 m7i3iAwGotBGIQ1AJ7sCB3//giHCkQW9V1MkWwavGdKsjkM8AGhtPg0lpXvVd+8nS4oVn
	 qkVkBBIWhVjKzu3ngBiuURf39uo8De2LL5ODtOojPYgTYlQXRAjLAVqS55+cDxq88gdRy
	 mkVXDCuNhIBOC0M0jG+xWUU0X7PxpGe23Me0R/jFaUKJ9fT9JO7wKWJwNxdaJF91Vx9FX
	 m7DQGk96zXft5hMpvNPUNB+Pbhg80H+JW/ccRHgFwV2nKDYUqKodSsLC17kQ9cjow8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kCP9s8Vr;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34FB606D816
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D34FB606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kCP9s8Vr
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36d6765756fso734503eec.1
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811412; x=1794416212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gn7Vn4SwsVH+p5VUqdHL4flc2b/Z4fswSqRV+byEjsE=;
        b=kCP9s8VrCg/13i0ZvqMzZuUmktyH+GlFZ2KrzEozRxYNjxwtUFfqQ4YcRch8Qeyk6u
         Hyn0u3av8Oq/ekitd88yUopP0KS5X3nfx5bJN9XLDCihsS9/B+LmIOjoIg8kMGHp55AA
         itpmpYPOnoIXeErCCDxkUnG9ddysA9lPc9P+UN27efB2O7duIM4/z/uptdK27yKrupJl
         wGzjO2kl3X2ToG59tSS1CSXqYjRi2kMx/7bC8MIgy1Ghv4RO4R5aSoIy5zr5UcYM7Z0f
         APMXkid8qQKM47Pb5yXyT1eLecZbbRtPU2rV+l7kFLzHqUXv5g7AxolJjZR1ODawytlm
         oxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811412; x=1794416212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gn7Vn4SwsVH+p5VUqdHL4flc2b/Z4fswSqRV+byEjsE=;
        b=gj8jaoYmt+9PsRnMRj8SwcZLHTKT5Evcly0ApJBywMkEL858XQgtDOBE6UL4IcW/QP
         l97EaSBZRxtmTTx/QEWjcJGPTTQJuufMg14eF3DtlcrFoQTZNlIA9jvILO73w4mkXdvd
         T8CLWdK9fU/vaek0eOM4RrPj8unH/3nvalfqsCpr+T0aATlUjOu9IyyfTPP4xRoYROPp
         QmnF9aCtauKCIFfaNXOidxxiV4NAY9Nn5/FyjqoAkUwO91WD/briOHwG6t4uFNVAvqKV
         CCr5nFvyb2QbQxira0n727IpFmn4k8HmAQ2yllKqTco8ec3w4E/KdJZbRBpuI0TZ8DRr
         mU+g==
X-Forwarded-Encrypted: i=1; AKwUvBysGl02JvgkYCwQ957aT8ktNcu+66RPX4TLSEWnCuKwkkRp2D1YurDOKLJm+XvJT0Och2tL9vhWa9N8@vger.kernel.org
X-Gm-Message-State: APuU4Z8FAb8JGBhqz+Ty7BoGk/3d/uJlQCFAYRhoSaJsRVrijHryyQlg
	xiL+Spjde0VE1SkBqHT96HuJWsk1M7ud+lqcOfc6E9FMumsg0qQJL0Ru
X-Gm-Gg: AYBFou2oHFGALHy2Ocld7c8f9Qdv0dNQLWF/GAtvdGGL7iJhdyKuKAd55EpSHnArZKS
	DLvxP7a8TShReZSJPReX4UFVCFWLdRpTgIDZYX6tH8yP242FqdfXBPq5fMYsDs3UTm2GA+3JHQr
	5coe82mZMuMspVVBM+an5gqhaTCrFX/LoHvi2U1qioG4E7ICbocjOogNfpJ/qTPBa1sB5a1g9HN
	wB4Dk3xBed5tC3EFfKG+za9iT9nuqkesNVGDspSQwdvXNygK/8vvquAyO+fDqIRiTWBCCpHU+Ke
	YO5Fkkk6zYOEueSc9WF4tDv0obJ4qSJ7tjlrBlAeNEk2OnWXE/QNXdfGbRAQlaiv5xmkuZgFoak
	m3LC3+hXb2k/zHm6i47HzLAA+8fpR7I1Y2bRFqCVrZ5ikkBxOJqUmRzqdNkCOTJDYE+fG/YlGYU
	PEEoDJvABJFvWo6l4hJMSxw/o3cBhXn37Lr+29TpuxVWBna2wPLuJd4YirHGHgzYq9dXL0z63sD
	GlZe0X1MVsQqfEs+X+v5Oe9Y4VHL5rAIsN9jsvywuYJ1N7nw1+MZzAtH0Kj8qFiGnw3nTLRw1Kp
	DQ2Ont1azuiwZ870t8HJkztTjh9Y2H98mdX+l5Q=
X-Received: by 2002:a05:693c:88d6:20b0:35f:8c5d:5928 with SMTP id 5a478bee46e88-36a4244db5emr23827711eec.30.1793811411412;
        Wed, 04 Nov 2026 08:56:51 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:56:51 -0800 (PST)
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
Subject: [PATCH 10/28] hazptrtorture: Add 128- and 256-CPU configs
Date: Thu,  5 Nov 2026 00:54:28 +0800
Message-ID: <20261104165504.2430480-11-kunwu.chan@gmail.com>
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

Add CPU128 and CPU256 configs for hazptr-stack torture testing.
These configs exercise the shared-scan path at larger CPU counts.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Bradley Morgan <brads@mainlining.org>
---
 .../selftests/rcutorture/configs/hazptr/CPU128   | 16 ++++++++++++++++
 .../rcutorture/configs/hazptr/CPU128.boot        |  1 +
 .../selftests/rcutorture/configs/hazptr/CPU256   | 16 ++++++++++++++++
 .../rcutorture/configs/hazptr/CPU256.boot        |  1 +
 4 files changed, 34 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU128
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU256
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot

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

