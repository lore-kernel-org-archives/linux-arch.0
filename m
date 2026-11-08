Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135902;
	b=SOjGDMonZp4BVh1lHez3yO5NgIKgpc2NfnBMM5k9XLcILwqM9jQZ8IGLgpSWhqN9Ens5
	 QfiwKd6CrQokNI3R2K7G5B0I45nT43mh2xazCnE6Ax+YDYBZoWWJ0fXNNP0LHF9ejc0OD
	 B8U7ZsEnCrjT9XjT2X1XJ8N4xLfhkgGMhxymjiSwyVL749OhuRimLc9gJsZiWlfWeSqc8
	 wDTAVHkiXC2KoU+PQ+I3bBfeiNdhfSc/EoltmCC2z7uNvLdQk91oPTiykk7kfCGLD4Vjd
	 VxFfic2THhQtfI/UhJ9Gv1jJvIIo1lAGFbKrI1Nr7ROyRRMbR2OUaMFmQXlVSRuFcmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KKnJ5ofY6xI7mGRCSoUHzG0stJCP5GNAGXYvslrLiuU=;
	b=fOR1vk2/Apjv6PyKMlZpy7PXRd6+Sf37Uzmm+BDnU7nX3QHYcpetF41YG91jLbNdiuPG
	 ApqRpOwIx+uv7HpGxEbKQ2E4z5oXnue6vfRXYgpIVJg3YPakv7MftQQ1r9EEnWiHGzs16
	 oydFOKxZ5vJHv4bkc6wyOgexRv0Vn00j4+wqcCH8qqHUXQFAioZNpn41U6ICJHK2dk/uQ
	 X3lYPjEnZmHf7+bZx+Racu6+8dPqELQzpr163z0VJKUIax1xdVaDDJRk1bNwhAQccJ1cJ
	 vMo+L5dTf5d7ZIQT+8adY7ynhkFStKZcqeIKNu8tETGe/ru3NGwZa8M58fN8XDUMtTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TYk0twXn;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850A4606A321
	for <linux-arch@vger.kernel.org>; Sun,  8 Nov 2026 11:05:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 850A4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=TYk0twXn
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3acdcfa2bd3so26165a91.3
        for <linux-arch@vger.kernel.org>; Sun, 08 Nov 2026 03:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794135901; x=1794740701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KKnJ5ofY6xI7mGRCSoUHzG0stJCP5GNAGXYvslrLiuU=;
        b=TYk0twXnCSyTPPkgKg6USfYbziaCIK3cHS/cA/JvC7apL4Vzd7htNNdmlrFNMyFOsJ
         QOMpQlBz4gBOtFwLMvHIRpiz5RzuMFoVUq14Hd/SRiz0BvaqyxGgn9JZwnTwKzwBhQxq
         1qudGUWe+mAvLfoRXLgzUFKVTa2DpG7f7E53yZSnbWVuSkJ6P3GfSG5hvrJiHbgTMS6k
         gTXX+UbRhDrdm1uWKkNLqnks842dBShSbnNgkzvAoKVekSirWF5q1z1nOWwx9IwzSnHJ
         ncNGS/ASQkMq/I24P+pGdNRr1SWDOfvc4rtbg3xyLWYAp7GR/HPESpjB+bRj9f+WIlU9
         LIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794135901; x=1794740701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KKnJ5ofY6xI7mGRCSoUHzG0stJCP5GNAGXYvslrLiuU=;
        b=TMmc2abYHxx8C0EzBmmKrmSjPd2Bu7+bg3axKtvf0Fkq1mLAMB7dReMzGI+cKI7LOr
         7iU278lt/n5r/k1rOAP5cKvehC9JVcn8G8zIWboS6JbbUNXK3aI/5MHXROI3be8Jr8Xq
         AwmwZ/+oMhfcnipDWkSBJlP2bxoCV2IRLgrU2RdXvvVjrF0nJaL4MwZIjFIakfflIEnm
         RIIaGXU4NcPgF6/48Kd6tXqljRn21DDM+COB8m9B1xcO2PHbCm4QzdaxrdPbquKvm+vZ
         YLt6k836nPpUDngPrVMA/D5VlCrcW7HvoZaT9AI+7ATfRig9OUIsaRB1jMbwJeCxhSzU
         OZlA==
X-Forwarded-Encrypted: i=1; AL+hErGqo7RjjD3DodLkFoK7iQJ8c4fG220tKHUjSJYVe9pJrgNNzFumZMY2NrcLU5YB1lS9kzKXZ1akLAR9@vger.kernel.org
X-Gm-Message-State: APuU4Z8x7Z4pHvhf5Mc7ckFvEuJo1Ul3k3oKo3epSl6D8WOsklaGb8CX
	ayJSXjDhz77q7zx3MeXk7KPH+lJ6yOwPKn2WL3yoCxdTYFcH2OJJAStRJN7mzn4mm/U=
X-Gm-Gg: AYBFou2hDbl36k2mD5MvD3Jf4Pup4wNWDeXlImLk2UDcR7+n0mk4ZsxD3HyIJApg+g0
	dj/XYiXqCrNirXiKWc9WkVezTvdQU6btu9sAZrDM+no2wrXRrE2aSpemGxCgydluaIKPWxSssJV
	D8bbeXCp7k2Ybj+o8/suKKKBAi0QU3mJWYIciKjXHvrafRMXb+5OwEM19UOYQtl5wOZllmZWn3q
	xONgBru1VWOEaTRXuCzN3l8dH24LdDyJ+/ZjWVu0/Rr2Pz+NA/ZH5Uydv6IOGgG57eXzNT7RMUc
	LwNXYHEI5czWhjG+YAsOMSpq/ZeNLHraEe9n2Z8bkkQYGtO54k506q7B8VfEcCIKhIV3581v2E6
	XwE0gsi00CTsR3tGBFd3del3B4rQEjxaD9d2BEEFrhSNEla5qL6wlRCM6fROH2do7H9YrtpsSIn
	plgISfumsJi24fOtTB4KYVJ3m61N8WGMc4cS5SsWS7PxGje2FBBsr19M1egCxrIFFOfyy0n4Nt0
	0vQm16xr5kTptLS/xXVYL8zTSuBUxEq/ljuvz2oCSl6xwudDoB0hS5lRGNFqq3MccK9DHP+D+2z
	TJ+se6fXXZBo//96Ww67dfUslF4F9OCTkyPe5rHW3fhwAqx9Wy+EguGE2ONnq4c=
X-Received: by 2002:a17:90b:554f:b0:3a8:10e2:ad08 with SMTP id 98e67ed59e1d1-3b12d51f0b3mr872216a91.48.1794135900776;
        Sun, 08 Nov 2026 03:05:00 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1278918f4sm2609818a91.6.2026.11.08.03.04.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Nov 2026 03:04:59 -0800 (PST)
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
	llvm@lists.linux.dev,
	dave@stgolabs.net,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	broonie@kernel.org,
	cuiyunhui@bytedance.com
Subject: [PATCH v9 0/3] riscv: optimize percpu access
Date: Sun,  8 Nov 2026 19:04:03 +0800
Message-Id: <20261108110406.97495-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RISC-V has no asm/percpu.h, so this_cpu_*() read-modify-write
operations use generic fallbacks that disable local interrupts. Per-CPU
addressing also derives the current offset from the CPU number and
__per_cpu_offset[].

Implement RISC-V-specific this_cpu operations using relaxed AMOs with
preemption disabled. Native-width read-modify-write operations use AMOs,
while 8-bit and 16-bit read-modify-write operations use Zabha when
available or a local 32-bit LR/SC sequence otherwise. Cache the current
per-CPU offset in thread_info, keep it valid across CPU bringup, hotplug
and context switches, and select HAVE_CMPXCHG_LOCAL so vmstat and percpu
counters can use the this_cpu_try_cmpxchg() fast path.

On a SiFive P550, Davidlohr Bueso measured about 15-20% lower
this_cpu_inc() cost in an ad-hoc microbenchmark.

Changes since v8:

- Drop the PIO helper patch, which has already been merged.
- Rename the first patch and update its changelog as suggested by
  Davidlohr Bueso.
- Use value-returning AMOs instead of rd=x0 for CPU-local operations.
- Remove unnecessary memory clobbers from the new relaxed AMO and LR/SC
  code.
- Use .option arch,+zabha for the Zabha inline asm, matching the
  existing RISC-V cmpxchg implementation.
- Isolate arch_cmpxchg_relaxed() behind typed always-inline helpers to
  avoid macro variable capture while preserving atomic instrumentation.
- Make the cmpxchg128 fallback use the already resolved per-CPU pointer,
  avoiding the same macro variable capture.
- Copy the cached per-CPU offset from prev to next during context switch,
  as suggested by Thomas Gleixner.
- Initialize secondary idle tasks in the common startup path, covering
  parallel bringup and CPU hotplug, and remove the duplicate initialization
  from smp_callin(), as reported by Sashiko.
- Select HAVE_CMPXCHG_LOCAL in a separate patch.

Yunhui Cui (3):
  riscv: implement this_cpu operations
  riscv: store percpu offset into thread_info
  riscv: select HAVE_CMPXCHG_LOCAL

 arch/riscv/Kconfig                   |   1 +
 arch/riscv/include/asm/asm.h         |   6 +-
 arch/riscv/include/asm/percpu.h      | 574 +++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h   |   9 +
 arch/riscv/include/asm/thread_info.h |   3 +-
 arch/riscv/kernel/asm-offsets.c      |   2 +-
 arch/riscv/kernel/smpboot.c          |  10 +-
 arch/riscv/net/bpf_jit_comp64.c      |   9 +-
 8 files changed, 598 insertions(+), 16 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h


base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
-- 
2.39.5

