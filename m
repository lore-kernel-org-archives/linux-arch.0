Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811561;
	b=LO5pD48LxPkny1i8rHQCqtzJJORWLKbVOU+8dLVemQto4+TUXF1VfzE3IHKxMgtLzgHp
	 AJP3KsANHOLnRwCgC2EHPea/Z7PNFKghe+JiHbCBwuRnZa6xy91IrHkZOOau2FMPYqT+k
	 UGns+vhmJqf/e19v6kKj47igmFmGJnOvCjL3ai2jS2lvWrhclJHVg/vdp5u1/xzgevUfa
	 AV2Yynm2bfKy1jMe38XnVHHE6QUhB+dS7lrP2Upi8k+hFzhbjpDpJMAMegbIG+jFe10/w
	 p/xRzgZTbur4YeefRuxdYWWvrpsgmnfhEhWuFVK7LBcP48yDb5maG42gP9Vm2onsj6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811561;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ccVf83RTacEiSDDfp2h5xNH+o9FDf22bxraZEScVifs=;
	b=HThIX4u/hQtSCaOGvEbYCk1QUebWPhv9hBD+Yj/izriIE5Pj8KHC6H3KTDYo6YB2MnA9
	 TV03aQL/q/zdpN5FbtWq+wMiFxmZQSD4UOGB+EWIPxO7B7nB1xaK3jfVim/J02nkpgk5K
	 hXbBNQ1+WEGeacH1P7qMl4VqNez8MCaXjPXsd3nI/4ajGxhT6vIKi4I4OliJKKk+dWt0w
	 dxVURZcg/pXql9XXGnwIuHNMYUVKS5G3p/jmwauz2o8m8gVLSI++nsGVSuMVFqH0SkUym
	 LsrqNqWwk711ZVe8EUY0TOzl+TXsEXP4nSX9SNrS7EajYxFeBMrw3PXxmjhTG0DZ3ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=srwPcV0C;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC18606EE82
	for <linux-arch@vger.kernel.org>; Wed,  4 Nov 2026 16:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DC18606EE82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=srwPcV0C
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36d6e342f98so876942eec.0
        for <linux-arch@vger.kernel.org>; Wed, 04 Nov 2026 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811560; x=1794416360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ccVf83RTacEiSDDfp2h5xNH+o9FDf22bxraZEScVifs=;
        b=srwPcV0CMrFf09RumsTb6kBXvwJSmyv7F6Ok6cQb4RLoNTiP6mDJJ41AONoG3IBegg
         379AGoSfjaRazt2ZxU+Y67WdxSbYjW8t6oX0gLgWERE6FMNjvMjXxcOd6Ktdnc/OnQhg
         7CkFVW/HO4lzzZI6IXqVLY7dzdszcT4WWgR0uw+rX31a1/YYlmIrQ8cwUbAIuGACbM6w
         vKAA4UG+0TPX7jAJmab/BP2MApuRxmhM4c5Sb5Z5knQDN6HhMTR9IWNkB1xVYiZxbAIe
         H2FBfin851fcltS4cy0iogqxcy8G6CzVVIxlrmHwDWg2Y/Rj6tiru7Gg2HoezRX+hjYr
         SwRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811560; x=1794416360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ccVf83RTacEiSDDfp2h5xNH+o9FDf22bxraZEScVifs=;
        b=FZTdPUucLUkTjdhd1GGMFiMI4/Qhz5qiUbFNjGqYdvizfILUx3fMj8d45frNIyyTOI
         I39v1IL3vRXLPgnUVp4BYw5zHG7qpi7Z4eGox1L2ouxHSLUgXyTz5sIfdeA0x+uUIGLQ
         iivRW84XFCbrN937lNHkaW4jrQ6RhrO+LzlQV97uVnUxiOA+bItDrpu19j8DHVtggr7E
         EJu6CAjvcYBmarrkaiDrM1zgrduhLIn3AB+M/KOmPazFRjrS4dAdSskIQ74JvGAxkcF3
         3vx9p6dRJ90nb8aSfXQAe2ifNnkjxO0lBtw39hb7ll+D1BPKmNaHhq1k9nZ4NpNY/gY2
         UitQ==
X-Forwarded-Encrypted: i=1; AKwUvBz1i9JGswWPyzn39P8aO8ic1/LW14q9hmWAuQaHZs8a59fxVctUuhS9RlruLPfoBLdEUFX/XhvAr/BR@vger.kernel.org
X-Gm-Message-State: APuU4Z9rQUuTBq51BJ1CCyTU8ackOW+M5rdqBsxEkBk3wax+VyYRAkBX
	XIwO7pTAl8ZUFxj4Xt8rS+hIOFHWC5e+Upoz3Gp8Yadr6OUNaGIJOVpR
X-Gm-Gg: AYBFou1y/eC1X+xx52eWdJvA+4uECIN93ZQ7wNVHUosZuiGpE7qPudCoGPJhNJmgvaU
	WL67bIRp903+iaud00Y+/+C9hIqkCD/S6H+GaTBYQ3oe2cEotv333guiU0PgDQGc9CxXX6zx2Zd
	KnkmKdPwWbKlpDqG0FDU+ul3obWml0p32oenvxe/WxDR7AMlZqWzcTOVo3eY7BFuAYE5kc5ZTRT
	4qVtvZyyxApuS1haK/EhNXrURJ4Yv4cfkBKBVeLPIhFkFd78VyBYvkyI60FOh/5DfwnVARF7Pey
	tdriU/lntWX8ILnKFMpTUGNkR08xJ6NiGlIyd/1BrX9k0UCsAuO/F0QCJKkqpYYAsU6RHF10ZGP
	yOucLqDMx35uGjacofxMNvw356FRBB+TAe+tBCtnvjKgjtg5xZopqpHVsI2bk0DT9cwwD4rfwCK
	cKFRb74Kzh05mYfZJulcD2Bqz4O/0fH/5IN8Gbx3VbzLf8xzakt1yrfMTI3wVYu6uWODBCtqBLB
	SjF2iULgd2O//k0Us2HcjjiluSycphPyAfmHkvf7W5IhBnOMKGOSE3ilH3u7GgLfVAuidBQ47xH
	NABGhwj6DDwQwqjXc5iuxAuPzTbsYNJHaQS3GcE=
X-Received: by 2002:a05:7301:640b:b0:33c:16f1:2e11 with SMTP id 5a478bee46e88-36a42363ef8mr22540460eec.7.1793811559006;
        Wed, 04 Nov 2026 08:59:19 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:59:18 -0800 (PST)
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
Subject: [PATCH 26/28] hazptrtorture: Add torture_type=none clean skip for rcuscale coexistence
Date: Thu,  5 Nov 2026 00:54:44 +0800
Message-ID: <20261104165504.2430480-27-kunwu.chan@gmail.com>
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

When both HAZPTR_TORTURE_TEST and RCU_SCALE_TEST are built into
the same kernel, hazptrtorture calls torture_init_begin() first
and rcuscale fails with -EBUSY.  torture_type=none makes
hazptrtorture return early without registering, allowing the
rcuscale hazptr scale type to run in the same boot.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 .../selftests/rcutorture/configs/rcuscale/HAZPTR    | 13 +++++++++++++
 .../rcutorture/configs/rcuscale/HAZPTR.boot         |  1 +
 2 files changed, 14 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR
new file mode 100644
index 000000000000..c5e9cf0184ae
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR
@@ -0,0 +1,13 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=128
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_HOTPLUG_CPU=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_TORTURE_TEST=y
+CONFIG_HAZPTR_DEBUG=y
+CONFIG_HAZPTR_STALL_DETECTOR=y
+CONFIG_HAZPTR_STALL_TIMEOUT=1000
+CONFIG_HAZPTR_DRAIN_ASSIST=y
+CONFIG_RCU_SCALE_TEST=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot
new file mode 100644
index 000000000000..e9cca4cf453b
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/HAZPTR.boot
@@ -0,0 +1 @@
+hazptrtorture.torture_type=none
-- 
2.43.0

