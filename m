Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32894 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726343AbfEAT4p (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2019 15:56:45 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41JqH9d037417
        for <linux-arch@vger.kernel.org>; Wed, 1 May 2019 15:56:43 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s7dvw2jy2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 01 May 2019 15:56:43 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 1 May 2019 20:56:41 +0100
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 3/3] sparc: remove ARCH_SELECT_MEMORY_MODEL
Date: Wed,  1 May 2019 22:56:17 +0300
In-Reply-To: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
References: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1556740577-4140-4-git-send-email-rppt@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Message-ID: <20190501195617.YNb9u4jk2K1r8ncCea7cB2zHujFL9DtRBCMVGoqtsJc@z>

The ARCH_SELECT_MEMORY_MODEL option is enabled only for 64-bit. However,
64-bit configuration also enables ARCH_SPARSEMEM_DEFAULT and there is no
ARCH_FLATMEM_ENABLE in arch/sparc/Kconfig.

With such settings, the dependencies in mm/Kconfig are always evaluated to
SPARSEMEM=y for 64-bit and to FLATMEM=y for 32-bit.

The ARCH_SELECT_MEMORY_MODEL option in arch/sparc/Kconfig does not affect
anything and can be removed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/sparc/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 40f8f4f..9137dbe 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -305,9 +305,6 @@ config NODES_SPAN_OTHER_NODES
 	def_bool y
 	depends on NEED_MULTIPLE_NODES
 
-config ARCH_SELECT_MEMORY_MODEL
-	def_bool y if SPARC64
-
 config ARCH_SPARSEMEM_ENABLE
 	def_bool y if SPARC64
 	select SPARSEMEM_VMEMMAP_ENABLE
-- 
2.7.4
