Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1E63CE0A7
	for <linux-arch@vger.kernel.org>; Fri,  3 Jul 2026 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783081755; cv=none; b=ivrtjWoL4/YCq7lufeQdnArX21cfY92vR91PZGN1fUiuC6prK9q/M9EcRTZlrNDn+em31TYE8iYPb3z7ShzfVr+WgBH3oCNKX4w4QXnMmdmBDnH82fs0n5HcUge6Hrv1+iXuh6hWyMyi1JPVJNMN/F1tpsqSVUtE5+9p3B5LHlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783081755; c=relaxed/simple;
	bh=3enjAhj+bJCSQm1Q7LRQk1xR8OO/wkxTmZzaOgcPYa4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KGQ5SbjVLnASHJ89eBon7lEoRsvYpod6sWk+ccc+PXFEBAexJki7A27rjnbKVoAiOY2l/SWVh60hHRPLQCDQPaV3OdG9744woBWWudxV61yPfNa7DBh3vDIdm+1Vba6AtVDp8TouYk5O3z20UrDmSqkXNohNJL2smj3j/0DYxOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WkmeyIv1; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WkmeyIv1"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c96d2bebca3so305022a12.3
        for <linux-arch@vger.kernel.org>; Fri, 03 Jul 2026 05:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1783081753; x=1783686553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+VxPGsXEB5teg9HEsa3LZ3vy1Qgi8wQBPtiYzVf6Qc=;
        b=WkmeyIv19WFtZsms5/dPudHOxsyiAC6KOMSXxcgjxTVxkbW+0rJg0HK7s8jcoywfLL
         riGhpZRz5fzR3YDBzKyUSctQzZzoUCJZ/A321WCDFnnlQwWT368rbpGaQnx1Z7xFw665
         8axCiTjh2DMi7xFneknJND9ngbwNNksLz5YoVsKWi7m3/enDRJ6KsQCxbbq8TYxXLaf+
         vWHZF3SHySIP2ICeTa+FstBF2lP4fnYl/9GQp91IxEwe/qO6EWFTPKXI+vZ/XltsiUWW
         cdLVVgDIfCVExdPczXctgvu65hPk23eNpnoM++vZZkJ4MFxT2r/ePTgBovJvkfONHi8p
         2hrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783081753; x=1783686553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v+VxPGsXEB5teg9HEsa3LZ3vy1Qgi8wQBPtiYzVf6Qc=;
        b=s1WSq+X3NgRLFopq4ro3nY2PaxlzxBFPM06dzaaHsMHpL6XfIL1TvfCa4flXXEmXt8
         ejcoYmawyAOGnzllPBaJA0OIORdjNWKkoZETlCuzdRRbqlxct59skBtausZVLa6v3bII
         pYgoOgIzrBKwXNFDyVbVsztdCF7f3RMUkphUjVE2wi5f4xxdPSqwBTTuxUGArmmenYa1
         GwI6Ssc1IgDrqvyNCtTwSqMlttG25wQnnbn6Fnxv6QgMYc3ThXJGI90Q0vhfiRqNq4kT
         +D9fWBqqMERDQsRlJJOGYzOT1jMEF3wFSxRLNe/KeFmCWTqn/AXfEnEE2UTfQSFcaOQT
         v/7w==
X-Forwarded-Encrypted: i=1; AFNElJ/uHEfJbZ2u5cK8npVCPo26TaKTMI+5kn/WExbCbQ+x1mj9gHyhtalc70oNmVXdAd9JCtqU3HUxsePt@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8RDVXW9w3UG6qGjz4W7Txk5guEopGS9uWBWCEOhpDMCjNQ1C/
	07r+7Lo8dtSGR3W15wYtSpRrG1FX7PC7nRIjb4AvkneeYEljijiQWZxOwvq1/GBmHeY=
X-Gm-Gg: AfdE7cl+MLj7Vl59v5rNBcnkN1nt2LWiiKN6lIdwbpV+mO7Xn+ykGckNswCCLeBGFt/
	lgPVn16oeZFsQrziVJWJitb7+48lDpcjSjBIQygyFTwUJPyr6hZF0lsleleFvFpJrStswRqOrdr
	Z5mb2qsKdM4Tvv+8fv9vq7lp1+iqHjzuvYuRltQi6I0WvmrZIyw+KcHFqQPIfLwaDlXOw7g9R88
	GWY3b/I1zzKIJDJpB3ndmNLVSLBCjSX/+d0gGrTGAznmhPDCjY5o0GGbRo7g6UoZeXyaXWHCrjL
	0hchAOcto37h/jD4cRUGGDqsERGyX8cHeC6nh8b0EyS4NRCthbYYwAhSh3z1diHg8c/imCm46Sk
	bLHbU9hfxXaXuWXDzi0rphyvrFikwiNZOmRZn0iI9sdS6WBV+m/DvnzOKrvYR87pl4VrzCao+1U
	DjP/OUsfMTrmkhITCKyenT2FSO2c3rAdVFxrsQ86DeRKKKHbxkAjY=
X-Received: by 2002:a05:6a21:514:b0:3bf:b960:6fc4 with SMTP id adf61e73a8af0-3bfed4701b4mr11795889637.30.1783081752569;
        Fri, 03 Jul 2026 05:29:12 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.224])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9e8f3d74ccsm2705551a12.9.2026.07.03.05.28.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Jul 2026 05:29:11 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dennis@kernel.org,
	tj@kernel.org,
	cl@gentwo.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bjorn@kernel.org,
	pulehui@huawei.com,
	puranjay@kernel.org,
	thuth@redhat.com,
	ajones@ventanamicro.com,
	ben.dooks@codethink.co.uk,
	rkrcmar@ventanamicro.com,
	cuiyunhui@bytedance.com,
	samuel.holland@sifive.com,
	zong.li@sifive.com,
	conor.dooley@microchip.com,
	tglx@kernel.org,
	debug@rivosinc.com,
	seanwascoding@gmail.com,
	andybnac@gmail.com,
	menglong8.dong@gmail.com,
	cyrilbur@tenstorrent.com,
	wangruikang@iscas.ac.cn,
	atishp@rivosinc.com,
	apatel@ventanamicro.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	arnd@arndb.de,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qingfang.deng@siflower.com.cn,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v8 1/3] riscv: io: avoid null-pointer arithmetic in PIO helpers
Date: Fri,  3 Jul 2026 20:28:30 +0800
Message-Id: <20260703122832.15984-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260703122832.15984-1-cuiyunhui@bytedance.com>
References: <20260703122832.15984-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When port I/O is not supported, exposing the port-string helpers is both
unnecessary and can make clang diagnose null-pointer arithmetic from the
PCI_IOBASE based address expression.  Keep the MMIO string helpers
available as before, but only provide the port I/O variants when
CONFIG_HAS_IOPORT is enabled.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/include/asm/io.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
index 09bb5f57a9d34..92d5f831f3495 100644
--- a/arch/riscv/include/asm/io.h
+++ b/arch/riscv/include/asm/io.h
@@ -102,12 +102,14 @@ __io_reads_ins(reads, u32, l, __io_br(), __io_ar(addr))
 #define readsw(addr, buffer, count) __readsw(addr, buffer, count)
 #define readsl(addr, buffer, count) __readsl(addr, buffer, count)
 
+#ifdef CONFIG_HAS_IOPORT
 __io_reads_ins(ins,  u8, b, __io_pbr(), __io_par(addr))
 __io_reads_ins(ins, u16, w, __io_pbr(), __io_par(addr))
 __io_reads_ins(ins, u32, l, __io_pbr(), __io_par(addr))
 #define insb(addr, buffer, count) __insb(PCI_IOBASE + (addr), buffer, count)
 #define insw(addr, buffer, count) __insw(PCI_IOBASE + (addr), buffer, count)
 #define insl(addr, buffer, count) __insl(PCI_IOBASE + (addr), buffer, count)
+#endif
 
 __io_writes_outs(writes,  u8, b, __io_bw(), __io_aw())
 __io_writes_outs(writes, u16, w, __io_bw(), __io_aw())
@@ -116,26 +118,32 @@ __io_writes_outs(writes, u32, l, __io_bw(), __io_aw())
 #define writesw(addr, buffer, count) __writesw(addr, buffer, count)
 #define writesl(addr, buffer, count) __writesl(addr, buffer, count)
 
+#ifdef CONFIG_HAS_IOPORT
 __io_writes_outs(outs,  u8, b, __io_pbw(), __io_paw())
 __io_writes_outs(outs, u16, w, __io_pbw(), __io_paw())
 __io_writes_outs(outs, u32, l, __io_pbw(), __io_paw())
 #define outsb(addr, buffer, count) __outsb(PCI_IOBASE + (addr), buffer, count)
 #define outsw(addr, buffer, count) __outsw(PCI_IOBASE + (addr), buffer, count)
 #define outsl(addr, buffer, count) __outsl(PCI_IOBASE + (addr), buffer, count)
+#endif
 
 #ifdef CONFIG_64BIT
 __io_reads_ins(reads, u64, q, __io_br(), __io_ar(addr))
 #define readsq(addr, buffer, count) __readsq(addr, buffer, count)
 
+#ifdef CONFIG_HAS_IOPORT
 __io_reads_ins(ins, u64, q, __io_pbr(), __io_par(addr))
 #define insq(addr, buffer, count) __insq(PCI_IOBASE + (addr), buffer, count)
+#endif
 
 __io_writes_outs(writes, u64, q, __io_bw(), __io_aw())
 #define writesq(addr, buffer, count) __writesq(addr, buffer, count)
 
+#ifdef CONFIG_HAS_IOPORT
 __io_writes_outs(outs, u64, q, __io_pbr(), __io_paw())
 #define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), buffer, count)
 #endif
+#endif
 
 #include <asm-generic/io.h>
 
-- 
2.39.5

