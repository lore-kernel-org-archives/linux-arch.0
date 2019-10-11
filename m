From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v9 21/28] x86/asm/ftrace: Mark function_hook as function
Date: Fri, 11 Oct 2019 13:51:01 +0200
Message-ID: <20191011115108.12392-22-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011115108.12392-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: bp@alien8.de
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
List-Id: linux-arch.vger.kernel.org

Relabel function_hook to be marked really as a function. It is called
from C and has the same expectations towards the stack etc.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/ftrace_32.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index e0061dc976e1..219be1309c37 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -21,9 +21,9 @@ EXPORT_SYMBOL(__fentry__)
 # define MCOUNT_FRAME			0	/* using frame = false */
 #endif
 
-ENTRY(function_hook)
+SYM_FUNC_START(function_hook)
 	ret
-END(function_hook)
+SYM_FUNC_END(function_hook)
 
 ENTRY(ftrace_caller)
 
-- 
2.23.0
