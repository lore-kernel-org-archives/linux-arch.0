Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35115 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfLHRTX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 8 Dec 2019 12:19:23 -0500
Date: Sun, 8 Dec 2019 20:19:18 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH v2] execve: warn if process starts with executable stack
Message-ID: <20191208171918.GC19716@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: dan.carpenter@oracle.com, will@kernel.org, ebiederm@xmission.com, linux-arch@vger.kernel.org, security@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20191208171918.GH-5cKqufFLkN3LWpn436ICdm_JVzb8CfViOzOS-Hh8@z>

There were few episodes of silent downgrade to an executable stack over
years:

1) linking innocent looking assembly file will silently add executable
   stack if proper linker options is not given as well:

	$ cat f.S
	.intel_syntax noprefix
	.text
	.globl f
	f:
	        ret

	$ cat main.c
	void f(void);
	int main(void)
	{
	        f();
	        return 0;
	}

	$ gcc main.c f.S
	$ readelf -l ./a.out
	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
                         0x0000000000000000 0x0000000000000000  RWE    0x10
			 					 ^^^

2) converting C99 nested function into a closure
https://nullprogram.com/blog/2019/11/15/

	void intsort2(int *base, size_t nmemb, _Bool invert)
	{
	    int cmp(const void *a, const void *b)
	    {
	        int r = *(int *)a - *(int *)b;
	        return invert ? -r : r;
	    }
	    qsort(base, nmemb, sizeof(*base), cmp);
	}

will silently require stack trampolines while non-closure version will not.

Without doubt this behaviour is documented somewhere, add a warning so that
developers and users can at least notice. After so many years of x86_64 having
proper executable stack support it should not cause too many problems.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

	v2: print pathname instead of comm/pid

 fs/exec.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -761,6 +761,11 @@ int setup_arg_pages(struct linux_binprm *bprm,
 		goto out_unlock;
 	BUG_ON(prev != vma);
 
+	if (unlikely(vm_flags & VM_EXEC)) {
+		pr_warn_once("process '%pD4' started with executable stack\n",
+			     bprm->file);
+	}
+
 	/* Move stack pages down in memory. */
 	if (stack_shift) {
 		ret = shift_arg_pages(vma, stack_shift);
