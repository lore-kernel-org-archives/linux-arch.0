From: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
Subject: Re: [RFC2 nowrap: PATCH v7 00/18] ILP32 for ARM64
Date: Fri, 2 Sep 2016 18:20:34 +0800
Message-ID: <57C95272.1060603@huawei.com>
References: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1471434403-25291-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-doc-owner@vger.kernel.org
To: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, manuel.montezelo@gmail.com, linyongting@huawei.com, maxim.kuvyrkov@linaro.org, davem@davemloft.net, zhouchengming1@huawei.com, cmetcalf@ezchip.com, Hanjun Guo <guohanjun@huawei.com>, jijun 00321192 <jijun2@huawei.com>, "liupeifeng (A)" <liupeifeng3@huawei.com>, hushiyuan 00178794 <hushiyuan@huawei.com>, zhangjian 00293696 <bamvor.zhangjian@huawei.com>
List-Id: linux-arch.vger.kernel.org

Base on the off-list discussion, the community care about the
performance regression of aarch64 LP64 and aarch32 after ILP32
is merged.

Given that there is not big open issue in ILP32 in kernel part, I try
to address this concern. It is reasonable that we should run lots of
testsuite(such as LKP) to ensure there is no performance regression.
But I am not expert of this, I started from test the lmbench for
aarch64 LP64 and compare the differnce between ILP32 enabled and
without ILP32 patches.

The branch I used is ilp32-4.8 on [1], compare the result between
two commit "d3746f1 arm64:ilp32: add ARM64_ILP32 to Kconfig"(defconfig
with CONFIG_ARM64_ILP32) and "3054de8 fiz set_personality by Catalin"
(defconfig).

The result show there is no big difference. Most of the difference is
less than 5%. Only two differnce more than 10%:
1.  Context switching 2p/16K 13.16%(ILP32 is bigger than No_ILP32.
    smaller is better)
2.  *Local* Communication bandwidths: TCP -10.77%.(ILP32 is smaller than
    No_ILP32. bigger is better).


If it is make sense to community, I could continue to do more that.

Thanks

Bamvor

[1] https://github.com/norov/linux.git
[2] The full result: (ILP32 - No_ILP32)/No_ILP32

                 L M B E N C H  3 . 0   S U M M A R Y
                 ------------------------------------
                 (Alpha software, do not distribute)

Basic system parameters
------------------------------------------------------------------------------
Host                 OS Description              Mhz  tlb  cache  mem   scal
                                                     pages line   par   load
                                                           bytes
--------- ------------- ----------------------- ---- ----- ----- ------ ----
buildroot Linux 4.8.0-r A64_ILP32_diff_No_ILP32 1024    32   128 0.23%     1

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
buildroot Linux 4.8.0-r 0.00% 0.00% 0.00% -3.03% -0.42% -1.96% 0.00% -0.67% 2.29% -6.34% 0.85%

Basic integer operations - times in nanoseconds - smaller is better
-------------------------------------------------------------------
Host                 OS  intgr intgr  intgr  intgr  intgr
                          bit   add    mul    div    mod
--------- ------------- ------ ------ ------ ------ ------
buildroot Linux 4.8.0-r 0.00%  0.00%  0.00%  0.00%  0.00%

Basic uint64 operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS int64  int64  int64  int64  int64
                         bit    add    mul    div    mod
--------- ------------- ------ ------ ------ ------ ------
buildroot Linux 4.8.0-r  0.00%        0.00%  0.00%  0.00%

Basic float operations - times in nanoseconds - smaller is better
-----------------------------------------------------------------
Host                 OS  float  float  float  float
                         add    mul    div    bogo
--------- ------------- ------ ------ ------ ------
buildroot Linux 4.8.0-r 0.00%  0.00%  0.04%  0.00%

Basic double operations - times in nanoseconds - smaller is better
------------------------------------------------------------------
Host                 OS  double double double double
                         add    mul    div    bogo
--------- ------------- ------  ------ ------ ------
buildroot Linux 4.8.0-r 0.00%  0.00%    0.00%  0.00%

Context switching - times in microseconds - smaller is better
-------------------------------------------------------------------------
Host                 OS  2p/0K 2p/16K 2p/64K 8p/16K 8p/64K 16p/16K 16p/64K
                         ctxsw  ctxsw  ctxsw ctxsw  ctxsw   ctxsw   ctxsw
--------- ------------- ------ ------ ------ ------ ------ ------- -------
buildroot Linux 4.8.0-r  -6.00%  13.16% -1.83% 3.80%  9.94%  -6.17%   2.72%

*Local* Communication latencies in microseconds - smaller is better
---------------------------------------------------------------------
Host                 OS 2p/0K  Pipe AF     UDP  RPC/   TCP  RPC/ TCP
                        ctxsw       UNIX         UDP         TCP conn
--------- ------------- ----- ----- ---- ----- ----- ----- ----- ----
buildroot Linux 4.8.0-r -6.00% -4.08% 1.95% -5.02%    4.87%     0.00%


File & VM system latencies in microseconds - smaller is better
-------------------------------------------------------------------------------
Host                 OS   0K File      10K File     Mmap    Prot   Page   100fd
                        Create Delete Create Delete Latency Fault  Fault  selct
--------- ------------- ------ ------ ------ ------ ------- ----- ------- -----
buildroot Linux 4.8.0-r -2.92%  0.49% -0.96% -0.55%   1.70% -3.00% 0.94% -4.35%

*Local* Communication bandwidths in MB/s - bigger is better
-----------------------------------------------------------------------------
Host                OS  Pipe   AF      TCP    File   Mmap  Bcopy  Bcopy  Mem   Mem
                               UNIX          reread reread (libc) (hand) read write
--------- ------------- ---- ---- ---- ------ ------ ------ ------ ---- -----
buildroot Linux 4.8.0-r -3.16% 7.77% -10.77% -0.13% -0.41% 1.38% -0.21% -0.46% 1.79%

Memory latencies in nanoseconds - smaller is better
    (WARNING - may not be correct, check graphs)
------------------------------------------------------------------------------
Host                 OS   Mhz   L1 $   L2 $    Main mem    Rand mem    Guesses
--------- -------------   ---   ----   ----    --------    --------    -------
buildroot Linux 4.8.0-r  0.00% 0.00% -0.02%        1.12%     -4.05%

On 08/17/2016 07:46 PM, Yury Norov wrote:
> This series enables aarch64 with ilp32 mode, and as supporting work,
> introduces ARCH_32BIT_OFF_T configuration option that is enabled for
> existing 32-bit architectures but disabled for new arches (so 64-bit
> off_t is is used by new userspace).
> 
> This version is based on kernel v4.8-rc2.
> It works with glibc-2.23, and tested with LTP.
> 
> This is RFC because there is still no solid understanding what type of registers
> top-halves delousing we prefer. In this patchset, w0-w7 are cleared for each
> syscall in assembler entry. The alternative approach is in introducing compat
> wrappers which is little faster for natively routed syscalls (~2.6% for syscall
> with no payload) but much more complicated.
> 
> There's no major changes here comparing to previous submission, mostly
> the rebase to current master. All changes in details are listed below.
> No additional regression is observed since previous submission.
> 
> Patch 1 may be applied separately from other patches of series.
> 
> v3: https://lkml.org/lkml/2014/9/3/704
> v4: https://lkml.org/lkml/2015/4/13/691
> v5: https://lkml.org/lkml/2015/9/29/911
> v6: https://lkml.org/lkml/2016/5/23/661
> v7: RFC nowrap: https://lkml.org/lkml/2016/6/17/990
> v7: RFC2 nowrap:
>  - rebased on kernel 4.8-rc2;
>  - setrlimit(), getrlimit() are handled by non-compat handlers to follow 
>    switching rlim_t to 64-bit in glibc, as pointed by Andreas Shwab;
>  - fixed {GET,SET}SIGMASK handling in ptrace(), as pointed by Zhou Chengming;
>  - removed put_sig{set,get)_t duplication;
>  - patches 1 and 2 from previous submission are joined, missed chunk restored,
>    found by by Andreas Shwab.
> 
> Links:
> Kernel: https://github.com/norov/linux/commits/ilp32-4.8
> glibc:  https://github.com/norov/glibc/commits/ilp32-2.24-dev
> 
> Andrew Pinski (6):
>   arm64: ensure the kernel is compiled for LP64
>   arm64: rename COMPAT to AARCH32_EL0 in Kconfig
>   arm64:uapi: set __BITS_PER_LONG correctly for ILP32 and LP64
>   arm64: ilp32: add sys_ilp32.c and a separate table (in entry.S) to use
>     it
>   arm64: ilp32: introduce ilp32-specific handlers for sigframe and
>     ucontext
>   arm64:ilp32: add ARM64_ILP32 to Kconfig
> 
> Philipp Tomsich (1):
>   arm64:ilp32: add vdso-ilp32 and use for signal return
> 
> Yury Norov (11):
>   32-bit ABI: introduce ARCH_32BIT_OFF_T config option
>   arm64: ilp32: add documentation on the ILP32 ABI for ARM64
>   thread: move thread bits accessors to separated file
>   arm64: introduce is_a32_task and is_a32_thread (for AArch32 compat)
>   arm64: ilp32: add is_ilp32_compat_{task,thread} and TIF_32BIT_AARCH64
>   arm64: introduce binfmt_elf32.c
>   arm64: ilp32: introduce binfmt_ilp32.c
>   arm64: ilp32: share aarch32 syscall handlers
>   arm64: signal: share lp64 signal routines to ilp32
>   arm64: signal32: move ilp32 and aarch32 common code to separated file
>   arm64: ptrace: handle ptrace_request differently for aarch32 and ilp32
> 
>  Documentation/arm64/ilp32.txt                 |  54 ++++++++
>  arch/Kconfig                                  |   4 +
>  arch/arc/Kconfig                              |   1 +
>  arch/arm/Kconfig                              |   1 +
>  arch/arm64/Kconfig                            |  19 ++-
>  arch/arm64/Makefile                           |   5 +
>  arch/arm64/include/asm/compat.h               |  19 +--
>  arch/arm64/include/asm/elf.h                  |  29 +++--
>  arch/arm64/include/asm/fpsimd.h               |   2 +-
>  arch/arm64/include/asm/ftrace.h               |   2 +-
>  arch/arm64/include/asm/hwcap.h                |   6 +-
>  arch/arm64/include/asm/is_compat.h            |  90 ++++++++++++++
>  arch/arm64/include/asm/memory.h               |   5 +-
>  arch/arm64/include/asm/processor.h            |  11 +-
>  arch/arm64/include/asm/ptrace.h               |   2 +-
>  arch/arm64/include/asm/signal32.h             |   9 +-
>  arch/arm64/include/asm/signal32_common.h      |  28 +++++
>  arch/arm64/include/asm/signal_common.h        |  33 +++++
>  arch/arm64/include/asm/signal_ilp32.h         |  38 ++++++
>  arch/arm64/include/asm/syscall.h              |   2 +-
>  arch/arm64/include/asm/thread_info.h          |   4 +-
>  arch/arm64/include/asm/unistd.h               |   6 +-
>  arch/arm64/include/asm/unistd32.h             |   2 +-
>  arch/arm64/include/asm/vdso.h                 |   6 +
>  arch/arm64/include/uapi/asm/bitsperlong.h     |   9 +-
>  arch/arm64/kernel/Makefile                    |  18 ++-
>  arch/arm64/kernel/asm-offsets.c               |   9 +-
>  arch/arm64/kernel/binfmt_elf32.c              |  31 +++++
>  arch/arm64/kernel/binfmt_ilp32.c              |  96 +++++++++++++++
>  arch/arm64/kernel/cpufeature.c                |   8 +-
>  arch/arm64/kernel/cpuinfo.c                   |  20 +--
>  arch/arm64/kernel/entry.S                     |  34 ++++-
>  arch/arm64/kernel/entry32.S                   |  65 ----------
>  arch/arm64/kernel/entry32_common.S            |  93 ++++++++++++++
>  arch/arm64/kernel/entry_ilp32.S               |  23 ++++
>  arch/arm64/kernel/head.S                      |   2 +-
>  arch/arm64/kernel/hw_breakpoint.c             |  10 +-
>  arch/arm64/kernel/perf_regs.c                 |   2 +-
>  arch/arm64/kernel/process.c                   |   7 +-
>  arch/arm64/kernel/ptrace.c                    | 110 +++++++++++++++--
>  arch/arm64/kernel/signal.c                    | 102 +++++++++------
>  arch/arm64/kernel/signal32.c                  | 107 ----------------
>  arch/arm64/kernel/signal32_common.c           | 136 ++++++++++++++++++++
>  arch/arm64/kernel/signal_ilp32.c              | 171 ++++++++++++++++++++++++++
>  arch/arm64/kernel/sys32.c                     |   1 +
>  arch/arm64/kernel/sys_ilp32.c                 |  86 +++++++++++++
>  arch/arm64/kernel/traps.c                     |   5 +-
>  arch/arm64/kernel/vdso-ilp32/.gitignore       |   2 +
>  arch/arm64/kernel/vdso-ilp32/Makefile         |  74 +++++++++++
>  arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S     |  33 +++++
>  arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S |  95 ++++++++++++++
>  arch/arm64/kernel/vdso.c                      |  79 +++++++++---
>  arch/arm64/kernel/vdso/gettimeofday.S         |  18 ++-
>  arch/blackfin/Kconfig                         |   1 +
>  arch/cris/Kconfig                             |   1 +
>  arch/frv/Kconfig                              |   1 +
>  arch/h8300/Kconfig                            |   1 +
>  arch/hexagon/Kconfig                          |   1 +
>  arch/m32r/Kconfig                             |   1 +
>  arch/m68k/Kconfig                             |   1 +
>  arch/metag/Kconfig                            |   1 +
>  arch/microblaze/Kconfig                       |   1 +
>  arch/mips/Kconfig                             |   1 +
>  arch/mn10300/Kconfig                          |   1 +
>  arch/nios2/Kconfig                            |   1 +
>  arch/openrisc/Kconfig                         |   1 +
>  arch/parisc/Kconfig                           |   1 +
>  arch/powerpc/Kconfig                          |   1 +
>  arch/score/Kconfig                            |   1 +
>  arch/sh/Kconfig                               |   1 +
>  arch/sparc/Kconfig                            |   1 +
>  arch/tile/Kconfig                             |   1 +
>  arch/unicore32/Kconfig                        |   1 +
>  arch/x86/Kconfig                              |   1 +
>  arch/x86/um/Kconfig                           |   1 +
>  arch/xtensa/Kconfig                           |   1 +
>  drivers/clocksource/arm_arch_timer.c          |   2 +-
>  include/linux/fcntl.h                         |   2 +-
>  include/linux/ptrace.h                        |   6 +
>  include/linux/thread_bits.h                   |  55 +++++++++
>  include/linux/thread_info.h                   |  44 +------
>  include/uapi/asm-generic/unistd.h             |   5 +-
>  kernel/ptrace.c                               |  10 +-
>  83 files changed, 1597 insertions(+), 374 deletions(-)
>  create mode 100644 Documentation/arm64/ilp32.txt
>  create mode 100644 arch/arm64/include/asm/is_compat.h
>  create mode 100644 arch/arm64/include/asm/signal32_common.h
>  create mode 100644 arch/arm64/include/asm/signal_common.h
>  create mode 100644 arch/arm64/include/asm/signal_ilp32.h
>  create mode 100644 arch/arm64/kernel/binfmt_elf32.c
>  create mode 100644 arch/arm64/kernel/binfmt_ilp32.c
>  create mode 100644 arch/arm64/kernel/entry32_common.S
>  create mode 100644 arch/arm64/kernel/entry_ilp32.S
>  create mode 100644 arch/arm64/kernel/signal32_common.c
>  create mode 100644 arch/arm64/kernel/signal_ilp32.c
>  create mode 100644 arch/arm64/kernel/sys_ilp32.c
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/.gitignore
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/Makefile
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.S
>  create mode 100644 arch/arm64/kernel/vdso-ilp32/vdso-ilp32.lds.S
>  create mode 100644 include/linux/thread_bits.h
> 
