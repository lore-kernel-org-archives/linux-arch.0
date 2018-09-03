Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46180 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730923AbeICVsT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Sep 2018 17:48:19 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.14 147/165] kprobes/arm: Fix %p uses in error messages
Date: Mon,  3 Sep 2018 18:57:13 +0200
Message-ID: <20180903165704.182995394@linuxfoundation.org>
In-Reply-To: <20180903165655.003605184@linuxfoundation.org>
References: <20180903165655.003605184@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli <ananth@in.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, "David S . Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Jon Medhurst <tixy@linaro.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Thomas Richter <tmricht@linux.ibm.com>, "Tobin C . Harding" <me@tobin.cc>, Will Deacon <will.deacon@arm.com>, acme@kernel.org, akpm@linux-foundation.org, brueckner@linux.vnet.ibm.com, linux-arch@vger.kernel.org, rostedt@goodmis.org, schwidefsky@de.ibm.com, Ingo Molnar <mingo@kernel.org>
Message-ID: <20180903165713.3aUsmKswsP0KX8iXbueRCccn1RlYPgTBqICl-WoQ6yk@z>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masami Hiramatsu <mhiramat@kernel.org>

commit 75b2f5f5911fe7a2fc82969b2b24dde34e8f820d upstream.

Fix %p uses in error messages by removing it and
using general dumper.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
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
Cc: Will Deacon <will.deacon@arm.com>
Cc: acme@kernel.org
Cc: akpm@linux-foundation.org
Cc: brueckner@linux.vnet.ibm.com
Cc: linux-arch@vger.kernel.org
Cc: rostedt@goodmis.org
Cc: schwidefsky@de.ibm.com
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/lkml/152491905361.9916.15300852365956231645.stgit@devbox
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/probes/kprobes/core.c      |    4 ++--
 arch/arm/probes/kprobes/test-core.c |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -291,8 +291,8 @@ void __kprobes kprobe_handler(struct pt_
 				break;
 			case KPROBE_REENTER:
 				/* A nested probe was hit in FIQ, it is a BUG */
-				pr_warn("Unrecoverable kprobe detected at %p.\n",
-					p->addr);
+				pr_warn("Unrecoverable kprobe detected.\n");
+				dump_kprobe(p);
 				/* fall through */
 			default:
 				/* impossible cases */
--- a/arch/arm/probes/kprobes/test-core.c
+++ b/arch/arm/probes/kprobes/test-core.c
@@ -1517,7 +1517,6 @@ fail:
 	print_registers(&result_regs);
 
 	if (mem) {
-		pr_err("current_stack=%p\n", current_stack);
 		pr_err("expected_memory:\n");
 		print_memory(expected_memory, mem_size);
 		pr_err("result_memory:\n");
