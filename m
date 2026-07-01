Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3D437C936
	for <linux-arch@vger.kernel.org>; Wed,  1 Jul 2026 04:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782879674; cv=none; b=Iov6Z6pN4dpGr0j4bu8GPKUaVkXDhBF0F6Ls0ogg7VKEVUC4a7Sjy4C8F5qO8S3wi6ZdlRhpqxAcuqq6+tfDipsd7ohub33CM2XAzKAo2sP8QyB2iiH8rVtoMMWynA/KFqUbE2H4LUyKov2GpEeccCCMHctTxf57CpSP6UkyrOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782879674; c=relaxed/simple;
	bh=ndidOr7I8IHgvxf1AeP1Ck+0PatfZjEXy4LWSt++W30=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=aWV/a+INeC/cnWrypQEULdFHrH/RlRuU4J1DmHKCKJz9qS+CE0qP4qda2sR1mkPMZHHnyV76zO14aRE6Kkx0MAnjvmdM9QY792HRP4tviVwr8L9uyiwCUfgq4HjHyhzr/33XNYOm+jZbn5XVki7X5kPpHQ7hLSDuFC2SuieiImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dKtmCoE+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dKtmCoE+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c9f44ddf26so836135ad.3
        for <linux-arch@vger.kernel.org>; Tue, 30 Jun 2026 21:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782879669; x=1783484469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=wIXJacBAyEaKz61QqT13AHUcLwATDSXxJV4uZgWwmww=;
        b=dKtmCoE+cMY+ae/6a2cuOy+r+DPt6J+S4DxJSxhCK/iVk2m5G8zm0VFeoSMS++ijC8
         ZikwGoEKOiyIGXH/IwGqj2V3NbknCEcKa93vP8AMlFJfJIzRpw4PF+yRwt5swNe64yCy
         m8RhGaagOMQX53X3qrgHwEdkmNXf1zbFkYp4UvFI6OerLariet9nHvlCJipDMGvI8O+a
         Qx/5LCScOL9uAio4n0vbpSdNIsot8E59GhGqTIAzcvR2/gQXPZ1FHiPinOZj+rU1Hapx
         YsbNN9SrRkWmJfaKblaBkGbluEZP2ZAqaZSrYdIrNkNt+6xAQbcROLCv/dnKIX1J6FbZ
         dNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782879669; x=1783484469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wIXJacBAyEaKz61QqT13AHUcLwATDSXxJV4uZgWwmww=;
        b=NMm88y0nMQAMnYCHDzDWzTkLkUeZx8vjE+lyEVQLG8aVptuSYmxx0XfFRfp44CSUaH
         s4eBf2fMAyD3XnJ/LAfB8vNGCpFf2f6XIpG1CsAESYkHMNIFW+BnyB04akHe+iCFPDEg
         k/qsdOJ41y1pHhkSI7v5u83yImEf5zTGKkvyTw0WOif+KmHKKL8tNWcacQEcgvjcyG9+
         UW6Jo74NvD+kI1BNMJ4nV8eRammFs3IquZyrAOk/XMal+NkamWdNDYyAUtQW/5VLZzJw
         f5AUeo9yWPJfafwLVrv+hOpx8kx1NCIYXN+3ClrIkwsZ0wSyqBUYkG6PIoWHhPF8az+I
         ZkwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqsAB+7VSc9f16BoEMvzw+WIrLColOFq9boWH03fnC6DT8hwocHD8QfGASLgngsdf8wsErmhLO7JYQh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3BpttbjBQJj6IgOC3wsgXo7yrsUYOT3N/CZhbKUeVPKBdkdJK
	E0vB05GG17px5OLRq0FA+kfOoXoz1lC3cSpENovMGzGzXMZpNsEtNosyZRHM1xIuy4M=
X-Gm-Gg: AfdE7ckEGwNkALIy5eGAq7jAbA6NlpTeVuK3IW5UIQ1I4VOXW7UE8IL9zN91lDzcRZb
	2n5c3NuAbAWGP7XMyuAn0X0CXhiyRmmIpNTl/lVaPVXEl120i1LmENklDUktanSDpegGvuEF6SJ
	tiAOft9eOG7lO4214WT64oYkcVc5kKRONzDS0XOo/jjPk3Q1uWB2fuD1YAnhs0SdC0D5s6XWjO2
	L/xY+M6FbzzJKI5Ne69I9L0cKFqVotRzv4mGWbqqNNm8eXERrPVun6lpXlcbbiuUtwQhtzhesCP
	wTCFRCn0BTDafPnAkEUSuF6WXOIfS+9QRSn+ns5zwZDiWA7+s9eAr2WyIzdLS+VNgToD1BJlBCR
	aS9HqVf51DpIpnLOs7bz6UsWqZWI+kSWVjfnm5e6i+VTJGQD/kyGqWE357ggjUicRtnvtf4k2UO
	JO7Ef0M2MV8cwo4pkAo/T1ptMTON4hMj5vABMHfmpB91SwIQ==
X-Received: by 2002:a17:902:d54f:b0:2ca:e3f:6a4a with SMTP id d9443c01a7336-2ca7e73b1bfmr1201915ad.21.1782879669155;
        Tue, 30 Jun 2026 21:21:09 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37c73a9csm24450865ad.21.2026.06.30.21.20.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 30 Jun 2026 21:21:08 -0700 (PDT)
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
Subject: [PATCH v5 0/3] riscv: improve percpu helpers and PIO mapping
Date: Wed,  1 Jul 2026 12:20:38 +0800
Message-Id: <cover.1782877663.git.cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v5:
- Keep the PIO helper fix local to RISC-V: drop the generic
  HAS_IOPORT_MAP dependency change and the generic ioport_map() change
  from v4.
- Add the missing linux/bits.h include for GENMASK and BITS_PER_BYTE.
- Fix the 8/16-bit LR/SC fallback to mask subword results before writing
  them back.
- Use early-clobber constraints in the 8/16-bit add_return LR/SC fallback.
- Fix this_cpu_and_4/8 to pass the intended operand to RISC-V amoand.
- Initialize the secondary idle task pcpu_offset before starting the CPU.

Yunhui Cui (3):
  riscv: io: avoid null-pointer arithmetic in PIO helpers
  riscv: introduce percpu.h into include/asm
  riscv: store percpu offset into thread_info

 arch/riscv/include/asm/asm.h         |   6 +-
 arch/riscv/include/asm/io.h          |  26 ++-
 arch/riscv/include/asm/percpu.h      | 287 +++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h   |   8 +
 arch/riscv/include/asm/thread_info.h |   3 +-
 arch/riscv/kernel/asm-offsets.c      |   1 +
 arch/riscv/kernel/smpboot.c          |   8 +
 arch/riscv/net/bpf_jit_comp64.c      |   9 +-
 8 files changed, 326 insertions(+), 22 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h

-- 
2.39.5

