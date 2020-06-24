Return-Path: <SRS0=MbEv=AF=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406618AbgFXUdk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 Jun 2020 16:33:40 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BE4C061796
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:38 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id y5so2427045qto.10
        for <linux-arch@vger.kernel.org>; Wed, 24 Jun 2020 13:33:38 -0700 (PDT)
Date: Wed, 24 Jun 2020 13:32:00 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-ID: <20200624203200.78870-23-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
Subject: [PATCH 22/22] x86, build: allow LTO_CLANG and THINLTO to be selected
From: Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>, Will Deacon <will@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>, clang-built-linux@googlegroups.com, kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Message-ID: <20200624203200.lVLTMSj8q5yQSwXN7hnM-dkMrSAD5k0KfbE9LjQgqBA@z>

Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/x86/Kconfig  | 2 ++
 arch/x86/Makefile | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 6a0cc524882d..df335b1f9c31 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -92,6 +92,8 @@ config X86
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
+	select ARCH_SUPPORTS_LTO_CLANG		if X86_64
+	select ARCH_SUPPORTS_THINLTO		if X86_64
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 00e378de8bc0..a1abc1e081ad 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -188,6 +188,11 @@ ifdef CONFIG_X86_64
 KBUILD_LDFLAGS += $(call ld-option, -z max-page-size=0x200000)
 endif
 
+ifdef CONFIG_LTO_CLANG
+KBUILD_LDFLAGS	+= -plugin-opt=-code-model=kernel \
+		   -plugin-opt=-stack-alignment=$(if $(CONFIG_X86_32),4,8)
+endif
+
 # Workaround for a gcc prelease that unfortunately was shipped in a suse release
 KBUILD_CFLAGS += -Wno-sign-compare
 #
-- 
2.27.0.212.ge8ba1cc988-goog
