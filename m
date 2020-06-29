Return-Path: <SRS0=AQMQ=AK=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731513AbgF2TNs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 15:13:48 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647F9C08EAF9
        for <linux-arch@vger.kernel.org>; Sun, 28 Jun 2020 23:18:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u5so7455406pfn.7
        for <linux-arch@vger.kernel.org>; Sun, 28 Jun 2020 23:18:49 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v4 05/17] ctype: Work around Clang -mbranch-protection=none bug
Date: Sun, 28 Jun 2020 23:18:28 -0700
Message-ID: <20200629061840.4065483-6-keescook@chromium.org>
In-Reply-To: <20200629061840.4065483-1-keescook@chromium.org>
References: <20200629061840.4065483-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>, Dave Martin <Dave.Martin@arm.com>, clang-built-linux@googlegroups.com, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Collingbourne <pcc@google.com>, James Morse <james.morse@arm.com>, Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <masahiroy@kernel.org>, Arvind Sankar <nivedita@alum.mit.edu>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20200629061828.0JepkpSt2XhQYNh0FvIylbnAgf6cT6ywouz2wsl-ZOE@z>

In preparation for building efi/libstub with -mbranch-protection=none
(EFI does not support branch protection features[1]), add no-op code
to work around a Clang bug that emits an unwanted .note.gnu.property
section for object files without code[2].

[1] https://lore.kernel.org/lkml/CAMj1kXHck12juGi=E=P4hWP_8vQhQ+-x3vBMc3TGeRWdQ-XkxQ@mail.gmail.com
[2] https://bugs.llvm.org/show_bug.cgi?id=46480

Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>
Cc: clang-built-linux@googlegroups.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/ctype.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/lib/ctype.c b/lib/ctype.c
index c819fe269eb2..21245ed57d90 100644
--- a/lib/ctype.c
+++ b/lib/ctype.c
@@ -36,3 +36,13 @@ _L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,_L,	/* 224-239 */
 _L,_L,_L,_L,_L,_L,_L,_P,_L,_L,_L,_L,_L,_L,_L,_L};	/* 240-255 */
 
 EXPORT_SYMBOL(_ctype);
+
+/*
+ * Clang will generate .note.gnu.property sections for object files
+ * without code, even in the presence of -mbranch-protection=none.
+ * To work around this, define an unused static function.
+ * https://bugs.llvm.org/show_bug.cgi?id=46480
+ */
+#ifdef CONFIG_CC_IS_CLANG
+void __maybe_unused __clang_needs_code_here(void) { }
+#endif
-- 
2.25.1
