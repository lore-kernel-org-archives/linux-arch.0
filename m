Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04E42264A9
	for <linux-arch@vger.kernel.org>; Fri, 16 Oct 2026 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158826; cv=none; b=osV06Ln//CmxFpQnraBZQffgBgpOIlpzq/Z+aWqczHLv+43dSIklz4GgAn8LXzywdowqDYQZafBDzoAiW/p4ExRk0bx5bnfve6bPDQWp9nQuxJmnoLojpGhMOqZ/G3b3MXl+7pXVb0rqnRWggIiFU4VNWeBeYVVMhWM0VqwhBPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158826; c=relaxed/simple;
	bh=FcjT/tV1AAPZAUiYW2/NfW5PJ4IcgeHs9Y+lCEFRR9M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhHDLJywYitE5JI8fIshynpq5lbvNuQeLUHNXiAplQQTSIMfcHcvhLQJsi0CsZYwPf5mtilihfFEDthmCjlheYQXmmy3i2X2wItFucWR7OVwyz5aR3A2haNQxasL5sXoMM2/s+vOB0b+ppxDXho07+ZAcjhoCJS3lNBIZuyoyI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsIL1pag; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsIL1pag"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3acb11973c3so6200a91.3
        for <linux-arch@vger.kernel.org>; Fri, 16 Oct 2026 06:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792158824; x=1792763624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t0FXTrpk84O2ALFK9ZDUuPOuQ+3rvOMAc9cRpwzYN8o=;
        b=DsIL1pagVaFkXSG1t+OfWMw6PgQ97U4qBbhrDjtNVvsMH+WgcJPSNcMyRb3hrZSKFa
         TErSFRXCY1ovrdD8LKNg1/+zcg7tI/onNphuwHrDJuYePJp2kxeBfOF/XSwJnZDZbg6X
         IUcdJAIdqcCVkf/enHdWGqqqLoptUJkADximgIgCESiA3ouwgtYBGFjmkMXhIHuKLpEb
         mZediW659h/p4G8g1uxWaQfAFbF9zpjc7NWkD7nM4BqW4Oh7q/7OIwEaToCp82ogs8r1
         SKGtB0gPzr+ZIJ1dJ4YaZBMl77CNlAEzT4LE5AlMYb+cuzYTLRyUYOUu99oUxcAAmt8w
         LG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158824; x=1792763624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t0FXTrpk84O2ALFK9ZDUuPOuQ+3rvOMAc9cRpwzYN8o=;
        b=Xn9q+6/swYnbXyVssDj78uyW91gVbu3cWXSDrI+zTbFZj5TzqEiC6ET/FFJzZnWmCO
         Sn9/AYKMG9hZdGNJCtVeKsDTxAYI/9reWMLShDuB64z/y+Le5bQZXcdbn5wAPKxw5CqS
         w4VnnzE/deFp5/oMAEUbQ72kTjvNw/cuXGdIaRTTB4dWTLOjBWapvr/gizrqZCUUMSC3
         oCmTlx1mbyuB9TTMwbnibJSd9uiZyTYzwW/9p07aUpEkwYwR6oi6bRFt9q5ijNdfTdRD
         m89eSOVGFpyjVRNAJa3V+1HN5CaTMicekYJOq/Y0t0fw4krkB2AIg7AvhewIY5enobTU
         ySAA==
X-Forwarded-Encrypted: i=1; AKwUvBz7O5YtPlu4/5Hyq7JIB2bkBK+Mjw5LmlZvsSAj77tixcsFCS4d5u/a3KzHOuC6nuV2AdUOcAIjKg/Z@vger.kernel.org
X-Gm-Message-State: AFq9FYJlZ7N8P9+nk1ncJhA5sKOb8Sns2lEmtDof/q6xyQKRN62fkp6+
	Iblc9ijtU8M3Jz5itL0WVWY5x8lyG3GLwqIpIYKOKhHskR5c+9Iz9NL2nyusFKts
X-Gm-Gg: AYBFou3kTgOFFrFfKbwYmUiHZ4h71SA0XQXwIEajwqRy/IWA6cvdD74vLGC+1c3pgt/
	N1uZQDHwx10CI7g8BDxKp7YI0dCYNP9tZGrp07mi+rrC3BUN+yhIs13NdY1M1ii8MfEeqGMgBD3
	FzUNBMFEcXB4VdYS/vktxzlxjrFEki6i/HUnolUI7tIv4XMR4Aq2fA4lIpyIBv7nECvHg/TRfj6
	FjlfMQJF1RbNkFRDulqBKD4mz0ICxU14nVwvtdOW93JgvXaFDhPgmlKyqWD7vW0AI0pDdUTBxun
	qh7IOY+xK0To8IQed7mtgMhXfN4hfP6wQ8ezOtTiozaKlXD2C1CXQxzduawSyY9EMjSMUZ6bSbR
	/4wPHMnmnbiCgCZ7FL43NGCK4/PdtE4CCIx2hPs5zaQyZHfrA/WxJpxXj4kWcOURPbSaNQCVBS4
	ZCIV2wc29Crc9c6QI2ka0lbGjIZuzs7ITSo29JBDrjT1N3z2eIVXSEdpJBLpfT/sduxYKtvG9GV
	ZM=
X-Received: by 2002:a17:90b:5343:b0:39e:6c6a:6580 with SMTP id 98e67ed59e1d1-3ab3a9d3dfdmr17699436a91.67.1792158823766;
        Fri, 16 Oct 2026 06:53:43 -0700 (PDT)
Received: from arm-a100.. ([140.112.28.118])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc4872861sm4831265a91.7.2026.10.16.06.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:53:43 -0700 (PDT)
From: Tzu-Ching Yang <shingekinocore@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bitops: Share the generic ffs()/fls() binary search via UNROLL()
Date: Fri, 16 Oct 2026 21:53:29 +0800
Message-Id: <20261016135329.509250-1-shingekinocore@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <dbb44e92-0bc5-449d-9e43-1f93362aa6c3@app.fastmail.com>
References: <20261016025634.2690862-1-shingekinocore@gmail.com> <7eb58dd0-99f9-45aa-bdf4-9707a0c9e1b4@app.fastmail.com> <dbb44e92-0bc5-449d-9e43-1f93362aa6c3@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 16, 2026, at 09:16, Arnd Bergmann wrote:
> If you are interested in creating helpful patches in this area,
> maybe you could work towards eliminating the generic versions
> of these functions in favor of using the builtin ones on targets
> where the compilers produce sensible code for them.

Thanks, I looked into this. For each architecture variant, I put the
kernel's current version of each function and the builtin one into a
small userspace test file, each in a function of its own, compiled it
at -O2 and -Os with every GCC major release from 8 to 16 and Clang 17
to 23 that supports the target, and compared the instruction counts
for a variable argument. Of the rows below, only hexagon (Clang only),
powerpc and mips other than octeon could be built with Clang. A few
GCC -Os builds did not inline the kernel's version, so those cells
(arc ARCompact, ffs() and fls() on mips, and ffs() on microblaze) use
-O2 only.

Each cell below gives what the kernel uses today (G the generic
version or a copy of it, A arch asm, B the builtin) and how the
builtin compares with it:

  +  inline and never more instructions, with every compiler
  ~  as +, but only with some compilers (see below)
  -  more instructions, with every compiler
  x  the hardware has an instruction, but the compiler never emits it
     (the builtin is a library call)

In the "fls (clzg)" column, the code in parentheses is for fls()
written as 32 - __builtin_clzg(x, 32), which needs GCC 14 or Clang 19
or later, so it covers only those compilers.

                     | __ffs | ffs | __fls | fls (clzg)
---------------------+-------+-----+-------+-----------
ColdFire ISA_A+/C    | A-    | A-  | G+    | G+  (G+)
microblaze PCMP 8.10 | G+    | G+  | G+    | G+  (G+)
microblaze PCMP 11.0 | G~    | G~  | G~    | G~  (G+)
hexagon              | A+    | A+  | A+    | A+  (A+)
mips32 r2/r6         | A~    | A+  | A+    | A~  (A+)
mips64 r2            | A~    | A+  | A+    | A~  (A~)
mips64 r6            | G+    | A+  | G+    | A~  (A~)
mips octeon          | A+    | A+  | A+    | A-  (A+)
xtensa NSA           | A+    | A+  | A+    | A-  (A-)
arc ARCompact        | A+    | A-  | A+    | A-  (A-)
m68k 68020+          | A+    | A-  | A+    | A-  (A-)
arc HS               | A~    | A+  | A~    | A-  (A-)
csky                 | Ax    | Ax  | A+    | A-  (A-)
openrisc FF1/FL1     | Ax    | Ax  | Ax    | Ax  (Ax)
powerpc              | B     | B   | B     | A~  (A+)

The ~ cells depend on the compiler: microblaze 11.0 needs GCC 14
(older GCC compares "v11.0" and "v8.10.a" as plain strings and emits a
library call), arc HS needs GCC 12, mips __ffs() is + only with GCC,
mips and powerpc fls() only with Clang, and on mips64 neither fls()
nor clzg is + with Clang 19.

Not listed are the targets without a suitable instruction, where GCC
turns the builtins into library calls, so their current code has to
stay: alpha ev56, arm v4/v4t, ColdFire ISA_A/ISA_B, m68000, microblaze
without PCMP or before 8.10.a, mips R3000, nios2, openrisc without
FF1/FL1, parisc, riscv without Zbb, loongarch la32r, sh and sparc32.

The G cells are the clear candidates: microblaze with PCMP (8.10.a or
later) uses the generic versions although GCC emits clz for the
builtins, and ColdFire ISA_A+/C still uses them for __fls() and fls(),
while __ffs() and ffs() there already use ff1 in asm. On mips64 r6,
__ffs() and __fls() end up in the C fallback of __fls(), a copy of the
generic version. I confirmed this in 64r6el_defconfig builds with GCC
16 and Clang 23: the dclz branch is used only if cpu_has_mips64 is a
compile-time constant, and on r6 it is not, because cpu_has_mips64r6
still tests a runtime flag. The builtins would cut both functions
there from 34-64 instructions to 4-8; making cpu_has_mips64r6 constant
on 64-bit r6 kernels would fix this as well.

In the A cells, __ffs() and __fls() could mostly switch at no cost,
which also lets the compiler fold constant arguments where the asm
does not. fls() pays for the zero test that __builtin_clz() needs,
unless the compiler knows what the instruction returns for 0: Clang
does on hexagon, mips and powerpc, and GCC only with __builtin_clzg(),
on mips and powerpc. That test is why powerpc keeps asm for fls() with
non-constant arguments.

If this is what you had in mind, I would send one patch per
architecture to its maintainers, with you, Yury and Rasmus on Cc:
first the G+ cells (microblaze, ColdFire and mips64 r6), then the A+
cells (hexagon, mips, xtensa, arc, m68k 68020+ and csky), with fls()
using __builtin_clzg() behind a __has_builtin() check where the table
shows that it helps (mips and powerpc). The same change to
builtin-fls.h would make fls() smaller with some compilers, and never
larger, on arm, arm64, loongarch and s390 (on arm64 from 6 to 4
instructions at -O2 with GCC 14 and later). The ~ cells would need a
check for the compiler or its version, so I would only do those if the
maintainers want it. Each patch would be tested with kernel builds and
the ffs KUnit test.

> On Fri, Oct 16, 2026, at 07:54, Arnd Bergmann wrote:
>> I don't understand what you are trying to do here, but I don't
>> think we want this change: I find the nested macros harder
>> to read than the open-coded version and your changelog text
>> fails to explain what the purpose is.

Sorry, the changelog buried the point. This is a cleanup of the
generic versions, which are still needed on targets without a suitable
instruction. generic_ffs(), generic___ffs(), generic_fls() and
generic___fls() each open-code the same binary search with their own
hand-written masks. The copies differ in the order of the two updates
in a step and in how the test is written, and the two unsigned long
ones need an #if around the extra step for 64-bit words. The patch
replaces the four copies with one shared step per direction, whose
shift and mask are computed from the step number and the type of the
word, so the literal masks and the #if go away (27 fewer lines
overall).

One detail that may look odd is that the patch uses UNROLL(20)
although a 64-bit word needs only six steps. The steps are not tied to
a particular width, so it expands all 20 that UNROLL() supports: once
the shift reaches 0, a step does nothing and the compiler drops it
when optimizing.

generic_ffs() and generic_fls() compile to the same code as before.
With GCC 16.2, the code in callers of generic___ffs() and
generic___fls() mostly differs only in the order of two independent
instructions, and vmlinux size is unchanged on most of the
architectures I built.

I agree that each step is easier to check in the open-coded version.
The trade-off is one place to check instead of four, but since you
find the current code easier to read, I'm happy to drop this unless
Yury sees it differently.

>> If you have a specific problem with one of the platforms using
>> this, I would suggest you address that one but leave the
>> generic code unchanged.

No, the patch did not come from a problem on a specific platform; it
was meant purely as a cleanup.

A few minor notes, for completeness. Because the shifts and masks are
derived from the type of the word, the steps also work for wider words
(I checked unsigned __int128) and could be used to build ctz/clz-style
helpers for other unsigned types, though nothing needs that today. And
__fls_step as posted is only correct for unsigned words, which is what
both of its users pass; if there were a v2, it would make the steps
work in the unsigned type of the same width as the word. Separately
from this patch, generic_ffs() in mainline right-shifts its int
argument; for negative values that is implementation-defined, though
GCC and Clang shift arithmetically and the result is correct. If you
think it is worth fixing, I can send a small patch that copies the
argument to an unsigned int first.

Thanks,
Tzu-Ching
