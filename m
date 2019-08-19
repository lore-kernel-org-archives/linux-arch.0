Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33177 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728520AbfHSXlT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Aug 2019 19:41:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so2135355pfq.0
        for <linux-arch@vger.kernel.org>; Mon, 19 Aug 2019 16:41:18 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 4/7] bug: Lift "cut here" out of __warn()
Date: Mon, 19 Aug 2019 16:41:08 -0700
Message-ID: <20190819234111.9019-5-keescook@chromium.org>
In-Reply-To: <20190819234111.9019-1-keescook@chromium.org>
References: <20190819234111.9019-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Drew Davenport <ddavenport@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Steven Rostedt (VMware)" <rostedt@goodmis.org>, Feng Tang <feng.tang@intel.com>, Petr Mladek <pmladek@suse.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Borislav Petkov <bp@suse.de>, YueHaibing <yuehaibing@huawei.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20190819234108.BFI3f2a3WCpbHeuNfcaJiS75WdaPgOPoRXkBFo9kLcE@z>

In preparation for cleaning up "cut here", move the "cut here" logic
up out of __warn() and into callers that pass non-NULL args. For anyone
looking closely, there are two callers that pass NULL args: one already
explicitly prints "cut here". The remaining case is covered by how a
WARN is built, which will be cleaned up in the next patch.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/panic.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/panic.c b/kernel/panic.c
index 51efdeb2558e..dc2243429903 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -551,9 +551,6 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 {
 	disable_trace_on_warning();
 
-	if (args)
-		pr_warn(CUT_HERE);
-
 	if (file)
 		pr_warn("WARNING: CPU: %d PID: %d at %s:%d %pS\n",
 			raw_smp_processor_id(), current->pid, file, line,
@@ -597,8 +594,9 @@ void warn_slowpath_fmt(const char *file, int line, unsigned taint,
 {
 	struct warn_args args;
 
+	pr_warn(CUT_HERE);
+
 	if (!fmt) {
-		pr_warn(CUT_HERE);
 		__warn(file, line, __builtin_return_address(0), taint,
 		       NULL, NULL);
 		return;
-- 
2.17.1
