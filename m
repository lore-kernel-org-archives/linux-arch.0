Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46998 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2Jz1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jul 2019 05:55:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id d4so58793877edr.13
        for <linux-arch@vger.kernel.org>; Mon, 29 Jul 2019 02:55:26 -0700 (PDT)
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] asm-generic: make simd.h a mandatory include/asm header
Date: Mon, 29 Jul 2019 12:55:21 +0300
Message-Id: <20190729095521.1916-1-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-crypto@vger.kernel.org
Cc: herbert@gondor.apana.org.au, geert@linux-m68k.org, linux-arch@vger.kernel.org, arnd@arndb.de, Ard Biesheuvel <ard.biesheuvel@linaro.org>

The generic aegis128 software crypto driver recently gained support
for using SIMD intrinsics to increase performance, for which it
uncondionally #include's the <asm/simd.h> header. Unfortunately,
this header does not exist on many architectures, resulting in
build failures.

Since asm-generic already has a version of simd.h, let's make it
a mandatory header so that it gets instantiated on all architectures
that don't provide their own version.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/asm-generic/Kbuild | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 6f4536d70b8e..adff14fcb8e4 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -3,3 +3,5 @@
 # asm headers that all architectures except um should have
 # (This file is not included when SRCARCH=um since UML borrows several
 # asm headers from the host architecutre.)
+
+mandatory-y += simd.h
-- 
2.17.1
