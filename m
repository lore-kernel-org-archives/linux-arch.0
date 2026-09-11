Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABAA501F25;
	Fri, 11 Sep 2026 19:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154901; cv=none; b=ESfLDyb4WEaZEyMfGENQqJPAtPLC/piUV21dIvriyfEOhPSNIejGPoByJXDv4aSF5RrutV8RvuUMxbbUGSwA85mnH8Atal2LW5SW+Z6AsjxNNUjYg/8/1srhZqUu7ZT96VCiEW+0CRVSaMsoe0/+Ct5mlHxg5/UD0ngCRnEBS4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154901; c=relaxed/simple;
	bh=zaLJJGvfKl0xexHwGZM6tuZV9IXYGAAfbZVXKhiVXsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Th2UPuikSBdjpOTahg6nB2tjnpWNkzdfoCBMawc91IxkV7Ft2a83A1fmnb0N5dygO3sYM06Iwv3LPzZxxrlAiOvUrw1ab+r4nq5ud1ySLuqBhBxSnv2wak1XrYEPj3MZvbAC1DO8qv9inPvLxXQCoZ1855NoKDIc+agmpwz65PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.helo=mail.mainlining.org; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.helo=mail.mainlining.org
From: Bradley Morgan <brads@mainlining.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	boqun@kernel.org,
	joelagnelf@nvidia.com,
	rcu@vger.kernel.org,
	"Andrew Morton" <akpm@linux-foundation.org>,
	"Arnd Bergmann" <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	"Vineet Gupta" <vgupta@kernel.org>,
	linux-snps-arc@lists.infradead.org,
	"Russell King" <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	"Guo Ren" <guoren@kernel.org>,
	linux-csky@vger.kernel.org,
	"Yoshinori Sato" <ysato@users.sourceforge.jp>,
	"Rich Felker" <dalias@libc.org>,
	"John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	"Chris Zankel" <chris@zankel.net>,
	"Max Filippov" <jcmvbkbc@gmail.com>,
	linux-kernel@vger.kernel.org,
	brads@mainlining.org
Subject: [PATCH 0/6] Add two-byte cmpxchg emulation and wire it into the architectures
Date: Fri, 11 Sep 2026 19:25:33 +0000
Message-ID: <20260911192540.20983-1-brads@mainlining.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Paul McKenney asked me off list to add cmpxchg_emu_u16() next to
cmpxchg_emu_u8() and wire it into the architectures that use the
one byte emulation, arc, ARMv6, csky, sh and xtensa.

Patch 1 adds the function, the prototype, and renames the Kconfig
symbol to ARCH_NEED_CMPXCHG_1_2_EMU since it now gates both
emulations. Patches 2 through 6 add case 2 beside each existing
case 1, following each file's current style. The function body
follows the two byte implementation in Paul's April 2024 RFC
series, of which only the one byte part landed as commit
a88d970c8bb5 ("lib: Add one-byte emulation function").

Per Paul's note, Arnd Bergmann's platform removal series was
checked before analyzing the users. It removes the imx31 and
omap24xx CPU_ARM1136R0 selectors, but INTEGRATOR_CM1136JFS still
selects CPU_ARM1136R0 until its scheduled removal in early 2027,
so the ARMv6 path in patch 3 is still live. The arc !LLSC path
already handles any size because it reads and writes through the
typed pointer under the atomic_ops lock, so only the LLSC switch
gains case 2.

Verification. The union splice is endian independent because h[i]
sits at byte offset 2*i on both layouts and i is (addr & 2) / 2,
so the selected halfword always matches the caller's byte offset.
A host test ran 240 cases across both halfword offsets, matching
and mismatching compares, against a byte level reference model,
all passing. The function also compiles big endian for ARM, which
matters because sh is a big endian user. lib/cmpxchg-emu.o builds
for arm with CONFIG_CPU_V6 and a test instantiation of cmpxchg()
on a u16 resolves to cmpxchg_emu_u16. The remaining checkpatch
warnings are the volatile and long line ones that the merged
cmpxchg_emu_u8() lines already carry.

Bradley Morgan (6):
  lib: Add two-byte cmpxchg emulation function
  ARC: Emulate two-byte cmpxchg
  ARM: Emulate two-byte cmpxchg on ARMv6
  csky: Emulate two-byte cmpxchg
  sh: Emulate two-byte cmpxchg
  xtensa: Emulate two-byte cmpxchg

 arch/Kconfig                      |  2 +-
 arch/arc/Kconfig                  |  2 +-
 arch/arc/include/asm/cmpxchg.h    |  3 +++
 arch/arm/Kconfig                  |  2 +-
 arch/arm/include/asm/cmpxchg.h    |  3 +++
 arch/csky/Kconfig                 |  2 +-
 arch/csky/include/asm/cmpxchg.h   |  9 ++++++++
 arch/sh/Kconfig                   |  2 +-
 arch/sh/include/asm/cmpxchg.h     |  2 ++
 arch/xtensa/Kconfig               |  2 +-
 arch/xtensa/include/asm/cmpxchg.h |  1 +
 include/linux/cmpxchg-emu.h       |  1 +
 lib/Makefile                      |  2 +-
 lib/cmpxchg-emu.c                 | 35 ++++++++++++++++++++++++++++---
 14 files changed, 58 insertions(+), 10 deletions(-)

-- 
2.47.3

