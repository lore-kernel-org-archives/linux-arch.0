Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1bon0065.outbound.protection.outlook.com ([157.56.111.65]:9556
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751490AbbLZQjq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 26 Dec 2015 11:39:46 -0500
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 0/2] ABI: handle 32-bit off_t for 32-bit and compat ABIs
Date: Sat, 26 Dec 2015 19:06:38 +0300
Message-ID: <1451146000-5646-1-git-send-email-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, klimov.linux@gmail.com, Yury Norov <ynorov@caviumnetworks.com>
Message-ID: <20151226160638.IJIym6dHwiBLaoUVuMwhtDOkNteCVYCpblN5YkzsUNA@z>

32-bit off_t is supported only for old 32-bit and compat ABIs. New ABIs
are 64-bit length only. This patchset makes 64-bit length the default
for off_t, and reverts it for old architectures where needed. It does not
change the behaviour of existing code.

First patch makes all compat users of generic unistd.h to use non-compat
versions of openat and open_by_handle_at. Tile that requires old behaviour
is turned around.

Second patch introduces ARCH_32BIT_OFF_T config option, disabled by default,
but enables it explicitly for existing 32-bit architectures.

Yury Norov (2):
  ABI: compat: use non-compat openat and open_by_handle_at variants
  32-bit ABI: introduce ARCH_32BIT_OFF_T config option

 arch/Kconfig                      | 4 ++++
 arch/arc/Kconfig                  | 1 +
 arch/arm/Kconfig                  | 1 +
 arch/blackfin/Kconfig             | 1 +
 arch/cris/Kconfig                 | 1 +
 arch/frv/Kconfig                  | 1 +
 arch/h8300/Kconfig                | 1 +
 arch/hexagon/Kconfig              | 1 +
 arch/ia64/Kconfig                 | 1 +
 arch/m32r/Kconfig                 | 1 +
 arch/m68k/Kconfig                 | 1 +
 arch/metag/Kconfig                | 1 +
 arch/microblaze/Kconfig           | 1 +
 arch/mips/Kconfig                 | 1 +
 arch/mn10300/Kconfig              | 1 +
 arch/nios2/Kconfig                | 1 +
 arch/openrisc/Kconfig             | 1 +
 arch/parisc/Kconfig               | 1 +
 arch/powerpc/Kconfig              | 1 +
 arch/s390/Kconfig                 | 1 +
 arch/score/Kconfig                | 1 +
 arch/sh/Kconfig                   | 1 +
 arch/sparc/Kconfig                | 1 +
 arch/tile/Kconfig                 | 1 +
 arch/tile/kernel/compat.c         | 3 +++
 arch/unicore32/Kconfig            | 1 +
 arch/x86/Kconfig                  | 1 +
 arch/x86/um/Kconfig               | 1 +
 arch/xtensa/Kconfig               | 1 +
 include/linux/fcntl.h             | 3 ++-
 include/uapi/asm-generic/unistd.h | 5 ++---
 31 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.5.0

