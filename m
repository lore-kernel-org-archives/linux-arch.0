Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726463AbfECNsw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 May 2019 09:48:52 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x43DmFMb105464
        for <linux-arch@vger.kernel.org>; Fri, 3 May 2019 09:48:50 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s8maaeqau-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 03 May 2019 09:48:43 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Fri, 3 May 2019 14:47:26 +0100
Date: Fri, 3 May 2019 15:47:19 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/3] s390: remove ARCH_SELECT_MEMORY_MODEL
References: <1556740577-4140-1-git-send-email-rppt@linux.ibm.com>
 <1556740577-4140-3-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556740577-4140-3-git-send-email-rppt@linux.ibm.com>
Message-ID: <20190503134719.GB5602@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>, "David S. Miller" <davem@davemloft.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20190503134719.dQOJN06B0TY25R89BfA5k9rEk9lNBibhU6-7di1cogo@z>

On Wed, May 01, 2019 at 10:56:16PM +0300, Mike Rapoport wrote:
> The only reason s390 has ARCH_SELECT_MEMORY_MODEL option in
> arch/s390/Kconfig is an ancient compile error with allnoconfig which was
> fixed by commit 97195d6b411f ("[S390] fix sparsemem related compile error
> with allnoconfig on s390") by adding the ARCH_SELECT_MEMORY_MODEL option.
> 
> Since then a lot have changed and now allnoconfig builds just fine without
> ARCH_SELECT_MEMORY_MODEL, so it can be removed.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/s390/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
