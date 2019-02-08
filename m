Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41970 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727121AbfBHSM4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2019 13:12:56 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x18I3rZ2006082
        for <linux-arch@vger.kernel.org>; Fri, 8 Feb 2019 13:12:56 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2qhe1w22vt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-arch@vger.kernel.org>; Fri, 08 Feb 2019 13:12:55 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>;
        Fri, 8 Feb 2019 18:12:53 -0000
Date: Fri, 8 Feb 2019 20:12:47 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 0/3] generic asm: mman cleanup
References: <20190124142448.23243-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124142448.23243-1-mst@redhat.com>
Message-ID: <20190208181246.GF11096@rapoport-lnx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190208181247.O_HcU_9AZ9qm9ch1vDkun9iRx0NeCDaJQwOp6NLI4Cg@z>

On Fri, Feb 08, 2019 at 01:02:51AM -0500, Michael S. Tsirkin wrote:
> Now that we have MAP_SHARED, MAP_PRIVATE and MAP_SHARED_VALIDATE on all
> architectures, it probably makes sense to de-duplicate these
> and put them into a common header.

I like the idea, but it seems there are more asm/mman.h users than just mpx
and drm.

Any reason only those were updated to include linux/mman.h?

 
> Please review and consider merging though the generic tree.
> 
> Build tested on x86 only. Has been in linux-next for a while now.
> 
> Michael S. Tsirkin (3):
>   x86/mpx: tweak header name
>   drm: tweak header name
>   arch: move common mmap flags to linux/mman.h
> 
>  arch/alpha/include/uapi/asm/mman.h     | 4 +---
>  arch/mips/include/uapi/asm/mman.h      | 4 +---
>  arch/parisc/include/uapi/asm/mman.h    | 4 +---
>  arch/x86/mm/mpx.c                      | 2 +-
>  arch/xtensa/include/uapi/asm/mman.h    | 4 +---
>  include/drm/drmP.h                     | 3 +--
>  include/uapi/asm-generic/mman-common.h | 4 +---
>  include/uapi/linux/mman.h              | 4 ++++
>  8 files changed, 11 insertions(+), 18 deletions(-)
> 
> -- 
> MST
> 

-- 
Sincerely yours,
Mike.
