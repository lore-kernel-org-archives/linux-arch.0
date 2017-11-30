From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v5 20/27] x86: ftrace, mark function_hook as function
Date: Thu, 30 Nov 2017 15:46:46 +0100
Message-ID: <20171130144653.23688-21-jslaby@suse.cz>
References: <20171130144653.23688-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130144653.23688-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Relabel function_hook to be marked really as a function. It is called
from C and has the same expectations towards the stack etc.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/ftrace_32.S | 4 ++--
 arch/x86/kernel/ftrace_64.S | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index 8ec623798970..b9253728defd 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -30,9 +30,9 @@ EXPORT_SYMBOL(mcount)
 # define MCOUNT_FRAME			0	/* using frame = false */
 #endif
 
-ENTRY(function_hook)
+SYM_FUNC_START(function_hook)
 	ret
-END(function_hook)
+SYM_FUNC_END(function_hook)
 
 ENTRY(ftrace_caller)
 
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index e9af91bcfc05..085c74a4f98b 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -146,9 +146,9 @@ EXPORT_SYMBOL(mcount)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-ENTRY(function_hook)
+SYM_FUNC_START(function_hook)
 	retq
-END(function_hook)
+SYM_FUNC_END(function_hook)
 
 ENTRY(ftrace_caller)
 	/* save_mcount_regs fills in first two parameters */
-- 
2.15.0
