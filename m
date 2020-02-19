From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH 6/6] kbuild: Enable -Wtautological-compare
Date: Tue, 18 Feb 2020 21:54:23 -0700
Message-ID: <20200219045423.54190-7-natechancellor@gmail.com>
References: <20200219045423.54190-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34149 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgBSEyh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Feb 2020 23:54:37 -0500
In-Reply-To: <20200219045423.54190-1-natechancellor@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Arnd Bergmann <arnd@arndb.de>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>, Jason Baron <jbaron@akamai.com>, Catalin Marinas <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>

Currently, we disable -Wtautological-compare, which in turn disables a
bunch of more specific tautological comparison warnings that are useful
for the kernel (see clang's documentation below). Now that all of the
major/noisy warnings have been fixed, enable -Wtautological-compare so
that more issues can be caught at build time.

-Wtautological-constant-out-of-range-compare is kept disabled because
there are places in the kernel where a constant or variable size can
change based on the kernel configuration; these are not fixed in a
clean/concise way and they are almost always harmless so this one
subwarning is kept disabled.

Link: https://github.com/ClangBuiltLinux/linux/issues/488
Link: http://releases.llvm.org/9.0.0/tools/clang/docs/DiagnosticsReference.html#wtautological-compare
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index b954c304c479..99080c57a1cb 100644
--- a/Makefile
+++ b/Makefile
@@ -742,8 +742,7 @@ ifdef CONFIG_CC_IS_CLANG
 KBUILD_CPPFLAGS += -Qunused-arguments
 KBUILD_CFLAGS += -Wno-format-invalid-specifier
 KBUILD_CFLAGS += -Wno-gnu
-# Quiet clang warning: comparison of unsigned expression < 0 is always false
-KBUILD_CFLAGS += -Wno-tautological-compare
+KBUILD_CFLAGS += -Wno-tautological-constant-out-of-range-compare
 # CLANG uses a _MergedGlobals as optimization, but this breaks modpost, as the
 # source of a reference will be _MergedGlobals and not on of the whitelisted names.
 # See modpost pattern 2
-- 
2.25.1
