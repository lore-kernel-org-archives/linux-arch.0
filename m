Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527AD4A2E35
	for <linux-arch@vger.kernel.org>; Wed,  1 Jul 2026 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782909033; cv=none; b=P/4Mvhpt9oJ/cQYvbsZS1bzkQjimKRY9N2oV0r15iNaBGr9dH9Kv5NERuzj8ZdAWL0FhlgHx7xhQEUXLpLlpfEkiKvDRH3XqFk9Q36DSn5ufY3opl4PBnZhCrWL0D1Ov7KDtl2fXd905T4JNnk9tyUeo1BsuT6PLP8gRuZ3P6XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782909033; c=relaxed/simple;
	bh=ZjWVD0tSQ1mhVm/q0JGy6VGtAnh9yMg+FOzzJVCwjsQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=uOZsk2frf7mlJ/vXdkfScmsS8iQQhUQno2uVpXJZZUy7xeMEqMNeV3ThnCe1AHSLixAWEzUNqkIVcyj6v684YUju61jgit0UR5uO9sgba/ZSvBHIuZ9JvpOngj8IGXRCEWGfBrHza+ANPL8GV/9cRUxhIMZM6Tt4680POavQxXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RlorFXYE; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RlorFXYE"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c99672293cso3673675ad.2
        for <linux-arch@vger.kernel.org>; Wed, 01 Jul 2026 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1782909030; x=1783513830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=J5IzwYzPDTeWx7tKr7hSDF5l+BLDO1MD+S8kZpieZcM=;
        b=RlorFXYER/EHRQzx3IGHWl9SwBRtuttV2zpJ9Tcfo7IRhAgnNN9+2vgTLLwD/sjfBv
         ctaKxML9I4FKtKJ1xiIOscGW5tbEsHuv6l33+AQ3MxuQDepCM3WJx51gyHK2jeQPCmaX
         9DKQL6uSp5Y+YYHGX2Ka5GpD28m8hdu73bxL2oW4m2qjWka9MGRRJMUwAnRx2zs6OSpK
         a0LpqgRsrvusiW7c5F5E4GhF5CabXRsr6ONN0w4ZmQil88dYcuUTkdBfLIgiixOmQH6n
         1fghPFQyOkhhTd1zEef7Zl0dnZVtDt1TU6Mw38mhMnJtWESzAYSBPeIc9oYjE/6JY0C6
         awMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782909030; x=1783513830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5IzwYzPDTeWx7tKr7hSDF5l+BLDO1MD+S8kZpieZcM=;
        b=haX2zInDWfzDi8pdLwyKXjj13XZ3kVZnIXr6VlgLbUuwFWsRcWNRNEZiz1y6mhhTF4
         ZEIzLJeqgSCHz1bBki4sLdDcsaaoPbWQMgB8y0jCYMD9XgT2afCXAp/Z8tmXEZzFQVwM
         LwKXRdo4l5HO+xtoE04oiHhzMroLn7ZzhrhqjepyCPlx40Wmm/g3GnnWpnf6UqyQzZax
         2wcbuaD0JWaVTL8ulbyW+gNX1Bl003d74cxB+alFFa+2iPNqZ89OClAS1O4rSv8Sxs0o
         IwSNFtlApC6PVsxxtMZRlMY44gSe28RADQdUkMQka11KBQDbt1Smf3XFXq+vRyf462L1
         rO8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrMgzQAv1MzK6jc31ltFiq3MD+oyW0b6GloZr6cS7KfYA/JuBmiQYHNLNRdRWafi0ER441GH5ruqnT7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4sK0T+bi92HnZVvJHPDULQuSiXjK1C28sixbou/1iX+JpEWCy
	Ft3Db2rHCr/ioLezqPfflcs+w/V7CROOrJRDEydIRavP+bAb3jq0uZbx+hSkRbhXiGs=
X-Gm-Gg: AfdE7cl6R/q+3rA+Q8jRvQGU0xO8/pI0Phot6nVo9wYD5lPa+Tbq0V3gmmDorReP5sX
	+X1doLEfRwjn1f2uN4AA8ada0FiUZssT2A3uQkZK6i735IzRJCwJ+7vadY0iLHungvVu8woLWkN
	Db8HKObyf86rD2HOo8lg0B8+MoGB4s4b4KbHfLRISKbD9rqzAGSLLIIr1kelTtKxyr3F2FnYSMQ
	8GyQ/t8U5Ul72zU/ELKBaHexb5AxDH3kFK4v/8y45GMHRrnXUvaJ6FmbWvko3O/Sr9Ip9eaPsS2
	LapudeDAYdCJiZAdIdT88arlU+zFw3aXK/qeINgm2PnKdqTzIaIDRM59xqWgEARWXFYsbgMx5ea
	OoTD4MbWgjWzV1sJY2i2SSRaFPqumMqfByTp+i+I4moPh0FlLLmeEDwEhRNNjxeWj0lLd1EbRge
	xCzaHdTg9e1h2h4gaUMOiUxVByPTGxJEjRC97q8PySpFCeQlb5UIBJPAQr
X-Received: by 2002:a17:902:d549:b0:2c9:c991:3bf0 with SMTP id d9443c01a7336-2ca7e682ad6mr16606255ad.8.1782909030457;
        Wed, 01 Jul 2026 05:30:30 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca4bae1e2asm25166825ad.73.2026.07.01.05.30.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 01 Jul 2026 05:30:29 -0700 (PDT)
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
Subject: [PATCH v6 0/3] riscv: fix PIO helpers and add optimized percpu ops
Date: Wed,  1 Jul 2026 20:29:45 +0800
Message-Id: <20260701122948.57584-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v6:
- Drop the extra PCI_IO_ADDR() helper; directly guard the RISC-V ins*/outs*
  helpers with CONFIG_HAS_IOPORT.
- Add the missing <asm/cmpxchg.h> include to arch/riscv/include/asm/percpu.h
  so cmpxchg_relaxed() and system_has_cmpxchg128() are visible.
- Clean up the two 8/16-bit LR/SC fallback asm blocks to use consistent
  old/new/field variable names.

Yunhui Cui (3):
  riscv: io: avoid null-pointer arithmetic in PIO helpers
  riscv: introduce percpu.h into include/asm
  riscv: store percpu offset into thread_info

 arch/riscv/include/asm/asm.h         |   6 +-
 arch/riscv/include/asm/io.h          |   8 +
 arch/riscv/include/asm/percpu.h      | 288 +++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h   |   8 +
 arch/riscv/include/asm/thread_info.h |   3 +-
 arch/riscv/kernel/asm-offsets.c      |   1 +
 arch/riscv/kernel/smpboot.c          |   8 +
 arch/riscv/net/bpf_jit_comp64.c      |   9 +-
 8 files changed, 317 insertions(+), 14 deletions(-)
 create mode 100644 arch/riscv/include/asm/percpu.h

-- 
2.39.5

