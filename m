From: changbin.du@intel.com
Subject: [PATCH v2 4/5] kernel hacking: new config DEBUG_EXPERIENCE to apply GCC -Og optimization
Date: Wed,  2 May 2018 21:44:59 +0800
Message-ID: <1525268700-10631-5-git-send-email-changbin.du@intel.com>
References: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525268700-10631-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org
Cc: rostedt@goodmis.org, rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Changbin Du <changbin.du@intel.com>
List-Id: linux-arch.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

This will apply GCC '-Og' optimization level which is supported
since GCC 4.8. This optimization level offers a reasonable level
of optimization while maintaining fast compilation and a good
debugging experience. It is similar to '-O1' while perfer keeping
debug ability over runtime speed.

If enabling this option breaks your kernel, you should either
disable this or find a fix (mostly in the arch code). Currently
this option has only be tested on x86_64 platform.

This option can satisfy people who was searching for a method
to disable compiler optimizations so to achieve better kernel
debugging experience with kgdb or qemu.

The main problem of '-Og' is we must not use __attribute__((error(msg))).
The compiler will report error though the call to error function
still can be optimize out. So we must fallback to array tricky.

Comparison of vmlinux size: a bit smaller.

    w/o CONFIG_DEBUG_EXPERIENCE
    $ size vmlinux
       text    data     bss     dec     hex filename
    22665554   9709674  2920908 35296136        21a9388 vmlinux

    w/ CONFIG_DEBUG_EXPERIENCE
    $ size vmlinux
       text    data     bss     dec     hex filename
    21499032   10102758 2920908 34522698        20ec64a vmlinux

Comparison of system performance: a bit drop (~6%).
    This benchmark of kernel compilation is suggested by Ingo Molnar.
    https://lkml.org/lkml/2018/5/2/74

    Preparation: Set cpufreq to 'performance'.
    for ((cpu=0; cpu<120; cpu++)); do
      G=/sys/devices/system/cpu/cpu$cpu/cpufreq/scaling_governor
      [ -f $G ] && echo performance > $G
    done

    w/o CONFIG_DEBUG_EXPERIENCE
    $ perf stat --repeat 5 --null --pre                 '\
        cp -a kernel ../kernel.copy.$(date +%s);         \
        rm -rf *;                                        \
        git checkout .;                                  \
        echo 1 > /proc/sys/vm/drop_caches;               \
        find ../kernel* -type f | xargs cat >/dev/null;  \
        make -j kernel >/dev/null;                       \
        make clean >/dev/null 2>&1;                      \
        sync                                            '\
                                                         \
        make -j8 >/dev/null

     Performance counter stats for 'make -j8' (5 runs):

        219.764246652 seconds time elapsed                   ( +-  0.78% )

    w/ CONFIG_DEBUG_EXPERIENCE
    $ perf stat --repeat 5 --null --pre                 '\
        cp -a kernel ../kernel.copy.$(date +%s);         \
        rm -rf *;                                        \
        git checkout .;                                  \
        echo 1 > /proc/sys/vm/drop_caches;               \
        find ../kernel* -type f | xargs cat >/dev/null;  \
        make -j kernel >/dev/null;                       \
        make clean >/dev/null 2>&1;                      \
        sync                                            '\
                                                         \
        make -j8 >/dev/null

    Performance counter stats for 'make -j8' (5 runs):

         233.574187771 seconds time elapsed                  ( +-  0.19% )

Signed-off-by: Changbin Du <changbin.du@intel.com>

---
v2:
  o Improve performance benchmark as suggested by Ingo.
  o Grammar updates in description. (Randy Dunlap)
---
 Makefile                     |  4 ++++
 include/linux/compiler-gcc.h |  2 +-
 include/linux/compiler.h     |  2 +-
 lib/Kconfig.debug            | 21 +++++++++++++++++++++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index eb694f6..6a10469 100644
--- a/Makefile
+++ b/Makefile
@@ -639,6 +639,9 @@ KBUILD_CFLAGS	+= $(call cc-disable-warning, format-truncation)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS	+= $(call cc-disable-warning, int-in-bool-context)
 
+ifdef CONFIG_DEBUG_EXPERIENCE
+KBUILD_CFLAGS	+= $(call cc-option, -Og)
+else
 ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
 KBUILD_CFLAGS	+= $(call cc-option,-Oz,-Os)
 KBUILD_CFLAGS	+= $(call cc-disable-warning,maybe-uninitialized,)
@@ -649,6 +652,7 @@ else
 KBUILD_CFLAGS   += -O2
 endif
 endif
+endif
 
 KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
 			$(call cc-disable-warning,maybe-uninitialized,))
diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index b4bf73f..b8b3832 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -192,7 +192,7 @@
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-#ifndef __CHECKER__
+#if !defined(__CHECKER__) && !defined(CONFIG_DEBUG_EXPERIENCE)
 # define __compiletime_warning(message) __attribute__((warning(message)))
 # define __compiletime_error(message) __attribute__((error(message)))
 #endif /* __CHECKER__ */
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index ab4711c..952cc7f 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -301,7 +301,7 @@ unsigned long read_word_at_a_time(const void *addr)
  * sparse see a constant array size without breaking compiletime_assert on old
  * versions of GCC (e.g. 4.2.4), so hide the array from sparse altogether.
  */
-# ifndef __CHECKER__
+# if !defined(__CHECKER__) && !defined(CONFIG_DEBUG_EXPERIENCE)
 #  define __compiletime_error_fallback(condition) \
 	do { ((void)sizeof(char[1 - 2 * condition])); } while (0)
 # endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ab55801..e264199 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -216,6 +216,27 @@ config NO_AUTO_INLINE
 
 	  If unsure, select N.
 
+config DEBUG_EXPERIENCE
+	bool "Optimize for better debugging experience (-Og)"
+	default n
+	select NO_AUTO_INLINE
+	depends on !CC_OPTIMIZE_FOR_SIZE
+	help
+	  This will apply GCC '-Og' optimization level which is supported
+	  since GCC 4.8. This optimization level offers a reasonable level
+	  of optimization while maintaining fast compilation and a good
+	  debugging experience. It is similar to '-O1' while preferring to
+	  keep debug ability over runtime speed. The overall performance
+	  will drop a bit (~6%).
+
+	  Use only if you want to debug the kernel, especially if you want
+	  to have better kernel debugging experience with gdb facilities
+	  like kgdb or qemu. If enabling this option breaks your kernel,
+	  you should either disable this or find a fix (mostly in the arch
+	  code). Currently this option has only be tested on x86_64 platform.
+
+	  If unsure, select N.
+
 config ENABLE_WARN_DEPRECATED
 	bool "Enable __deprecated logic"
 	default y
-- 
2.7.4
