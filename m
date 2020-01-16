Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56100 "EHLO
 mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1726889AbgAPGq2 (ORCPT <rfc822;linux-arch@vger.kernel.org>); Thu,
 16 Jan 2020 01:46:28 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v4 5/9] asm-generic/tlb: Add missing CONFIG symbol
Date: Thu, 16 Jan 2020 12:15:27 +0530
Message-ID: <20200116064531.483522-6-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
References: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
To: akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org, mpe@ellerman.id.au
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Message-ID: <20200116064527.jdsIzufHC0T0tXT8JFu3-toZBZMLZLITnKM1dmMVXoo@z>

From: Peter Zijlstra <peterz@infradead.org>

Without this the symbol will not actually end up in .config files.

Fixes: a30e32bd79e9 ("asm-generic/tlb: Provide generic tlb_flush() based =
on flush_tlb_mm()")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 208aad121630..5e907a954532 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -399,6 +399,9 @@ config HAVE_RCU_TABLE_FREE
 config HAVE_MMU_GATHER_PAGE_SIZE
 	bool

+config MMU_GATHER_NO_RANGE
+	bool
+
 config HAVE_MMU_GATHER_NO_GATHER
 	bool

--=20
2.24.1
