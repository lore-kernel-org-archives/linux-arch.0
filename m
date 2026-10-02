Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796F1502573
	for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2026 17:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961106; cv=none; b=Ekv9Nl7FkH0Siv6mDe/VsT+ZdlErILx7ZjmQJ56minD3vuxvWk/94AVB38PpOKxOw1XxiWKVS1mvCb1SY9WR5j0nLDP7MOcNwpyFlgf9FUElpEGMCWSOScUBrQL1mygFlvX0avCOujZUtNuITEMyF3O49rkwjxwEFH/za9w75b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961106; c=relaxed/simple;
	bh=ikRDPvJS94ZCR7PUsAAuEp28RxgBvB/t5DdR/IX8Lk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxWfhZldTCOn70+L8E/yhfLAWf0M9a7BOss6FL6aMnpN5G1kkuj8FjRHLZEvXaj3n1OterQr+W3VadxQayPtyLyaSEoLfzOY+HyivRfvx1J0py678vfRKwBEFKx5Iz1qdCbHDVDCC2Iz1A+dptQIEqgXq+MBmc1MEi/7HJYe9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLj9+rNA; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLj9+rNA"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso111981a91.2
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2026 10:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790961095; x=1791565895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7JGfeM05iMohWhPKcbFv96DJOpIFn77eSNSRuB4K3d4=;
        b=GLj9+rNA0k6Ks5TDBh4975HRkTZNF0soWoVxnoHAdRJ05DSNaSZhFuyrr1mWL0PzcY
         8vhNsb1dD5OzKyazj/+EdUiHe17qdN5H66B3dHO/4o6o2Kv3hVAL4U4OnoBw10M0H/Xk
         tHb+aXKaLOrLBsh1DCEwasUMaIIspJmx51O4//vP22yW3S1hi5WAnp2PIYq2oNVOHTfM
         qHcTaCxxO+anU6ImT1SRiXVuiaXfbvziw7nvYQZXPRtqCOHWXDaApqk2bPkgEsfpM/h7
         cfIMmpR3UWTQslM8DCwOvSti/3H8B6l3/Sm5CH5yQ6PMSgkA0rsgWtmn5InzWa4qiNfO
         vudQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790961095; x=1791565895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7JGfeM05iMohWhPKcbFv96DJOpIFn77eSNSRuB4K3d4=;
        b=0F5x2cvvwiDsKw3O1VZT3WKja7mlnpyC/80b7fvwCfZha+9zx0gqZgUE+105NwDSJS
         oOKkxNR9ho5CeZ4wlsXRkY1fM0sMkBlPQ9sLYDTTslbu4FaQk+hXWjy262mcTzBKL0Ak
         BuJJMxK2LZ/OPVhUFbWEeP/I4QOJC8djuXf1Sigxhf/13gT6NbIBE4xEswvirFmQ743Q
         cUrBMOEH8p9FnpuozPiuEaMuhjyoa9uI5KiRM3p0j1HFQm+JiJ2JcHHYqWb9D7g0Zpds
         FnjflvOPiutPOZd+/SIz3UjsRrXVHV/KQko52WRdNtmjkk4sh4nNUMX/KuiRysDJSYos
         Cipg==
X-Forwarded-Encrypted: i=1; AKwUvBz0UdI98RHumVlYB0Tc7Z/JFeKml2c7NUSxjys8eFVNIfhq4TKkVhG3kBBOwGwnUFEOwpSD3VcX8VJu@vger.kernel.org
X-Gm-Message-State: AFq9FYKQqcbUPprmGZXxkjPybiwXe4gVNGlNGrC7FbWmi2XKqZDSW+Df
	Qdd2ZEghQhV31CK7x3YME/IUt5EMsq/zz/3EGHZDDzITPMH8EwrgzAlu
X-Gm-Gg: AYBFou2ctrTQy9hM1yvodhJ4o+GpKb4O4jqyqnSEHEeAlGKNc5vv51LiKk6CDdX6fH3
	H/b4Dh96hR044gYjCfLfjP3VJQZeb0vpm22azzUhuAs0V3R1ZiFeMo/vvlzJ6V3r9O9GHyNznqg
	gKA9Zl2ekxzFyjadOUIoUPD/E2ANFHDTD665a90zcoChaj2JVnCh97ueSNd/52wT192A37jkFNA
	7tIx7qHvq5H5kv8zvigd8TY64zImilmAtYHbidW2drDveOL9jlSQZNYFm9hxYop/fZg5HKyEu9+
	l3UnBbjkvk3wRz4eW1M2zM6H2oGJi4ir61HEpvT1/40I583qBEVA0n7qIUVLDoiZLhHAcLke9fs
	Gmin8+DLk1MgNxfPxBGEThNDlwpU117leXesXK702p2kjU3ZeT57B9xoYpxJvURvxeqYH0ZnuJv
	2pE3kiNkrnlA6HGhHG0udlEcisX1XdR/8e21zxbSYsclrBx0z9oHKdgLlzZ21zRK/Dh5Auf+Y0h
	EEO0NzGCpBeyglP+7tvI4Sp2aaP
X-Received: by 2002:a17:90b:2ec3:b0:3a6:fec5:c184 with SMTP id 98e67ed59e1d1-3a6fec5d190mr1028380a91.7.1790961094328;
        Fri, 02 Oct 2026 10:11:34 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([185.220.238.43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a7024d0f5fsm1597719a91.0.2026.10.02.10.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:11:32 -0700 (PDT)
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
Subject: [PATCH RFC v2 13/15] hazptrtorture: add READERS4 and READERS0 torture configs
Date: Sat,  3 Oct 2026 01:08:45 +0800
Message-ID: <20261002170847.3653663-14-kunwu.chan@gmail.com>
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

Add READERS4 and READERS0 configs to cover reader-active and
reader-free synchronize paths.

Both use the PREEMPT baseline and hazptr-stack torture type,
with four readers for READERS4 and no readers for READERS0.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 .../selftests/rcutorture/configs/hazptr/CFLIST   |  2 ++
 .../selftests/rcutorture/configs/hazptr/READERS0 | 16 ++++++++++++++++
 .../rcutorture/configs/hazptr/READERS0.boot      |  2 ++
 .../selftests/rcutorture/configs/hazptr/READERS4 | 16 ++++++++++++++++
 .../rcutorture/configs/hazptr/READERS4.boot      |  2 ++
 5 files changed, 38 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS0.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/READERS4.boot

diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
index 380b8402ccc9..1826be30c066 100644
--- a/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/CFLIST
@@ -1,4 +1,6 @@
 NOPREEMPT
 PREEMPT
+READERS0
+READERS4
 SLOWPATH
 LOCKDEP
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

