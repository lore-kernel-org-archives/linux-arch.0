Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45988 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbbCSWgl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 19 Mar 2015 18:36:41 -0400
From: Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.13.y-ckt 19/80] vm: make stack guard page errors return VM_FAULT_SIGSEGV rather than SIGBUS
Date: Thu, 19 Mar 2015 15:35:07 -0700
Message-ID: <1426804568-2907-20-git-send-email-kamal@canonical.com>
In-Reply-To: <1426804568-2907-1-git-send-email-kamal@canonical.com>
References: <1426804568-2907-1-git-send-email-kamal@canonical.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Kamal Mostafa <kamal@canonical.com>
Message-ID: <20150319223507.wbAjlNEFeUoQVtvTzLMwWJGoPb3UqeY4F_B92o_Ylpk@z>

3.13.11-ckt17 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Torvalds <torvalds@linux-foundation.org>

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
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index b24ac03..9ddabd0 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3239,7 +3239,7 @@ static int do_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/* Check if we need to add a guard page to the stack */
 	if (check_stack_guard_page(vma, address) < 0)
-		return VM_FAULT_SIGBUS;
+		return VM_FAULT_SIGSEGV;
 
 	/* Use the zero-page for reads */
 	if (!(flags & FAULT_FLAG_WRITE)) {
-- 
1.9.1

