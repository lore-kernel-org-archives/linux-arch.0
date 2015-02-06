Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41384 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756057AbbBFMDK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Feb 2015 07:03:10 -0500
From: Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 3.16.y-ckt 117/135] vm: make stack guard page errors return VM_FAULT_SIGSEGV rather than SIGBUS
Date: Fri,  6 Feb 2015 12:01:35 +0000
Message-ID: <1423224113-10958-118-git-send-email-luis.henriques@canonical.com>
In-Reply-To: <1423224113-10958-1-git-send-email-luis.henriques@canonical.com>
References: <1423224113-10958-1-git-send-email-luis.henriques@canonical.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Luis Henriques <luis.henriques@canonical.com>
Message-ID: <20150206120135.F_T0e5KlaFNIC8vEswDIu0EOGLJOmJWRJzJQIJ1eUJo@z>

3.16.7-ckt6 -stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index dda1dc6d92dd..769bc8906b2d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2639,7 +2639,7 @@ static int do_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/* Check if we need to add a guard page to the stack */
 	if (check_stack_guard_page(vma, address) < 0)
-		return VM_FAULT_SIGBUS;
+		return VM_FAULT_SIGSEGV;
 
 	/* Use the zero-page for reads */
 	if (!(flags & FAULT_FLAG_WRITE)) {
-- 
2.1.4

