Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f202.google.com ([209.85.222.202]:56758 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbfE1Qdf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 May 2019 12:33:35 -0400
Received: by mail-qk1-f202.google.com with SMTP id q17so28547241qkc.23
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2019 09:33:34 -0700 (PDT)
Date: Tue, 28 May 2019 18:32:57 +0200
In-Reply-To: <20190528163258.260144-1-elver@google.com>
Message-ID: <20190528163258.260144-2-elver@google.com>
Mime-Version: 1.0
References: <20190528163258.260144-1-elver@google.com>
Subject: [PATCH 2/3] tools/objtool: add kasan_check_* to uaccess whitelist
From: Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: peterz@infradead.org, aryabinin@virtuozzo.com, dvyukov@google.com, glider@google.com, andreyknvl@google.com
Cc: corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org, arnd@arndb.de, jpoimboe@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kasan-dev@googlegroups.com, Marco Elver <elver@google.com>
Message-ID: <20190528163257.2DyKuAwlw-CaZIsPOT0lhljOua4JyLX4mF1fv40y6PI@z>

This is a pre-requisite for enabling bitops instrumentation. Some bitops
may safely be used with instrumentation in uaccess regions.

For example, on x86, `test_bit` is used to test a CPU-feature in a
uaccess region:   arch/x86/ia32/ia32_signal.c:361

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/objtool/check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 172f99195726..eff0e5209402 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -443,6 +443,8 @@ static void add_ignores(struct objtool_file *file)
 static const char *uaccess_safe_builtin[] = {
 	/* KASAN */
 	"kasan_report",
+	"kasan_check_read",
+	"kasan_check_write",
 	"check_memory_region",
 	/* KASAN out-of-line */
 	"__asan_loadN_noabort",
-- 
2.22.0.rc1.257.g3120a18244-goog
