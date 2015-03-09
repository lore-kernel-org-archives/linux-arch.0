Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:50261 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754004AbbCIK1c (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 Mar 2015 06:27:32 -0400
From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 0/6] make memtest a generic kernel feature
Date: Mon,  9 Mar 2015 10:27:04 +0000
Message-ID: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, lauraa@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, linux@arm.linux.org.uk, arnd@arndb.de, mark.rutland@arm.com, ard.biesheuvel@linaro.org, baruch@tkos.co.il, rdunlap@infradead.org
Message-ID: <20150309102704.dhZE91-Iv4_s5Z35c4aoq9Y8ZKUp7YfHs0Z4r8-Rx6w@z>

Hi,

Memtest is a simple feature which fills the memory with a given set of
patterns and validates memory contents, if bad memory regions is detected i=
t
reserves them via memblock API. Since memblock API is widely used by other
architectures this feature can be enabled outside of x86 world.

This patch set promotes memtest to live under generic mm umbrella and enabl=
es
memtest feature for arm/arm64.

It was reported that this patch set was useful for tracking down an issue w=
ith
some errant DMA on an arm64 platform.

Since it touches x86 and mm bits it'd be great to get ACK/NAK for these bit=
s.

Changelog:

    RFC -> v1
        - updated kernel-parameters.txt for memtest entry
        - updated number of test patterns in Kconfig menu
        - added Acked/Tested tags for arm64 bits
        - rebased on v4.0-rc3

Vladimir Murzin (6):
  mm: move memtest under /mm
  memtest: use phys_addr_t for physical addresses
  arm64: add support for memtest
  arm: add support for memtest
  Kconfig: memtest: update number of test patterns up to 17
  Documentation: update arch list in the 'memtest' entry

 Documentation/kernel-parameters.txt |    2 +-
 arch/arm/mm/init.c                  |    3 +
 arch/arm64/mm/init.c                |    2 +
 arch/x86/Kconfig                    |   11 ----
 arch/x86/include/asm/e820.h         |    8 ---
 arch/x86/mm/Makefile                |    2 -
 arch/x86/mm/memtest.c               |  118 -------------------------------=
----
 include/linux/memblock.h            |    8 +++
 lib/Kconfig.debug                   |   11 ++++
 mm/Makefile                         |    1 +
 mm/memtest.c                        |  118 +++++++++++++++++++++++++++++++=
++++
 11 files changed, 144 insertions(+), 140 deletions(-)
 delete mode 100644 arch/x86/mm/memtest.c
 create mode 100644 mm/memtest.c

--=20
1.7.9.5


