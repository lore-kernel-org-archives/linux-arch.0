From: Jiri Slaby <jslaby@suse.cz>
Subject: [patch added to the 3.12 stable tree] vm: make stack guard page errors return VM_FAULT_SIGSEGV rather than SIGBUS
Date: Thu, 12 Mar 2015 16:52:09 +0100
Message-ID: <1426175534-29874-3-git-send-email-jslaby@suse.cz>
References: <1426175534-29874-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ip4-83-240-67-251.cust.nbox.cz ([83.240.67.251]:52620 "EHLO
	ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932585AbbCLPwQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Mar 2015 11:52:16 -0400
In-Reply-To: <1426175534-29874-1-git-send-email-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: stable@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

From: Linus Torvalds <torvalds@linux-foundation.org>

This patch has been added to the 3.12 stable tree. If you have any
objections, please let us know.

===============

commit 9c145c56d0c8a0b62e48c8d71e055ad0fb2012ba upstream.

The stack guard page error case has long incorrectly caused a SIGBUS
rather than a SIGSEGV, but nobody actually noticed until commit
fee7e49d4514 ("mm: propagate error from stack expansion even for guard
page") because that error case was never actually triggered in any
normal situations.

Now that we actually report the error, people noticed the wrong signal
that resulted.  So far, only the test suite of libsigsegv seems to have
actually cared, but there are real applications that use libsigsegv, so
let's not wait for any of those to break.

Reported-and-tested-by: Takashi Iwai <tiwai@suse.de>
Tested-by: Jan Engelhardt <jengelh@inai.de>
Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com> # "s390 still compiles and boots"
Cc: linux-arch@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index 7c11dd8b9571..9d6f692c49c3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3226,7 +3226,7 @@ static int do_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/* Check if we need to add a guard page to the stack */
 	if (check_stack_guard_page(vma, address) < 0)
-		return VM_FAULT_SIGBUS;
+		return VM_FAULT_SIGSEGV;
 
 	/* Use the zero-page for reads */
 	if (!(flags & FAULT_FLAG_WRITE)) {
-- 
2.3.0
