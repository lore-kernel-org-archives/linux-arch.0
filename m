Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C93F6600;
	Fri, 24 Apr 2026 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056984; cv=none; b=reEgmA/MJbDCHlRkK0eIwXXnlRic1BDKDP6mco/iMZAm/1zWUR7C9vaLxSZwWfNM89saSAFcxQi5s58FZiiXMZGD4xhSJEGjqNWxRM6RvfMByrYuz4rG6pEA/E/+v8EgQsSzOC4XHKmSKHamuSjuVGKrCx0IBCmqmCkzE4BpNfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056984; c=relaxed/simple;
	bh=Nnv5QRXkgVjxOh6HNohLvKFKPrKW3JfNYfbL9qxytN0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MTPdlT/+7NsB+jmYyalDugAsYdO4URi9a/G8sFxTr3zlVk56VdiX8iYjCElg6dBmJUAsrdeCYcNDRrYFC0D2az/ZoD0Chk2vgmQMZYpEiuJH55kyPRDkIZOCIPmTjc3l0yWiBtIkpws2pWyTSOZawt0WaybaGIL1RT0731RvV30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Bsjn0MNc; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Bsjn0MNc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-Id:Date:Subject:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GUNIXOXau0uPo6m4W/eUzMNxNJvrU8hctsDdhIVgwyo=; b=Bsjn0MNczoy/pjIFMq9JhttjSK
	yNKJLzKYHo8nn20XfbTaiO/fQVWMpivxHZmbKmJsvGgxTbLQHBEuBUQe0wN5SgOt/5Cg7RwRfBspR
	XsgDpMszFyyRcHxjVV8OOX35W4vQPsAWXTNh4yDJADfavYD2Hd7SlK/GHPSmTbap6ExrFLCKMzp9/
	C3NeQH14v4IVQJIpFCVWWYAjJ3NILnz3I5AFHTvDmF0FweNIMQvK1q5jH/e1fmSZ3VO2c4kDNyje/
	HCevKiH+CiM+muzRyerjLlzBio2UkKRseGTuV8aIHEVeFl8NAlk+recTh8xxu/L48A40Tx+3wglHI
	PXM7h9UQ==;
Received: from [187.57.76.96] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wGLhJ-001j1m-Vg; Fri, 24 Apr 2026 20:56:17 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH RFC v2 0/2] arm64: vdso: Implement
 __vdso_futex_robust_try_unlock()
Date: Fri, 24 Apr 2026 15:55:59 -0300
Message-Id: <20260424-tonyk-robust_arm-v2-0-db4e46f752cf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ6CMBREr0L+2pq2VkhcmZh4ALeGmFJ+4atQ0
 xYiIdxdQHcu32Rm3ggBPWGAQzKCx54CuXYGuUnA1LqtkFE5M0guU65EyqJrhwfzruhCvGnfsL2
 yNstKaRQqmGcvj5be6+UVLucT5N8wdMUdTVzOllpNITo/rOJerOWfI/t39IJxxndapwqltUIfq
 dJP0lvjGsinafoA8QXV3sgAAAA=
X-Change-ID: 20260416-tonyk-robust_arm-54ff77d2c4e4
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Carlos O'Donell <carlos@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Florian Weimer <fweimer@redhat.com>, Rich Felker <dalias@aerifal.cx>, 
 Torvald Riegel <triegel@redhat.com>, Darren Hart <dvhart@infradead.org>, 
 Ingo Molnar <mingo@kernel.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Arnd Bergmann <arnd@arndb.de>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
 Uros Bizjak <ubizjak@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, kernel-dev@igalia.com, 
 LKML <linux-kernel@vger.kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.15.2

Hi folks,

This is my take on implementing the new vDSO for unlocking a robust futex in
arm64. If you don't know what's that, Thomas wrote a good summary,
including the motivation for this work and the x86 implementation:

   https://lore.kernel.org/lkml/878qb89g7b.ffs@tglx/

There are some loose ends in my patchset so I'm sending as a RFC to ask
some questions:

 - If the process is interrupted between the labels, we need to check the
 conditional flags and clear the op_pending address from the register. Using
 objdump I see that op_pending addr is being stored at x2, but I suspect that
 this isn't stable, so I need to figure out how to make sure that the address
 will always be stored in the same register.
 - So far I have implemented only the LL/SC version to make review easier, but I
 can do the LSE version as well.

This patchset works fine with the tests proposed at
https://lore.kernel.org/lkml/20260330120118.012924430@kernel.org/

Changes from v1:
 - s/CONFIG_COMPAT/CONFIG_COMPAT_VDSO (Thomas Weißschuh)
 - Fixed linker not finding the symbols (Thomas Weißschuh)
v1: https://patch.msgid.link/20260417-tonyk-robust_arm-v1-0-03aa64e2ff1a@igalia.com

---
André Almeida (2):
      arm64: vdso: Prepare for robust futex unlock support
      arm64: vdso: Implement __vdso_futex_robust_try_unlock()

 arch/arm64/Kconfig                                 |  1 +
 arch/arm64/include/asm/futex_robust.h              | 35 +++++++++++++
 arch/arm64/kernel/vdso.c                           | 30 +++++++++++
 arch/arm64/kernel/vdso/Makefile                    |  9 +++-
 arch/arm64/kernel/vdso/vdso.lds.S                  | 11 ++++
 .../kernel/vdso/vfutex_robust_list_try_unlock.c    | 59 ++++++++++++++++++++++
 6 files changed, 144 insertions(+), 1 deletion(-)
---
base-commit: 0e8896e9899b607bb168c1cce340596b8c2e3e2b
change-id: 20260416-tonyk-robust_arm-54ff77d2c4e4

Best regards,
--  
André Almeida <andrealmeid@igalia.com>

