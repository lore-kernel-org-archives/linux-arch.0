Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47592 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbeICVyK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Sep 2018 17:54:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.18 028/123] kprobes/arm64: Fix %p uses in error messages
Date: Mon,  3 Sep 2018 18:56:12 +0200
Message-ID: <20180903165720.682951559@linuxfoundation.org>
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Will Deacon <will.deacon@arm.com>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "David S . Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jon Medhurst <tixy@linaro.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas Richter <tmricht@linux.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, acme@kernel.org, akpm@linux-foundation.org, brueckner@linux.vnet.ibm.com, linux-arch@vger.kernel.org, rostedt@goodmis.org, schwidefsky@de.ibm.com, Ingo Molnar <mingo@kernel.org>
Message-ID: <20180903165612.dSFT42-tCPReC-z20YQ_nTZpUl3tsT1ly1nviv7JNLk@z>

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 0722867dcbc28cc9b269b57acd847c7c1aa638d6 upstream.

Fix %p uses in error messages by removing it because
those are redundant or meaningless.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Will Deacon <will.deacon@arm.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>
Cc: David S . Miller <davem@davemloft.net>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Jon Medhurst <tixy@linaro.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: Tobin C . Harding <me@tobin.cc>
Cc: acme@kernel.org
Cc: akpm@linux-foundation.org
Cc: brueckner@linux.vnet.ibm.com
Cc: linux-arch@vger.kernel.org
Cc: rostedt@goodmis.org
Cc: schwidefsky@de.ibm.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/lkml/152491908405.9916.12425053035317241111.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/probes/kprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -275,7 +275,7 @@ static int __kprobes reenter_kprobe(stru
 		break;
 	case KPROBE_HIT_SS:
 	case KPROBE_REENTER:
-		pr_warn("Unrecoverable kprobe detected at %p.\n", p->addr);
+		pr_warn("Unrecoverable kprobe detected.\n");
 		dump_kprobe(p);
 		BUG();
 		break;
