Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33885 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfKROvU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Nov 2019 09:51:20 -0500
Date: Mon, 18 Nov 2019 17:51:15 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] ELF: warn if process starts with executable stack
Message-ID: <20191118145114.GA9228@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, security@kernel.org
Message-ID: <20191118145115.mynt0gRK4g4FpIETPyxy6rPAKVxuyYA1PEDoamZ6JDw@z>

PT_GNU_STACK is fail open design, at least warn people that something
isn't right.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/exec.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -762,6 +762,13 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		goto out_unlock;
 	BUG_ON(prev != vma);
 
+#ifdef CONFIG_MMU
+	if (vm_flags & VM_EXEC) {
+		pr_warn_once("process '%s'/%u started with executable stack\n",
+			     current->comm, current->pid);
+	}
+#endif
+
 	/* Move stack pages down in memory. */
 	if (stack_shift) {
 		ret = shift_arg_pages(vma, stack_shift);
