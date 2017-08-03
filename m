From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v9 1/5] h8300: mark _stext and _etext as char-arrays, not single char
Date: Thu,  3 Aug 2017 11:35:04 +0900
Message-ID: <150172769415.27216.12021110228384155707.stgit@devbox>
References: <150172762859.27216.16741726568669538542.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751188AbdHCCfy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Aug 2017 22:35:54 -0400
In-Reply-To: <150172762859.27216.16741726568669538542.stgit@devbox>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Francis Deslauriers <francis.deslauriers@efficios.com>, mathieu.desnoyers@efficios.com, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com, linux-arch@vger.kernel.org

Mark _stext and _etext as character arrays instead of
single character, as same as include/asm-generic/sections.h
does.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/h8300/include/asm/traps.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/h8300/include/asm/traps.h b/arch/h8300/include/asm/traps.h
index 15e701130b27..1c5a30ec2df8 100644
--- a/arch/h8300/include/asm/traps.h
+++ b/arch/h8300/include/asm/traps.h
@@ -33,9 +33,9 @@ extern unsigned long *_interrupt_redirect_table;
 #define TRAP2_VEC 10
 #define TRAP3_VEC 11
 
-extern char _start, _etext;
+extern char _start[], _etext[];
 #define check_kernel_text(addr) \
-	((addr >= (unsigned long)(&_start)) && \
-	 (addr <  (unsigned long)(&_etext)) && !(addr & 1))
+	((addr >= (unsigned long)(_start)) && \
+	 (addr <  (unsigned long)(_etext)) && !(addr & 1))
 
 #endif /* _H8300_TRAPS_H */
