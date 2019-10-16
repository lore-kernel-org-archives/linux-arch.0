Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm1-f73.google.com ([209.85.128.73]:55006 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391741AbfJPIlQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2019 04:41:16 -0400
Received: by mail-wm1-f73.google.com with SMTP id g67so664867wmg.4
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2019 01:41:15 -0700 (PDT)
Date: Wed, 16 Oct 2019 10:39:53 +0200
In-Reply-To: <20191016083959.186860-1-elver@google.com>
Message-ID: <20191016083959.186860-3-elver@google.com>
Mime-Version: 1.0
References: <20191016083959.186860-1-elver@google.com>
Subject: [PATCH 2/8] objtool, kcsan: Add KCSAN runtime functions to whitelist
From: Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: elver@google.com
Cc: akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com, parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org, ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com, bp@alien8.de, dja@axtens.net, dlustig@nvidia.com, dave.hansen@linux.intel.com, dhowells@redhat.com, dvyukov@google.com, hpa@zytor.com, mingo@redhat.com, j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net, jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com, npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Message-ID: <20191016083953.GVjQ94_GtHmfdCof3LB_WynWYVMsI2yD0gQT838TVpU@z>

This patch adds KCSAN runtime functions to the objtool whitelist.

Signed-off-by: Marco Elver <elver@google.com>
---
 tools/objtool/check.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 044c9a3cb247..d1acc867b43c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -466,6 +466,23 @@ static const char *uaccess_safe_builtin[] = {
 	"__asan_report_store4_noabort",
 	"__asan_report_store8_noabort",
 	"__asan_report_store16_noabort",
+	/* KCSAN */
+	"__kcsan_check_watchpoint",
+	"__kcsan_setup_watchpoint",
+	/* KCSAN/TSAN out-of-line */
+	"__tsan_func_entry",
+	"__tsan_func_exit",
+	"__tsan_read_range",
+	"__tsan_read1",
+	"__tsan_read2",
+	"__tsan_read4",
+	"__tsan_read8",
+	"__tsan_read16",
+	"__tsan_write1",
+	"__tsan_write2",
+	"__tsan_write4",
+	"__tsan_write8",
+	"__tsan_write16",
 	/* KCOV */
 	"write_comp_data",
 	"__sanitizer_cov_trace_pc",
-- 
2.23.0.700.g56cf767bdb-goog
