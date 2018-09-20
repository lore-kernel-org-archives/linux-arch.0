From: Vincent Chen <vincentc@andestech.com>
Subject: [PATCH 0/5] nds32 FPU port
Date: Thu, 20 Sep 2018 10:46:17 +0800
Message-ID: <1537411582-23723-1-git-send-email-vincentc@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, deanbo422@gmail.com, vincentc@andestech.com
List-Id: linux-arch.vger.kernel.org

  This patchset contains basic components for nds32 FPU support such as
exception handler and context switch for FPU register. Lazy FPU is
supported in nds32 by default. User can through CONFIG_UNLZAY_FPU to
disable this feature. In addition, a floating point emulator is needed to
deal with all arithmetic for denormalized number because it is unsupported
by nds32 FPU.

  As stated above, denormalized number is unsupported by nds32 FPU. This
means denormalized operands and result are not permitted. If an instruction
contains denormalized operands, nds32 FPU will raise an denormalized input
exception to notify kernel to deal with this instruction. If the result of
a instruction is a denormalized number, normally nds32 FPU will treat it as
an underflow case and round the result to an appropriate value based on
current rounding mode. Obviously, there is a precision gap for tininess
number. To reduce this precision gap, kernel will enable the underflow trap
by default to direct all underflow cases to floating pointer emulator.
Through floating pointer emulator, the correct denormalized number can be
derived in kernel and return to user program. The feature is configurable
by CONFIG_SUPPORT_DENORMAL_ARITHMETIC and user maybe disable this feature
to keep performance if the precision recruitment is not strict for tininess
number.

  The implementation of floating point emulator is based on the soft-fp
which is placed in include/math-emu folder. However, the soft-fp is too
out-of-date to pass the check by current compiler. The needed modification
for soft-fp is included in this patchset

Vincent Chen (5):
  nds32: nds32 FPU port
  nds32: Support FP emulation
  nds32: support denormalized result through FP emulator
  math-emu/op-2.h: Use statement expressions to prevent negative
    constant shift
  math-emu/soft-fp.h: (_FP_ROUND_ZERO) cast 0 to void to fix warning

 arch/nds32/Kconfig                       |    1 +
 arch/nds32/Kconfig.cpu                   |   35 +++
 arch/nds32/Makefile                      |   11 +
 arch/nds32/include/asm/bitfield.h        |   15 ++
 arch/nds32/include/asm/elf.h             |   11 +
 arch/nds32/include/asm/fpu.h             |  128 +++++++++++
 arch/nds32/include/asm/fpuemu.h          |   32 +++
 arch/nds32/include/asm/nds32_fpu_inst.h  |  109 +++++++++
 arch/nds32/include/asm/processor.h       |    7 +
 arch/nds32/include/asm/sfp-machine.h     |  158 +++++++++++++
 arch/nds32/include/asm/syscalls.h        |    1 +
 arch/nds32/include/uapi/asm/auxvec.h     |    7 +
 arch/nds32/include/uapi/asm/sigcontext.h |   14 ++
 arch/nds32/include/uapi/asm/udftrap.h    |   13 +
 arch/nds32/include/uapi/asm/unistd.h     |    2 +
 arch/nds32/kernel/Makefile               |    9 +
 arch/nds32/kernel/ex-entry.S             |    9 +
 arch/nds32/kernel/ex-exit.S              |    8 +-
 arch/nds32/kernel/ex-scall.S             |    8 +-
 arch/nds32/kernel/fpu.c                  |  257 +++++++++++++++++++++
 arch/nds32/kernel/process.c              |   64 +++++-
 arch/nds32/kernel/setup.c                |    5 +
 arch/nds32/kernel/signal.c               |   77 +++++++-
 arch/nds32/kernel/sys_nds32.c            |   32 +++
 arch/nds32/kernel/traps.c                |   16 ++
 arch/nds32/math-emu/Makefile             |    7 +
 arch/nds32/math-emu/faddd.c              |   24 ++
 arch/nds32/math-emu/fadds.c              |   24 ++
 arch/nds32/math-emu/fcmpd.c              |   24 ++
 arch/nds32/math-emu/fcmps.c              |   24 ++
 arch/nds32/math-emu/fd2s.c               |   22 ++
 arch/nds32/math-emu/fdivd.c              |   27 +++
 arch/nds32/math-emu/fdivs.c              |   26 +++
 arch/nds32/math-emu/fmuld.c              |   23 ++
 arch/nds32/math-emu/fmuls.c              |   23 ++
 arch/nds32/math-emu/fnegd.c              |   21 ++
 arch/nds32/math-emu/fnegs.c              |   21 ++
 arch/nds32/math-emu/fpuemu.c             |  357 ++++++++++++++++++++++++++++++
 arch/nds32/math-emu/fs2d.c               |   23 ++
 arch/nds32/math-emu/fsqrtd.c             |   21 ++
 arch/nds32/math-emu/fsqrts.c             |   21 ++
 arch/nds32/math-emu/fsubd.c              |   27 +++
 arch/nds32/math-emu/fsubs.c              |   27 +++
 include/math-emu/op-2.h                  |   97 ++++-----
 include/math-emu/soft-fp.h               |    2 +-
 45 files changed, 1807 insertions(+), 63 deletions(-)
 create mode 100644 arch/nds32/include/asm/fpu.h
 create mode 100644 arch/nds32/include/asm/fpuemu.h
 create mode 100644 arch/nds32/include/asm/nds32_fpu_inst.h
 create mode 100644 arch/nds32/include/asm/sfp-machine.h
 create mode 100644 arch/nds32/include/uapi/asm/udftrap.h
 create mode 100644 arch/nds32/kernel/fpu.c
 create mode 100644 arch/nds32/math-emu/Makefile
 create mode 100644 arch/nds32/math-emu/faddd.c
 create mode 100644 arch/nds32/math-emu/fadds.c
 create mode 100644 arch/nds32/math-emu/fcmpd.c
 create mode 100644 arch/nds32/math-emu/fcmps.c
 create mode 100644 arch/nds32/math-emu/fd2s.c
 create mode 100644 arch/nds32/math-emu/fdivd.c
 create mode 100644 arch/nds32/math-emu/fdivs.c
 create mode 100644 arch/nds32/math-emu/fmuld.c
 create mode 100644 arch/nds32/math-emu/fmuls.c
 create mode 100644 arch/nds32/math-emu/fnegd.c
 create mode 100644 arch/nds32/math-emu/fnegs.c
 create mode 100644 arch/nds32/math-emu/fpuemu.c
 create mode 100644 arch/nds32/math-emu/fs2d.c
 create mode 100644 arch/nds32/math-emu/fsqrtd.c
 create mode 100644 arch/nds32/math-emu/fsqrts.c
 create mode 100644 arch/nds32/math-emu/fsubd.c
 create mode 100644 arch/nds32/math-emu/fsubs.c
