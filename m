Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60666313558
	for <linux-arch@vger.kernel.org>; Wed,  4 Mar 2026 13:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632344; cv=none; b=QpFfgaRdk2gWAGg2ah/FMpVY4XawqZVbLq7g704v14FScn6Njphd90SUNVgFMFcHd35jPXWNa/+5QujdgcVBpp96uie8t0KDcc/eT6tpDaHzygBd1J9ZPVHkApjgfrO/zpeiT/NqwH3Expn80GTDIXYZrc6B+RhWXKV5ZZtgjwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632344; c=relaxed/simple;
	bh=HtPwdh/RwoBGXHuJf4+43ZMxxXvBkBrAxyR+gumSlkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sxb0H73wZliaL2NTNY8WzlaeDc06nvMdhsyPCExvz/4GCuqwh0rIEp8lFEt1Hx2bHO6KfBs8DAQpuGIPlmXDcCPEiW06RQpT1k30eXPdENwzSEwveAHgSeXp9vAgCcEEUnTLiFFZ7MsauuPv6s3WkT2Ov7jT87oAvmQI5VDAzM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jYfFK3VY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jYfFK3VY"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae4d48dc2fso14897075ad.3
        for <linux-arch@vger.kernel.org>; Wed, 04 Mar 2026 05:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772632343; x=1773237143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFxAhuVv3JTnbLlSrwYDpsB+eqc6+h6NlWQmCG4zYK0=;
        b=jYfFK3VYuV47MBdlZH33SkgHNqT+ozmkbyU//rR2m2U9t5rcT9JG2ZYnpEfMHGH/43
         AWhXAGyTGpsbxmpIZlWhiCKxVCpl9fJEbWokZ77SEi7WH6By8aldfDDc+/v7ALThY4WN
         UxLDPaq9Qp2vKbGYw+/fIf/48EzzVPEVGV7YM9oj763gNLR+gsNYcOhfbL1QeUkVQEUr
         17D4mwgNwHyruhk9xFD9RHguhct3HwVPxWzt4uZdHZUFRwkrvDKsvDHJh33AsLz6oRTW
         u1/VyWDyuU457zTv2bLWKaFEPsZnczrqD35axvf1CO0L9AQQ5GROjLmdvS10bf9qoEgY
         3pvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772632343; x=1773237143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VFxAhuVv3JTnbLlSrwYDpsB+eqc6+h6NlWQmCG4zYK0=;
        b=cpx2iwFX9yTTFMf0sJ7fO5ko8zOYkLu/09sAFpP4s5q3KN9VJUaFx5Of3ZkVSlq3If
         h41CtmTF00zrUz4VlsmnJ1WVraa4j1IcxC0ex+YEl8qSbJnpZUEDfBRCXQ56bZp7u/5u
         odk4JVJ7K6+ksfaDqDRHp+SraARiAa6kOAwwHrsAs++MBPuwkKLTrE1QRwvHNJzvbLRz
         vdyBUaTqJFuemZ4MPe5D0yRB7vSmhzA6izmOXlqNiKlY3WG6dWOA427iAXl6S7+bVKw3
         7g1S4uow4ioeaTZa/UDGoX+Lv5IfTtbNEIS60MXbFPNsbhZssPiZtND3vMWfhN1JbNaC
         DoGw==
X-Forwarded-Encrypted: i=1; AJvYcCUzMDT2nYfFC2F360pSJHUZUiEumjcYA0mLI8+BLTzNmzJ5zALq/pHYYfsVrJPrEfBHhSaw5R871UoX@vger.kernel.org
X-Gm-Message-State: AOJu0YxRgEZpG/pJY/5jJFSG9GC9pBB52TgxE5Id8Soq9E3qfhz8fm+W
	Mm2+y5iuUH61YRyt0fsGJsmpv1OzM1J4fc927RYmPEMt7czmSLGn7SeRqHcQ27mk
X-Gm-Gg: ATEYQzy9ewd0LkL0FCPz2DvzLnjy2V/uFCVndxi8d8E7JSYpaItTvs5kp85lSP/GZY6
	acLcmT8tFLn+fHa0sRjPm3U5Ecp34tns3nSUICyhIJ3XOjODOB55pdMMlEAS12lq15GrBH10Lso
	Ntcu2SSNgORckuTUfV/vY23vfh75NsCGdMQoBWZ7Rri+6pMkNP5MLj0ulNzVdbNMv0VSCu77pdd
	I8MygbxF87qtvBX0bFoXwUCL+eL3s4Yh+MHUEVucTfnkJthqlyilxo7ty6N/YkMEXsbTeYnqPvq
	4eW4xGGvJtu5KoPw8Zq5r0+cURTPGSVRM7ssi7fccQ091DlHXfa1TN8dQb0y/mjrb/QdSlrLq9w
	pby5+EZD7YCb6M0ECT8Tv258eSM1R4eR/f4nKNLwY3SGpp6xm+BBXZFOkMtGZEmtFGhyUI9agbz
	8voDLX1JMG9pEN6GRJYXsAElRFPKhw+Cvj58/6nlibYHRa
X-Received: by 2002:a17:903:19c7:b0:2ae:670e:309f with SMTP id d9443c01a7336-2ae6aaf6261mr19825925ad.34.1772632342691;
        Wed, 04 Mar 2026 05:52:22 -0800 (PST)
Received: from Modern-15.. ([2401:4900:86f4:d8e0:8d8d:c166:cad9:b4a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6c4dd0sm199264225ad.70.2026.03.04.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 05:52:22 -0800 (PST)
From: Mathura_Kumar <academic1mathura@gmail.com>
To: brauner@kernel.org
Cc: academic1mathura@gmail.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH 3/3] [PATCH]-This patch series completes the implementation of do_mq_timedreceive2 new        system calls that provide non-destructive peek functionality        on POSIX message queues
Date: Wed,  4 Mar 2026 19:21:23 +0530
Message-ID: <20260304135126.77270-3-academic1mathura@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260304135126.77270-1-academic1mathura@gmail.com>
References: <20260304135126.77270-1-academic1mathura@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v1 of this series  was incomplete — syscall table entries for several
architectures were missing, and false postive warning. This addresses all of that
and has been tested on x86-64 with all tests passing.

 Patch 1/3 — core implementation
 Patch 2/3 — RFC about false postive build error
 Patch 3/3 — remaining per-arch syscall table entries

All older patch was still seem unseen/unmerged so for convenience i am including
all required commit of previous patch with this.

Architecture support: ALL Ready

Signed-off-by: Mathura_Kumar <academic1mathura@gmail.com>
---
 arch/alpha/kernel/syscalls/syscall.tbl      | 1 +
 arch/arm/tools/syscall.tbl                  | 2 ++
 arch/arm64/tools/syscall_32.tbl             | 2 ++
 arch/m68k/kernel/syscalls/syscall.tbl       | 3 +++
 arch/microblaze/kernel/syscalls/syscall.tbl | 3 +++
 arch/mips/kernel/syscalls/syscall_n32.tbl   | 2 ++
 arch/mips/kernel/syscalls/syscall_n64.tbl   | 1 +
 arch/mips/kernel/syscalls/syscall_o32.tbl   | 2 ++
 arch/powerpc/kernel/syscalls/syscall.tbl    | 3 +++
 arch/s390/kernel/syscalls/syscall.tbl       | 1 +
 arch/sh/kernel/syscalls/syscall.tbl         | 2 ++
 arch/sparc/kernel/syscalls/syscall.tbl      | 3 +++
 arch/xtensa/kernel/syscalls/syscall.tbl     | 2 ++
 include/uapi/asm-generic/unistd.h           | 9 +++++----
 scripts/checksyscalls.sh                    | 1 +
 scripts/syscall.tbl                         | 3 +++
 16 files changed, 36 insertions(+), 4 deletions(-)

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
index 94351e22bfcf..bcec28be852c 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -486,3 +486,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2		sys_mq_timedreceive2_time32
+473	common	mq_timedreceive2_time64	sys_mq_timedreceive2
diff --git a/arch/arm64/tools/syscall_32.tbl b/arch/arm64/tools/syscall_32.tbl
index 62d93d88e0fe..02603704231e 100644
--- a/arch/arm64/tools/syscall_32.tbl
+++ b/arch/arm64/tools/syscall_32.tbl
@@ -483,3 +483,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2_time64	sys_mq_timedreceive2
+473	common	mq_timedreceive2		sys_mq_timedreceive2_time32
diff --git a/arch/m68k/kernel/syscalls/syscall.tbl b/arch/m68k/kernel/syscalls/syscall.tbl
index 248934257101..b67f23edda11 100644
--- a/arch/m68k/kernel/syscalls/syscall.tbl
+++ b/arch/m68k/kernel/syscalls/syscall.tbl
@@ -471,3 +471,6 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2		sys_mq_timedreceive2_time32
+473	common	mq_timedreceive2_time64	sys_mq_timedreceive2
+
diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 223d26303627..89fb60006a99 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -477,3 +477,6 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2		sys_mq_timedreceive2_time32
+473	common	mq_timedreceive2_time64	sys_mq_timedreceive2
+
diff --git a/arch/mips/kernel/syscalls/syscall_n32.tbl b/arch/mips/kernel/syscalls/syscall_n32.tbl
index 7430714e2b8f..fee830be67a6 100644
--- a/arch/mips/kernel/syscalls/syscall_n32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_n32.tbl
@@ -410,3 +410,5 @@
 469	n32	file_setattr			sys_file_setattr
 470	n32	listns				sys_listns
 471	n32	rseq_slice_yield		sys_rseq_slice_yield
+472	n32	mq_timedreceive2	    sys_mq_timedreceive2_time32
+473	n32	mq_timedreceive2_time64	sys_mq_timedreceive2
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
index 128653112284..8694a2d2f084 100644
--- a/arch/mips/kernel/syscalls/syscall_o32.tbl
+++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
@@ -459,3 +459,5 @@
 469	o32	file_setattr			sys_file_setattr
 470	o32	listns				sys_listns
 471	o32	rseq_slice_yield		sys_rseq_slice_yield
+472	o32	mq_timedreceive2	    sys_mq_timedreceive2_time32
+473	o32	mq_timedreceive2_time64	sys_mq_timedreceive2
diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
index 4fcc7c58a105..fd90a2f500b6 100644
--- a/arch/powerpc/kernel/syscalls/syscall.tbl
+++ b/arch/powerpc/kernel/syscalls/syscall.tbl
@@ -562,3 +562,6 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	nospu	rseq_slice_yield		sys_rseq_slice_yield
+472	32	mq_timedreceive2	        sys_mq_timedreceive2_time32
+473	64	mq_timedreceive2    		sys_mq_timedreceive2
+474	32	mq_timedreceive2_time64	    sys_mq_timedreceive2          sys_mq_timedreceive2
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
index 70b315cbe710..1796ccd23d10 100644
--- a/arch/sh/kernel/syscalls/syscall.tbl
+++ b/arch/sh/kernel/syscalls/syscall.tbl
@@ -475,3 +475,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2		sys_mq_timedreceive2_time32
+473	common	mq_timedreceive2_time64		sys_mq_timedreceive2
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 7e71bf7fcd14..5cfde6e0e6ba 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -517,3 +517,6 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	32	mq_timedreceive2			sys_mq_timedreceive2_time32
+473	64	mq_timedreceive2			sys_mq_timedreceive2
+474	32	mq_timedreceive2_time64		sys_mq_timedreceive2		sys_mq_timedreceive2
diff --git a/arch/xtensa/kernel/syscalls/syscall.tbl b/arch/xtensa/kernel/syscalls/syscall.tbl
index a9bca4e484de..9f69ef99e617 100644
--- a/arch/xtensa/kernel/syscalls/syscall.tbl
+++ b/arch/xtensa/kernel/syscalls/syscall.tbl
@@ -442,3 +442,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_timedreceive2		sys_mq_timedreceive2_time32
+473	common	mq_timedreceive2_time64		sys_mq_timedreceive2
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 1d27fd3e118e..ecfad24055b3 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -863,12 +863,13 @@ __SYSCALL(__NR_listns, sys_listns)
 #define __NR_rseq_slice_yield 471
 __SYSCALL(__NR_rseq_slice_yield, sys_rseq_slice_yield)
 
-#undef __NR_syscalls
-#define __NR_syscalls 472
-#define __NR_mq_timedreceive2 473
+
+#define __NR_mq_timedreceive2 472
 __SC_3264(__NR_mq_timedreceive2, sys_mq_timedreceive2_time32, sys_mq_timedreceive2)
-#define __NR_mq_timedreceive2_time64 474
+#define __NR_mq_timedreceive2_time64 473
 __SYSCALL(__NR_mq_timedreceive2_time64, sys_mq_timedreceive2)
+#undef __NR_syscalls
+#define __NR_syscalls 474
 /*
  * 32 bit systems traditionally used different
  * syscalls for off_t and loff_t arguments, while
diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index 1e5d2eeb726d..605a65cfa144 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -104,6 +104,7 @@ cat << EOF
 #define __IGNORE_recvmmsg_time64
 #define __IGNORE_mq_timedsend_time64
 #define __IGNORE_mq_timedreceive_time64
+#define __IGNORE_mq_timedreceive2_time64
 #define __IGNORE_semtimedop_time64
 #define __IGNORE_rt_sigtimedwait_time64
 #define __IGNORE_futex_time64
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index 7a42b32b6577..7a09cd65cd8d 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -412,3 +412,6 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	time32	mq_timedreceive2		sys_mq_timedreceive2_time32
+473	64	mq_timedreceive2			sys_mq_timedreceive2
+474	32	mq_timedreceive_time64		sys_mq_timedreceive2
-- 
2.43.0

