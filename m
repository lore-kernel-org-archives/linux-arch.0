Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34838 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726096AbfEAT4j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2019 15:56:39 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41JqHWQ016909
        for <linux-arch@vger.kernel.org>; Wed, 1 May 2019 15:56:38 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2s7es90s8f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 01 May 2019 15:56:38 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 1 May 2019 20:56:36 +0100
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 2/3] s390: remove ARCH_SELECT_MEMORY_MODEL
Date: Wed,  1 May 2019 22:56:16 +0300
In-Reply-To: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
References: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <1556740577-4140-3-git-send-email-rppt@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Message-ID: <20190501195616.SHD4M59DBxTp2XmQjTFPI2-bdwl6Q2yi2B1ka6z7NWs@z>

The only reason s390 has ARCH_SELECT_MEMORY_MODEL option in
arch/s390/Kconfig is an ancient compile error with allnoconfig which was
fixed by commit 97195d6b411f ("[S390] fix sparsemem related compile error
with allnoconfig on s390") by adding the ARCH_SELECT_MEMORY_MODEL option.

Since then a lot have changed and now allnoconfig builds just fine without
ARCH_SELECT_MEMORY_MODEL, so it can be removed.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/s390/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b6e3d06..69d3956 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -621,9 +621,6 @@ config ARCH_SPARSEMEM_ENABLE
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
 
-config ARCH_SELECT_MEMORY_MODEL
-	def_bool y
-
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	def_bool y if SPARSEMEM
 
-- 
2.7.4
