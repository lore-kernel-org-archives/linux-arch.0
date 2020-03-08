From: guoren@kernel.org
Subject: [RFC PATCH V3 00/11] riscv: Add vector ISA support
Date: Sun,  8 Mar 2020 17:49:43 +0800
Message-ID: <20200308094954.13258-1-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: paul.walmsley@sifive.com, palmer@dabbelt.com, Anup.Patel@wdc.com, greentime.hu@sifive.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>, Dave Martin <Dave.Martin@arm.com>, Liu Zhiwei <zhiwei_liu@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
128bit-vlen and it's based on linux-5.6-rc3 and tested with qemu [1].

The patch implement basic context switch, sigcontext save/restore and
ptrace interface with a new regset NT_RISCV_VECTOR. Only fixed 128bit-vlen
is implemented. We need to discuss about vlen-size for libc sigcontext and
ptrace (the maximum size of vlen is unlimited in spec).

Puzzle:
Dave Martin has talked "Growing CPU register state without breaking ABI" [2]
before, and riscv also met vlen size problem. Let's discuss the common issue
for all architectures and we need a better solution for unlimited vlen.

Any help are welcomed :)

 1: https://github.com/romanheros/qemu.git branch:vector-upstream-v3
 2: https://blog.linuxplumbersconf.org/2017/ocw/sessions/4671.html

---
Changelog V3
 - Rebase linux-5.6-rc3 and tested with qemu
 - Seperate patches with Anup's advice
 - Give out a ABI puzzle with unlimited vlen

Changelog V2
 - Fixup typo "vecotr, fstate_save->vstate_save".
 - Fixup wrong saved registers' length in vector.S.
 - Seperate unrelated patches from this one.

Guo Ren (11):
  riscv: Separate patch for cflags and aflags
  riscv: Rename __switch_to_aux -> fpu
  riscv: Extending cpufeature.c to detect V-extension
  riscv: Add CSR defines related to VECTOR extension
  riscv: Add vector feature to compile
  riscv: Add has_vector detect
  riscv: Reset vector register
  riscv: Add vector struct and assembler definitions
  riscv: Add task switch support for VECTOR
  riscv: Add ptrace support
  riscv: Add sigcontext save/restore

 arch/riscv/Kconfig                       |   9 ++
 arch/riscv/Makefile                      |  19 ++-
 arch/riscv/include/asm/csr.h             |  17 ++-
 arch/riscv/include/asm/processor.h       |   1 +
 arch/riscv/include/asm/switch_to.h       |  54 ++++++-
 arch/riscv/include/uapi/asm/elf.h        |   1 +
 arch/riscv/include/uapi/asm/hwcap.h      |   1 +
 arch/riscv/include/uapi/asm/ptrace.h     |   9 ++
 arch/riscv/include/uapi/asm/sigcontext.h |   1 +
 arch/riscv/kernel/Makefile               |   1 +
 arch/riscv/kernel/asm-offsets.c          | 187 +++++++++++++++++++++++
 arch/riscv/kernel/cpufeature.c           |  12 +-
 arch/riscv/kernel/entry.S                |   2 +-
 arch/riscv/kernel/head.S                 |  49 +++++-
 arch/riscv/kernel/process.c              |  10 ++
 arch/riscv/kernel/ptrace.c               |  41 +++++
 arch/riscv/kernel/signal.c               |  40 +++++
 arch/riscv/kernel/vector.S               |  84 ++++++++++
 include/uapi/linux/elf.h                 |   1 +
 19 files changed, 524 insertions(+), 15 deletions(-)
 create mode 100644 arch/riscv/kernel/vector.S

-- 
2.17.0
