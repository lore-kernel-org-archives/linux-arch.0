From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 00/25] Change time_t and clock_t to 64 bit
Date: Tue, 13 May 2014 16:57:36 +0800
Message-ID: <1399971456-3941-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0140.outbound.protection.outlook.com ([207.46.100.140]:55293
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752503AbaEMI5u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 04:57:50 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Arnd Bergmann <arnd@arndb.de>

This patchset change default time_t and clock_t to 64 bit in
include/uapi/asm-generic/posix_types.h. The existing 32 bit architectures override
these define to 32 bit in arch posix_types.h.

There is request to support 64 bit time_t for new architecture [1]. According to the
previous discussion we had (in [2]), defining suseconds_t as 64-bit, while probably
reasonable for LP64 or LP64+ILP32 architectures, but can makes things troublesome
for ILP32 architectures, not to mention the additional overhead.

This series is compiled tested on ARM, mips, powerpc32 and x86_64, but only boot
tested on ARM.

These patches are also available on this branch:
git://git.rocketboards.org/linux-socfpga-next.git  64bit_time

[1] https://lkml.org/lkml/2012/11/14/358
[2] https://lkml.org/lkml/2014/4/18/216

Ley Foon Tan (25):
  asm-generic: Change time_t and clock_t to 64 bit
  arc: Add 32 bit time_t and clock_t
  arm: Add 32 bit time_t and clock_t
  avr32: Add 32 bit time_t and clock_t
  blackfin: Add 32 bit time_t and clock_t
  c6x: Add 32 bit time_t and clock_t
  cris: Add 32 bit time_t and clock_t
  frv: Add 32 bit time_t and clock_t
  hexagon: Add 32 bit time_t and clock_t
  m32r: Add 32 bit time_t and clock_t
  m68k: Add 32 bit time_t and clock_t
  metag: Add 32 bit time_t and clock_t
  microblaze: Add 32 bit time_t and clock_t
  mips: Add 32 bit time_t and clock_t
  mn10300: Add 32 bit time_t and clock_t
  openrisc: Add 32 bit time_t and clock_t
  parisc: Add 32 bit time_t and clock_t
  powerpc: Add 32 bit time_t and clock_t
  s390: Add 32 bit time_t and clock_t
  score: Add 32 bit time_t and clock_t
  sh: Add 32 bit time_t and clock_t
  sparc: Add 32 bit time_t and clock_t
  unicore32: Add 32 bit time_t and clock_t
  x86: Add 32 bit time_t and clock_t
  xtense: Add 32 bit time_t and clock_t

 arch/arc/include/asm/Kbuild                    |  1 -
 arch/arc/include/uapi/asm/Kbuild               |  1 +
 arch/arc/include/uapi/asm/posix_types.h        | 17 +++++++++++++++++
 arch/arm/include/uapi/asm/posix_types.h        |  6 ++++++
 arch/avr32/include/uapi/asm/posix_types.h      |  6 ++++++
 arch/blackfin/include/uapi/asm/posix_types.h   |  6 ++++++
 arch/c6x/include/asm/Kbuild                    |  1 -
 arch/c6x/include/uapi/asm/Kbuild               |  1 +
 arch/c6x/include/uapi/asm/posix_types.h        | 17 +++++++++++++++++
 arch/cris/include/uapi/asm/posix_types.h       |  6 ++++++
 arch/frv/include/uapi/asm/posix_types.h        |  6 ++++++
 arch/hexagon/include/asm/Kbuild                |  1 -
 arch/hexagon/include/uapi/asm/Kbuild           |  1 +
 arch/hexagon/include/uapi/asm/posix_types.h    | 17 +++++++++++++++++
 arch/m32r/include/uapi/asm/posix_types.h       |  6 ++++++
 arch/m68k/include/uapi/asm/posix_types.h       |  6 ++++++
 arch/metag/include/asm/Kbuild                  |  1 -
 arch/metag/include/uapi/asm/Kbuild             |  1 +
 arch/metag/include/uapi/asm/posix_types.h      | 17 +++++++++++++++++
 arch/microblaze/include/uapi/asm/posix_types.h |  6 ++++++
 arch/mips/include/uapi/asm/posix_types.h       |  6 ++++++
 arch/mn10300/include/uapi/asm/posix_types.h    |  6 ++++++
 arch/openrisc/include/asm/Kbuild               |  1 -
 arch/openrisc/include/uapi/asm/Kbuild          |  1 +
 arch/openrisc/include/uapi/asm/posix_types.h   | 17 +++++++++++++++++
 arch/parisc/include/uapi/asm/posix_types.h     |  8 ++++++++
 arch/powerpc/include/uapi/asm/posix_types.h    |  6 ++++++
 arch/s390/include/uapi/asm/posix_types.h       |  6 ++++++
 arch/score/include/uapi/asm/posix_types.h      |  6 ++++++
 arch/sh/include/uapi/asm/posix_types_32.h      |  6 ++++++
 arch/sparc/include/uapi/asm/posix_types.h      |  6 ++++++
 arch/unicore32/include/asm/Kbuild              |  1 -
 arch/unicore32/include/uapi/asm/Kbuild         |  1 +
 arch/unicore32/include/uapi/asm/posix_types.h  | 17 +++++++++++++++++
 arch/x86/include/uapi/asm/posix_types_32.h     |  6 ++++++
 arch/xtensa/include/uapi/asm/posix_types.h     |  6 ++++++
 include/uapi/asm-generic/posix_types.h         | 14 ++++++++++++--
 37 files changed, 230 insertions(+), 8 deletions(-)
 create mode 100644 arch/arc/include/uapi/asm/posix_types.h
 create mode 100644 arch/c6x/include/uapi/asm/posix_types.h
 create mode 100644 arch/hexagon/include/uapi/asm/posix_types.h
 create mode 100644 arch/metag/include/uapi/asm/posix_types.h
 create mode 100644 arch/openrisc/include/uapi/asm/posix_types.h
 create mode 100644 arch/unicore32/include/uapi/asm/posix_types.h

-- 
1.8.2.1
