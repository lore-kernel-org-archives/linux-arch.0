From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] ELF: warn if process starts with executable stack
Date: Mon, 18 Nov 2019 17:51:15 +0300
Message-ID: <20191118145114.GA9228@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, security@kernel.org
List-Id: linux-arch.vger.kernel.org

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
