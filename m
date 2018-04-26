From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH -tip v2 2/7] kprobes: Show blacklist addresses as same as kallsyms does
Date: Thu, 26 Apr 2018 17:09:02 +0900
Message-ID: <152473014240.8819.3919458094230811205.stgit@devbox>
References: <152473007907.8819.10449983839199591406.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <152473007907.8819.10449983839199591406.stgit@devbox>
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
---
 kernel/kprobes.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 314cec85a8b2..e7d7e3e8598a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2427,9 +2427,17 @@ static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
 {
 	struct kprobe_blacklist_entry *ent =
 		list_entry(v, struct kprobe_blacklist_entry, list);
+	void *start = (void *)ent->start_addr, *end = (void *)ent->end_addr;
 
-	seq_printf(m, "0x%p-0x%p\t%ps\n", (void *)ent->start_addr,
-		   (void *)ent->end_addr, (void *)ent->start_addr);
+	/*
+	 * As long as kallsyms shows the address, kprobes blacklist also
+	 * show it, Or, it shows null address and symbol.
+	 */
+	if (!kallsyms_show_value())
+		start = end = NULL;
+
+	seq_printf(m, "0x%px-0x%px\t%ps\n", start, end,
+		   (void *)ent->start_addr);
 	return 0;
 }
 
