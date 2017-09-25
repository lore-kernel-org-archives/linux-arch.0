From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 0/3] arch: improvenemts for new ABIs
Date: Tue, 26 Sep 2017 00:00:32 +0300
Message-ID: <20170925210035.31514-1-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

Hi all,

This 3 patches are the subset of arm64/ilp32 project [1]. They are generic,
and not related to arm64 platform. I sent patches few times before, and they
collected some acks. But due to technical reasons some of them didn't appear
in arch maillist, so I would resend them explicitly, as suggested by Catalin
Marinas.

All patches are on top of next-20170922.

[1] https://lkml.org/lkml/2017/6/19/624

Yury


Yury Norov (3):
  compat ABI: use non-compat openat and open_by_handle_at variants
  32-bit userspace ABI: introduce ARCH_32BIT_OFF_T config option
  asm-generic: Drop getrlimit and setrlimit syscalls from default list

 arch/Kconfig                             | 15 +++++++++++++++
 arch/arc/Kconfig                         |  1 +
 arch/arc/include/uapi/asm/unistd.h       |  1 +
 arch/arm/Kconfig                         |  1 +
 arch/arm64/include/uapi/asm/unistd.h     |  1 +
 arch/blackfin/Kconfig                    |  1 +
 arch/c6x/include/uapi/asm/unistd.h       |  1 +
 arch/cris/Kconfig                        |  1 +
 arch/frv/Kconfig                         |  1 +
 arch/h8300/Kconfig                       |  1 +
 arch/h8300/include/uapi/asm/unistd.h     |  1 +
 arch/hexagon/Kconfig                     |  1 +
 arch/hexagon/include/uapi/asm/unistd.h   |  1 +
 arch/m32r/Kconfig                        |  1 +
 arch/m68k/Kconfig                        |  1 +
 arch/metag/Kconfig                       |  1 +
 arch/metag/include/uapi/asm/unistd.h     |  1 +
 arch/microblaze/Kconfig                  |  1 +
 arch/mips/Kconfig                        |  1 +
 arch/mn10300/Kconfig                     |  1 +
 arch/nios2/Kconfig                       |  1 +
 arch/nios2/include/uapi/asm/unistd.h     |  1 +
 arch/openrisc/Kconfig                    |  1 +
 arch/openrisc/include/uapi/asm/unistd.h  |  1 +
 arch/parisc/Kconfig                      |  1 +
 arch/powerpc/Kconfig                     |  1 +
 arch/score/Kconfig                       |  1 +
 arch/score/include/uapi/asm/unistd.h     |  1 +
 arch/sh/Kconfig                          |  1 +
 arch/sparc/Kconfig                       |  1 +
 arch/tile/Kconfig                        |  1 +
 arch/tile/include/uapi/asm/unistd.h      |  1 +
 arch/tile/kernel/compat.c                |  3 +++
 arch/unicore32/Kconfig                   |  1 +
 arch/unicore32/include/uapi/asm/unistd.h |  1 +
 arch/x86/Kconfig                         |  1 +
 arch/x86/um/Kconfig                      |  1 +
 arch/xtensa/Kconfig                      |  1 +
 include/linux/fcntl.h                    |  2 +-
 include/uapi/asm-generic/unistd.h        | 10 +++++++---
 scripts/checksyscalls.sh                 |  5 +++++
 41 files changed, 67 insertions(+), 4 deletions(-)

-- 
2.11.0
