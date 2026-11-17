Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794894592;
	b=klWLWfQ31fW8CCtfc/K1HJZocmFQjGawymmojOCTQhhb9BATv4nz71dvg5p+RI/ZSE5O
	 Or9SKczvWEpGdt71YTOYLP7tHm/62B5lL7PH1BpHsFE15hyPnkNdISOt1by67zVasF11x
	 5BHk4PnsVhd5ub4lpA2uOlZqvZWTc6YsKJHuXL9F4ZelH0pW+gvjZhErzcPKJK2p2denr
	 RblIG2MIeH3UVTl1unuNeWWRpaBE4L1B3KoJ3409VGkFxsx1PtKJ4t4R+7vvsZjf/tNoh
	 TVyAKbGwAZ4Baw8HvaQVUAhjXfNVSiPA6bHs5tC9NV78/b5bmzexpJAAioqkfI6A/+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794894592;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eJPyKHP64G2eKzhiRICR4S2i28pJ2+2iaIFvgsyda0E=;
	b=WUWLMMoIgqCV3RqQzg/ttNu5FWVG/89qUoaFukx6VkLI5dCYbf97THSP9mAITG5t7Cq6
	 t5HaAXaFSc7u+Xug3qXc7uGL39Tp++38kJipugvrQfnqNJlfwY+WcVqnbFyAj94MraWLu
	 +wIQcV0h75Sz/kLSOLkgj66SyI3PVwuP6AYkDeInRGb6WtCfyFvJKY1F3IyeJTmrasqyr
	 JVGYPzrHQBnCxwQGmrYqQzOXslrpWLkuuUEOYQMTVyuvLEQAlR6lWaAX5IFWIe6+cAOii
	 KWhXuqJzzaCEQd5h9kU8QOS4wauLmoU4PIf3McDJ/KmSCGRpxFQA/6xI5J3bDgGe/YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HvTlA8fr;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5A7606A329
	for <linux-arch@vger.kernel.org>; Tue, 17 Nov 2026 05:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD5A7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HvTlA8fr
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b3af93b85cso281469a91.1
        for <linux-arch@vger.kernel.org>; Mon, 16 Nov 2026 21:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794894591; x=1795499391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eJPyKHP64G2eKzhiRICR4S2i28pJ2+2iaIFvgsyda0E=;
        b=HvTlA8frczprnGV9oZERL7YtGJ4Kl7oX929awdw7jEyRTP1C6BtfVWQxkKK8MH5hWU
         0uY5ker2kfrApUFLZg/cu+LALqGuaKZD0fIiOONWamxbJXqDyLIaw5O3780FvPrErR8C
         3f2gnt9lq8A7Q0bUlRvehyE5liaY1nPoURDqmB2d74LSaOgN3y2iKmrvPeTKLU3RUX9p
         ojw3cLNNzHt0naRZoneZ0YeZHfbPgzux9ZnAQcgFrCFdaNaYxqUa4elMXHeYG8NM371F
         /R9M0RNn1M9ou4tqd/urU9i1xHCpfadHm6NTWvsJmr99+gF14D/oiQ1Hnr0gqwwUl4zo
         pWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794894591; x=1795499391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eJPyKHP64G2eKzhiRICR4S2i28pJ2+2iaIFvgsyda0E=;
        b=DwSgMPaZl0EJjzJOOM520x9KUeGwUyyMrFMN8tVwjWVUv0wVt715HmcpMyGfB3bE2j
         idClphqRXDqMaDdgtxCzohfrGB1BpBBWrU4G9oqKNu5dBr8p6jIoAfJ8lUrT/tH7dJv6
         mkWq8YdrbGWhZXC5oQN0BrUfQbhdrAy6rADJEB+MBSIL76nOgrcZLts51X/dL04b8lXd
         ePTJUcKjjtMi4eC7Sj5C+5IK2EWe3gsfOB/jtoNCvwi6hR1vUYJndF28nn6FlwL+Ik1x
         NcKBSxWx70vF1TR+KFakxI4XU8e9Xn5YBsfbq/dmKADMiqKNHHOa0ZAsCdSQo6NR8I6c
         h+8w==
X-Forwarded-Encrypted: i=1; AL+hErF8wj9mezdUpoh1HAukGhcv9loaesU8HcGJR14AwkDoEaDZnBNeLpbcEUD8riKKvOYzkRIpYdPqiUb1@vger.kernel.org
X-Gm-Message-State: APuU4Z+IpkKydittWyPAHnZStCFxVOry4exEtKwb2WrkoTcWrqlJGBWW
	ZKnwHeLplooa414NI8KImomyejN+mJKw9HaXVPeaSu3m6RdNdTRGuHff
X-Gm-Gg: AZFdTZcmIt2j2/qZ+mZ8RYrxznNJgGfB6+TiVN+CJu2RTZ3gbisx6F82DH0FZGurr27
	FD7eZ7vKKOEte5NxDMAsD1T5xNCVv+n7VPEoUi09or7IvGwGpgh2iZOvr7GNhB7trUJ6kqZnn6l
	+oovoEiwT7KiyiOQ7S8vfaXIPANsT/iihm9qLCLKPO/y+lfPRIvISNQzNJm+82GePeMf7ORR+3H
	rOk1w2pTkSIvuEZvLD8d8V005Zc5qUVkHgBmE81cnI2IqStwoREgRdg0kYjYJBq7FVMc2fSZle5
	qyh4tMogVtbBmh2hf8P27p1efjbWv6K2TENg1iUoIxK7FwO2kbL3jPLn9AkdObh8+jfPuGCndJ6
	rnEv6GDWPDEw86Ba8lRj28uniBaVurczXscECJApRjMGn5Ktm+D0YxxCr3iC1BasHo8hbzF0FYs
	Fu2y5DkmOCDRY7MRWAY586NzfuUjygllAaWq0PyQgsWb6U/EoWRwGBrbjQIm1d42k14pVgy/Tfw
	m8BnIOkI/utPWQTa1M1sq9MaJ/GSh8W8Whi1SDdSAYNQ5VxBoUzINAys5Xs/nVnmz6N6KNWzJlt
	IW5+OldN5k0DaGlASIBuZtM+Tytujiq1rQ==
X-Received: by 2002:a17:90b:1846:b0:3a4:6f38:f2a2 with SMTP id 98e67ed59e1d1-3b1b0a3e7bemr11245113a91.25.1794894590926;
        Mon, 16 Nov 2026 21:49:50 -0800 (PST)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3ab9f3c5dsm2313835a91.0.2026.11.16.21.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 21:49:50 -0800 (PST)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: Brian Cain <bcain@kernel.org>,
	linux-hexagon@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hexagon: bitops: use the compiler builtins for ffs(), fls() and ffz()
Date: Tue, 17 Nov 2026 13:49:39 +0800
Message-Id: <20261117054939.2126980-1-shingekinocore@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hexagon inline asm for ffs(), __ffs(), fls(), __fls() and ffz() is
not needed: Clang, the only compiler that builds hexagon kernels, emits
the same ct0, cl0 and ct1 instructions for the compiler builtins, and
unlike the asm, the builtins fold constant arguments. The asm dates
from the 2011 port (a86a7ce30ac0, "Hexagon: Add bitops support"),
before the builtin-based asm-generic helpers existed (048fa2df92c3,
"generic: Implement generic ffs/fls using __builtin_* functions").

Replace the asm with the asm-generic builtin helpers, and ffz() with
the generic __ffs(~x), as arm64 does.

ffs(0) and fls(0) still return 0. __ffs() and __fls() now return
unsigned int, which is as wide as unsigned long on hexagon, and ffz()
returns unsigned int instead of long. __ffs(0), __fls(0) and ffz(~0)
remain undefined.

With Clang 17 to 23, the functions of a defconfig vmlinux shrink by 1972
to 6068 bytes in total (scripts/bloat-o-meter -t). One helper in
lib/find_bit.c gets worse: _find_last_bit() executes one instruction
more per call that finds a bit, because LLVM rewrites 31 - clz as 31 ^
clz once it knows clz < 32, and the hexagon backend keeps the xor, which
needs the 31 in a register, instead of sub(#31, Rs) [1]. A few 1 <<
ffz() sites also grow by a few instructions, as LLVM rewrites that
expression too [2]. __find_nth_bit() executes two fewer, and the other
helpers that find_bit_benchmark calls the same number.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/all/affe7da1-41aa-4710-bee0-5e3c2b8a8dfc@app.fastmail.com/
Link: https://github.com/llvm/llvm-project/issues/236764 [1]
Link: https://github.com/llvm/llvm-project/issues/236765 [2]
Signed-off-by: Tzu-Ching Yang <shingekinocore@gmail.com>
---
I have no hexagon hardware, and mainline does not boot in QEMU yet. On
Brian's out-of-tree bcain/hexagon-qemu-virt branch (dc370baa041d,
v7.3-rc1 plus 24 patches) with this patch on top, qemu_defconfig plus
the ffs and bitops KUnit tests and find_bit_benchmark, built with Clang
17 and 23, boots under qemu-system-hexagon from qualcomm/qemu hex-next
with -M virt,hvm=on (and under -M qcs6490-cdsp with the prebuilt H2
hypervisor); the KUnit tests pass before and after, with the same
.config on both sides. Under -M virt,hvm=on, with a TCG plugin that
writes the same bitmaps into both kernels before each test and counts
the executed instructions without interrupts, find_bit_benchmark's
find_last_bit executes one instruction more per iteration,
bitmap_find_next_zero_area_off 36 more on the random bitmap through its
find_last_bit() calls, find_nth_bit and test_bitops' fns() two fewer,
and the other tests the same.

Under qemu-hexagon (user mode), the old and new helpers return the
same values for every defined 32-bit input, and fls64() and __ffs64()
for selected 64-bit inputs, with Clang 17 to 23 at -O2 and -Os.

defconfig (also with the KUnit tests and find_bit_benchmark, with -Os
and with -mv73) and allmodconfig were built with Clang 17 to 23 before
and after, with the same .config on both sides: same W=1 warnings, no
calls to __ctzsi2(), __clzsi2() or ffs(), and a smaller bloat-o-meter -t
total in every defconfig-based vmlinux. allmodconfig does not link with
Clang 17 and 18, before or after: ld.lld before 19.1.5 rejects the calls
in head.S as out of range.

Instructions of each helper in a test function that only returns its
result (return included), built with the kernel's flags by Clang 17
to 22 at -O2 and -Os; Clang 23 adds an allocframe to both rows:

            ffs  __ffs  fls  __fls  ffz
  asm         6      3    4      4    3
  builtin     5      2    3      3    2

The instruction saved is the copy of the result to r0: the asm's
early-clobber output ("=&r") cannot share the argument's register.

In packets, only ffs() takes one more than the asm (4 -> 5): with
df5e4db805d5 ("hexagon: disable the LLVM packetizer") applied, each
instruction of the builtin version gets a packet of its own, while
the asm is bundled by hand. Without that workaround, which linux-next
does not have yet, ffs() goes from 6 instructions in 3 packets to 5
in 2.

Against the bcain/hexagon-fixes branch of bcain/linux.git
(0304683b4c43); also applies to next-20261113 and to bitmap-for-next.

 arch/hexagon/include/asm/bitops.h | 100 ++----------------------------
 1 file changed, 5 insertions(+), 95 deletions(-)

diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index b23cb13833af..975328172b7c 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -194,101 +194,11 @@ arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
 	return retval;
 }
 
-/*
- * ffz - find first zero in word.
- * @word: The word to search
- *
- * Undefined if no zero exists, so code should check against ~0UL first.
- */
-static inline long __attribute_const__ ffz(int x)
-{
-	int r;
-
-	asm("%0 = ct1(%1);\n"
-		: "=&r" (r)
-		: "r" (x));
-	return r;
-}
-
-/*
- * fls - find last (most-significant) bit set
- * @x: the word to search
- *
- * This is defined the same way as ffs.
- * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
- */
-static inline __attribute_const__ int fls(unsigned int x)
-{
-	int r;
-
-	asm("{ %0 = cl0(%1);}\n"
-		"%0 = sub(#32,%0);\n"
-		: "=&r" (r)
-		: "r" (x)
-		: "p0");
-
-	return r;
-}
-
-/*
- * ffs - find first bit set
- * @x: the word to search
- *
- * This is defined the same way as
- * the libc and compiler builtin ffs routines, therefore
- * differs in spirit from the above ffz (man ffs).
- */
-static inline __attribute_const__ int ffs(int x)
-{
-	int r;
-
-	asm("{ P0 = cmp.eq(%1,#0); %0 = ct0(%1);}\n"
-		"{ if (P0) %0 = #0; if (!P0) %0 = add(%0,#1);}\n"
-		: "=&r" (r)
-		: "r" (x)
-		: "p0");
-
-	return r;
-}
-
-/*
- * __ffs - find first bit in word.
- * @word: The word to search
- *
- * Undefined if no bit exists, so code should check against 0 first.
- *
- * bits_per_long assumed to be 32
- * numbering starts at 0 I think (instead of 1 like ffs)
- */
-static inline __attribute_const__ unsigned long __ffs(unsigned long word)
-{
-	int num;
-
-	asm("%0 = ct0(%1);\n"
-		: "=&r" (num)
-		: "r" (word));
-
-	return num;
-}
-
-/*
- * __fls - find last (most-significant) set bit in a long word
- * @word: the word to search
- *
- * Undefined if no set bit exists, so code should check against 0 first.
- * bits_per_long assumed to be 32
- */
-static inline __attribute_const__ unsigned long __fls(unsigned long word)
-{
-	int num;
-
-	asm("%0 = cl0(%1);\n"
-		"%0 = sub(#31,%0);\n"
-		: "=&r" (num)
-		: "r" (word));
-
-	return num;
-}
+#include <asm-generic/bitops/builtin-__ffs.h>
+#include <asm-generic/bitops/builtin-ffs.h>
+#include <asm-generic/bitops/builtin-__fls.h>
+#include <asm-generic/bitops/builtin-fls.h>
+#include <asm-generic/bitops/ffz.h>
 
 #include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/non-instrumented-non-atomic.h>

base-commit: 0304683b4c43048082483e9445fdd0691d088431
-- 
2.34.1

