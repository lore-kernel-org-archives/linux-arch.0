Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36370 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751106AbdHROyl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Aug 2017 10:54:41 -0400
From: Punit Agrawal <punit.agrawal@arm.com>
Subject: [PATCH v2] mm/hugetlb.c: make huge_pte_offset() consistent and document behaviour
Date: Fri, 18 Aug 2017 15:54:15 +0100
Message-ID: <20170818145415.7588-1-punit.agrawal@arm.com>
In-Reply-To: <20170725154114.24131-2-punit.agrawal@arm.com>
References: <20170725154114.24131-2-punit.agrawal@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Punit Agrawal <punit.agrawal@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Steve Capper <steve.capper@arm.com>, Will Deacon <will.deacon@arm.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Michal Hocko <mhocko@suse.com>, Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <20170818145415.QNLQliqSHCsJLECH0mxjfzr1YSVgNqKNC0XeM-bZ7wI@z>

When walking the page tables to resolve an address that points to
!p*d_present() entry, huge_pte_offset() returns inconsistent values
depending on the level of page table (PUD or PMD).

It returns NULL in the case of a PUD entry while in the case of a PMD
entry, it returns a pointer to the page table entry.

A similar inconsitency exists when handling swap entries - returns NULL
for a PUD entry while a pointer to the pte_t is retured for the PMD entry.

Update huge_pte_offset() to make the behaviour consistent - return a
pointer to the pte_t for hugepage or swap entries. Only return NULL in
instances where we have a p*d_none() entry and the size parameter
doesn't match the hugepage size at this level of the page table.

Document the behaviour to clarify the expected behaviour of this function.
This is to set clear semantics for architecture specific implementations
of huge_pte_offset().

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: Steve Capper <steve.capper@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
---

Hi Andrew,
