Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32868 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754363AbeAKCJv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 10 Jan 2018 21:09:51 -0500
Received: by mail-pg0-f65.google.com with SMTP id i196so1646902pgd.0
        for <linux-arch@vger.kernel.org>; Wed, 10 Jan 2018 18:09:51 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 29/38] fork: Define usercopy region in mm_struct slab caches
Date: Wed, 10 Jan 2018 18:03:01 -0800
Message-ID: <1515636190-24061-30-git-send-email-keescook@chromium.org>
In-Reply-To: <1515636190-24061-1-git-send-email-keescook@chromium.org>
References: <1515636190-24061-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, David Windsor <dave@nullcore.net>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@infradead.org>, Christoph Lameter <cl@linux.com>, "David S. Miller" <davem@davemloft.net>, Laura Abbott <labbott@redhat.com>, Mark Rutland <mark.rutland@arm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoffer Dall <christoffer.dall@linaro.org>, Dave Kleikamp <dave.kleikamp@oracle.com>, Jan Kara <jack@suse.cz>, Luis de Bethencourt <luisbg@kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Rik van Riel <riel@redhat.com>, Matthew Garrett <mjg59@google.com>, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, netdev@vger.kernel.org, linux-mm@kvack.org, kernel-hardening@lists.openwall.com
Message-ID: <20180111020301.n4el2A3WjAskHfVDPrhJZNQu3PnWBFugASSXbIFyn_E@z>

From: David Windsor <dave@nullcore.net>

In support of usercopy hardening, this patch defines a region in the
mm_struct slab caches in which userspace copy operations are allowed.
Only the auxv field is copied to userspace.

cache object allocation:
    kernel/fork.c:
        #define allocate_mm()     (kmem_cache_alloc(mm_cachep, GFP_KERNEL))

        dup_mm():
            ...
            mm = allocate_mm();

        copy_mm(...):
            ...
            dup_mm();

        copy_process(...):
            ...
            copy_mm(...)

        _do_fork(...):
            ...
            copy_process(...)

example usage trace:

    fs/binfmt_elf.c:
        create_elf_tables(...):
            ...
            elf_info = (elf_addr_t *)current->mm->saved_auxv;
            ...
            copy_to_user(..., elf_info, ei_index * sizeof(elf_addr_t))

        load_elf_binary(...):
            ...
            create_elf_tables(...);

This region is known as the slab cache's usercopy region. Slab caches
can now check that each dynamically sized copy operation involving
cache-managed memory falls entirely within the slab's usercopy region.

This patch is modified from Brad Spengler/PaX Team's PAX_USERCOPY
whitelisting code in the last public patch of grsecurity/PaX based on my
understanding of the code. Changes or omissions from the original code are
mine and don't reflect the original grsecurity/PaX code.

Signed-off-by: David Windsor <dave@nullcore.net>
[kees: adjust commit log, split patch, provide usage trace]
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Rik van Riel <riel@redhat.com>
---
 kernel/fork.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 432eadf6b58c..82f2a0441d3b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2225,9 +2225,11 @@ void __init proc_caches_init(void)
 	 * maximum number of CPU's we can ever have.  The cpumask_allocation
 	 * is at the end of the structure, exactly for that reason.
 	 */
-	mm_cachep = kmem_cache_create("mm_struct",
+	mm_cachep = kmem_cache_create_usercopy("mm_struct",
 			sizeof(struct mm_struct), ARCH_MIN_MMSTRUCT_ALIGN,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
+			offsetof(struct mm_struct, saved_auxv),
+			sizeof_field(struct mm_struct, saved_auxv),
 			NULL);
 	vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT);
 	mmap_init();
-- 
2.7.4
