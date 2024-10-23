Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B731D20011A;
	Wed, 23 Oct 2024 14:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695147; cv=none; b=msaIo2G5FwDduqJkLCEktqYa29D1JoXDqumJi+oJBxyIvgH2Tyr+47nif9KrDe3qMU/pCao1p2DOIRg1F15QcE6nVGbYsXCmbaq2FIA3IIghuuajGiOraUlJ+q/MsKBT735OF2XjrPBYmKUHdxXYl3JtFNhG7zLuw7c1Xpm6SYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695147; c=relaxed/simple;
	bh=d6b2MF8VL+p7bkGL8vqC1T6bqyedUz2TzHjaxlQoFoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tAXCvdmDwEjclWM4pZHEOUBPhYobfcpMySjDC1xodLXD+fqkafD6d6tsxx/wiUTIlgGgGm0DMT6tfo2+f9v+NVx7PYo3pUKzLQamrsZDjHHxCF3mfb3a0WRoOPIVvdY4TQiLCscc5wWULsFW0ltp2eRxOo3ezrGH5R1Xduu8IZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC17C4CEC6;
	Wed, 23 Oct 2024 14:52:23 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.12-rc5
Date: Wed, 23 Oct 2024 22:52:12 +0800
Message-ID: <20241023145214.2559236-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:

  Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.12-1

for you to fetch changes up to 73adbd92f3223dc0c3506822b71c6b259d5d537b:

  LoongArch: KVM: Mark hrtimer to expire in hard interrupt context (2024-10-23 22:15:44 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.12-rc5

Get correct cores_per_package for SMT systems, enable IRQ if do_ale()
triggered in irq-enabled context, and fix some bugs about vDSO, memory
managenent, hrtimer in KVM, etc. 
----------------------------------------------------------------
Bibo Mao (1):
      LoongArch: Set initial pte entry with PAGE_GLOBAL for kernel space

Huacai Chen (5):
      LoongArch: Get correct cores_per_package for SMT systems
      LoongArch: Enable IRQ if do_ale() triggered in irq-enabled context
      LoongArch: Set correct size for vDSO code mapping
      LoongArch: Make KASAN usable for variable cpu_vabits
      LoongArch: KVM: Mark hrtimer to expire in hard interrupt context

Thomas Weißschuh (1):
      LoongArch: Don't crash in stack_top() for tasks without vDSO

Yanteng Si (1):
      LoongArch: Use "Exception return address" to comment ERA

 arch/loongarch/include/asm/bootinfo.h  |  4 ++++
 arch/loongarch/include/asm/kasan.h     |  2 +-
 arch/loongarch/include/asm/loongarch.h |  2 +-
 arch/loongarch/include/asm/pgalloc.h   | 11 +++++++++++
 arch/loongarch/include/asm/pgtable.h   | 35 +++++++---------------------------
 arch/loongarch/kernel/process.c        | 16 +++++++++-------
 arch/loongarch/kernel/setup.c          |  3 ++-
 arch/loongarch/kernel/traps.c          |  5 +++++
 arch/loongarch/kernel/vdso.c           |  8 ++++----
 arch/loongarch/kvm/timer.c             |  7 ++++---
 arch/loongarch/kvm/vcpu.c              |  2 +-
 arch/loongarch/mm/init.c               |  2 ++
 arch/loongarch/mm/pgtable.c            | 20 +++++++++++++++++++
 include/linux/mm.h                     |  3 ++-
 mm/kasan/init.c                        |  8 +++++++-
 mm/sparse-vmemmap.c                    |  5 +++++
 16 files changed, 85 insertions(+), 48 deletions(-)
