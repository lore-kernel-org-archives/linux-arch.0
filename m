From: Mao Han <han_mao@c-sky.com>
Subject: [PATCH V5 0/3] riscv: Add perf callchain support
Date: Fri, 23 Aug 2019 14:15:57 +0800
Message-ID: <cover.1566540652.git.han_mao@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Mao Han <han_mao@c-sky.com>
List-Id: linux-arch.vger.kernel.org

This patch set add perf callchain(FP/DWARF) support for RISC-V.
It comes from the csky version callchain support with some
slight modifications. The patchset base on Linux 5.3.

Changes since v4:
  - Add missing PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
    verified with extra CFLAGS(-Wall -Werror)

Changes since v3:
  - Add more strict check for unwind_frame_kernel
  - update for kernel 5.3

Changes since v2:
  - fix inconsistent comment
  - force to build kernel with -fno-omit-frame-pointer if perf
    event is enabled

Changes since v1:
  - simplify implementation and code convention


Mao Han (3):
  riscv: Add perf callchain support
  riscv: Add support for perf registers sampling
  riscv: Add support for libdw

 arch/riscv/Kconfig                            |   2 +
 arch/riscv/Makefile                           |   3 +
 arch/riscv/include/uapi/asm/perf_regs.h       |  42 ++++++++++
 arch/riscv/kernel/Makefile                    |   4 +-
 arch/riscv/kernel/perf_callchain.c            | 115 ++++++++++++++++++++++++++
 arch/riscv/kernel/perf_regs.c                 |  44 ++++++++++
 tools/arch/riscv/include/uapi/asm/perf_regs.h |  42 ++++++++++
 tools/perf/Makefile.config                    |   6 +-
 tools/perf/arch/riscv/Build                   |   1 +
 tools/perf/arch/riscv/Makefile                |   4 +
 tools/perf/arch/riscv/include/perf_regs.h     |  96 +++++++++++++++++++++
 tools/perf/arch/riscv/util/Build              |   2 +
 tools/perf/arch/riscv/util/dwarf-regs.c       |  72 ++++++++++++++++
 tools/perf/arch/riscv/util/unwind-libdw.c     |  57 +++++++++++++
 14 files changed, 488 insertions(+), 2 deletions(-)
 create mode 100644 arch/riscv/include/uapi/asm/perf_regs.h
 create mode 100644 arch/riscv/kernel/perf_callchain.c
 create mode 100644 arch/riscv/kernel/perf_regs.c
 create mode 100644 tools/arch/riscv/include/uapi/asm/perf_regs.h
 create mode 100644 tools/perf/arch/riscv/Build
 create mode 100644 tools/perf/arch/riscv/Makefile
 create mode 100644 tools/perf/arch/riscv/include/perf_regs.h
 create mode 100644 tools/perf/arch/riscv/util/Build
 create mode 100644 tools/perf/arch/riscv/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/riscv/util/unwind-libdw.c

-- 
2.7.4
