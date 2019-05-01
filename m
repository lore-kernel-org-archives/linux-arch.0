Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36610 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726207AbfEAT4b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 May 2019 15:56:31 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x41JrFGm046029
        for <linux-arch@vger.kernel.org>; Wed, 1 May 2019 15:56:30 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s7gpf3hkg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Wed, 01 May 2019 15:56:30 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 1 May 2019 20:56:27 +0100
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 0/3] remove ARCH_SELECT_MEMORY_MODEL where it has no effect
Date: Wed,  1 May 2019 22:56:14 +0300
Message-ID: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Message-ID: <20190501195614.-Cn9031Ya8_MJeZHobFgpkPc2ai4R-sapQyNJ9EuiEA@z>

Hi,

For several architectures the ARCH_SELECT_MEMORY_MODEL has no real effect
because the dependencies for the memory model are always evaluated to a
single value.

Remove the ARCH_SELECT_MEMORY_MODEL from the Kconfigs for these
architectures.

Mike Rapoport (3):
  arm: remove ARCH_SELECT_MEMORY_MODEL
  s390: remove ARCH_SELECT_MEMORY_MODEL
  sparc: remove ARCH_SELECT_MEMORY_MODEL

 arch/arm/Kconfig   | 3 ---
 arch/s390/Kconfig  | 3 ---
 arch/sparc/Kconfig | 3 ---
 3 files changed, 9 deletions(-)

-- 
2.7.4
