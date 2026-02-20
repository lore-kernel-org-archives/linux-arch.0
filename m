Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC37321F48;
	Fri, 20 Feb 2026 09:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771579674; cv=none; b=eVpCt3tGbC11PXxWy0f9qUaxyyFRGw4vbVpsASxGTOVnOFTaxMwVbFcKEhg0r9YdJrhx0+KLMPMbNAE8RzjLMDlFE8c2x6vRdIuL+9GcrTrbFxe3RDIdmxtQKHfYiHjFgVNj/UQe9HUIZTSjhwG6D2XYk+Ny0MxP5bCSkR7dD+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771579674; c=relaxed/simple;
	bh=NJPGvTmlDcLmtgZEyJBgLqYqr3TADL+hhrIydbb16zw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AP7eIc1Fc07PLUp7XS+QpiadPoqrf2biBnEMasublYOD/brRkoFZpg18oRhWpg7QsdU7e39X+apivsUYnaVpw2JLpmPMAE17UX5YXDb4toJ0FSgL/MtABs2miYhLX/CqQJw2OUNyCkiXsoSfT8MFTHsDgJloC3ASHjxFmsoSrlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU4q3K6d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU4q3K6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE24CC116D0;
	Fri, 20 Feb 2026 09:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771579674;
	bh=NJPGvTmlDcLmtgZEyJBgLqYqr3TADL+hhrIydbb16zw=;
	h=From:To:Cc:Subject:Date:From;
	b=RU4q3K6dTajkeNAMGx5MkM68MOQQHw+mrUfNV5Nzof3hNgHHADZg8J4ZN28jLsmta
	 V+sMp+AuJkBCbLD9dOPlOLgirPzBEYsp8kPLFUlcEYOH+X2Cn09t39iCHEkYVnOAwb
	 quH4qTw//as3CZwFrxflIbJcFBINjaPTVrhcCWPQnuF9w9H17MSfYa9+RgFxA5+Wx3
	 O0otf8+dj9Un942DFEIE7tRSbwwhh2m3w6CQoFWhs2mC8XKdQ85J9/6m+4DXFX+Fik
	 g6CY1BxdLUQIAWFd9kRazbYgEAaIZ08jw1nbjUTH8lHvkQyY8U70XhFcoTn7Md89eY
	 BceCyzoQ0n9AA==
From: Jisheng Zhang <jszhang@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Guo Ren <guoren@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-csky@vger.kernel.org
Subject: [PATCH 0/3] use runtime constant to optimize handle_arch_irq access
Date: Fri, 20 Feb 2026 17:09:19 +0800
Message-ID: <20260220090922.1506-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, on GENERIC_IRQ_MULTI_HANDLER or arm64 platforms, the
handle_arch_irq is a pointer which is set during booting, and every
irq processing needs to access it, so it sits in hot code path. We can
use the runtime constant mechanism which was introduced by Linus to
speed up its accessing.

Tested on Sipeed Lichee Pi 4A (riscv64) board, the perf sched benchmark is
improved by ~5.8%

Tested on Quad CA55 platform, the perf sched benchmark is improved
by ~6.5%

As for the GENERIC_IRQ_MULTI_HANDLER platforms but without runtime const
support, such as arm, csky, loongarch, microblaze and openrisc, there
should be no changes.

Jisheng Zhang (3):
  vmlinux.lds.h: add _handle_arch_irq RUNTIME_CONST section
  genirq: use runtime constant to optimize handle_arch_irq access
  arm64: use runtime constant to optimize handle_arch_irq access

 arch/arm64/kernel/entry-common.c  | 4 +++-
 arch/arm64/kernel/irq.c           | 9 ++++++---
 include/asm-generic/vmlinux.lds.h | 3 ++-
 include/linux/irq.h               | 4 +++-
 kernel/irq/handle.c               | 8 +++++---
 5 files changed, 19 insertions(+), 9 deletions(-)

-- 
2.51.0

