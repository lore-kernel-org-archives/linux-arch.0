From: Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [RFC PATCH 0/4] make memtest a generic kernel feature
Date: Mon,  2 Mar 2015 14:55:41 +0000
Message-ID: <1425308145-20769-1-git-send-email-vladimir.murzin@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:51868 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753984AbbCBOzz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Mar 2015 09:55:55 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, akpm@linux-foundation.org, lauraa@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, linux@arm.linux.org.uk, arnd@arndb.de, mark.rutland@arm.com, ard.biesheuvel@linaro.org

Hi,

Memtest is a simple feature which fills the memory with a given set of
patterns and validates memory contents, if bad memory regions is detected i=
t
reserves them via memblock API. Since memblock API is widely used by other
architectures this feature can be enabled outside of x86 world.

This patch set promotes memtest to live under generic mm umbrella and enabl=
es
memtest feature for arm/arm64.

Patches are built on top of 4.0-rc1

Vladimir Murzin (4):
  mm: move memtest under /mm
  memtest: use phys_addr_t for physical addresses
  arm64: add support for memtest
  arm: add support for memtest

 arch/arm/mm/init.c          |    3 ++
 arch/arm64/mm/init.c        |    2 +
 arch/x86/Kconfig            |   11 ----
 arch/x86/include/asm/e820.h |    8 ---
 arch/x86/mm/Makefile        |    2 -
 arch/x86/mm/memtest.c       |  118 ---------------------------------------=
----
 include/linux/memblock.h    |    8 +++
 lib/Kconfig.debug           |   11 ++++
 mm/Makefile                 |    1 +
 mm/memtest.c                |  118 +++++++++++++++++++++++++++++++++++++++=
++++
 10 files changed, 143 insertions(+), 139 deletions(-)
 delete mode 100644 arch/x86/mm/memtest.c
 create mode 100644 mm/memtest.c

--=20
1.7.9.5
