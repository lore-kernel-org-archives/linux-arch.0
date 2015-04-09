From: lizf@kernel.org
Subject: [PATCH 3.4 130/176] vm: make stack guard page errors return VM_FAULT_SIGSEGV rather than SIGBUS
Date: Thu,  9 Apr 2015 16:46:18 +0800
Message-ID: <1428569224-23820-130-git-send-email-lizf@kernel.org>
References: <1428569028-23762-1-git-send-email-lizf@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428569028-23762-1-git-send-email-lizf@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org, Zefan Li <lizefan@huawei.com>
List-Id: linux-arch.vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

3.4.107-rc1 review patch.  If anyone has any objections, please let me know.

------------------


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
Signed-off-by: Zefan Li <lizefan@huawei.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index f573cec..45cd14f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3175,7 +3175,7 @@ static int do_anonymous_page(struct mm_struct *mm, struct vm_area_struct *vma,
 
 	/* Check if we need to add a guard page to the stack */
 	if (check_stack_guard_page(vma, address) < 0)
-		return VM_FAULT_SIGBUS;
+		return VM_FAULT_SIGSEGV;
 
 	/* Use the zero-page for reads */
 	if (!(flags & FAULT_FLAG_WRITE)) {
-- 
1.9.1
