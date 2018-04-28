From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v4 2/7] kprobes: Show blacklist addresses as same as kallsyms does
Date: Sat, 28 Apr 2018 21:35:32 +0900
Message-ID: <152491893217.9916.14760965896164273464.stgit@devbox>
References: <152491886943.9916.18051658590418236184.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152491886943.9916.18051658590418236184.stgit@devbox>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Richter <tmricht@linux.ibm.com>, akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Show kprobes blacklist addresses under same condition of
showing kallsyms addresses.

Since there are several name conflict for local symbols,
kprobe blacklist needs to show each addresses so that
user can identify where is on blacklist by comparing
with kallsyms.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 Changes in v4:
  - Do not use local variables and fix comment.
 Changes in v3:
  - Updated based on the latest linus tree.
---
 kernel/kprobes.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 5eb42c82497c..6ec1b5e024bf 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2428,8 +2428,16 @@ static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
 	struct kprobe_blacklist_entry *ent =
 		list_entry(v, struct kprobe_blacklist_entry, list);
 
-	seq_printf(m, "0x%px-0x%px\t%ps\n", (void *)ent->start_addr,
-		   (void *)ent->end_addr, (void *)ent->start_addr);
+	/*
+	 * If /proc/kallsyms is not showing kernel address, we won't
+	 * show them here either.
+	 */
+	if (!kallsyms_show_value())
+		seq_printf(m, "0x%px-0x%px\t%ps\n", NULL, NULL,
+			   (void *)ent->start_addr);
+	else
+		seq_printf(m, "0x%px-0x%px\t%ps\n", (void *)ent->start_addr,
+			   (void *)ent->end_addr, (void *)ent->start_addr);
 	return 0;
 }
 
