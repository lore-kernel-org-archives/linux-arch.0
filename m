Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FEC92288E3
	for <linux-arch@vger.kernel.org>; Sun, 15 Mar 2026 04:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773547794; cv=none; b=idtOjsX9/9f+fX8f7qRgsibf3eyqcDtA3U0EkmwKzTnlga0Tq+vMSSHdoqBAwil6mcLXQNycTK9M8eE2xdkskozhXayv14uvXKg3SCfeJUOY0rNyoPshmYSD9F5geFSK2MrMJ9/yq7d09JQ0WOiqiVyK0GgM3ts1bBFOlyOrvIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773547794; c=relaxed/simple;
	bh=bBQ8eU9COzhoiSE8iroJ9UrjlJbEQHeRPmWx2f4Tifw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEHlhCGqYufakvzV99TL8REouk8PXLdihbUSCXf7TLZWyWo1mEZ/z5obgr4uzJgk2+nq66e0EllyEt+vlaqVWnuhvI4WPrJ+XVr2kA6VBKI0szai0ZseEmwUh5igTl794aQBAjWVDtWHQqHCrpzCtm7sQAghyFvW1wYSsVlDRNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bigBs3RN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bigBs3RN"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82a13374cf6so2915341b3a.1
        for <linux-arch@vger.kernel.org>; Sat, 14 Mar 2026 21:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773547792; x=1774152592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o072AjhwxnOu54vKZkT8gFGqCYJjeQUma+HHruoaLvA=;
        b=bigBs3RNfnc7JJmd330EX6IXr2rs7dkmFfd1ZXeLph52ONddWKUA1n7WZruR0otvro
         DpnDdW+dRta93vI3wma6jdbIpCB8lM9Lvt1ltSRt8un9Ptma/C5ujpvRaixYJ4TX6cbt
         QMHtf8+H2klmP8rDtFyiyDzh3WP35yCO9pEvawLQBQKyeJW303opjhb/ax31Cg4Xh0Ti
         C/rpHHSprvROVhaJGA/ua+HmlE7ygj4P0la2yNawxxJJrGFbjxZk4Y4iTNOAMDYXK2Bi
         3VRhojvl0zgoykKDyefuxx8Ak6cmt21L5VKBZ9hCEYD/brMq+U9qD1k+cwobH54d8gvf
         cY/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773547792; x=1774152592;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o072AjhwxnOu54vKZkT8gFGqCYJjeQUma+HHruoaLvA=;
        b=M5FWPls8vSmFQLnGTM1e3V0Deu7SEqkFqSX+mpftZv6IUwWOrcmDStIPz7FjUHaS7+
         j5fqVdwOccJunLSs1SPUzg1oJb958yWDEJ+QEXXW0Dxu8wlUEr+fcF3ioKSXQQ57H32T
         IPhspZDWRRVl/y/QBWONcAEDpLN8FQ/tik6xHMPK26+vP0jZdPl/IJz+y4q4OOfnnymI
         BFmPewLwr7+ysJ1ZEXxAhTtXrFVwdnUYqQrz/1mLXnf9YdnYr/82Jnh4pq/SvaQAhCDC
         AO7hzmUBKeuuMSmt6rwU4hABy8Wj7emBZvAFr3n1aDn3GlL2ZPd1DTDGVv1sKCkWLeCz
         fAwg==
X-Forwarded-Encrypted: i=1; AJvYcCWHLmxaz0JlBt24R4AEXv87DhYf/T7i93CvCvKfldLr3X2uq1umuYyZgPbx1LseVqc0SZGAlY42F70e@vger.kernel.org
X-Gm-Message-State: AOJu0Yx82UTK6JrerPIMoGv1f4Xc3ua1pqdHamo5u8FyVtB8VVgBPVDs
	7ACmsf+R+QXVALS2xlmObazGu/by1sUk4qW37ah4hj7fJI3mbd9hfLpt
X-Gm-Gg: ATEYQzx6de7Lub78ZaA0CBCcCw3/fFD8Mxqnz28VEH9zVdA5UF+0ltY2wRR6vkhwa4v
	5JVYxAbEMPXm3X9xnx5KBmQ27hGIyLCsxVI7poOgK1BzsLFTC8m+bpGMSOE0wOMXgSnd7LuhFqa
	v5IXy2/BkY6Ika1i/YbjImEHtV6+5js+PYeUe7f53Rbq+tYYC4gioNTxsAHX2+TICY857k7r8vw
	pkuRZU78gJHeJRqBpnMjM630fP8tcgljdJj/Xb/C/Upe3OZfBcoAz+3TqQIH19/mTLVx6VKdI6h
	3P4V/9DdZ3JPxUJFD9vd845QNS+xEtQFJHWYgWm9KfQLOelINESX8XAeyXZ0o+HvHz7j4HiL3ut
	imAQ7YX8mxHWx0YXMUURbPD33f4nXYR/dC501C1lnf5ReLOwVeIAjUDB2t9qMw+DkoydPhOd/jn
	/5wa1t9wElc2MLf9bCdN6t20RTi4UWVsdbU/9o02D9voEA
X-Received: by 2002:a05:6a00:37c1:b0:829:7d74:d0d1 with SMTP id d2e1a72fcca58-82a198ef50bmr5674555b3a.36.1773547792480;
        Sat, 14 Mar 2026 21:09:52 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:b50e:ee5b:78d:f26b:704b:c464])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072449fesm10192206b3a.13.2026.03.14.21.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 21:09:52 -0700 (PDT)
From: Mathura_Kumar <academic1mathura@gmail.com>
To: brauner@kernel.org
Cc: academic1mathura@gmail.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v1 4/4] IPC:Added entry in performance tools for new system call
Date: Sun, 15 Mar 2026 09:38:00 +0530
Message-ID: <20260315040827.156558-5-academic1mathura@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260315040827.156558-1-academic1mathura@gmail.com>
References: <20260315040827.156558-1-academic1mathura@gmail.com>
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

