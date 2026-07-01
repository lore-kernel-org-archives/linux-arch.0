Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC7148C41E
	for <linux-arch@vger.kernel.org>; Wed,  1 Jul 2026 12:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909050; cv=none; b=V/8hS6jKyW5mGcBu6Cq3mv0UdtLdaSru9DNixiR8jYh+V2jpkUx8yTxE3ExoxGIATpi3u1VWSF0+mYV4NxjY4tXj/EMBkGL6mryXz/UnDXtBRqNeINRrfShxlakxnJhMob5c7NwcEdU3H+hCY4FAdHHTsBIqHgfScw/obFB803Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909050; c=relaxed/simple;
	bh=lmOaxI1RXCMjG8bFhu5Ke54uH3zrNAZJOEhH2v7clo0=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ke72SMOsosMC7prvLmbYut1kkHy1XuWQTPJOYXT9yl9Qt5Fd+GMFAtgKj9M2K3vz7FMf1G5Vi+VB9gf7rKDqkeki6NoBp+5z0UFgllfroGvN/Ksh3Z5wMcIiM9Kdn3ou04juXFXDJ9HWTbKlgiH/Lc900d2LsE8QiUDN/qVeK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bPld6kde; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bPld6kde"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2c82da9504cso2187665ad.2
        for <linux-arch@vger.kernel.org>; Wed, 01 Jul 2026 05:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782909048; x=1783513848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zDd9DofNJHdq9P/rugFQPHi9oXh/6OPbyalY3nUgBIk=;
        b=bPld6kdeWHcVD06nFg1ZnyNLAsj9/drtiLJ2TvvmYQDkZI9C9MWPrExB/xUB2uR2cx
         HOQ1+i2ClQpm1QBYRSBGerH1zJDj2li8g08WP4n0IH0fHoO/ZtRm5lNGuGbqbQmM5GOX
         Q/2ILjnp1uKfDZ3cuD5qDKH9OHzh4Vseti1F+TgU/YSMdegkEG1q9H1fHG3lAM1jicfD
         4tRflBpDetTfUv28JCRLy5trCz1kmguJC5YMXhB5AfXABTSudZxvc+XcwSdR1+FGvXu6
         ke9lXeIRWyycfefgsSuQvq8/nnoZVz1zmlIdJ12BcWhNN1v+Z5S80wU0YQFEYd7VwVtN
         8dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782909048; x=1783513848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zDd9DofNJHdq9P/rugFQPHi9oXh/6OPbyalY3nUgBIk=;
        b=EauWnfh5sStdbIkBEd25LpGhpdac0qnu5bsNhExHS1lcs6GT6O9lrzWhOvdLzjqFhy
         CqfELMVqAgf6SsJ7knQKvQnA3WH8HJe154rUIgjJvLKG09AWKq5HaJfo31c2Niiggtka
         ZxmxiMY0elwUXUqCQEMWllcswaEA/64G4Txq8b5ieq/+0CIbQKiQXhrHc+oXFXCh9LW6
         WutAfCgDyDT56VeaIydB3EqNiE/SLlXO2O0gkIL+sPjHGIUQkDGkkR0o4vDAvddMvWly
         3ZrjEidfvIW6M8qcW5km+j8OA/xq56VwNeikRLSJqHDihYKEdpQG/W+X5OYxnWxvJF2q
         ABQw==
X-Forwarded-Encrypted: i=1; AHgh+RrgMoDreS38B7wKZDeqjaqm0GNRIDXsNJvC2VcPxyPwQJPS8AdkYGpKK31Tght0RGTwU8AoWcxAf3zU@vger.kernel.org
X-Gm-Message-State: AOJu0YygjeRZ7DAcArHORKVkEhjMc/djoAsk0j+gtaFJPYD9ve9fity7
	tuj2DiFDJYyL6PxBO7EN99zvVVutx7FQyxtC1khWMS/3i5zGidUZ2G8Si4LRpg/obII=
X-Gm-Gg: AfdE7cmVEYoaVGIY1OQEkb30hSxkR8/bedCWlqrLZKxJGOmxi3w7W+lxOhjvVOvRlmv
	2hqqG+qBYDuUCeGbNwmYmkC+esWXjC+FKZt4cl0mV4K7Q+dAD6WFj8QGVTIiE5BFpOp8xQXaMWZ
	vdV5kGVSczKWuQcR+4pgKZpgUj214K5v52VUJomGCGjNk3aWa5DCb47WeCY3px9Vn47WmkjozKG
	fjsieNcZXwvg08ykIl1N9kGYjaqm7T4Zxs0fYwdkdrgJXttHxY8/0zrY2hUSu6fv+2/kiX6b8tv
	M4ZPHMjcf35AHiXNwwReOcY49kJm9186q4U+AzSN5ZYA0cdP+GjZRQ68Epru8D26Muu+ZyEwdEH
	+HVMZpQ/1P5tZ0vCHy7VD1mPWiP3NqcR+EpQ8yhQBwANPq0NCwe+6H8o2Q12mmYcGLyvcXuo3OF
	9eBqoIHP/EveH8Ppk5DodOyaAoY6d4lccckkxvJPSecPTaZRoxvWYYSrbI
X-Received: by 2002:a17:902:e841:b0:2c8:be9:1d9e with SMTP id d9443c01a7336-2ca7e86485dmr15171775ad.34.1782909047857;
        Wed, 01 Jul 2026 05:30:47 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca4bae1e2asm25166825ad.73.2026.07.01.05.30.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:30:47 -0700 (PDT)
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
Subject: [PATCH v6 1/3] riscv: io: avoid null-pointer arithmetic in PIO helpers
Date: Wed,  1 Jul 2026 20:29:46 +0800
Message-Id: <20260701122948.57584-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260701122948.57584-1-cuiyunhui@bytedance.com>
References: <20260701122948.57584-1-cuiyunhui@bytedance.com>
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

