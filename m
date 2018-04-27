From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 3/7] kprobes: Show address of kprobes if kallsyms does
Date: Fri, 27 Apr 2018 15:41:10 +0900
Message-ID: <152481126987.22588.9245868234845928726.stgit@devbox>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152481117776.22588.1210388093668905564.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Show probed address in debugfs kprobe list file as same
as kallsyms does. This information is used for checking
kprobes are placed in the expected address. So it should
be able to compared with address in kallsyms.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e7d7e3e8598a..94af7c99cf81 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2326,6 +2326,7 @@ static void report_probe(struct seq_file *pi, struct kprobe *p,
 		const char *sym, int offset, char *modname, struct kprobe *pp)
 {
 	char *kprobe_type;
+	void *addr = p->addr;
 
 	if (p->pre_handler == pre_handler_kretprobe)
 		kprobe_type = "r";
@@ -2334,13 +2335,16 @@ static void report_probe(struct seq_file *pi, struct kprobe *p,
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
