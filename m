From: changbin.du@intel.com
Subject: [PATCH 0/5] kernel hacking: GCC optimization for debug experience (-Og)
Date: Tue,  1 May 2018 21:00:09 +0800
Message-ID: <1525179614-14571-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org
Cc: x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Changbin Du <changbin.du@intel.com>
List-Id: linux-arch.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

Hi all,
I know some kernel developers was searching for a method to dissable GCC
optimizations, probably they want to apply GCC '-O0' option. But since Linux
kernel replys on GCC optimization to remove some dead code, so '-O0' just
breaks the build. They do need this because they want to debug kernel with
qemu, simics, kgtp or kgdb.

Thanks for the GCC '-Og' optimization level introduced in GCC 4.8, which
offers a reasonable level of optimization while maintaining fast compilation
and a good debugging experience. It is similar to '-O1' while perfer keeping
debug ability over runtime speed. With '-Og', we can build a kernel with
better debug ability and little performance drop after some simple change.

In this serias, firstly introduce a new config CONFIG_NO_AUTO_INLINE after two
fixes. Selecting this option will make compiler not auto-inline kernel
functions.This is useful when you are using ftrace to understand the control
flow of kernel code or tracing some static functions.

Then introduce new config CONFIG_DEBUG_EXPERIENCE which apply '-Og'
optimization level for whole kernel, with a simple fix in fix_to_virt().
Currently this option is only tested on a QEMU gust and it works fine.

Comparison of vmlinux size: a bit smaller.

    w/o CONFIG_DEBUG_EXPERIENCE
    $ size vmlinux
       text    data     bss     dec     hex filename
    22665554   9709674  2920908 35296136        21a9388 vmlinux

    w/ CONFIG_DEBUG_EXPERIENCE
    $ size vmlinux
       text    data     bss     dec     hex filename
    21499032   10102758 2920908 34522698        20ec64a vmlinux

Comparison of system performance: a bit drop.

    w/o CONFIG_DEBUG_EXPERIENCE
    $ time make -j4
    real    6m43.619s
    user    19m5.160s
    sys     2m20.287s

    w/ CONFIG_DEBUG_EXPERIENCE
    $ time make -j4
    real    6m55.054s
    user    19m11.129s
    sys     2m36.345s

Changbin Du (5):
  x86/mm: surround level4_kernel_pgt with #ifdef
    CONFIG_X86_5LEVEL...#endif
  regulator: add dummy of_find_regulator_by_node
  kernel hacking: new config NO_AUTO_INLINE to disable compiler
    atuo-inline optimizations
  kernel hacking: new config DEBUG_EXPERIENCE to apply GCC -Og
    optimization
  asm-generic: fix build error in fix_to_virt with
    CONFIG_DEBUG_EXPERIENCE

 Makefile                          | 10 ++++++++++
 arch/x86/include/asm/pgtable_64.h |  2 ++
 arch/x86/kernel/head64.c          | 13 ++++++-------
 drivers/regulator/internal.h      |  9 +++++++--
 include/asm-generic/fixmap.h      |  3 ++-
 include/linux/compiler-gcc.h      |  2 +-
 include/linux/compiler.h          |  2 +-
 lib/Kconfig.debug                 | 34 ++++++++++++++++++++++++++++++++++
 8 files changed, 63 insertions(+), 12 deletions(-)

-- 
2.7.4
