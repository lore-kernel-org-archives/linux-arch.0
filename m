From: Anthony Yznaga <anthony.yznaga@oracle.com>
Subject: [RFC PATCH 2/5] mm: do not assume only the stack vma exists in setup_arg_pages()
Date: Mon, 27 Jul 2020 10:11:24 -0700
Message-ID: <1595869887-23307-3-git-send-email-anthony.yznaga@oracle.com>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:39514 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728999AbgG0RDH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Jul 2020 13:03:07 -0400
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc: mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com

In preparation for allowing vmas to be preserved across exec do not
assume that there is no prev vma to pass to mprotect_fixup() in
setup_arg_pages().
Also, setup_arg_pages() expands the initial stack of a process by
128k or to the stack size limit, whichever is smaller.  expand_stack()
assumes there is no vma between the vma passed to it and the
address to expand to, so check before calling it.

Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
---
 fs/exec.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index e6e8a9a70327..262112e5f9f8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -720,7 +720,7 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	unsigned long stack_shift;
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma = bprm->vma;
-	struct vm_area_struct *prev = NULL;
+	struct vm_area_struct *prev = vma->vm_prev;
 	unsigned long vm_flags;
 	unsigned long stack_base;
 	unsigned long stack_size;
@@ -819,6 +819,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
 	else
 		stack_base = vma->vm_start - stack_expand;
 #endif
+	if (vma != find_vma(mm, stack_base)) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
 	current->mm->start_stack = bprm->p;
 	ret = expand_stack(vma, stack_base);
 	if (ret)
-- 
1.8.3.1
