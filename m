Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173B137C109
	for <linux-arch@vger.kernel.org>; Sun, 15 Mar 2026 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773611277; cv=none; b=GVr9x8Ue+WKabxqUkzTkqczOiFQPymMJmzIINbpkqQCCI+Inl+7VLAaWRjV6XEL/EjpBAa985NrHNfMl7gGveXdys0vGSAD/D9YIBmywvmc/SwCeKrKATYakg1xgiSy2N6juBfYhXvrfIFs0/Nl+D8Mq6lm/o7tmLBSCXJHS95g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773611277; c=relaxed/simple;
	bh=bBQ8eU9COzhoiSE8iroJ9UrjlJbEQHeRPmWx2f4Tifw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/GUNiR/FhbKJOrne27bX2RMIhDHhBIYFAXSTkIlOrIXzPpJQN4tvP72M4S68aWCCI6g9H3eFCTSLQpjZXDpyXjiE2sVL+TQy+liJGYkXrKK5qfq0P2ubp9A/p8JZqrP574zrgoAFRJwOcIL/PT1QNCbCF9R/qxxBpuIXTCsQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3taf9ac; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3taf9ac"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aecc6b0861so13520695ad.2
        for <linux-arch@vger.kernel.org>; Sun, 15 Mar 2026 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773611275; x=1774216075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o072AjhwxnOu54vKZkT8gFGqCYJjeQUma+HHruoaLvA=;
        b=e3taf9accPmWURAzYG469Eru5nh/a2tRQLQyqnquUI2UtDGRg58JaNdlmgA1Omy9m+
         OHujSonoGBsgIgjNHEt4LZxB1ytoKAmMLxzOwjTrAf5uPNfEbWgqzSLtYSUQ2xBd8OzY
         bPt3e12NMepz8MYC698vSXJTCkygzSxplTG2djSqvAqznfypI+oXJU30ZSf7+EYlIlUZ
         zeK3w6JNjBOO5lSzMcIM451o/Ss/heP0U6MBYPbBMoINEaCW5DIHWbrFjhvP2lIRB9BQ
         LUM7m1bVpHqRt1q39BmYxqHCZH7GQDHoXXBHScUZwS3ySv6U2i38D9QMnz/QRR0Gl7kI
         mAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773611275; x=1774216075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o072AjhwxnOu54vKZkT8gFGqCYJjeQUma+HHruoaLvA=;
        b=mPVaePl7+i30R3e4bzw/7iwUy5qh737bNz2nTqXQIb5STbGxVHJVu/flqFJrzJgTfs
         vgwF19pBrjGCTTti/dm7Ibd3rYeHAsv1kYSDKOHzZQB8aZBfXLNxbMkIivtlobwg3elE
         l7I2L8Y/XmMsPTanXdLFOVvynkcsvhl1yRfDzIMGmaGT0NF8UG3R5bauRy64ZwrvGek8
         PfDzJjpWNXgZIZTQF3i1uwYefoCLC1IT3+eyPBpEiW0F/JFym0s4Ljn4/BqM7mOId1OC
         9iebw2DnAdxSXwpdWUmLzCsmAay6SOHA5BdsTqsxBklRglYW0maxsY+Sa5PTPHwtRpL5
         MbLw==
X-Forwarded-Encrypted: i=1; AJvYcCXqKcv5VpIj7+gQjVH/P78a8+VNXijjLTxqhzrmgUTVeGizlLhv4z3GUUOEwJ0NZGnpAlCSO78ngM5E@vger.kernel.org
X-Gm-Message-State: AOJu0YwMt/0buwL3YK8lweEhb+2tMuY+2+G2faLiu9vYsJ2ErRJ3gKbK
	KgHziMuJxHlEqEDZczlfHVgtPTRq/gnfwiqPL152zsAnoYXuZi8QwwDhQEO5Bg==
X-Gm-Gg: ATEYQzy1LYuNLMCwzAabpXv8aNdEmEWoE7O2RovXPBqjZIVhbVgqbRsCOiKbFS+pD7u
	NrZgi97uJSgAKgnisK6+t711wnj79tBVi3OjIAcAR1BYnkX6q36aCNysxMoIX83sBI5/zeG0ZEy
	cZYywEhqAMQA4xPiaE3XdR7YeCyBvsRQWpiW9g5ujm+mAyuQz7BjNSpU0xCewFKOG2ECfsqYBGf
	bgB3Tg3iiZxKKCXpP18R8+eNe3Q3Eq6K2xsvkRiaoD2gkz3OW5/KEdxh1ZDBmadPazhcGkvPJRP
	zHXuapjGg905LxXHFcbo7qwTkpf04EZp3iuzsxzHmiwgVzGpq/uTvCe2GWgk/n8Jj2pb2sQk3r6
	mYnH8u0T2HJm8UWnsEHbyCBPBN+eWTpxzriaup7SD23JfRzAeRhPcYyjYSfMtX3YbV/JELLFEDZ
	WhkQPOmy2e5YnecFZQrR0GKNm9peIJqS49v/I=
X-Received: by 2002:a17:902:daca:b0:2b0:5520:f4a0 with SMTP id d9443c01a7336-2b055210ab4mr19571845ad.11.1773611275367;
        Sun, 15 Mar 2026 14:47:55 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:b4fc:c14c:ba99:ba0e:908b:8404])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b04f40f515sm34153085ad.74.2026.03.15.14.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 14:47:55 -0700 (PDT)
From: Mathura_Kumar <academic1mathura@gmail.com>
To: brauner@kernel.org
Cc: academic1mathura@gmail.com,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk
Subject: [PATCH v2 4/4]IPC:Added  entry in performance tools for new  system call
Date: Mon, 16 Mar 2026 03:16:54 +0530
Message-ID: <20260315214656.658590-5-academic1mathura@gmail.com>
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

