Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35597 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbeH2KnW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Aug 2018 06:43:22 -0400
Received: by mail-ed1-f66.google.com with SMTP id y20-v6so3107230edq.2
        for <linux-arch@vger.kernel.org>; Tue, 28 Aug 2018 23:48:00 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] powerpc: disable support for relative ksymtab references
Date: Wed, 29 Aug 2018 08:47:53 +0200
Message-ID: <20180829064753.7133-1-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linuxppc-dev@ozlabs.org
Cc: nicholas.piggin@gmail.com, schwab@linux-m68k.org, jeyu@kernel.org, mpe@ellerman.id.au, will.deacon@arm.com, mingo@kernel.org, akpm@linux-foundation.org, linux-arch@vger.kernel.org, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Message-ID: <20180829064753.3w9QixjecYzJRjKe4DKC8FFW1NrqF62NGQX6GTWI6kc@z>

The newly added code that emits ksymtab entries as pairs of 32-bit
relative references interacts poorly with the way powerpc lays out
its address space: when a module exports a per-CPU variable, the
primary module region covering the ksymtab entry -and thus the 32-bit
relative reference- is too far away from the actual per-CPU variable's
base address (to which the per-CPU offsets are applied to obtain the
respective address of each CPU's copy), resulting in corruption when
the module loader attempts to resolve symbol references of modules
that are loaded on top and link to the exported per-CPU symbol.

So let's disable this feature on powerpc. Even though it implements
CONFIG_RELOCATABLE, it does not implement CONFIG_RANDOMIZE_BASE and
so KASLR kernels (which are the main target of the feature) do not
exist on powerpc anyway.

Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Suggested-by: Nicholas Piggin <nicholas.piggin@gmail.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/powerpc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index db0b6eebbfa5..a80669209155 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -177,7 +177,6 @@ config PPC
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
-	select HAVE_ARCH_PREL32_RELOCATIONS
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_CBPF_JIT			if !PPC64
-- 
2.17.1
