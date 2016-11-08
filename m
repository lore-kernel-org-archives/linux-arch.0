From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [Resend PATCH v2 0/2] ABI: handle 32-bit off_t for 32-bit and compat ABIs
Date: Tue, 8 Nov 2016 16:02:58 +0530
Message-ID: <1478601180-20932-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de
Cc: cmetcalf@ezchip.com, tglx@linutronix.de, Yury Norov <ynorov@caviumnetworks.com>
List-Id: linux-arch.vger.kernel.org

32-bit off_t is supported only for old 32-bit and compat ABIs. New ABIs
are 64-bit length only. This patchset makes 64-bit length the default
for off_t, and reverts it for old architectures where needed. It does not
change the behaviour of existing code.

First patch makes all compat users of generic unistd.h to use non-compat
versions of openat and open_by_handle_at. Tile that requires old behaviour
is turned around.

Second patch introduces ARCH_32BIT_OFF_T config option, disabled by default,
but enables it explicitly for existing 32-bit architectures.

Original submission:
http://lists-archives.com/linux-kernel/28471158-abi-handle-32-bit-off_t-for-32-bit-and-compat-abis.html

This is the same series that I sent in Dec 29. In arm64 ilp32 this patches are
melded, but Chris asked to split it. So I decided to resend old series. Here is
no changes, it's only rebased on 4.9-rc4.

Yury Norov (2):
  compat ABI: use non-compat openat and open_by_handle_at variants
  32-bit ABI: introduce ARCH_32BIT_OFF_T config option

 arch/Kconfig                      | 4 ++++
 arch/arc/Kconfig                  | 1 +
 arch/arm/Kconfig                  | 1 +
 arch/blackfin/Kconfig             | 1 +
 arch/cris/Kconfig                 | 1 +
 arch/frv/Kconfig                  | 1 +
 arch/h8300/Kconfig                | 1 +
 arch/hexagon/Kconfig              | 1 +
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
 arch/score/Kconfig                | 1 +
 arch/sh/Kconfig                   | 1 +
 arch/sparc/Kconfig                | 1 +
 arch/tile/Kconfig                 | 1 +
 arch/tile/kernel/compat.c         | 3 +++
 arch/unicore32/Kconfig            | 1 +
 arch/x86/Kconfig                  | 1 +
 arch/x86/um/Kconfig               | 1 +
 arch/xtensa/Kconfig               | 1 +
 include/linux/fcntl.h             | 2 +-
 include/uapi/asm-generic/unistd.h | 5 ++---
 29 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.7.4
