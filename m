Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38010 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbfEPFTd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 May 2019 01:19:33 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4G5HWaR121164
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 01:19:31 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sgxr5wwhf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Thu, 16 May 2019 01:19:31 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Thu, 16 May 2019 06:19:29 +0100
Date: Thu, 16 May 2019 08:19:21 +0300
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 0/3] remove ARCH_SELECT_MEMORY_MODEL where it has no
 effect
References: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <20190516051921.GC21366@rapoport-lnx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20190516051921.UUO9zfa4MurQ3a3Ru27JoRQs1qdnPcHzB2c3-UdA8J0@z>

Andrew,

Can this go via the -mm tree?

On Wed, May 01, 2019 at 10:56:14PM +0300, Mike Rapoport wrote:
> Hi,
> 
> For several architectures the ARCH_SELECT_MEMORY_MODEL has no real effect
> because the dependencies for the memory model are always evaluated to a
> single value.
> 
> Remove the ARCH_SELECT_MEMORY_MODEL from the Kconfigs for these
> architectures.
> 
> Mike Rapoport (3):
>   arm: remove ARCH_SELECT_MEMORY_MODEL
>   s390: remove ARCH_SELECT_MEMORY_MODEL
>   sparc: remove ARCH_SELECT_MEMORY_MODEL
> 
>  arch/arm/Kconfig   | 3 ---
>  arch/s390/Kconfig  | 3 ---
>  arch/sparc/Kconfig | 3 ---
>  3 files changed, 9 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.
