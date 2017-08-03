From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v9 2/5] xtensa: mark _stext and _end as char-arrays, not single char
Date: Thu,  3 Aug 2017 11:36:09 +0900
Message-ID: <150172775958.27216.12951305461398200544.stgit@devbox>
References: <150172762859.27216.16741726568669538542.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751188AbdHCChA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Aug 2017 22:37:00 -0400
In-Reply-To: <150172762859.27216.16741726568669538542.stgit@devbox>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>, mathieu.desnoyers@efficios.com, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com, linux-arch@vger.kernel.org

Mark _stext and _end as character arrays instead of single
character, as same as include/asm-generic/sections.h does.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/xtensa/kernel/setup.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/kernel/setup.c b/arch/xtensa/kernel/setup.c
index 33bfa5270d95..08175df7a69e 100644
--- a/arch/xtensa/kernel/setup.c
+++ b/arch/xtensa/kernel/setup.c
@@ -273,8 +273,8 @@ void __init init_arch(bp_tag_t *bp_start)
  * Initialize system. Setup memory and reserve regions.
  */
 
-extern char _end;
-extern char _stext;
+extern char _end[];
+extern char _stext[];
 extern char _WindowVectors_text_start;
 extern char _WindowVectors_text_end;
 extern char _DebugInterruptVector_literal_start;
@@ -333,7 +333,7 @@ void __init setup_arch(char **cmdline_p)
 	}
 #endif
 
-	mem_reserve(__pa(&_stext), __pa(&_end));
+	mem_reserve(__pa(_stext), __pa(_end));
 
 #ifdef CONFIG_VECTORS_OFFSET
 	mem_reserve(__pa(&_WindowVectors_text_start),
