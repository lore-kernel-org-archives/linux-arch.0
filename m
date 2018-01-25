From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/8] kprobes: Show address of kprobes if kallsyms does
Date: Thu, 25 Jan 2018 14:27:33 +0900
Message-ID: <151685805305.3099.10341850491509023684.stgit@devbox>
References: <151685799071.3099.10383062804474021403.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751154AbeAYF15 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jan 2018 00:27:57 -0500
In-Reply-To: <151685799071.3099.10383062804474021403.stgit@devbox>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>

Show probed address in debugfs kprobe list file as same
as kallsyms does. This information is used for checking
kprobes are placed in the expected address. So it should
be able to compared with address in kallsyms.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index cb15991ba676..a5f13e379ae1 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2281,6 +2281,7 @@ static void report_probe(struct seq_file *pi, struct kprobe *p,
 		const char *sym, int offset, char *modname, struct kprobe *pp)
 {
 	char *kprobe_type;
+	void *addr = p->addr;
 
 	if (p->pre_handler == pre_handler_kretprobe)
 		kprobe_type = "r";
@@ -2289,13 +2290,16 @@ static void report_probe(struct seq_file *pi, struct kprobe *p,
 	else
 		kprobe_type = "k";
 
+	if (!kallsyms_show_value())
+		addr = NULL;
+
 	if (sym)
-		seq_printf(pi, "%p  %s  %s+0x%x  %s ",
-			p->addr, kprobe_type, sym, offset,
+		seq_printf(pi, "%px  %s  %s+0x%x  %s ",
+			addr, kprobe_type, sym, offset,
 			(modname ? modname : " "));
-	else
-		seq_printf(pi, "%p  %s  %p ",
-			p->addr, kprobe_type, p->addr);
+	else	/* try to use %pS */
+		seq_printf(pi, "%px  %s  %pS ",
+			addr, kprobe_type, p->addr);
 
 	if (!pp)
 		pp = p;
