Return-Path: <SRS0=JdYX=CN=vger.kernel.org=linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4402CC43461
	for <linux-arch@archiver.kernel.org>; Fri,  4 Sep 2020 10:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AD120658
	for <linux-arch@archiver.kernel.org>; Fri,  4 Sep 2020 10:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgIDKfl (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:35:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:51530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730196AbgIDKbV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Sep 2020 06:31:21 -0400
Received: from localhost.localdomain (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 597E120DD4;
        Fri,  4 Sep 2020 10:31:12 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 17/29] mm: Allow arm64 mmap(PROT_MTE) on RAM-based files
Date:   Fri,  4 Sep 2020 11:30:17 +0100
Message-Id: <20200904103029.32083-18-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200904103029.32083-1-catalin.marinas@arm.com>
References: <20200904103029.32083-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since arm64 memory (allocation) tags can only be stored in RAM, mapping
files with PROT_MTE is not allowed by default. RAM-based files like
those in a tmpfs mount or memfd_create() can support memory tagging, so
update the vm_flags accordingly in shmem_mmap().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/shmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 271548ca20f3..ec94f4c7851e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2267,6 +2267,9 @@ static int shmem_mmap(struct file *file, struct vm_area_struct *vma)
 			vma->vm_flags &= ~(VM_MAYWRITE);
 	}
 
+	/* arm64 - allow memory tagging on RAM-based files */
+	vma->vm_flags |= VM_MTE_ALLOWED;
+
 	file_accessed(file);
 	vma->vm_ops = &shmem_vm_ops;
 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
