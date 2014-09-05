Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yk0-f180.google.com ([209.85.160.180]:41267 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbaIEWOP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Sep 2014 18:14:15 -0400
Received: by mail-yk0-f180.google.com with SMTP id 9so7500383ykp.11
        for <linux-arch@vger.kernel.org>; Fri, 05 Sep 2014 15:14:14 -0700 (PDT)
From: Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v5 2/5] x86,entry: Only call user_exit if TIF_NOHZ
Date: Fri,  5 Sep 2014 15:13:53 -0700
Message-ID: <0b13e0e24ec0307d67ab7a23b58764f6b1270116.1409954077.git.luto@amacapital.net>
In-Reply-To: <cover.1409954077.git.luto@amacapital.net>
References: <cover.1409954077.git.luto@amacapital.net>
In-Reply-To: <cover.1409954077.git.luto@amacapital.net>
References: <cover.1409954077.git.luto@amacapital.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-arch@vger.kernel.org, linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@plumgrid.com>, hpa@zytor.com, Frederic Weisbecker <fweisbec@gmail.com>, Andy Lutomirski <luto@amacapital.net>
Message-ID: <20140905221353.3z6KKIMKHz9xkNKx2ySKVtOqSVoB1lHhNcSzXxbQILU@z>

The RCU context tracking code requires that arch code call
user_exit() on any entry into kernel code if TIF_NOHZ is set.  This
patch adds a check for TIF_NOHZ and a comment to the syscall entry
tracing code.

The main purpose of this patch is to make the code easier to follow:
one can read the body of user_exit and of every function it calls
without finding any explanation of why it's called for traced
syscalls but not for untraced syscalls.  This makes it clear when
user_exit() is necessary.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Andy Lutomirski <luto@amacapital.net>
---
 arch/x86/kernel/ptrace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 39296d25708c..bbf338a04a5d 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -1449,7 +1449,12 @@ long syscall_trace_enter(struct pt_regs *regs)
 {
 	long ret = 0;
 
-	user_exit();
+	/*
+	 * If TIF_NOHZ is set, we are required to call user_exit() before
+	 * doing anything that could touch RCU.
+	 */
+	if (test_thread_flag(TIF_NOHZ))
+		user_exit();
 
 	/*
 	 * If we stepped into a sysenter/syscall insn, it trapped in
-- 
1.9.3

