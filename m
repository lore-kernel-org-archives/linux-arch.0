From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/8] kprobes: Show blacklist addresses as same as kallsyms does
Date: Thu, 25 Jan 2018 14:27:03 +0900
Message-ID: <151685802318.3099.14391385436778328009.stgit@devbox>
References: <151685799071.3099.10383062804474021403.stgit@devbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751154AbeAYF12 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jan 2018 00:27:28 -0500
In-Reply-To: <151685799071.3099.10383062804474021403.stgit@devbox>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S . Miller" <davem@davemloft.net>, Jon Medhurst <tixy@linaro.org>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Linus Torvalds <torvalds@linux-foundation.org>

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
index da2ccf142358..cb15991ba676 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -2382,9 +2382,17 @@ static int kprobe_blacklist_seq_show(struct seq_file *m, void *v)
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
 
