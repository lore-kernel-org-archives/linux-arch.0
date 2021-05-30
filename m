Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AFBC47091
	for <linux-arch@archiver.kernel.org>; Sun, 30 May 2021 16:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DDDA611CE
	for <linux-arch@archiver.kernel.org>; Sun, 30 May 2021 16:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbhE3Qv4 (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Sun, 30 May 2021 12:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229769AbhE3Qvx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 May 2021 12:51:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82A9E61027;
        Sun, 30 May 2021 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622393413;
        bh=HDSaZ0r8YKgOW4RVtraztMNXpYLvrjOWnnb7z2CxfsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GAGEb5c22zpNCgKwGBgY8HNtxiJgf0vgoElGLScInJXq+kuUkcai+NAm5FYi1S5fe
         Wfdn/WN+Tra9jBnjfvuw0dBg7b5AjxiD7BIRbn00pRkCh0xyDVYPvwt74QsoXXOUOS
         gfzas4nvp/Jca6YhLA/1tHUWJkEAFHPEV4mOEn0FIgu5H0LNMmXPQmeyoUx1f3rS8W
         oy7zXQIGU0rqhAfdie79pXVa/2nJbvWhtsbObF93E1Dn/X8hBjHCxY0UVDQc1qa6Ac
         sLvrTnTQT502mD9HDx13tAidDdRzPTNdIqqMsWpEZpEVMPH7kUc4trbRRMdJtEi1IH
         JBlAUV7Vaf4lg==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, hch@lst.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V5 0/3] riscv: Fixup asid_allocator remaining issues
Date:   Sun, 30 May 2021 16:49:23 +0000
Message-Id: <1622393366-46079-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The patchset fixes the remaining problems of asid_allocator.
 - Fixup _PAGE_GLOBAL for kernel virtual address mapping
 - Optimize tlb_flush with asid & range

Changes since v4:
 - Fixup double PAGE_SIZE add in local_flush_tlb_range_asid
 - Add tlbflush: Optimize coding convention
 - Optimize comment

Changes since v3:
 - Optimize coding convention for
   "riscv: Use use_asid_allocator flush TLB"

Changes since v2:
 - Remove PAGE_UP/DOWN usage in tlbflush.h
 - Optimize variable name

Changes since v1:
 - Drop PAGE_UP wrong fixup
 - Rebase on clean linux-5.13-rc2
 - Add Reviewed-by

Guo Ren (3):
  riscv: Use global mappings for kernel pages
  riscv: Add ASID-based tlbflushing methods
  riscv: tlbflush: Optimize coding convention

 arch/riscv/include/asm/mmu_context.h |  2 ++
 arch/riscv/include/asm/pgtable.h     |  3 +-
 arch/riscv/include/asm/tlbflush.h    | 22 ++++++++++++++
 arch/riscv/mm/context.c              |  2 +-
 arch/riscv/mm/tlbflush.c             | 57 ++++++++++++++++++++++++++++--------
 5 files changed, 71 insertions(+), 15 deletions(-)

-- 
2.7.4

