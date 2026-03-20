Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4352F4A0C
	for <linux-arch@vger.kernel.org>; Fri, 20 Mar 2026 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773984290; cv=none; b=IswM3EDxIdIZrrx25Lga2SCGDxXU0aQUX60dZuSd6fbsauRW5dWMg2mrPcDwr9FkfBS36DW9JQqNQ/IJiU3/IpRLzS7grSSCgnRxvfxGLkCSFRJ0PxDoeAHHqxnVfHgbySHulj8rhzRrXtP01ppa2Eo1PRdGIpE2RvadMhUpiQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773984290; c=relaxed/simple;
	bh=bBQ8eU9COzhoiSE8iroJ9UrjlJbEQHeRPmWx2f4Tifw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4WsmxQKS8tyRqjxS9+blO1BsJfYlFiK7g5P5mbJGzXjOE1nv7+yyJanactSksJ5yFWkn00ev32jhk2fhYB4cCWlOBOLAxwMYAcqd6CJEwqdE13bATtsmPdPlFN0ZMMH5O0FdcZTntwVWsUlAQ6jZJKr2KXK+x6kkJWUcM7xMdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ba7H+lPU; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ba7H+lPU"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35b90d6fe14so1010021a91.2
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2026 22:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773984288; x=1774589088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o072AjhwxnOu54vKZkT8gFGqCYJjeQUma+HHruoaLvA=;
        b=Ba7H+lPUqHi2AVem+3+wyqTb2WQBY8xjKRJDCtGtB+gs1DCUWv1mwqvT4+ClBtoF5/
         vxygw/Bsku1rm3/Ik0SQVi7ZxvSCyE14Wh5TdjUOgG5w83JH7lDyGCW8n9xPzTxL0rmL
         OeacVwYSoey7JH3ylXtl+PcMGh+YjPyM8LXvRkbDYExq82IhWE7K4oSDp//0pWH6HiSb
         3iCaCUQXsZHWnRAf1vtUlRe+RN68RVF19ylh2RohDwca8ClPFYIp9naOF3DQebA0TV5n
         36jo6oXrFshiFWBqSZFseBLkEMQHpoMtsrzsYu91fDG6XqwCkDVU13/h6Ej9gy59XS0z
         H+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773984288; x=1774589088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o072AjhwxnOu54vKZkT8gFGqCYJjeQUma+HHruoaLvA=;
        b=KgjRFRVjGgFnCTXH0JBjMltSDbjQL6iL8glPExrxTPsfW0dYokWwJFqoIAA+8ZedxQ
         nGgSBNOr23x1amnrai3r0KoxTRoPEfh1PeQuQetd/k6/9dJgfCaN7FPxDwqfWmxJIYQu
         bQFhZQZAz5quW4Gu/ueZYIl1kjbtqn1/1B4bIjudygDYYQXv0fowVjVl1YxnY+Fn9Z1c
         RgeuCoDMpbUy/8wkimq2j3O507JGGRUKcD+1s3dPQkeIpWBW86I3XABy99ag/N/Auvyo
         /ekpiQ6P2TlnMdcKf6Ud/pLma+dcDS5rnSh35n0FAarnOgOVC3sNlNWnI5U31Sxd1UOM
         Ssrg==
X-Forwarded-Encrypted: i=1; AJvYcCV4vaYbux93U+bRKLVw+fEJU9zrJSJq/nL4QZpU1/+vWep/y3Q2F1BnpmDno5n1DjV7Y7wLrnzKLyML@vger.kernel.org
X-Gm-Message-State: AOJu0YwNIBnxjObP7zxQCFfD8HG7Kk2y0kLdS3GAtRgjNiFcC+vR2xXV
	25zGX4jCHZc0zVx1onNQMGiHWq8f212UfIRP2semjT4zcf/IeyRsZU66
X-Gm-Gg: ATEYQzydRPhx55nrw9tI1vsCdeesaw91JWY1qa39nPiHQ7KGd5NNcupMCTzhYC586VJ
	lTYbk6Nwbli2sqctNqzXkRTfQaBf8dhNavS3MMLS3e35YiMvhA5LSU+d+r8PpVZg5Sg2A911Veg
	mLMwf+f81uIPspQuM7YEO4Ig72h595xfuzLXusrNkbOgxB9RwLMeNtTn9Bizj9i/teSD0KtzE4x
	zxayGsf5m2n4AJ+ijTR/VscF+rNMVLDuSjgH1RukV23njIMnD4OUl8F6Mb2jsskid0yu9QX/W1d
	fg4nutxGnD9gYb4dJj0LyA2YQTbCqP8QTnZfThYdmmBwfqeWjCxCwJvU0tumXgpyADTjgKtUjqW
	SBq6p6yDup8J4d3K16VBqp0+SIL/w3EmBT/ruLMSPn2GnliJDNi86U0qqVqmyF+6xoxn+S2VsjB
	DOQvsT909nhQypN1XVqEkfZRr3RdyjKYBTbaY=
X-Received: by 2002:a17:90b:4d:b0:35b:a170:f266 with SMTP id 98e67ed59e1d1-35bd2c2090dmr1454113a91.13.1773984288006;
        Thu, 19 Mar 2026 22:24:48 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:b471:fd0e:76f1:2fa0:b416:4f73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd40e4bfdsm779344a91.9.2026.03.19.22.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 22:24:47 -0700 (PDT)
From: Mathura_Kumar <academic1mathura@gmail.com>
To: brauner@kernel.org
Cc: academic1mathura@gmail.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH RESEND v2 4/4]IPC:Added  entry in performance tools for new  system call
Date: Fri, 20 Mar 2026 10:53:38 +0530
Message-ID: <20260320052340.6696-5-academic1mathura@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260320052340.6696-1-academic1mathura@gmail.com>
References: <20260320052340.6696-1-academic1mathura@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mathura_Kumar <academic1mathura@gmail.com>
---
 tools/perf/arch/alpha/entry/syscalls/syscall.tbl    | 1 +
 tools/perf/arch/arm/entry/syscalls/syscall.tbl      | 1 +
 tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl | 1 +
 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl | 1 +
 tools/perf/arch/parisc/entry/syscalls/syscall.tbl   | 1 +
 tools/perf/arch/powerpc/entry/syscalls/syscall.tbl  | 1 +
 tools/perf/arch/s390/entry/syscalls/syscall.tbl     | 1 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl       | 1 +
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl    | 1 +
 tools/perf/arch/x86/entry/syscalls/syscall_32.tbl   | 1 +
 tools/perf/arch/x86/entry/syscalls/syscall_64.tbl   | 1 +
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl   | 1 +
 tools/scripts/syscall.tbl                           | 1 +
 13 files changed, 13 insertions(+)

diff --git a/tools/perf/arch/alpha/entry/syscalls/syscall.tbl b/tools/perf/arch/alpha/entry/syscalls/syscall.tbl
index 74720667fe09..95893d9ec401 100644
--- a/tools/perf/arch/alpha/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/alpha/entry/syscalls/syscall.tbl
@@ -502,3 +502,4 @@
 570	common	lsm_set_self_attr		sys_lsm_set_self_attr
 571	common	lsm_list_modules		sys_lsm_list_modules
 572	common  mseal				sys_mseal
+582	common	mq_timedreceive2		sys_mq_timedreceive2
diff --git a/tools/perf/arch/arm/entry/syscalls/syscall.tbl b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
index fd09afae72a2..40b018f08f7d 100644
--- a/tools/perf/arch/arm/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/arm/entry/syscalls/syscall.tbl
@@ -485,3 +485,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+472	common	mq_timedreceive2		sys_mq_timedreceive2
diff --git a/tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl b/tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl
index 9a37930d4e26..0e9ff6deb3fa 100644
--- a/tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl
+++ b/tools/perf/arch/arm64/entry/syscalls/syscall_32.tbl
@@ -474,3 +474,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+472	common	mq_timedreceive2		sys_mq_timedreceive2		compat_sys_mq_timedreceive2
\ No newline at end of file
diff --git a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
index 9b92bddf06b5..154886e07e8b 100644
--- a/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
+++ b/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
@@ -385,3 +385,4 @@
 468	n64	file_getattr			sys_file_getattr
 469	n64	file_setattr			sys_file_setattr
 470	n64	listns				sys_listns
+472	n64	mq_timedreceive2		sys_mq_timedreceive2
diff --git a/tools/perf/arch/parisc/entry/syscalls/syscall.tbl b/tools/perf/arch/parisc/entry/syscalls/syscall.tbl
index 66dc406b12e4..f1741102631b 100644
--- a/tools/perf/arch/parisc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/parisc/entry/syscalls/syscall.tbl
@@ -461,3 +461,4 @@
 460	common	lsm_set_self_attr		sys_lsm_set_self_attr
 461	common	lsm_list_modules		sys_lsm_list_modules
 462	common	mseal				sys_mseal
+472	common	mq_timedreceive2		sys_mq_timedreceive2		compat_sys_mq_timedreceive2
diff --git a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
index ec4458cdb97b..9326132328bf 100644
--- a/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/powerpc/entry/syscalls/syscall.tbl
@@ -561,3 +561,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+472	common	mq_timedreceive2		sys_mq_timedreceive2		compat_sys_mq_timedreceive2
diff --git a/tools/perf/arch/s390/entry/syscalls/syscall.tbl b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
index 5863787ab036..003603fd789b 100644
--- a/tools/perf/arch/s390/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/s390/entry/syscalls/syscall.tbl
@@ -473,3 +473,4 @@
 468  common	file_getattr		sys_file_getattr		sys_file_getattr
 469  common	file_setattr		sys_file_setattr		sys_file_setattr
 470  common	listns			sys_listns			sys_listns
+472	 common	mq_timedreceive2		sys_mq_timedreceive2		compat_sys_mq_timedreceive2
diff --git a/tools/perf/arch/sh/entry/syscalls/syscall.tbl b/tools/perf/arch/sh/entry/syscalls/syscall.tbl
index 969c11325ade..af944271a813 100644
--- a/tools/perf/arch/sh/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/sh/entry/syscalls/syscall.tbl
@@ -474,3 +474,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+472	common	mq_timedreceive2		sys_mq_timedreceive2
diff --git a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
index 39aa26b6a50b..7236b2158ae0 100644
--- a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
@@ -516,3 +516,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+472	common	mq_timedreceive2		sys_mq_timedreceive2		compat_sys_mq_timedreceive2
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
index e979a3eac7a3..a93f76e01232 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_32.tbl
@@ -476,3 +476,4 @@
 468	i386	file_getattr		sys_file_getattr
 469	i386	file_setattr		sys_file_setattr
 470	i386	listns			sys_listns
+472	i386	mq_timedreceive2		sys_mq_timedreceive2		compat_sys_mq_timedreceive2
diff --git a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
index 8a4ac4841be6..b6521fc1045b 100644
--- a/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/tools/perf/arch/x86/entry/syscalls/syscall_64.tbl
@@ -440,3 +440,4 @@
 547	x32	pwritev2		compat_sys_pwritev64v2
 # This is the end of the legacy x32 range.  Numbers 548 and above are
 # not special and are not to be used for x32-specific syscalls.
+548	common	mq_timedreceive2		sys_mq_timedreceive2		compat_sys_mq_timedreceive2
diff --git a/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl b/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
index 438a3b170402..9525878dd8b1 100644
--- a/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
+++ b/tools/perf/arch/xtensa/entry/syscalls/syscall.tbl
@@ -441,3 +441,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+472	common	mq_timedreceive2		sys_mq_timedreceive2
diff --git a/tools/scripts/syscall.tbl b/tools/scripts/syscall.tbl
index e74868be513c..576d34045747 100644
--- a/tools/scripts/syscall.tbl
+++ b/tools/scripts/syscall.tbl
@@ -411,3 +411,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+472 common	mq_timedreceive2	sys_mq_timedreceive2	compat_sys_mq_timedreceive2
-- 
2.43.0

