Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3AD377A8D
	for <linux-arch@vger.kernel.org>; Sat, 26 Sep 2026 03:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790395121; cv=none; b=HokhXRbtjinq3VGfgA+19VCx+d7UW7rSS+/h1orEf7DrBkZyIJTP5HbVZ2/o3F35H/7+tfOpWkFSs7ieMrIqRzJAWZBoLKhOgcOYJKYUpS1UwO+g6qx0DdHRe23HdJvL5A/K7270A0LrUpJpC4SZmxQv7fyaWEv0/Fxg+dDVFOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790395121; c=relaxed/simple;
	bh=MaU/7mPDJMeiixRYuVialuhS9Ch9lgCwcXdW+wj4Idw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcUCHPvG2nd5aFfj7ZDYvvVZPswX3EZ4QUu6kZzjMG6M38B44d8uSMuPW3DjM+n3VJbNExrvAbOC46wkOv9mlOBVeAQFirOT4v6nasYmsYt6zASP/rLAxqV2SobEws99vFVmhI5pkZUn54ErUjYPoMCpws8fAFlzad8CjeUlrgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p81xIOeR; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p81xIOeR"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-341d5303884so803832eec.3
        for <linux-arch@vger.kernel.org>; Fri, 25 Sep 2026 20:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790395118; x=1790999918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ps2Mul73UWS8TSnsgDmtr1shDveDexZA9drtRRJEyO8=;
        b=p81xIOeRk0MmahasfL6ycTcubmlNWJevxJGJj2XNnL1GNB1sx8E/IAoGZwRP3PR93n
         vZPE3ubwFCV+jOhDGRVxLf0U3g+e/5SNCe40xZzCW91eMzvtlsud7/xZUFoArLs/0Cxv
         fUYQvuTikNPJD8/nqkso1PxXuZ6KUfKSO0v/GMXQMXAeLP1Ei4V3cL27It8gNvRyshUa
         wQs7z/cYb3ppo0Cefba7wxWpOL/a3je4SCtQmGHIdhu/B9cbIHG6gM5FdTN5ERh1pWWt
         kelcfc8ilZ8ZKFRL8zg8uvRLkJ16OHllmvOQGDcv8dgQy7+LmKmI8cKNL+eNWbrpLUry
         sX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790395118; x=1790999918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ps2Mul73UWS8TSnsgDmtr1shDveDexZA9drtRRJEyO8=;
        b=Z+4vJ6qv4EwhqS7N7/7arWr3Z6NZ3eY73BV/OHYxSQhMuOJUR5DqBF/P0x9lM2zbzN
         QzFhYkw2oQiUnWsNNa+PY3/AQw5qrJfPpAwU0M/vsiZhQ3yWOfn/cVd1Ky14t7NJsZS0
         zCtB6815EcJ+puyGhl/KO22LdjqtiuDsvhqHp1wpWbnUaKeKGV/yrrOCa3ImRivMN4LY
         JpWbV3JwIOfgF3J9OXcsrJ7ijF86VRzoyBX0FkiUXZZHpl7Bksyszn9JhOrHAdKnrojb
         WQfNy6U793ZGs9yIfKK4vO2JMK1hu181Kdndfwjc/HMugoUOeoS0mu3nuYQvY8z5vOc/
         ZQBw==
X-Forwarded-Encrypted: i=1; AKwUvBxPcOWF8I6nPonDYdni3lQfvBaap110C9dQt2LN77fO2aGBTxV6cOds6nHEopfN5YvwW0APJEtDLsrf@vger.kernel.org
X-Gm-Message-State: AFuF++m2yRmR925+SylEW3//A5EwYIeVDF9f5dCiKVI4BI6Zd6DSdoay
	VVL4xsibr861aw/xlzFvViSExAESJKx3oWml8BVtAnbsZ05OeS7zs40t
X-Gm-Gg: AYBFou28jmHlP6t1Pk9JIQ8dzfpxyonLO6Y08TfTFcKy1B9sN+y/BRlcauAEA9DFJ6a
	OcT87b+XtwPt3QK7ozayZmcCdVABDSKUho5h568nhnHtDIEM/2i+wwaq7fu/rjRnsbCUHRb0BHM
	s1ziabf7z5QmgFO8TtEcqzSQHj8sYtFZaoH4yiqYFMR8kr9pR+SfGqVrEfAF5ReFlENeFpktu3w
	koBGqbdQAqXhk6togLqGBFWLu3aVtUXuXpt/44kfWe8rWXLwbEZPVid3WbuTmNlz6NqSoaNaNid
	lwqpvca34fUp+MWswjbHqtotc0Cu6FBUTdTt/TYHTsiNV6u/MYNXOdG64I9pY3e2T01IpTDdHCK
	xoIuCzum/+DlMmE1/RZUMOl3Gj4pGiFQ52IYGiRTzarl33ynzpW19J5ZNYh6oHvZ9qrJqfDg5Tt
	I9aCObpFqoqPuEskS95m24HOJGH9+zH9DJezT8biC6lX1+w13pUv9h6uRTX8dV0ArXAYCPRqleG
	NfiHYNulRi2xQ==
X-Received: by 2002:a05:7300:a987:b0:33b:fc68:9790 with SMTP id 5a478bee46e88-34271a8dd5emr2429143eec.21.1790395117427;
        Fri, 25 Sep 2026 20:58:37 -0700 (PDT)
Received: from Modern-15.. ([2401:4900:8206:fc0b:ca44:7562:7898:358b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-343539989casm364689eec.14.2026.09.25.20.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 20:58:37 -0700 (PDT)
From: mathura kumar <mathura.kumar.tech@gmail.com>
To: brauner@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	corbet@lwn.net,
	mathura.kumar.tech@gmail.com
Subject: [PATCH v5 2/4]  IPC: Added system call entry in all of most common  architectures
Date: Sat, 26 Sep 2026 09:27:01 +0530
Message-ID: <20260926035705.307233-3-mathura.kumar.tech@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260926035705.307233-1-mathura.kumar.tech@gmail.com>
References: <20260926035705.307233-1-mathura.kumar.tech@gmail.com>
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
index 223d26303627..8f92da4e6c86 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -477,3 +477,5 @@
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
 471	common	rseq_slice_yield		sys_rseq_slice_yield
+472	common	mq_recvmmsg			sys_mq_recvmmsg
+473	common	mq_sendmmsg			sys_mq_sendmmsg
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

