Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CBF2D9EE8
	for <linux-arch@vger.kernel.org>; Fri, 20 Mar 2026 05:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773984275; cv=none; b=INQca3JONKXc3lp0syd+ToxHFF0Ebz4rdD1ZpsbpwN4yX6m070xtkZFhVBJiwdAiDN25yEgEWLygRPzTKNZJvZ0zQfN9trW+LhaX2lWVpaBCqBVqvxbSn/LYJVhnnovU+4eKMkugtKpBsqfgodEcrBEKkn5MyG6YXIJ7iJXZAac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773984275; c=relaxed/simple;
	bh=goBBsTk2MYrix5HgSc5P3EgwATIoXdXN56gmrYzwOzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSf3ZdMoKHqDqsRpFO2sIpCxTpisZkM4Xq0EbaLLxtYlyDY88RcC2YmeHNWEjSg7WBkEPooCGu8Hpr6sNcG2Be1dLDv90NJ0K2exFhQGaXMHa5OEm0AdB5flkrlYS7pViMEAjc5Wc0eOyVHJzeRV9qTaNdkOY45h00Ue9EMKFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCEkLMi+; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCEkLMi+"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so540063a12.0
        for <linux-arch@vger.kernel.org>; Thu, 19 Mar 2026 22:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773984272; x=1774589072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRg3BT7wnf4d3IQRMTP80BQdnBv6rSRlNe79T3b3Rvs=;
        b=nCEkLMi+jDbbNvUJzkuxo57/VjPiIc+FpFAn9t5geai+MJsvGDUM01HCwSbhm+9hTo
         eRSz1h4/IL/Cs5NW5PJOJB1R52Ryy1zay2h5GRgSQj9TWdgFB9O7+u0Yik+TZ2QAdiF1
         AAl4vTHBe0SBnZocomKjg5IlfSu85vBzYdY8Fowy48XIzn1cmjM12Yb2UpI0QWfN2qmw
         /E+qE+YXRLtnXCRiCyjFl4gSrpY1eLyJ/JAhzbCil+aMEkao6w02E04bL4vaczm7lElm
         GklLxd+9nI3MBFRJmrVKozr29nAWIpP1Sjlt/bFPfEEdUKa6XItQa0UC8RP5W61Mu7g/
         M/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773984272; x=1774589072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zRg3BT7wnf4d3IQRMTP80BQdnBv6rSRlNe79T3b3Rvs=;
        b=KCYFOIxpSu1CpiUrkr55Xfs/2NR8OLsmcomgVMFZDApB3gJGbCH8Ax+yZM5W4s6T/g
         jkDn6UYbLtVGFfaO7b7HkKlQD0lvR0G1LFc9aTX+4C/jelb4aVYL5DZfTOVmAElJhTsM
         GhoHHqfKQY03K4z5nzoGGbKPZjnHMmPHC9zF5KT6Qf4lKo/qI2css6hf+jEKLhKj7j5a
         NBaVGnnZimMXuz96JcjbD+/cTB8GtYWaYbEG+khgpJ7nNVbz/jPA4KiYVBLGT9k1Pln4
         fcokKjlTLkyTog9AqVz13CqO916A7zVVxEBits29cnPZLH6EzDZ2hQ4ucAIs8D6le7kU
         v/4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVT4UboB/HN6Q/D3hpal2Fc+W8nvlNcS4VHeVtPp+BNC391VQesaYzR4FC4mIb60NWO5EtyppyZ3Iok@vger.kernel.org
X-Gm-Message-State: AOJu0YzLMtSs+aRsEBPA/Kp6lsik2qHVzcsoqsaoi6aUTjJN2YIvrjuP
	B6ZE6J7+eSHIpKfWKa7N3AUOWTlmpx4SlXo4n53jD23Ovxs87PqpmCkq
X-Gm-Gg: ATEYQzxsDKq5kgE9eC9i/TD6ecX0J3VBrnReVLha1tcHgJptwzqed/dgAalZK3P85YM
	IerM1KtZKzLVZjchTrVLvg2C5P3x/zjb+uutQd2QjLRelKmn74w6jatdkqW6vqLFxbPSyffI2Lp
	jq3aOmuMbFFyQW9jPxpeuxfhefeGMLpYTKQxbyxJlT0A6F5Il82mt14+hcnr5Q7ytFKPpB6m4XC
	TlTaB5xX3LI9wBl4DpFdOEq0hX5mvE4+aT/o5RzovKambgP18yDu8ZSnMq9blxWu1gqYmmoYzz6
	cwkLVfBTB4N9Q00YLEzBxn4llEKWhsuCzIO+U1nJUQpJ8n62ks1Zyf8avdMpYmXQrGlMUv3W9lL
	qAUgaE0ZWjBL9stvpcWrISnm9WcZei78GdvE/9p1SFaPDgOp3QZirIqxSzUrFN75PCJ0ts9VPhh
	s9q86E9bYHQ3CDJeUwAekQmEfYi1C7CJoOIjI=
X-Received: by 2002:a17:90b:17ce:b0:35a:cf:64a6 with SMTP id 98e67ed59e1d1-35bd2cee711mr1233840a91.23.1773984272179;
        Thu, 19 Mar 2026 22:24:32 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:b471:fd0e:76f1:2fa0:b416:4f73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd40e4bfdsm779344a91.9.2026.03.19.22.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 22:24:31 -0700 (PDT)
From: Mathura_Kumar <academic1mathura@gmail.com>
To: brauner@kernel.org
Cc: academic1mathura@gmail.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH RESEND v2 2/4]IPC: Added system call number in all  most common arch.
Date: Fri, 20 Mar 2026 10:53:36 +0530
Message-ID: <20260320052340.6696-3-academic1mathura@gmail.com>
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

