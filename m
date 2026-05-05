Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D829F3B7B98
	for <linux-arch@vger.kernel.org>; Tue,  5 May 2026 06:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777962057; cv=none; b=tjdm5DPNoj4ahhY9VEJX8GorUa9bqw047LSrRY87JdeymAn6CmQQjsxgCnPQl9GTWWwndHEjSEM0g/SiyAePlbipIv+ay+s7MOs61f5QhjAU5bzDOvMgTYamV/RGM6y0TcbPk2XGPNNipDqNCbw0DIUhvmOjQHWMj9VRjkzDcmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777962057; c=relaxed/simple;
	bh=1N/LGKwuOq9v0S6+Nwko/9VEdnuS/5VPERf1X8fCvxQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aMe0JswkzhvE9bBIz9ym/K7nmJn1JhvDOddM2wfXNOf2gr9ErF0oy04eJsLYWy0kCGBOP5m9gwcM7GYEhG2umt2hSQ2usxrNdjpFTu/kLiHzAvDQTAnpRissA2Wt/u2ZR5QoQyCgy37kq8e5VAPl4OjYKQAuRFnu/m8GQ3H1LGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=FsV0MrSy; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="FsV0MrSy"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82735a41920so1744100b3a.2
        for <linux-arch@vger.kernel.org>; Mon, 04 May 2026 23:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1777962053; x=1778566853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IABxPdOKi9qQ0ncIcorYGTDUXVbyRSpLw0RRqytGSAg=;
        b=FsV0MrSyX4dGKdiYBjvMJ9Znh2XOJdS0ondvQExYTP/ZZvjB8PFlRxVXsvQ2IST+v/
         h4JNWJmC4ZCQ5jEffyic0zd+xwMdDY/d+ZzBH8PnaDVNWWQXODeTiIKoeTkYxZ+w8rYE
         7COZbfLpHfZ8mRvW/5y6Cq+4gS+QUZIlRUvxbdtULto8pFG6ehbE0K9kf4WhvzFiGSh+
         3I04eNkiw16xvQ5s6p9sXiu0PsDhPx3aUaxpuJGqFhAtSjTP78ZYb+312t9kv9atG6+t
         lSkK4w2SBUNCyEshTZJlAa+b2xDOL8og2YFR25EhQCa2tP8xQ7G1LYn59+hc8dufgRwq
         93zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777962053; x=1778566853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IABxPdOKi9qQ0ncIcorYGTDUXVbyRSpLw0RRqytGSAg=;
        b=N+vW17w4TaG5y9xoAZMaPEzJvo9eKtyS5CUlZbmCQFgf1g3x0NfihRZ2kgSyTkxihY
         63MkIdZUWQ0lB/DeNKKqxPReJ6uYrieC6mllu+8yUEKmZEEGj3SKzHRHJp7bfk9MHwUh
         fNjF7BlFyC1sOC9XQvi36tx+xgfuQG5fubKayFSJT0EY5iyWm798iUxqHSEbFdx73qiO
         w7eXMPZgB6gfALisy1ZT+XsyaHuDj4H210ic3O0s99Q3qG0hJqDa+3ruSa6+g0qgZiYO
         f2Zxr0x57cVFMJS6IyUA9LHmjk2M9C1UhTSXKqjcxOO+gp4oJWUVK0/g/Nh88SZRx+8v
         DdHA==
X-Forwarded-Encrypted: i=1; AFNElJ8TbPj29adnyGIHRHUgIqDqdGtNCyLrCVUGvPNVYtKFy6dGqgvdeLtyTGoiWAa2UqjH+iw9ocJYTx76@vger.kernel.org
X-Gm-Message-State: AOJu0YwwFHf7sGcLc/NxXxMVMsqSOCAPeIC8HPetDUOkmslX10wh9tT8
	lr2kZgp8bDhEyrO5WBO4ipTnweDKpaTKX/27cju74L1iX5z9b4pWpvYVCYdcmcCT7XQ=
X-Gm-Gg: AeBDietnToO/C8TKlN7DbspuG79i4w4SspdXiGo0HmtFrV8ulrJW7oTDmmAa7cL/m01
	J8t6Fx0RAVTLL6k19GcEGAkkL8m6+HqnpZsQmF4APkgag0OpwFP+jHs7fYFCKUDKIV4TC85VKpE
	8yv7oJlaw0LUwPsxxOFbTPJiFA7yIeqA+PY2KT0TGIxl0/9BYVPhBq7J6BND6fpjH9y7VebBS4H
	eXRsgm2amz0/WFMeZMzNgM4ww0FLILkg7vhc8pJKUM4h9zyHEeDxTfVGuxePa4hagYxiZ+DU1ui
	Fsh7lqTUj9nb6VW1y8bO+tLPdmRGRsRSlQMH/ht9QvNE5dSEvZxS3ETtqfkY4o5qTVYMdDXPmKH
	0TMTn9LNB09cz7V3Lxs5UhemZQjTMIlErTUs/qq5/ky8+/nrXHGfdMYB250GVAfgu27zn3mNtl2
	q5qPfYKgp5jWW81xod9raNdMhVIuwDmB3tSqx9uVQCwRVMxfutqUoJ+q6+QQFPzxgv
X-Received: by 2002:a05:6a00:c8c:b0:838:3f54:a0ee with SMTP id d2e1a72fcca58-8383f54a1aamr5208071b3a.7.1777962052522;
        Mon, 04 May 2026 23:20:52 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839679c8c10sm880738b3a.37.2026.05.04.23.20.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 May 2026 23:20:52 -0700 (PDT)
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
Subject: [PATCH v4 0/3] riscv: improve percpu helpers and PIO mapping
Date: Tue,  5 May 2026 14:20:23 +0800
Message-Id: <20260505062026.91724-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series makes three small RISC-V cleanups and fixes around percpu access
and PIO helper handling.

This work is motivated in part by build reports from lkp and by follow-up
review/discussion around the percpu access rework:

https://lore.kernel.org/all/202512202218.FI6bB5kV-lkp@intel.com/
https://lore.kernel.org/all/202512210052.w0bpUAAO-lkp@intel.com/

1. Avoid forming invalid PIO address expressions when I/O port support is not
enabled, while keeping the generic pci_iounmap() behavior intact.

2. Introduce arch/riscv/include/asm/percpu.h with RISC-V-specific percpu
helpers, including the fix for the 8/16-bit add_return LR/SC fallback.

3. Cache the percpu offset in thread_info so percpu accesses can use it
directly across the relevant RISC-V paths.

Yunhui Cui (3):
  riscv: io: avoid null-pointer arithmetic in PIO helpers
  riscv: introduce percpu.h into include/asm
  riscv: store percpu offset into thread_info

 arch/riscv/include/asm/asm.h         |   6 +-
 arch/riscv/include/asm/io.h          |  26 ++-
 arch/riscv/include/asm/percpu.h      | 284 +++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h   |   8 +
 arch/riscv/include/asm/thread_info.h |   3 +-
 arch/riscv/kernel/asm-offsets.c      |   1 +
 arch/riscv/kernel/smpboot.c          |   7 +
 arch/riscv/net/bpf_jit_comp64.c      |   9 +-
 include/asm-generic/io.h             |   4 +
 9 files changed, 326 insertions(+), 22 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h

-- 
2.39.5

