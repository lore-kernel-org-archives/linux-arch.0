Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728093AbfJKLvZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 11 Oct 2019 07:51:25 -0400
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v9 21/28] x86/asm/ftrace: Mark function_hook as function
Date: Fri, 11 Oct 2019 13:51:01 +0200
Message-ID: <20191011115108.12392-22-jslaby@suse.cz>
In-Reply-To: <20191011115108.12392-1-jslaby@suse.cz>
References: <20191011115108.12392-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: bp@alien8.de
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Message-ID: <20191011115101.ov075NcVHOog-jkKHT2vuFfsuIGAayCGxELzdZbVVig@z>

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
