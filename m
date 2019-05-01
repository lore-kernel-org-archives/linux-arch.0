Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33018 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726280AbfEAT4g (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2019 15:56:36 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41JqJ3c129238
        for <linux-arch@vger.kernel.org>; Wed, 1 May 2019 15:56:35 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s7es7131g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 01 May 2019 15:56:35 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 1 May 2019 20:56:32 +0100
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 1/3] arm: remove ARCH_SELECT_MEMORY_MODEL
Date: Wed,  1 May 2019 22:56:15 +0300
In-Reply-To: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
References: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1556740577-4140-2-git-send-email-rppt@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Message-ID: <20190501195615.xwuD1ZMCvd12FPTcD0NJcKgVRrQH59JCzw74sOQI52Y@z>

The ARCH_SELECT_MEMORY_MODEL in arch/arm/Kconfig is enabled only when
ARCH_SPARSEMEM_ENABLE=y. But in this case, ARCH_SPARSEMEM_DEFAULT is also
enabled and this in turn enables SPARSEMEM_MANUAL.

Since there is no definition of ARCH_FLATMEM_ENABLE in arch/arm/Kconfig,
SPARSEMEM_MANUAL is the only enabled memory model, hence the final
selection will evaluate to SPARSEMEM=y.

Since ARCH_SPARSEMEM_ENABLE is set to 'y' only by several sub-arch
configurations, the default for must sub-arches would be the falback to
FLATMEM regardless of ARCH_SELECT_MEMORY_MODEL.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9aed25a..25a69a3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1592,9 +1592,6 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool ARCH_SPARSEMEM_ENABLE
 
-config ARCH_SELECT_MEMORY_MODEL
-	def_bool ARCH_SPARSEMEM_ENABLE
-
 config HAVE_ARCH_PFN_VALID
 	def_bool ARCH_HAS_HOLES_MEMORYMODEL || !SPARSEMEM
 
-- 
2.7.4
