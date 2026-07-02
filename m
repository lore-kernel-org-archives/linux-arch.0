Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C02E2665
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 02:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782960915; cv=none; b=RfsaGqD+krz19/fvivcg8sHJD9onglFHhagADZTKS+kg3VcrQ7zaw6cGODAd7EX7zDkUCTlbDW60McpXyR8q9Vv9jU7lyAa5Oq0WOICnDya8wZQ+xmVuc8sHPO4+5iG6a5zY51GuDnapTXHwaHmtYh869Hrn7H/DsxgTUFgeAbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782960915; c=relaxed/simple;
	bh=pGDpUoR+YVfr0eRZnyVNQJ79pTwqmoMZJvjcbiau6fI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=bGnFBTVJmD82yHIY39hDUlKcTlrSVuxbaV3wiyB9N/tQgs//SVPMlPUN0eDZ7UxC8/hu+7HDLzLtpOhkXiOS1tJTYK/FaTG0EUd/x0NDrKvHlPKMLtj+HyJFW5/LltKqh7NRkEuQdk3Piy3Cfiaz9dPsLvADYP6y4We2B/VG570=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fQpWPuvH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fQpWPuvH"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-37ff798fe89so924399a91.1
        for <linux-arch@vger.kernel.org>; Wed, 01 Jul 2026 19:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782960913; x=1783565713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzv59asYaYM1r1NY8KtOkB7QhvGiD1GkLe9qJuyqT78=;
        b=fQpWPuvHjzNRmEEQ5HlNmHfVEbP9DLJw2+BGRgF3E4LLjGu3bKVBcWPmYvFls4rXJP
         TMNM4jxHhxqG2EUlbSu8m+L+FN0x56z80IPEoWEBTdUWPIsulnWbNI+ZSBGZ+9xtUMtn
         C6NnMvRSTcEq/HJuBZ+SFI6MlzF0LGCrei8z4yEjMSWQ1nETxVzStD4LURfsID165aUP
         OhXqhI8Rl6FJPI/Fij2bUyvldq+8BDCJItEBZKODRQJUyRq9lCFH2n/8OChviM8YHJ72
         v/0cS/vYQ/f4MhWykVWiSU5/K44a6aDRLyZc8FAkGARcQXqi+pcBJfp39TLpFqtCWGyU
         IYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782960913; x=1783565713;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bzv59asYaYM1r1NY8KtOkB7QhvGiD1GkLe9qJuyqT78=;
        b=Xgo9wdKstBvWwULONnUdlLnjYIQOcb+LvLqq9TqVycNu5mfSSElnPNPRY9EYoxOfHu
         WIgGG4nkeiVmluD1bSpYMKRTgtlBLcwJRQG3we3Yua2ZAetGtbZGb3rSTCmLDqDFDxhT
         OT5Hw1VZTCkVHkUJ+kdryXyL9IJij/WjoocMMXvqO1LM0YNP9f44QFgXyZwJl+HDRSEk
         cI828KUvnOTIUCUJIIH4c6I2k9iX7iUekRSAKb2gM6DYTgFzhr+XNaHEUv7az50Svlgg
         z/uAlldxU80V9WR6hDbvDql8przUklkHWFWGmkeB6R/V6HtPZOzdJu2I5b1OfC3NiSL7
         pzmA==
X-Forwarded-Encrypted: i=1; AHgh+RpmNaUj1sN0goHlcLJmz+r1S8kyPD20tt0HSoKQGJXjbrypaBz2kUp2pGPC4025YNtcR6IqbrPktsk3@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0YcJZ2DXPkfyEChcWaxND/tMEDjw29cKmvLpKPZX0+uHSHtgS
	xtPashB4JXp6KjRG6/EmXYHxQvDWhXxQmpYVt3PJAvyyPln44Guh1+s76JXBNHvIIYM=
X-Gm-Gg: AfdE7ckWuKISP/fqeftPwOMNleq6uhdhYjvgby+PEq1rgl2L2215dINzVVQ1JFDWxYm
	XSVnrbQT4WHsv6kP6hOdkhJSbBkYjdCvRwRtnQlCpLrku6CjEmwMjbkjIKgQ8BJaarkpoIT4CNi
	hGzSvcfjx0y9Pgwp3V5vYXTXXLLqnm9w7mMEtr8C1nrd5kGscSXDSjeQpoIfCNWFUIL9NpmSdr2
	XP6Vem3H8QssssrPT0zai+py6YbHvO4GexwfwZwi+hd5PODwtljzI0sgyQBYsXP4qdtnhC3AcUn
	Nw20CkTqirtfKUkgZkcv1WYmqxjfkybWhAXEPT/78OlGsT25od+sit9ZqUm2w8H0Npjd6kOzVqv
	7TQ6rYHbHOh0o+v8Q9+/PSlqB6LC3XOZMHkRF0eTMpZ9BOP7rAjmoaiMgH4U0yFdOrOdIfDOIUy
	io0Fzg0aqPAX2tJwhIHPD+EdQkbZFArnHSO+suawetKvEWglcJGZSxq/q+
X-Received: by 2002:a17:90b:580e:b0:37f:f89a:a1e6 with SMTP id 98e67ed59e1d1-380a9e38790mr4709918a91.0.1782960912995;
        Wed, 01 Jul 2026 19:55:12 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0bb80f5csm4358686eec.15.2026.07.01.19.54.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 19:55:12 -0700 (PDT)
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
Subject: [PATCH v7 0/3] riscv: fix PIO helpers and add optimized percpu ops
Date: Thu,  2 Jul 2026 10:54:40 +0800
Message-Id: <20260702025443.83389-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v7:
- Address the Sashiko comment about inconsistent AND helper naming: rename
  the RISC-V internal percpu helpers from andnot to and, and make all
  this_cpu_and_*() wrappers pass the operand directly.  This is a readability
  cleanup only; the generated operations still implement the same plain AND
  semantics required by this_cpu_and().
- Undefine internal percpu helper macros prior to including <asm-generic/percpu.h>
  as recommended by bpf-ci/Sashiko review. This prevents macro leakage into the
  global namespace and has no impact on generated code or runtime behavior.

Yunhui Cui (3):
  riscv: io: avoid null-pointer arithmetic in PIO helpers
  riscv: introduce percpu.h into include/asm
  riscv: store percpu offset into thread_info

 arch/riscv/include/asm/asm.h         |   6 +-
 arch/riscv/include/asm/io.h          |   8 +
 arch/riscv/include/asm/percpu.h      | 300 +++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h   |   8 +
 arch/riscv/include/asm/thread_info.h |   3 +-
 arch/riscv/kernel/asm-offsets.c      |   1 +
 arch/riscv/kernel/smpboot.c          |   8 +
 arch/riscv/net/bpf_jit_comp64.c      |   9 +-
 8 files changed, 329 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h

-- 
2.39.5

