Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C163BD64B
	for <linux-arch@vger.kernel.org>; Sun, 16 Aug 2026 15:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786894796; cv=none; b=jtAxN1SVnUxQNLoF6O2y+sfbYlLgvkoQjT6omdIw7b0MKX2W2AsWjt+vReJA7zmxluckiSiaQk7u/cGF+S52iGmqF8RXcQNx1rZfdO3fhCXen4MgH0tNTqIpH9tvLflWlLzQFiXs8HL9DRlnD1nQX1hPin5rrisjIwXAV23nCYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786894796; c=relaxed/simple;
	bh=HmMey20/L0xSMn4AQXlqZ3/bMwTkUSyDn/vtCtsZets=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ieG9ygfbAITJ6RQ1xVV6JYm0/E1hNMXPfPSDlkuL8C2EiGRsA1IXOYo+dMN04TYZtO1x3smHhuzTqLy+t8ks4RqjWDrGkMkpmoAxsOgtFMQKP8M2jDElhhGjlRlFbZ1e4FFFVxDvoP77xu8L8M7OyKcND758Zy/d03bZKuk7JYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jAt0km4u; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jAt0km4u"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c96b08cdd1cso1901666a12.0
        for <linux-arch@vger.kernel.org>; Sun, 16 Aug 2026 08:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786894794; x=1787499594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sDqOukKlsamMofl4SoKVQn8vVq34nTE5OKWRgPONYNI=;
        b=jAt0km4ugqP5EhPaXzKWHqNgS0/j7AMq398tIwbEzL5NxDZ21KbFMHWOKchSafLiUs
         bt5w5Q2KWTnw6Xk32gIngdrx125lntLlGHocv68Br4FeSEPWruHhhnRDmHCEe8SwNBTZ
         AzFvKuvFd+9KtEHznJwnRL5asZ9/WZmgS6xf1G9TJsym/KtoMGHX8WrMUawTUofSyX3B
         wjoJsDay6iQYdHnQqIOD1glSpWbafkaa34Pk/4kQeIUAWzhAxHWSBrOOZW3tQc4itApF
         /rm3t9UGwkYKPN0QKv2Q0P5Pilki0Qc+F4MKuDcFLWPXyBEfrZbIpt0Jzvx4f4U+Oo3M
         16zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786894794; x=1787499594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sDqOukKlsamMofl4SoKVQn8vVq34nTE5OKWRgPONYNI=;
        b=WPmRV5u641fbyPfQhQhqD8iVxigI4Zae9ARxGYZ6rioHo7L44cOWqs1lXNaCBPrmVt
         psRZxRpLM8xVdAFY+hcMpsO0vkQi0MMpMblJfFZTim59dJV9duwAwqFXIx7I34wWBm85
         YP8Uu+AupnvZqTjKKOXHEXat/UyAbaZEbKeRxke3UhHYHiZRSLx18TUBSxNcJsMuDPQd
         aNWpBgydn/61R7o+B0R7Ydxa900XEQhNWQZwMnds7zCakL29S1VJRGqzwY3ZBfeAlHGF
         MJ4ZE0T1RAYL3wVjFtdCnfGr/gfq2s8rueOMOJ5a+wVPZAEFDmR/nG+wuzPypS1uQ3uT
         nyKQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq4DBAQONOVYPpObbaP/fMZzFQAwG1ewbKHkEnQI9RQGGVenh/XCM8H3vqjVaQSS3z/eo7wT9mzWDjh@vger.kernel.org
X-Gm-Message-State: AOJu0YxISaiszAODM+ecXuVsqpcNmbvEi5kg7w89CYVn3+f+m3ytbEnt
	5hmmz4SyEwIQa3OvBg57/0UqKIedAn8l7y6aLbqvQetu05VOLBkyGp5O
X-Gm-Gg: AR+sD10YG6GiwNOHCcYtNnS/+zprQAKaaZyH+hSn961pr5DT4gHl/UHJJwLqflLJtXY
	3NrVxh/6QK1sJmVA6Cmt7ipIxRK0fS3i2Ay6DbbWU9tCb+VADjYmwgJNj712qfzhWU1qliHjE6C
	AZCFLRNkV9ROdQZx/fEmv/sS9/zMtUiU3FewgFQOlr7Jr5x0vrrbvZH4Apa/lkrMtTILAN5YveF
	qyvVK9eBjvzGhYh7ZOncMCzj1SXW8frW7zCCBMQQhO4T2B9O/Ck0fJTNMgsiQbhVXUONTNN6jlJ
	5ihcvCh0agBSWt5D59YQC/L6Cpj4fHARu7EDhMCCTImvtcn00Y/NHYcxHcaT69INtCBcR4CMCQP
	vpchSsgXM3G4LntdDhb3LPqRYq6UKZh/oWY5IFIZrEYzgFZMSMoplxMOkyGNlCwWOmDfQhP8mKe
	LKIbZj/JaWmG/ee73WkBkiwJ/K6q7kdEmW2QPkOYltBJVCUD6lsQdw8KDIt6WC3Wk9NhQht4Cyq
	H8=
X-Received: by 2002:a05:6a20:12c8:b0:3bf:6fb1:ce0d with SMTP id adf61e73a8af0-3cc71ebff5amr18540448637.21.1786894794034;
        Sun, 16 Aug 2026 08:39:54 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:a069:993b:8f9f:648d:c9a9:d989])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea804233sm24501914eec.26.2026.08.16.08.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 08:39:53 -0700 (PDT)
From: mathura kumar <mathura.kumar.tech@gmail.com>
To: brauner@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	corbet@lwn.net,
	mathura.kumar.tech@gmail.com
Subject: [PATCH v3 2/4]  IPC: Added system call entry in all of most common  architectures
Date: Sun, 16 Aug 2026 21:04:21 +0530
Message-ID: <20260816153811.1085261-3-mathura.kumar.tech@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260816153811.1085261-1-mathura.kumar.tech@gmail.com>
References: <20260816153811.1085261-1-mathura.kumar.tech@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wire up the new syscall numbers for all common architectures
in their respective syscall tables.

Signed-off-by: mathura kumar <mathura.kumar.tech@gmail.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 2 ++
 arch/arm/tools/syscall.tbl                  | 2 ++
 arch/arm64/tools/syscall_32.tbl             | 3 +++
 arch/m68k/kernel/syscalls/syscall.tbl       | 2 ++
 arch/microblaze/kernel/syscalls/syscall.tbl | 2 ++
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 2 ++
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 3 +++
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 2 ++
 arch/parisc/kernel/syscalls/syscall.tbl     | 2 ++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 2 ++
 arch/s390/kernel/syscalls/syscall.tbl       | 3 +++
 arch/sh/kernel/syscalls/syscall.tbl         | 2 ++
 arch/sparc/kernel/syscalls/syscall.tbl      | 3 +++
 arch/x86/entry/syscalls/syscall_32.tbl      | 2 ++
 arch/x86/entry/syscalls/syscall_64.tbl      | 3 ++-
 arch/xtensa/kernel/syscalls/syscall.tbl     | 2 ++
 scripts/syscall.tbl                         | 2 ++
 17 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index f31b7afffc34..d3f73725239b 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -511,3 +511,5 @@
 579	common	file_setattr			sys_file_setattr
 580	common	listns				sys_listns
 581	common	rseq_slice_yield		sys_rseq_slice_yield
+582	common	mq_recvmmsg			sys_mq_recvmmsg
+583	common	mq_sendmmsg			sys_mq_sendmmsg
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 94351e22bfcf..ad9080eb5800 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -486,3 +486,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
index 62d93d88e0fe..7d758c8de10f 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -483,3 +483,6 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg		compat_sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg		compat_sys_mq_sendmmsg
+
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 248934257101..42e277f7f1bc 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -471,3 +471,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 223d26303627..0a4a72d4f112 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -477,3 +477,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+473	common	mq_sendmmsg			sys_mq_sendmmsg
+472	common	mq_recvmmsg			sys_mq_recvmmsg
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 7430714e2b8f..03099ba20103 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -410,3 +410,5 @@
 469	n32	file_setattr			sys_file_setattr
 470	n32	listns				sys_listns
 471	n32	rseq_slice_yield		sys_rseq_slice_yield
+472	n32	mq_recvmmsg			compat_sys_mq_recvmmsg
+473	n32	mq_sendmmsg			compat_sys_mq_sendmmsg
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 630aab9e5425..49b52129b110 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -386,3 +386,6 @@
 469	n64	file_setattr			sys_file_setattr
 470	n64	listns				sys_listns
 471	n64	rseq_slice_yield		sys_rseq_slice_yield
+472	n64	mq_recvmmsg			sys_mq_recvmmsg
+473	n64	mq_sendmmsg			sys_mq_sendmmsg
+
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 128653112284..c26fa87ae06e 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -459,3 +459,5 @@
 469	o32	file_setattr			sys_file_setattr
 470	o32	listns				sys_listns
 471	o32	rseq_slice_yield		sys_rseq_slice_yield
+472	o32	mq_recvmmsg			sys_mq_recvmmsg		compat_sys_mq_recvmmsg
+473	o32	mq_sendmmsg			sys_mq_sendmmsg		compat_sys_mq_sendmmsg
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index c6331dad9461..fd3c4fde3298 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -470,3 +470,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg		compat_sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg		compat_sys_mq_sendmmsg
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 4fcc7c58a105..a84355ada041 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -562,3 +562,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	nospu	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg		compat_sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg		compat_sys_mq_sendmmsg
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 09a7ef04d979..a3ce9c216477 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -398,3 +398,6 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg
+
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 70b315cbe710..b14d8f4614c4 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -475,3 +475,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 7e71bf7fcd14..7ce825b9f531 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -517,3 +517,6 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg		compat_sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg		compat_sys_mq_sendmmsg
+
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index f832ebd2d79b..b40cce591f20 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -477,3 +477,5 @@
 469	i386	file_setattr		sys_file_setattr
 470	i386	listns			sys_listns
 471	i386	rseq_slice_yield	sys_rseq_slice_yield
+472	i386	mq_recvmmsg		sys_mq_recvmmsg		compat_sys_mq_recvmmsg
+473	i386	mq_sendmmsg		sys_mq_sendmmsg		compat_sys_mq_sendmmsg
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 524155d655da..16b29007e210 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -396,7 +396,8 @@
 469	common	file_setattr		sys_file_setattr
 470	common	listns			sys_listns
 471	common	rseq_slice_yield	sys_rseq_slice_yield
-
+472	common	mq_recvmmsg		sys_mq_recvmmsg
+473	common	mq_sendmmsg		sys_mq_sendmmsg
 #
 # Due to a historical design error, certain syscalls are numbered differently
 # in x32 as compared to native x86_64.  These syscalls have numbers 512-547.
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index a9bca4e484de..377f27d70a65 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -442,3 +442,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 7a42b32b6577..8e50ab85b951 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -412,3 +412,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg		compat_sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg		compat_sys_mq_sendmmsg
-- 
2.43.0

