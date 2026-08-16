Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BA735B631
	for <linux-arch@vger.kernel.org>; Sun, 16 Aug 2026 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786894801; cv=none; b=e4YgKqwvc0Kmp4bi8c5rmrij/m79GNTrz7l/JcqBTSZlz6v5e5Vg3a7vYGQsUujRLqwHdEG0MT5Ua5Cez7p4f3o7k2SaKLdW4uglmMd3WkjkEHn/gLbEPxbNnB/M/fHLSAg7r/4K8olvu2kDOJqFIIqMbpBBVrOCfTClB2qUQP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786894801; c=relaxed/simple;
	bh=mbW0//BGLoiGM7/KqsbbDvaT7TOxpU6dppbfGoucxow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s2eVOm+b183HtJkYLj2e+ywnkv3OXZ/OG9OK+gWkZV0XmOV991xQnJ3/Jl/Ac16ftOXX/E7Q3rlY5EkHhRS1ebvBR8OcJ2wCTvQLVp9IXDF3n0QIaML5rU/YyJ5uw28PFL6f/aqbrSbFKfV11Y8tcxqiqlZRsYjYe6gu1G8Xr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgpZq8Js; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgpZq8Js"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so2832560a91.3
        for <linux-arch@vger.kernel.org>; Sun, 16 Aug 2026 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786894799; x=1787499599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PHq3kx/aITpUfp32gN2q1/ndjJiSSW3d7Xl6YJ8epP0=;
        b=MgpZq8JsP4B6ciRY2oHDgOz0RIabNQNtMA5rwz87o+FG8+N1dfB1rBU9rel0TqS3Gq
         4aMBADgKeNKSjQQWqSOJIkrS5M+J8ntYRsq+CBooTt664mrkKYrzdYgS36ugwQrV0dJd
         +rG/f4nTkfzYfTk0Cb70Pezaaqplo41c0fF82dKUQtgb/6CIBqVL2fzpZL1Ch1QLkVMv
         mtgVdCotx092eeFmZc/nxCGwyTtEHazmbDSVwH9Gp/PFkXflhc3Th/T7WspFHOXXSSkv
         7YMD1vK2YAerpqeBw2g+BeDK8fsYS51YM+zoDm3h0074RrC/8HJ1GepUBupc9d4NI55J
         cQog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786894799; x=1787499599;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PHq3kx/aITpUfp32gN2q1/ndjJiSSW3d7Xl6YJ8epP0=;
        b=lpziapD5QUB8qFjRtzidU8m6IEDAzP6VkhuBPhIc0ejaFseO1QBqMZZUBLQgo/8bU+
         Z/170X73aog/BsnNJ3w2/2fIFwiuQaihei28RyXvAl6xnfJJIwH8rfb25XWpjy2D2Zfs
         PYiUH7v8s6Blsn0cWC73ce8+/zrILirqs42uJmiV9LLag79FyJqpuIpNfwr1mQOszY7r
         iINnQ/6Wgky/skw0hNttue+vwyekgQojMlyOHj1hLE8l2CO7dB8jKpTrfcvHrkfgRKgH
         S9g+J9AHA9bs3e8QT13lkWxhYdDDYKUnbd5XtEIxhkAg7+G7y8Tzxy4uXBrM/wySBXC4
         9p0g==
X-Forwarded-Encrypted: i=1; AHgh+RrwrWgFQhPQheqVKSLYvcV9M9vs7ON7bDamV7YFo2t4YAAjobBC3vwVj3kr9faHUzWpzuEPWeDoRDn6@vger.kernel.org
X-Gm-Message-State: AOJu0YypvnfvRpFsl3qZp8o8tQVo2R8i62gqXMkFCDGhutTJMYclaBXY
	gpS1TeRAz9JWVIGDN42qLEPGF64gS3DyKkZDeyHDDBK0yraeK5R+2f00
X-Gm-Gg: AR+sD11uzOcbQ6x1rfX60NxpuF7h+J0W2utwFeBB2vbA14i3WEIvGrc2kYD2EU20bHh
	Fqus3vKU5wXtZUUvCTYXGjlUx4XxC6jLAlCH1n+SdNLpRgDfVZIQh4UPcTJvLOdRwsHsSEOb44M
	0N4ZqudIJoyBtmnn2Zvc7pvX+gxJqocRq1UnkOfCnBOio2cXWnNrM7XVRcklZg8GMfczg5hBcRn
	JtfFll9TNdqTy3rRWf28uj3g6nsRdX8Lo3ehRKR9Bdfcg7hJoVnB3/UKlQiNUY+9i1uvtFsKwZ5
	/k3HqNjOv4zFg8y9W1LtCDZl0EaZHdCCGJQxxfFxK49NyC8fqd4GwQ8gK8xV71+cYqJ4GMH3G04
	zHx1BYuFcw2bltFOmai4D+8N6FpDiHSKsrVsdsCEqYVbUyKVrmrNW243bxxCwGzjTvgkB6p1fha
	jQpEA7eOxtWTgXx1F9MvukQlp9SEMtSdCNkZ7Ui0/5+Z3uwQeFO/KBYQwtH+mAHHh8fmd80xcpQ
	lQ=
X-Received: by 2002:a17:90b:1b47:b0:38e:5964:97a8 with SMTP id 98e67ed59e1d1-3933e63167amr18952669a91.16.1786894799397;
        Sun, 16 Aug 2026 08:39:59 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:a069:993b:8f9f:648d:c9a9:d989])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea804233sm24501914eec.26.2026.08.16.08.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 08:39:59 -0700 (PDT)
From: mathura kumar <mathura.kumar.tech@gmail.com>
To: brauner@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	corbet@lwn.net,
	mathura.kumar.tech@gmail.com
Subject: [PATCH v3 3/4] IPC: Added system call entry in performance tool
Date: Sun, 16 Aug 2026 21:04:22 +0530
Message-ID: <20260816153811.1085261-4-mathura.kumar.tech@gmail.com>
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

It include all the entries  made up in performance tools
for both new system call.

Signed-off-by: mathura kumar <mathura.kumar.tech@gmail.com>
---
 tools/include/uapi/asm-generic/unistd.h             | 8 +++++++-
 tools/perf/arch/alpha/entry/syscalls/syscall.tbl    | 4 ++++
 tools/perf/arch/arm/entry/syscalls/syscall.tbl      | 3 +++
 tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl | 3 +++
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 2 ++
 tools/perf/arch/parisc/entry/syscalls/syscall.tbl   | 3 +++
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 3 +++
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 2 ++
 tools/perf/arch/sh/entry/syscalls/syscall.tbl       | 2 ++
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl    | 2 ++
 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl   | 2 ++
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 2 ++
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl   | 2 ++
 tools/scripts/syscall.tbl                           | 2 ++
 14 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index a627acc8fb5f..b891edfebdf9 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -863,8 +863,14 @@ __SYSCALL(__NR_listns, sys_listns)
 #define __NR_rseq_slice_yield 471
 __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
 
+#define __NR_mq_recvmmsg 472
+__SC_COMP(__NR_mq_recvmmsg, sys_mq_recvmmsg, compat_sys_mq_recvmmsg)
+
+#define __NR_mq_sendmmsg 473
+__SC_COMP(__NR_mq_sendmmsg, sys_mq_sendmmsg, compat_sys_mq_sendmmsg)
+
 #undef __NR_syscalls
-#define __NR_syscalls 472
+#define __NR_syscalls 474
 
 /*
  * 32 bit systems traditionally used different
diff --git a/tools/perf/arch/alpha/entry/syscalls/syscall.tbl b/tools/perf/arch/alpha/entry/syscalls/syscall.tbl
index 74720667fe09..44cb7657bd44 100644
--- a/tools/perf/arch/alpha/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/alpha/entry/syscalls/syscall.tbl
@@ -502,3 +502,7 @@
 570	common	lsm_set_self_attr		sys_lsm_set_self_attr
 571	common	lsm_list_modules		sys_lsm_list_modules
 572	common  mseal				sys_mseal
+# 573-581 are kept reserved for existing system call
+582	common	mq_recvmmsg			sys_mq_recvmmsg
+583	common	mq_sendmmsg			sys_mq_sendmmsg
+
diff --git a/tools/perf/arch/arm/entry/syscalls/syscall.tbl b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
index 94351e22bfcf..714b3964e31c 100644
--- a/tools/perf/arch/arm/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
@@ -486,3 +486,6 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg
+
diff --git a/tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl b/tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl
index 9a37930d4e26..3d408a842d07 100644
--- a/tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl
+++ b/tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl
@@ -474,3 +474,6 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+# 463-471 are kept reserved for existing system call
+472	common mq_recvmmsg			sys_mq_recvmmsg		compat_sys_mq_recvmmsg
+473	common mq_sendmmsg			sys_mq_sendmmsg		compat_sys_mq_sendmmsg
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 630aab9e5425..de1000dff765 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -386,3 +386,5 @@
 469	n64	file_setattr			sys_file_setattr
 470	n64	listns				sys_listns
 471	n64	rseq_slice_yield		sys_rseq_slice_yield
+472	n64	mq_recvmmsg			sys_mq_recvmmsg
+473	n64	mq_sendmmsg			sys_mq_sendmmsg
diff --git a/tools/perf/arch/parisc/entry/syscalls/syscall.tbl b/tools/perf/arch/parisc/entry/syscalls/syscall.tbl
index 66dc406b12e4..e1d442f17f25 100644
--- a/tools/perf/arch/parisc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/parisc/entry/syscalls/syscall.tbl
@@ -461,3 +461,6 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+472	common	mq_recvmmsg			sys_mq_recvmmsg		compat_sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg		compat_sys_mq_sendmmsg
+
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index 4fcc7c58a105..4a9edd38da52 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -562,3 +562,6 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	nospu	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg		compat_sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg		compat_sys_mq_sendmmsg
+
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 09a7ef04d979..eba3ed5b7576 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -398,3 +398,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg
diff --git a/tools/perf/arch/sh/entry/syscalls/syscall.tbl b/tools/perf/arch/sh/entry/syscalls/syscall.tbl
index 70b315cbe710..b14d8f4614c4 100644
--- a/tools/perf/arch/sh/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/sh/entry/syscalls/syscall.tbl
@@ -475,3 +475,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg
diff --git a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
index 7e71bf7fcd14..35ee3651e66c 100644
--- a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
@@ -517,3 +517,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg		compat_sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg		compat_sys_mq_sendmmsg
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
index f832ebd2d79b..b40cce591f20 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
@@ -477,3 +477,5 @@
 469	i386	file_setattr		sys_file_setattr
 470	i386	listns			sys_listns
 471	i386	rseq_slice_yield	sys_rseq_slice_yield
+472	i386	mq_recvmmsg		sys_mq_recvmmsg		compat_sys_mq_recvmmsg
+473	i386	mq_sendmmsg		sys_mq_sendmmsg		compat_sys_mq_sendmmsg
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 524155d655da..c16fb5d613b2 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -396,6 +396,8 @@
 469	common	file_setattr		sys_file_setattr
 470	common	listns			sys_listns
 471	common	rseq_slice_yield	sys_rseq_slice_yield
+472	common	mq_recvmmsg		sys_mq_recvmmsg
+473	common	mq_sendmmsg		sys_mq_sendmmsg
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl b/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
index a9bca4e484de..377f27d70a65 100644
--- a/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
@@ -442,3 +442,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg
diff --git a/tools/scripts/syscall.tbl b/tools/scripts/syscall.tbl
index 7a42b32b6577..8e50ab85b951 100644
--- a/tools/scripts/syscall.tbl
+++ b/tools/scripts/syscall.tbl
@@ -412,3 +412,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg		compat_sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg		compat_sys_mq_sendmmsg
-- 
2.43.0

