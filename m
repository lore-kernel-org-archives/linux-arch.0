From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v4 14/26] mm: Allow arm64 mmap(PROT_MTE) on RAM-based files
Date: Fri, 15 May 2020 18:16:00 +0100
Message-ID: <20200515171612.1020-15-catalin.marinas@arm.com>
References: <20200515171612.1020-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:59488 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbgEORQu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 15 May 2020 13:16:50 -0400
In-Reply-To: <20200515171612.1020-1-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>

Since arm64 memory (allocation) tags can only be stored in RAM, mapping
files with PROT_MTE is not allowed by default. RAM-based files like
those in a tmpfs mount or memfd_create() can support memory tagging, so
update the vm_flags accordingly in shmem_mmap().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 mm/shmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index d722eb830317..73754ed7af69 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2221,6 +2221,9 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 			vma->vm_flags &= ~(VM_MAYWRITE);
 	}
 
+	/* arm64 - allow memory tagging on RAM-based files */
+	vma->vm_flags |= VM_MTE_ALLOWED;
+
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
