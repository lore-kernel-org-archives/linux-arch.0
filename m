From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
Subject: [PATCH V2 01/30] bitops: add parity functions
Date: Tue, 5 Apr 2016 10:06:21 +0800
Message-ID: <57031D9D.801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Martin Kepplinger <martink@posteo.de>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>, Sasha Levin <sasha.levin@oracle.com>, Denys Vlasenko <dvlasenk@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

These patches provide generic and architecture-specific odd parity 
calculations.

I did not use GCC's __builtin_parity* functions, based on the following 
reasons:
   1. I don't know where to identify which version of GCC from the beginning
      supported __builtin_parity for the architecture.
   2. For the architectures that doesn't have popcount instruction, GCC 
instead use
      "call __paritysi2" (__paritydi2 for 64-bits). So if use 
__builtin_parity, we must
      provide __paritysi2 and __paritydi2 functions for these architectures.
      Additionally, parity4,8,16 might be "__builtin_parity(x & mask)", 
but the "& mask"
      operation is totally unnecessary.
   3. For the architectures that have popcount instruction, we do the 
same things.
   4. For powerpc, sparc, and x86, we do runtime patching to use 
popcount instruction
      if the CPU support.

I have compiled successfully with x86_64_defconfig, i386_defconfig, 
pseries_defconfig
and sparc64_defconfig. And I used the following codes to test:

     #include <stdio.h>
     #include <stdlib.h>
     #include <stdint.h>

     #ifdef __x86_64__
     /* popcnt %edi, %eax -- redundant REX prefix for alignment */
     #define POPCNT32 ".byte 0xf3,0x40,0x0f,0xb8,0xc7"
     /* popcnt %rdi, %rax */
     #define POPCNT64 ".byte 0xf3,0x48,0x0f,0xb8,0xc7"
     #define REG_IN "D"
     #define REG_OUT "a"
     #else
     /* popcnt %eax, %eax */
     #define POPCNT32 ".byte 0xf3,0x0f,0xb8,0xc0"
     #define REG_IN "a"
     #define REG_OUT "a"
     #endif

     static inline int c_parity4(unsigned int w)
     {
         w &= 0xf;
         return (0x6996 >> w) & 1;
     }

     static inline int c_parity8(unsigned int w)
     {
         w ^= w >> 4;
         return c_parity4(w);
     }

     static inline int c_parity16(unsigned int w)
     {
         w ^= w >> 8;
         return c_parity8(w);
     }

     static inline int c_parity32(unsigned int w)
     {
         w ^= w >> 16;
         return c_parity16(w);
     }

     static inline int c_parity64(uint64_t w)
     {
         return c_parity32((unsigned int)w ^ (unsigned int)(w >> 32));
     }

     static inline int asm_parity4(unsigned int w)
     {
         unsigned int res = 0;

         asm("test    $0xf, %1        \n"
             "setpo    %b0                \n"
             : "+q" (res)
             : "r" (w)
             : "cc");

         return res;
     }

     static inline int asm_parity8(unsigned int w)
     {
         unsigned int res = 0;

         asm("test    %1, %1            \n"
             "setpo    %b0            \n"
             : "+q" (res)
             : "r" (w)
             : "cc");

         return res;
     }

     static inline int asm_parity16(unsigned int w)
     {
         unsigned int res = 0;

         asm("xor    %h1, %b1        \n"
             "setpo    %b0            \n"
             : "+q" (res), "+q" (w)
             : : "cc");

         return res;
     }

     static inline int asm_parity32_1(unsigned int w)
     {
         unsigned int res;

         w ^= w >> 16;
         asm("xor    %%ah, %%al        \n"
             "mov    $0, %%eax        \n"
             "setpo    %%al            \n"
             : "=a" (res)
             : "a" (w)
             : "cc");

         return res;
     }

     static inline int asm_parity32_2(unsigned int w)
     {
         unsigned int res;

         asm(POPCNT32 "                \n"
             "andl    $1, %0            \n"
             : "="REG_OUT (res)
             : REG_IN (w)
             : "cc");

         return res;
     }

     #ifdef __x86_64__
     static inline int asm_parity64_1(uint64_t w)
     {
         unsigned int res = (unsigned int)w ^ (unsigned int)(w >> 32);

         res ^= res >> 16;
         asm("xor    %%ah, %%al        \n"
             "mov    $0, %%eax        \n"
             "setpo    %%al            \n"
             : "=a" (res)
             : "a" (res)
             : "cc");

         return res;
     }

     static inline int asm_parity64_2(uint64_t w)
     {
         unsigned int res;

         asm(POPCNT64 "                \n"
             "andl    $1, %0            \n"
             : "="REG_OUT (res)
             : REG_IN (w)
             : "cc");

         return res;
     }
     #else
     static inline int asm_parity64_1(uint64_t w)
     {
         return asm_parity32_1((unsigned int)(w >> 32) ^ (unsigned int)w);
     }

     static inline int asm_parity64_2(uint64_t w)
     {
         return asm_parity32_2((unsigned int)(w >> 32) ^ (unsigned int)w);
     }
     #endif

     int main(int argc, char **argv)
     {
         int ok = 1;
         int count = 1000, i;

         if (argc >= 2)
             count = atoi(argv[1]);

         srand((unsigned)time(NULL));

         for (i = 0; i < count; i++) {
             uint64_t w = rand() | (uint64_t)rand() << 32;
             int p4_1 = c_parity4(w);
             int p4_2 = asm_parity4(w);
             int p8_1 = c_parity8(w);
             int p8_2 = asm_parity8(w);
             int p16_1 = c_parity16(w);
             int p16_2 = asm_parity16(w);
             int p32_1 = c_parity32(w);
             int p32_2 = asm_parity32_1(w);
             int p32_3 = asm_parity32_2(w);
             int p64_1 = c_parity64(w);
             int p64_2 = asm_parity64_1(w);
             int p64_3 = asm_parity64_2(w);
             if (p4_1 != p4_2 ||
                 p8_1 != p8_2 ||
                 p16_1 != p16_2 ||
                 p32_1 != p32_2 || p32_1 != p32_3 ||
                 p64_1 != p64_2 || p64_1 != p64_3) {
                 fprintf(stderr, "Err: %llx\n"
                             "\tc_parity4 = %d, asm_parity4 = %d,\n"
                             "\tc_parity8 = %d, asm_parity8 = %d,\n"
                             "\tc_parity16 = %d, asm_parity16 = %d,\n"
                             "\tc_parity32 = %d, asm_parity32_1 = %d, 
asm_parity32_2 = %d\n"
                             "\tc_parity64 = %d, asm_parity64_1 = %d, 
asm_parity64_2 = %d\n",
                             w, p4_1, p4_2, p8_1, p8_2, p16_1, p16_2, 
p32_1, p32_2, p32_3, p64_1, p64_2, p64_3);
                 ok = 0;
             }
         }

         fprintf(stderr, "%s\n", ok ? "OK" : "FAIL");
         return 0;
     }

---
  include/asm-generic/bitops.h              |  1 +
  include/asm-generic/bitops/arch_parity.h  | 39 
+++++++++++++++++++++++++++++++
  include/asm-generic/bitops/const_parity.h | 36 
++++++++++++++++++++++++++++
  include/asm-generic/bitops/parity.h       |  7 ++++++
  include/linux/bitops.h                    |  5 ++++
  5 files changed, 88 insertions(+)
  create mode 100644 include/asm-generic/bitops/arch_parity.h
  create mode 100644 include/asm-generic/bitops/const_parity.h
  create mode 100644 include/asm-generic/bitops/parity.h

diff --git a/include/asm-generic/bitops.h b/include/asm-generic/bitops.h
index dcdcacf..d85722f 100644
--- a/include/asm-generic/bitops.h
+++ b/include/asm-generic/bitops.h
@@ -27,6 +27,7 @@
  #include <asm-generic/bitops/sched.h>
  #include <asm-generic/bitops/ffs.h>
  #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
  #include <asm-generic/bitops/lock.h>

  #include <asm-generic/bitops/atomic.h>
diff --git a/include/asm-generic/bitops/arch_parity.h 
b/include/asm-generic/bitops/arch_parity.h
new file mode 100644
index 0000000..cddc555
--- /dev/null
+++ b/include/asm-generic/bitops/arch_parity.h
@@ -0,0 +1,39 @@
+#ifndef _ASM_GENERIC_BITOPS_ARCH_PARITY_H_
+#define _ASM_GENERIC_BITOPS_ARCH_PARITY_H_
+
+#include <asm/types.h>
+
+/*
+ * Refrence to 
'https://graphics.stanford.edu/~seander/bithacks.html#ParityParallel'.
+ */
+
+static inline unsigned int __arch_parity4(unsigned int w)
+{
+    w &= 0xf;
+    return (0x6996 >> w) & 1;
+}
+
+static inline unsigned int __arch_parity8(unsigned int w)
+{
+    w ^= w >> 4;
+    return __arch_parity4(w);
+}
+
+static inline unsigned int __arch_parity16(unsigned int w)
+{
+    w ^= w >> 8;
+    return __arch_parity8(w);
+}
+
+static inline unsigned int __arch_parity32(unsigned int w)
+{
+    w ^= w >> 16;
+    return __arch_parity16(w);
+}
+
+static inline unsigned int __arch_parity64(__u64 w)
+{
+    return __arch_parity32((unsigned int)(w >> 32) ^ (unsigned int)w);
+}
+
+#endif /* _ASM_GENERIC_BITOPS_ARCH_PARITY_H_ */
diff --git a/include/asm-generic/bitops/const_parity.h 
b/include/asm-generic/bitops/const_parity.h
new file mode 100644
index 0000000..6af7987
--- /dev/null
+++ b/include/asm-generic/bitops/const_parity.h
@@ -0,0 +1,36 @@
+#ifndef _ASM_GENERIC_BITOPS_CONST_PARITY_H_
+#define _ASM_GENERIC_BITOPS_CONST_PARITY_H_
+
+/*
+ * Compile time versions of __arch_parityN()
+ */
+#define __const_parity4(w)   ((0x6996 >> ((w) & 0xf)) & 1)
+#define __const_parity8(w)   (__const_parity4((w) ^ ((w) >> 4)))
+#define __const_parity16(w)  (__const_parity8((w) ^ ((w) >> 8)))
+#define __const_parity32(w)  (__const_parity16((w) ^ ((w) >> 16)))
+#define __const_parity64(w)  (__const_parity32((w) ^ ((w) >> 32)))
+
+/*
+ * Generic interface.
+ */
+#define parity4(w)   (__builtin_constant_p(w) ? __const_parity4(w) : 
__arch_parity4(w))
+#define parity8(w)   (__builtin_constant_p(w) ? __const_parity8(w) : 
__arch_parity8(w))
+#define parity16(w)  (__builtin_constant_p(w) ? __const_parity16(w) : 
__arch_parity16(w))
+#define parity32(w)  (__builtin_constant_p(w) ? __const_parity32(w) : 
__arch_parity32(w))
+#define parity64(w)  (__builtin_constant_p(w) ? __const_parity64(w) : 
__arch_parity64(w))
+
+/*
+ * Interface for known constant arguments
+ */
+#define PARITY4(w)   (BUILD_BUG_ON_ZERO(!__builtin_constant_p(w)) + 
__const_parity4(w))
+#define PARITY8(w)   (BUILD_BUG_ON_ZERO(!__builtin_constant_p(w)) + 
__const_parity8(w))
+#define PARITY16(w)  (BUILD_BUG_ON_ZERO(!__builtin_constant_p(w)) + 
__const_parity16(w))
+#define PARITY32(w)  (BUILD_BUG_ON_ZERO(!__builtin_constant_p(w)) + 
__const_parity32(w))
+#define PARITY64(w)  (BUILD_BUG_ON_ZERO(!__builtin_constant_p(w)) + 
__const_parity64(w))
+
+/*
+ * Type invariant interface to the compile time constant parity functions.
+ */
+#define PARITY(w)    PARITY64((u64)(w))
+
+#endif /* _ASM_GENERIC_BITOPS_CONST_PARITY_H_ */
diff --git a/include/asm-generic/bitops/parity.h 
b/include/asm-generic/bitops/parity.h
new file mode 100644
index 0000000..a91dce7
--- /dev/null
+++ b/include/asm-generic/bitops/parity.h
@@ -0,0 +1,7 @@
+#ifndef _ASM_GENERIC_BITOPS_PARITY_H_
+#define _ASM_GENERIC_BITOPS_PARITY_H_
+
+#include <asm-generic/bitops/arch_parity.h>
+#include <asm-generic/bitops/const_parity.h>
+
+#endif /* _ASM_GENERIC_BITOPS_PARITY_H_ */
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index defeaac..8952f88 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -80,6 +80,11 @@ static __always_inline unsigned long 
hweight_long(unsigned long w)
      return sizeof(w) == 4 ? hweight32(w) : hweight64(w);
  }

+static __always_inline unsigned int parity_long(unsigned long w)
+{
+    return sizeof(w) == 4 ? parity32(w) : parity64(w);
+}
+
  /**
   * rol64 - rotate a 64-bit value left
   * @word: value to rotate
-- 
2.5.0
