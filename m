Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.21]:55088 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754265Ab3BRQSs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Feb 2013 11:18:48 -0500
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 0/2] Arch-specific user pgtables ceiling
Date: Mon, 18 Feb 2013 16:18:29 +0000
Message-ID: <1361204311-14127-1-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20130218161829.HgKYkuL3Mjopu9U6JjmdQ2QvSQKS2jAmfudEo1wPAPE@z>

Following feedback on the previous patch to limit the free_pgtables()
ceiling, this series introduces a USER_PGTABLES_CEILING macro defaulting
to 0 and an ARM-specific definition to TASK_SIZE.

Catalin Marinas (1):
  arm: Set the page table freeing ceiling to TASK_SIZE

Hugh Dickins (1):
  mm: Allow arch code to control the user page table ceiling

 arch/arm/include/asm/pgtable.h |  7 +++++++
 fs/exec.c                      |  4 ++--
 include/asm-generic/pgtable.h  | 10 ++++++++++
 mm/mmap.c                      |  4 ++--
 4 files changed, 21 insertions(+), 4 deletions(-)

