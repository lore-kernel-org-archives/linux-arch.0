Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3456237B3F2
	for <linux-arch@vger.kernel.org>; Sun, 15 Mar 2026 21:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773611265; cv=none; b=Ht+PK3M8P0srWk2+AYpGq/IhWoK08F3JxKzcS3bfDZBjh5mklgUhzgm4bcGrvOhNxOXHw/fcBu/BMGe/wLuyYC0kl7Skbw2JzowMUislHa7xKLFHlXCDFD+VuQ2hQt1oY1KvrCJlnknnE+FEtpXUqf3yD0PI8ioOW1J5SSnhzGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773611265; c=relaxed/simple;
	bh=goBBsTk2MYrix5HgSc5P3EgwATIoXdXN56gmrYzwOzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJ6H311zI1HokR+uLEwdLlZ1AFZ+SMKnTlFKc5GQylaS9aXFqIIDNsdusAJkbU5WNpC/V03TeQA5sFqdCFZc5YbKX5ubAvtjTd5HXZBH7+WzmFXMBHgE2OWUajLQ0KpwD6Z4vq9CUx2OJLCBiNXeQ8djRqOLGtIVEaCLfzuuhVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSuywpPd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSuywpPd"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ad617d5b80so27279705ad.1
        for <linux-arch@vger.kernel.org>; Sun, 15 Mar 2026 14:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773611264; x=1774216064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRg3BT7wnf4d3IQRMTP80BQdnBv6rSRlNe79T3b3Rvs=;
        b=lSuywpPdoSNJ+YC3oYdM+eWlimbFzTxrJ/20bKjBWyubm9c/XzbXmktQCG++xceHMG
         7QN5N2a9lCJZaPPKp7I8Cm3sFKxEV8t1ybZDrj/zp+hBdX3MOzeQWBkFpJCGgdLRZmCn
         naE47ZVOaqGtPAHkq+9PT2XvMI1KNd5bFVO1L2vlHQ+iEO+ya0R2T3keZtmXs7/nEGiR
         xUmL0HTB+tmW6vUfi7VYwGDJXEJyaV4NSa3sd5s1v/OUM59S0QHKQq8e27l6+QIp8ygl
         r56baUk/34LEdZOAd87Y2EGiTKo73+gS4/EW2ZqqWQJS3UlT5AYYD2UKSKViYByuuLAe
         aoeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773611264; x=1774216064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zRg3BT7wnf4d3IQRMTP80BQdnBv6rSRlNe79T3b3Rvs=;
        b=THGaXtpiw2W/TQ6OWpquBfFb2U+GJHwwv+94VMd8w2rVTh04Ar8UCVSS7xvQDnXvXd
         Rikr5XyySXYDYWwf09cp6YeiKFoasNhX2BolCsQ8zUlvVUINyKsvqEtklb05OHf0WHqQ
         WQRpUKc6LzZPEUKOlova1QLkRe1YzLVeAxE74MmFMbtxtQWbn07i3M6NkZ9/RaS/6yAt
         lfQ4HMUQz+k7CA2iMHi9Xo+6yFdB8qaS+Xa5bx28UBHXR8Rjn1tXvwSTgD1ovlD0KXnt
         HahyMLyB6YvjUdzgFERrfTH1cwI8srAnjc3+CGcvDvdgA4FS5bfx5ShBga8fQ0hRFF8A
         IuSw==
X-Forwarded-Encrypted: i=1; AJvYcCXYqK6KdJhMDpCJ/2seQAl1a+q/ysJ1Cpvp0vRy4ctst9Ab0BSSCyZzoh3F3NzUt0dGGyG6e6jOPVdD@vger.kernel.org
X-Gm-Message-State: AOJu0YywzDlurs7wr9cC2XDQBb5iPD1ETcl2RUabyLIAySvddZeak1Wp
	O3PU1j40Qt+Kkop1h+yr4TZr/MSKAfdC9NMly2dkOo8LIAWcC5Fz/7wT
X-Gm-Gg: ATEYQzyC/rjqPh07+ekZDYFPEwTeXH88qB4Xr3YpiGwTukmeuowrKkz9/uLQxCClodt
	yWo2lmbztI9JGIAGBGRBd6aznN9Qvba5KrByDc30SeznGSTyyRA/PukKUCh1S84iYpTB55oZZfj
	QBJIcV1mhv+xxNNlMEUvltpdfoP3NMHDP64M4g5DkKRJ/Y/yxswnURkmPN+9X5kH7FsoIIn+DNx
	JOtKq/Rj6cEOcRIb3y/X6AxG8loywQoEkyIPHjmi5lKh+rc2I0CHqErh3ok0kA3EZE7VxFv6N+7
	m7DTcv0vEEHU4eNqzy1r6dNdKM8evEfflvIWjuL8rkRvf3xT+h33weSP7r29ta0dN37R32H0pzG
	RuERyf9j7mtSNNQqjy2cu/NoZjGonmnx34dHrpCBWT8u6qYFETEhyq/q8Zw2wZCgfsGomQUxPMd
	tq5dqF5Adn46P6EM2Yotfq3DWEmBXs7yRw9rc=
X-Received: by 2002:a17:902:e810:b0:2b0:5a4c:7265 with SMTP id d9443c01a7336-2b05a5bc019mr5279345ad.4.1773611263651;
        Sun, 15 Mar 2026 14:47:43 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:b4fc:c14c:ba99:ba0e:908b:8404])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b04f40f515sm34153085ad.74.2026.03.15.14.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 14:47:43 -0700 (PDT)
From: Mathura_Kumar <academic1mathura@gmail.com>
To: brauner@kernel.org
Cc: academic1mathura@gmail.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v2 2/4]IPC: Added system call number in all  most common arch.
Date: Mon, 16 Mar 2026 03:16:52 +0530
Message-ID: <20260315214656.658590-3-academic1mathura@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260315214656.658590-1-academic1mathura@gmail.com>
References: <20260315214656.658590-1-academic1mathura@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Mathura_Kumar <academic1mathura@gmail.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
 arch/arm/tools/syscall.tbl                  | 1 +
 arch/arm64/tools/syscall_32.tbl             | 1 +
 arch/m68k/kernel/syscalls/syscall.tbl       | 1 +
 arch/microblaze/kernel/syscalls/syscall.tbl | 1 +
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 1 +
 arch/parisc/kernel/syscalls/syscall.tbl     | 1 +
 arch/powerpc/kernel/syscalls/syscall.tbl    | 1 +
 arch/s390/kernel/syscalls/syscall.tbl       | 1 +
 arch/sh/kernel/syscalls/syscall.tbl         | 1 +
 arch/sparc/kernel/syscalls/syscall.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_32.tbl      | 1 +
 arch/x86/entry/syscalls/syscall_64.tbl      | 1 +
 arch/xtensa/kernel/syscalls/syscall.tbl     | 1 +
 scripts/syscall.tbl                         | 1 +
 17 files changed, 17 insertions(+)

diff --git a/arch/alpha/kernel/syscalls/syscall.tbl b/arch/alpha/kernel/syscalls/syscall.tbl
index f31b7afffc34..0ff42d241419 100644
--- a/arch/alpha/kernel/syscalls/syscall.tbl
+++ b/arch/alpha/kernel/syscalls/syscall.tbl
@@ -511,3 +511,4 @@
 579	common	file_setattr			sys_file_setattr
 580	common	listns				sys_listns
 581	common	rseq_slice_yield		sys_rseq_slice_yield
+582	common	mq_timedreceive2		sys_mq_timedreceive2
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index 94351e22bfcf..c00a185fbe50 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -486,3 +486,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2		sys_mq_timedreceive2          compat_sys_mq_timedreceive2
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
index 62d93d88e0fe..4eac85c25658 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -483,3 +483,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2     	sys_mq_timedreceive2		compat_sys_mq_timedreceive2
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 248934257101..6e336289eaf4 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -471,3 +471,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2		sys_mq_timedreceive2
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 223d26303627..6b617de0442e 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -477,3 +477,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2		sys_mq_timedreceive2
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 7430714e2b8f..1f761cf9cfb0 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -410,3 +410,4 @@
 469	n32	file_setattr			sys_file_setattr
 470	n32	listns				sys_listns
 471	n32	rseq_slice_yield		sys_rseq_slice_yield
+472	n32	mq_timedreceive2		compat_sys_mq_timedreceive2
diff --git a/arch/mips/kernel/syscalls/syscall_n64.tbl b/arch/mips/kernel/syscalls/syscall_n64.tbl
index 630aab9e5425..75de6ee2df94 100644
--- a/arch/mips/kernel/syscalls/syscall_n64.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n64.tbl
@@ -386,3 +386,4 @@
 469	n64	file_setattr			sys_file_setattr
 470	n64	listns				sys_listns
 471	n64	rseq_slice_yield		sys_rseq_slice_yield
+472	n64	mq_timedreceive2		sys_mq_timedreceive2
diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
index 128653112284..f11be7e34d93 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -459,3 +459,4 @@
 469	o32	file_setattr			sys_file_setattr
 470	o32	listns				sys_listns
 471	o32	rseq_slice_yield		sys_rseq_slice_yield
+472	o32	mq_timedreceive2		sys_mq_timedreceive2	compat_sys_mq_timedreceive2
diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
index f6e2d0379d57..1b22b8d0edcc 100644
--- a/arch/parisc/kernel/syscalls/syscall.tbl
+++ b/arch/parisc/kernel/syscalls/syscall.tbl
@@ -470,3 +470,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2		sys_mq_timedreceive2		compat_sys_mq_timedreceive2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 4fcc7c58a105..ab57aa18b24a 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -562,3 +562,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	nospu	rseq_slice_yield		sys_rseq_slice_yield
+472 common	mq_timedreceive2	sys_mq_timedreceive2	compat_sys_mq_timedreceive2
\ No newline at end of file
diff --git a/arch/s390/kernel/syscalls/syscall.tbl b/arch/s390/kernel/syscalls/syscall.tbl
index 09a7ef04d979..34df682061d9 100644
--- a/arch/s390/kernel/syscalls/syscall.tbl
+++ b/arch/s390/kernel/syscalls/syscall.tbl
@@ -398,3 +398,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2		sys_mq_timedreceive2
diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
index 70b315cbe710..cac787dbef1a 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -475,3 +475,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2		sys_mq_timedreceive2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 7e71bf7fcd14..06bcea3622cb 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -517,3 +517,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472 common	mq_timedreceive2	sys_mq_timedreceive2	compat_sys_mq_timedreceive2
\ No newline at end of file
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index f832ebd2d79b..79154690058f 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -477,3 +477,4 @@
 469	i386	file_setattr		sys_file_setattr
 470	i386	listns			sys_listns
 471	i386	rseq_slice_yield	sys_rseq_slice_yield
+472	i386	mq_timedreceive2	sys_mq_timedreceive2		compat_sys_mq_timedreceive2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 524155d655da..a76f9a2f043a 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -441,3 +441,4 @@
 547	x32	pwritev2		compat_sys_pwritev64v2
 # This is the end of the legacy x32 range.  Numbers 548 and above are
 # not special and are not to be used for x32-specific syscalls.
+548	common	mq_timedreceive2		sys_mq_timedreceive2
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index a9bca4e484de..ae106ac97418 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -442,3 +442,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2		sys_mq_timedreceive2
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 7a42b32b6577..282bfff83d59 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -412,3 +412,4 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2		sys_mq_timedreceive2		compat_sys_mq_timedreceive2
-- 
2.43.0

