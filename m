Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46325 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbfE2VhN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 May 2019 17:37:13 -0400
Date: Thu, 30 May 2019 00:37:08 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] elf: align AT_RANDOM bytes
Message-ID: <20190529213708.GA10729@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20190529213708.R22DY14qwxkZZ9BgNlhN1SHXISuOFQI0tZaCpBYcKY4@z>

AT_RANDOM content is always misaligned on x86_64:

	$ LD_SHOW_AUXV=1 /bin/true | grep AT_RANDOM
	AT_RANDOM:       0x7fff02101019

glibc copies first few bytes for stack protector stuff, aligned
access should be slightly faster.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/binfmt_elf.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -144,11 +144,15 @@ static int padzero(unsigned long elf_bss)
 #define STACK_ALLOC(sp, len) ({ \
 	elf_addr_t __user *old_sp = (elf_addr_t __user *)sp; sp += len; \
 	old_sp; })
+#define STACK_ALIGN(sp, align)	\
+	((typeof(sp))(((unsigned long)sp + (int)align - 1) & ~((int)align - 1)))
 #else
 #define STACK_ADD(sp, items) ((elf_addr_t __user *)(sp) - (items))
 #define STACK_ROUND(sp, items) \
 	(((unsigned long) (sp - items)) &~ 15UL)
 #define STACK_ALLOC(sp, len) ({ sp -= len ; sp; })
+#define STACK_ALIGN(sp, align)	\
+	((typeof(sp))((unsigned long)sp & ~((int)align - 1)))
 #endif
 
 #ifndef ELF_BASE_PLATFORM
@@ -217,6 +221,12 @@ create_elf_tables(struct linux_binprm *bprm, struct elfhdr *exec,
 			return -EFAULT;
 	}
 
+	/*
+	 * glibc copies first bytes for stack protector purposes
+	 * which are misaligned on x86_64 because strlen("x86_64") + 1 == 7.
+	 */
+	p = STACK_ALIGN(p, sizeof(long));
+
 	/*
 	 * Generate 16 random bytes for userspace PRNG seeding.
 	 */
