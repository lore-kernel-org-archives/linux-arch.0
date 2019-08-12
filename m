Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37283 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbfHLVwt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Aug 2019 17:52:49 -0400
Received: by mail-pl1-f201.google.com with SMTP id v13so3188557plo.4
        for <linux-arch@vger.kernel.org>; Mon, 12 Aug 2019 14:52:48 -0700 (PDT)
Date: Mon, 12 Aug 2019 14:50:46 -0700
In-Reply-To: <20190812215052.71840-1-ndesaulniers@google.com>
Message-ID: <20190812215052.71840-13-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190812215052.71840-1-ndesaulniers@google.com>
Subject: [PATCH 13/16] include/asm-generic: prefer __section from compiler_attributes.h
From: Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com, miguel.ojeda.sandonis@gmail.com, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Arnd Bergmann <arnd@arndb.de>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, Masami Hiramatsu <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Message-ID: <20190812215046.9ggbIhq5cnT_0IKYz3CsFVf4RYcwTjTeQ60awzdgYmc@z>

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/asm-generic/error-injection.h | 2 +-
 include/asm-generic/kprobes.h         | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index 95a159a4137f..a593a50b33e3 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -23,7 +23,7 @@ struct error_injection_entry {
  */
 #define ALLOW_ERROR_INJECTION(fname, _etype)				\
 static struct error_injection_entry __used				\
-	__attribute__((__section__("_error_injection_whitelist")))	\
+	__section(_error_injection_whitelist)				\
 	_eil_addr_##fname = {						\
 		.addr = (unsigned long)fname,				\
 		.etype = EI_ETYPE_##_etype,				\
diff --git a/include/asm-generic/kprobes.h b/include/asm-generic/kprobes.h
index 4a982089c95c..20d69719270f 100644
--- a/include/asm-generic/kprobes.h
+++ b/include/asm-generic/kprobes.h
@@ -9,12 +9,11 @@
  * by using this macro.
  */
 # define __NOKPROBE_SYMBOL(fname)				\
-static unsigned long __used					\
-	__attribute__((__section__("_kprobe_blacklist")))	\
+static unsigned long __used __section(_kprobe_blacklist)	\
 	_kbl_addr_##fname = (unsigned long)fname;
 # define NOKPROBE_SYMBOL(fname)	__NOKPROBE_SYMBOL(fname)
 /* Use this to forbid a kprobes attach on very low level functions */
-# define __kprobes	__attribute__((__section__(".kprobes.text")))
+# define __kprobes	__section(.kprobes.text)
 # define nokprobe_inline	__always_inline
 #else
 # define NOKPROBE_SYMBOL(fname)
-- 
2.23.0.rc1.153.gdeed80330f-goog
