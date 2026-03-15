Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB2622A7F0
	for <linux-arch@vger.kernel.org>; Sun, 15 Mar 2026 04:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773547780; cv=none; b=S8us+TtwlYIddu4SKqBPcbMqVXXbdeSdRvXvR4C3q6JEuH4Zu7zpMbhkYzGwImaeuQlERemY2vBagPmEVaHeMVfTBr+Ax61X88Fa0ucBnih7VoXXitzsGK5FWPoyz1y2l3N/ckw3AEjJar+cV4NbXNcPHLwp0YXMZiOGaSpDvvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773547780; c=relaxed/simple;
	bh=goBBsTk2MYrix5HgSc5P3EgwATIoXdXN56gmrYzwOzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TWjzVtSgsN7aZndg5+1oW0jb01ciuleFgkvAskz2N/QnwFtIRN78EyR+67/p1U3aYwKd87E1B0zx50xPjIES42a+MT8lbb/96Pn1cL6/xjDlXI25cfol3Hm65rNLnrin1UqhVt7LQyeZvHOIVaHWB/YK21ICXJlnK1SUjXTfTqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OEJQbLBB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OEJQbLBB"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82990763921so3300247b3a.1
        for <linux-arch@vger.kernel.org>; Sat, 14 Mar 2026 21:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773547779; x=1774152579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRg3BT7wnf4d3IQRMTP80BQdnBv6rSRlNe79T3b3Rvs=;
        b=OEJQbLBBQufw2N7d/fqj3mH73y0py15tlV0VFLVN3CO5u6/V3fgXbxRhZER9BDZsZ2
         u78Ggfq+rBzjIndUT2FvKPkTn/cXhpI5p9hnvCB/doMVIC87p4123PXYSa5X+Qqg7YDn
         rbb5PGJdvCQlfV9aNCE2kkfVr9img3RhOn1DplFCveJ5R1hf4TDA4mKzt2dHFW2zZIT4
         a/1iDQTLSJ2u8hPwaz6L40AMUxKSSXVnU6kMp6pPl+3IgYfQl2aBdxxpR/zIJ/WR2JlP
         D4JDbOki0W/vOYdbP46KEo+d1r0TmL9aHTCmAxoucaWVVKVrZF01/8nz8Tbc1QBH6Q54
         KoKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773547779; x=1774152579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zRg3BT7wnf4d3IQRMTP80BQdnBv6rSRlNe79T3b3Rvs=;
        b=MWpmXuE1RMCHP5b5j4QDIuvAZB89FjHC+A/28v9/fi2jl6vnmBb85kUJb8dEoW2nAN
         36EQPXzKgAF1EKTzJrk3EbCMmT7mQsFb5AW3w6zNDS+xA89sMUB8FQQPADGqAQxK6nTZ
         eNTBVSjhoKMi9dX2zWZZvrULg7mrdfxkP88OclReylnqYVPycFlZjQETtEGcHYSKrmO5
         4+qrEnWxIVjB4mg29ARazn2GQ75NxYdHb34vN5s09b1Brg5qBls7cNUdnDcd36ndrPhb
         3ClZP2Whrn6Cw4wLvzePB5Gte/jcQyOrzzE1qOR6SsiTrYSQ/ON/DMJtcHpKAkgIs13v
         eO0w==
X-Forwarded-Encrypted: i=1; AJvYcCWaKcbhPTqoV6NX05q8ETa4Ycm34pwVmvhFvZnlKEt1KgAp3kXIuuDUcKNhwqcZMWEwL/wNhuZW/uiQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxvpxIt+R5r2FSdlw7bo5f5a9Us3QQgtR3KCGNKh7HbANh9irpg
	dlMr5+gvFvParSyexpMty2NuFncb+vcgNxlGcEfethwd5LhmD0xaTDsi
X-Gm-Gg: ATEYQzzBwtmh1YGnGDGyegRBMPDwHSIFZggREpKDQboE9wTvcsBPGVo2hj5jPDAF9wM
	TFIu/WVM6zcwepJscrsZN0LajZ2+CX/4D/l96GyKwf1CwmhPSn9OlUejv9xwerT5WqWsuA7mMps
	9JKB06E6EGlAxyFKnfXJzPZGckJcTq/ERb9BEmh55fzFDxoiyaoaFwE2f/So5BJTglBE2puhHBX
	XYDLM2qVlBdynhws2lDiNsU4qfJcrlSMUIQbzJP3Hkrel4QfimGNY3o8bALxk1JRZpAtiuYFjLC
	k5+itCNHfzUgxNXMXkn2rbEh7WtNXalpovFLFqJiLGOSVFXNN8qXjK2iG/tkyJPUOT1wJgpETm3
	iCsVWa95jiEHbzWTmS5U6Yxcmxm4R24CAOhd7VQq21VPYDiMBi+oiiJK9yfJX2lsAhN/THLqMBM
	DWH5hsOGwCKcW5z/nMp0WBXQ+3V6PqGG7pOw==
X-Received: by 2002:a05:6a00:3d9b:b0:82a:122e:539c with SMTP id d2e1a72fcca58-82a198456f0mr6696689b3a.20.1773547778975;
        Sat, 14 Mar 2026 21:09:38 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:b50e:ee5b:78d:f26b:704b:c464])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a072449fesm10192206b3a.13.2026.03.14.21.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 21:09:38 -0700 (PDT)
From: Mathura_Kumar <academic1mathura@gmail.com>
To: brauner@kernel.org
Cc: academic1mathura@gmail.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v1 2/4] IPC: Added system call number in all  most common  arch.
Date: Sun, 15 Mar 2026 09:37:58 +0530
Message-ID: <20260315040827.156558-3-academic1mathura@gmail.com>
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

