Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDD03876A9
	for <linux-arch@vger.kernel.org>; Fri, 16 Oct 2026 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792119407; cv=none; b=mHV8j7RsTMqoPbq8HpjM7TXAZgDFqZLf/9mgVdAp39Ac1otrglR08EIw6Lt9npnbZ6q0mKFzHtY2yNrpXx6f9wFtnSXRN/UDr2iXwiIZNZcHWAeLfrIXDz9Ww1Xc1bR1hl3r/dQGJYQkLKRUuRO7UM2zuopoWDYmNQfbVagX580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792119407; c=relaxed/simple;
	bh=VLz0q3s7RsO5fzwcVDaeJtBet12srSV3Qn+XGcWeu7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o4QxIiM9Kq2cFC4jkMXOiEpc+N6U1I+YvCV/ED3UgC3a1M8O2Z87msmmpN8rZQHOmF6gjDVp5d0v8E5r4BuB1f6uRu6FAMYoWp37QyJdk+iI1uATiISZ1BdI2BzK7qIYdgTulArDwLshZWbIH87lAf/wQ7WkJI2J0mSoS8ZaWj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyVP/dxY; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyVP/dxY"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc758830601so1934227a12.2
        for <linux-arch@vger.kernel.org>; Thu, 15 Oct 2026 19:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792119403; x=1792724203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LbAGLkUAj40wmIzpusJ55mCpcacDel7IyLN6V4xCHLE=;
        b=CyVP/dxY4gUFZyCN+2d30Hv+6o36bUKBNcAQ7X1ttz8bxifCJxERm+O6ildfDDx2cF
         vjuN74F6QQj80zSlKUPhGBuN/82iJ3TyRGl6YUen3H8HEzs+I7y92rdE42dP2JX6jHC6
         VpujJRauc3evoYFOg2aC0eZRAcSaMSaD6i4yFJa2MuYwKgUnaeCJj0Kh847cq+ntwAa2
         J6JqnJB22I1OkhpvllLxg5qqub7epgFs5rVgaW60UEV2MBflZjda+H8ErIdGM9uXCxT1
         HPW8zHnTHkElw/iUqp6u9bBEb5a1FlAWTO3VkUHrBPmOuw3soWrWkTW3n6QqkLm3SBiK
         3kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792119403; x=1792724203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LbAGLkUAj40wmIzpusJ55mCpcacDel7IyLN6V4xCHLE=;
        b=wna+F2XxtVrrFiNekKc5eakRt2O1xQr/oM7prbtCwTMr7e1QzNZxM6GysgJhfAvGmF
         kdqEm9h8MzHxtDcXciPKol/zAqhqetlsDwJbbEppkeS78Pj+jy67BRIMVRXiWcUUCmJa
         sYQZCGCDGmO9+wvLSvXGJlN+TkPCsTMumPa6tym6CHgv7xgY4FLUQxPlSJg+gL3g6OBC
         W4cldJo91i5GEVIPZdIVFfxw3mdl4dFCK3+D0oPnZY21Gu+Fa9qe7EacwdCDLGqTo43n
         +8d8gysybC6hKm+FGy/cqyZrEn/GGAfbxjRApJ1C77GlyHU2Qknjii+o5n3MDUlzlkEd
         qANQ==
X-Forwarded-Encrypted: i=1; AKwUvBwL654TlGPumEIMu51nUmYnq2chsUoIMU1YyaE5VQDZLuQrVN1mmKqiF2buiL2xsqV3NIVcu8iBjnwd@vger.kernel.org
X-Gm-Message-State: AFq9FYIxJmNflCv6bnYnctfaFMP9I4UdOWOBbi77NYTkwAy0vPDc15yf
	IyoCZCYQmdNn+pSjxLhEWHPJMLWLwfKRhe4CVVBZ8AtgroF0g3UZ0K7ngrgZeXjITvU=
X-Gm-Gg: AYBFou0jXHWdq/+6Rl1CR7j1JV3MXXtpfjWlkhAxoj61u/zyxJblpTjwCRo6qUzOQjf
	Q+1wx8TWKvxtQUUPlGvVxSp0gdNVrSJdIFtrgwpkh/+6qXRWwDx0BUYr+PfIihiv0wmBb6O5hXB
	bfHJV+Cj4ZgxIVV4iJwucPt/QJtQkCFbLe8qHr70pH5ngqlClA9gRuHtTmHkXDoFOUdu7YPESMo
	7s6/JX2PODOudbqjOOufKOPzbCkmxiA6z8iMh6+MbqsvVMBbgQn6XD/FwzWpHjXkxIXO4LSMOJF
	P1Oatk+p6J1pQ38VAgf0qteV8kWM3g9wCTrOBChHU913X08yJAtBc9FF8YXVGZ0eenkcY/k3lXQ
	wBTPEimrg2/mhkWi1abuFhWCIp23MGnfFuDVNwi0FHbdy7DJLdGGwTvFSIYIIbrYnfSfEZACE5R
	GOM92S7QbuupfKgP09X8KCbKVlvDUn/3yCuplAJZAQEhXQgHjmWLYFaY6VJGaquzN8Rbpq9xxC7
	jg=
X-Received: by 2002:a17:90b:4d0b:b0:3ab:1285:dfd6 with SMTP id 98e67ed59e1d1-3ac6f2952e2mr6903472a91.38.1792119403203;
        Thu, 15 Oct 2026 19:56:43 -0700 (PDT)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3c8e2c9sm275821a91.2.2026.10.15.19.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:56:42 -0700 (PDT)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bitops: Share the generic ffs()/fls() binary search via UNROLL()
Date: Fri, 16 Oct 2026 10:56:34 +0800
Message-Id: <20261016025634.2690862-1-shingekinocore@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic_ffs(), generic___ffs(), generic_fls() and generic___fls() each
open-code the same binary search: if the low (or high) half of the bits
still in play is zero, shift it out and adjust the result, then repeat
with half the width. Each copy spells out its own masks, the two
unsigned long versions need an #if for their 32-bit step, and the
copies differ in the order of the two updates in a step and in how the
test is written. They implement some or all of these operations on
riscv (without Zbb, and as the fallback with Zbb), ARM before ARMv5,
m68k without bitfield instructions, sh, sparc32, microblaze, nios2 and
a few other architectures.

Add <asm-generic/bitops/ffs-fls-search.h> with one search step per
direction, whose shift and mask follow from the step number and the
type of the word, and expand the steps with UNROLL() from
<linux/unroll.h>. The four functions keep their definitions and
kernel-doc; only the steps are shared. UNROLL() works in the
preprocessor, so every shift and mask is still an integer constant
expression. Its count has to be a literal, so rather than hard-coding
six steps for a 64-bit word, expand the 20 that UNROLL() supports: a
step past the width of the word shifts by 0 and is optimized away,
which also removes the #if.

The shared step tests with "!", shifts the word and then adjusts the
result, as generic_ffs() and generic_fls() did, so those two compile to
the same code as before. generic___ffs() and generic___fls() adjusted
the result first; GCC now mostly emits the same instructions with the
shift and the update swapped, and Clang 18 changes a few riscv callers
somewhat more (sizes below). Nothing was timed on hardware that runs
this code. For the reordered code, models of the affected cores
(llvm-mca for riscv) predict no slowdown, except 1-2 cycles on a few
inputs in the out-of-order SiFive P450 model, whereas adjusting the
result first in all four functions is predicted to slow down
generic_ffs() and generic_fls().

A plain loop with unrolled_full would not need the step macros, but the
pragma is only a hint and leaves the code to each compiler's unroller:
both GCC and Clang unroll the loop completely, yet Clang then generates
different code for nearly every target, better in some cases and worse
in others, and so does GCC in some callers once the helpers are inlined.

As a side effect, every user of <linux/bitops.h> on these architectures,
including every riscv kernel, now also sees <linux/unroll.h>. The header
is small, but it defines the lower-case object-like macros unrolled,
unrolled_full and unrolled_none, so a variable, struct member or
parameter with one of these names stops building there while it still
builds on x86 and arm64. With GCC 11 and later, a parameter named
"unrolled" can even build, with only -Wunknown-pragmas warnings, and
silently lose its value. No in-tree code uses these names.

Results are unchanged for every 32-bit argument and every 64-bit word
with a zero low half (QEMU user mode; riscv64, rv32, m68k, sh4,
sparc32, ARMv4T, openrisc and parisc with GCC 16.2, riscv64 with Clang
18). The ffs and bitops KUnit tests, test_bitmap and test_bitops pass
on riscv64 without Zbb, and W=1 builds report no new warnings.

bloat-o-meter on vmlinux with GCC 16.2: no change for arm v4t, m68k
ColdFire 5475, sh4, sparc32, openrisc, parisc64 and xtensa without NSA;
+4 bytes for riscv without Zbb. With Clang 18, riscv without Zbb is -38
bytes (assoc_array_insert() -42, iio_device_add_event() +8). m68k
ColdFire 5208 is +16 bytes, from two functions that use none of these
helpers; GCC compiles them identically with -ftrack-macro-expansion=0.

Signed-off-by: Tzu-Ching Yang <shingekinocore@gmail.com>
---
<linux/unroll.h> now reaches 2327 of 2513 compiled units in a riscv
defconfig build (Zbb off), up from 44. Test modules with a local
variable or struct member named "unrolled" fail to build with this
patch on riscv (GCC with Zbb on and off, Clang with Zbb off), m68k
ColdFire and ARMv4T, and still build on x86_64 and arm64.

Generated code. generic_ffs() and generic_fls() are unchanged. In
callers of generic___ffs() and generic___fls() the shift and the
counter update trade places, e.g. riscv64 _find_first_bit(), GCC 16.2:

    mainline                   with this patch
    bnez   a3,<next>           bnez   a3,<next>
    addiw  a0,a0,16            srli   a4,a4,0x10
    srli   a4,a4,0x10          addiw  a0,a0,16
    zext.b a3,a4               zext.b a3,a4

Functions that differ in vmlinux, GCC 16.2:
  riscv, Zbb off   300; 298 reordered only, 2 with other registers
                   (alloc_large_system_hash +6 bytes, bpf_msg_push_data
                   one instruction fewer, same size)
  loongarch32      144 (LA32R), reordered only
  parisc64         114 (__fls only); 90 reordered only, 23 with another
                   delay slot fill, 1 with two registers swapped
  sparc32 48, openrisc 44, xtensa 12 (one also renames registers),
  sh4 4: reordered only
  arm v4t, m68k ColdFire 5475: vmlinux byte-identical
  m68k ColdFire 5208: percpu_rwsem_wait +8, __wait_for_common -4; they
                   inline no ffs/fls helper and compile identically with
                   -ftrack-macro-expansion=0 or -g
Except on riscv and 5208, function sizes are unchanged. Clang 18, riscv
with Zbb off: 12 functions, none only reordered; the _find_first*_bit()
helpers use "or" instead of "add" for idx + __ffs(),
assoc_array_insert() is 42 bytes smaller and iio_device_add_event() 8
bytes larger, with a 16-byte larger stack frame.

bloat-o-meter, riscv defconfig with RISCV_ISA_ZBB=n:
  GCC 16.2: add/remove: 0/0 grow/shrink: 1/1 up/down: 6/-2 (4)
  Clang 18: add/remove: 0/0 grow/shrink: 2/3 up/down: 44/-82 (-38)
mm_core_init -2 and dw_pcie_irq_domain_alloc -4 come from byte-identical
objects and change at link time (relaxation). On loongarch32 with
CONFIG_IKHEADERS only kernel_headers_data changes (-800 bytes).

Performance is model-only: no affected architecture could be timed on
hardware. llvm-mca 17/18 ran on every executed path for the SiFive
U74/E76/P450, Rocket and SCR1 models; m68k, sh, sparc32, xtensa,
parisc, openrisc, loongarch32 and microblaze only got simple static
issue models (and MC68000 instruction timings). Of 648 changed
compiler/target/flags/function combinations, none is predicted slower
except 20 riscv64 caller cases in which the out-of-order P450 model
needs 1-2 more cycles on some inputs (-0.4% to +0.4% averaged over the
inputs); the in-order SiFive-7 model is up to 4 cycles faster per
__ffs() call. llvm-mca did not predict the slowdowns that this kind of
reordering showed on x86 hardware (up to about 10% on single paths;
x86 does not use this code), so this is weak evidence. Adjusting the
result first everywhere is predicted slower for ffs()/fls() on every
affected architecture, e.g. +3 cycles per ffs() call on the U74.

A loop with unrolled_full, against the current headers in userspace
builds (GCC 9/12/13/14 and Clang 17/18, 75 compiler/target pairs, -O2,
-Os and kernel-like -O2): out of line, GCC gives identical code in all
324 cases and Clang different code in 567 of 576, e.g. Clang 18 rv64
fls() 33 -> 25 instructions but __ffs() 29 -> 31 and one more branch,
Clang 17 ARMv4 ffs() 23 -> 37. Inlined into callers, GCC differs in 60
of 324 cases.

UNROLL(20) rather than six steps: the extra steps vanish when
optimizing, but not at -O0 or under Clang's GCOV instrumentation, where
the four helpers out of line grow from 405 to 564 instructions and from
280 to 728 bytes of counters (Clang 18 riscv64; measured with the same
expansion before the step order was unified).

tools/include/asm-generic/bitops/{fls,__fls}.h copy two of these
headers, so tools/perf/check-headers.sh will report them as different.
They cannot simply be resynced, since tools/include has no
<linux/unroll.h> or ffs-fls-search.h; the current copies compute the
same values, so keeping them, or dropping the two entries from
check-headers.sh, is enough.

Testing details: all 2^32 arguments in 12 configurations and every 7th
block of 2^16 in 51 more (GCC 8.1 to 16.2, LLVM 17 to 23), with no
mismatch against the old code or an independent reference. W=1 vmlinux
builds: arm multi_v4t, m68k m5475evb and m5208evb, sh rts7751r2dplus,
sparc32, openrisc without ff1/fl1, parisc64, xtensa (custom core
without NSA), loongarch32 (LA32R) and riscv with Zbb off, GCC 16.2,
plus riscv with Clang 18. Not covered: hardware timing, and any model
of the Clang 18 riscv changes; run-time tests on parisc64, loongarch32,
microblaze, nios2, xtensa and SH-2A; other compiler versions in kernel
builds; modules; sparse, smatch, coccinelle.

Against bitmap-for-next (a73b4d1fa7d3); applies as is to v7.3-rc7 and
next-20261012, where the four headers are identical.

 include/asm-generic/bitops/__ffs.h          | 26 +----------
 include/asm-generic/bitops/__fls.h          | 26 +----------
 include/asm-generic/bitops/ffs-fls-search.h | 51 +++++++++++++++++++++
 include/asm-generic/bitops/ffs.h            | 23 ++--------
 include/asm-generic/bitops/fls.h            | 23 ++--------
 5 files changed, 61 insertions(+), 88 deletions(-)
 create mode 100644 include/asm-generic/bitops/ffs-fls-search.h

diff --git a/include/asm-generic/bitops/__ffs.h b/include/asm-generic/bitops/__ffs.h
index 3a899c626f..ad5c014c62 100644
--- a/include/asm-generic/bitops/__ffs.h
+++ b/include/asm-generic/bitops/__ffs.h
@@ -3,6 +3,7 @@
 #define _ASM_GENERIC_BITOPS___FFS_H_
 
 #include <asm/types.h>
+#include <asm-generic/bitops/ffs-fls-search.h>
 
 /**
  * generic___ffs - find first bit in word.
@@ -14,30 +15,7 @@ static __always_inline __attribute_const__ unsigned int generic___ffs(unsigned l
 {
 	unsigned int num = 0;
 
-#if BITS_PER_LONG == 64
-	if ((word & 0xffffffff) == 0) {
-		num += 32;
-		word >>= 32;
-	}
-#endif
-	if ((word & 0xffff) == 0) {
-		num += 16;
-		word >>= 16;
-	}
-	if ((word & 0xff) == 0) {
-		num += 8;
-		word >>= 8;
-	}
-	if ((word & 0xf) == 0) {
-		num += 4;
-		word >>= 4;
-	}
-	if ((word & 0x3) == 0) {
-		num += 2;
-		word >>= 2;
-	}
-	if ((word & 0x1) == 0)
-		num += 1;
+	__ffs_fls_unroll(__ffs_step, word, num);
 	return num;
 }
 
diff --git a/include/asm-generic/bitops/__fls.h b/include/asm-generic/bitops/__fls.h
index 35f33780ca..1c439e881b 100644
--- a/include/asm-generic/bitops/__fls.h
+++ b/include/asm-generic/bitops/__fls.h
@@ -3,6 +3,7 @@
 #define _ASM_GENERIC_BITOPS___FLS_H_
 
 #include <asm/types.h>
+#include <asm-generic/bitops/ffs-fls-search.h>
 
 /**
  * generic___fls - find last (most-significant) set bit in a long word
@@ -14,30 +15,7 @@ static __always_inline __attribute_const__ unsigned int generic___fls(unsigned l
 {
 	unsigned int num = BITS_PER_LONG - 1;
 
-#if BITS_PER_LONG == 64
-	if (!(word & (~0ul << 32))) {
-		num -= 32;
-		word <<= 32;
-	}
-#endif
-	if (!(word & (~0ul << (BITS_PER_LONG-16)))) {
-		num -= 16;
-		word <<= 16;
-	}
-	if (!(word & (~0ul << (BITS_PER_LONG-8)))) {
-		num -= 8;
-		word <<= 8;
-	}
-	if (!(word & (~0ul << (BITS_PER_LONG-4)))) {
-		num -= 4;
-		word <<= 4;
-	}
-	if (!(word & (~0ul << (BITS_PER_LONG-2)))) {
-		num -= 2;
-		word <<= 2;
-	}
-	if (!(word & (~0ul << (BITS_PER_LONG-1))))
-		num -= 1;
+	__ffs_fls_unroll(__fls_step, word, num);
 	return num;
 }
 
diff --git a/include/asm-generic/bitops/ffs-fls-search.h b/include/asm-generic/bitops/ffs-fls-search.h
new file mode 100644
index 0000000000..5c64364e54
--- /dev/null
+++ b/include/asm-generic/bitops/ffs-fls-search.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_BITOPS_FFS_FLS_SEARCH_H_
+#define _ASM_GENERIC_BITOPS_FFS_FLS_SEARCH_H_
+
+#include <linux/unroll.h>
+
+/*
+ * Steps of a binary search for the first or last set bit of a word
+ * @i: the step number, from 0
+ * @x: the word, a local variable that the steps shift in place
+ * @n: the result, a local variable that the steps adjust in place
+ *
+ * Step @i looks at the low (__ffs_step) or high (__fls_step)
+ * __ffs_fls_shift(@i, @x) bits of @x: half of its width, then a quarter,
+ * and so on. If they are all zero, the step shifts them out of @x and adds
+ * their number to @n (__ffs_step) or subtracts it (__fls_step). @x is
+ * shifted before @n is adjusted: the next step tests @x, while @n is only
+ * needed at the end. The masks are computed in the type of @x.
+ *
+ * UNROLL() expands the steps in the preprocessor, so every shift and mask
+ * is an integer constant expression, as in a hand-written search. It puts
+ * the steps next to each other with nothing in between, hence the braces.
+ */
+#define __ffs_fls_shift(i, x)	((int)sizeof(x) * 8 >> ((i) + 1))
+#define __ffs_mask(i, x)	(((typeof(x))1 << __ffs_fls_shift(i, x)) - 1)
+#define __fls_mask(i, x)	((typeof(x))~(~(typeof(x))0 >> __ffs_fls_shift(i, x)))
+
+#define __ffs_step(i, x, n)						\
+	{								\
+		if (!((x) & __ffs_mask(i, x))) {			\
+			(x) >>= __ffs_fls_shift(i, x);			\
+			(n) += __ffs_fls_shift(i, x);			\
+		}							\
+	}
+
+#define __fls_step(i, x, n)						\
+	{								\
+		if (!((x) & __fls_mask(i, x))) {			\
+			(x) <<= __ffs_fls_shift(i, x);			\
+			(n) -= __ffs_fls_shift(i, x);			\
+		}							\
+	}
+
+/*
+ * Six steps cover a 64-bit word. UNROLL() needs a literal count, which
+ * cannot be derived from sizeof(@x), so expand the most it supports. Steps
+ * past the width of @x shift by 0 and are optimized away.
+ */
+#define __ffs_fls_unroll(step, x, n)	UNROLL(20, step, x, n)
+
+#endif /* _ASM_GENERIC_BITOPS_FFS_FLS_SEARCH_H_ */
diff --git a/include/asm-generic/bitops/ffs.h b/include/asm-generic/bitops/ffs.h
index 5ff2b7fbda..53705ba8c9 100644
--- a/include/asm-generic/bitops/ffs.h
+++ b/include/asm-generic/bitops/ffs.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_GENERIC_BITOPS_FFS_H_
 #define _ASM_GENERIC_BITOPS_FFS_H_
 
+#include <asm-generic/bitops/ffs-fls-search.h>
+
 /**
  * generic_ffs - find first bit set
  * @x: the word to search
@@ -16,26 +18,7 @@ static inline __attribute_const__ int generic_ffs(int x)
 
 	if (!x)
 		return 0;
-	if (!(x & 0xffff)) {
-		x >>= 16;
-		r += 16;
-	}
-	if (!(x & 0xff)) {
-		x >>= 8;
-		r += 8;
-	}
-	if (!(x & 0xf)) {
-		x >>= 4;
-		r += 4;
-	}
-	if (!(x & 3)) {
-		x >>= 2;
-		r += 2;
-	}
-	if (!(x & 1)) {
-		x >>= 1;
-		r += 1;
-	}
+	__ffs_fls_unroll(__ffs_step, x, r);
 	return r;
 }
 
diff --git a/include/asm-generic/bitops/fls.h b/include/asm-generic/bitops/fls.h
index 8eed3437ed..42625a0785 100644
--- a/include/asm-generic/bitops/fls.h
+++ b/include/asm-generic/bitops/fls.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_GENERIC_BITOPS_FLS_H_
 #define _ASM_GENERIC_BITOPS_FLS_H_
 
+#include <asm-generic/bitops/ffs-fls-search.h>
+
 /**
  * generic_fls - find last (most-significant) bit set
  * @x: the word to search
@@ -16,26 +18,7 @@ static __always_inline __attribute_const__ int generic_fls(unsigned int x)
 
 	if (!x)
 		return 0;
-	if (!(x & 0xffff0000u)) {
-		x <<= 16;
-		r -= 16;
-	}
-	if (!(x & 0xff000000u)) {
-		x <<= 8;
-		r -= 8;
-	}
-	if (!(x & 0xf0000000u)) {
-		x <<= 4;
-		r -= 4;
-	}
-	if (!(x & 0xc0000000u)) {
-		x <<= 2;
-		r -= 2;
-	}
-	if (!(x & 0x80000000u)) {
-		x <<= 1;
-		r -= 1;
-	}
+	__ffs_fls_unroll(__fls_step, x, r);
 	return r;
 }
 

base-commit: a73b4d1fa7d334a5f7de5bb0a14726530f66196e
-- 
2.34.1

