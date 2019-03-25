Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53590 "EHLO
 mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
 with ESMTP id S1729765AbfCYHUe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
 Mon, 25 Mar 2019 03:20:34 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1]) by
 mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2P7DsGP029913
 for <linux-arch@vger.kernel.org>; Mon, 25 Mar 2019 03:20:32 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103]) by
 mx0a-001b2d01.pphosted.com with ESMTP id 2rer35pb87-1 (version=TLSv1.2
 cipher=AES256-GCM-SHA384 bits=256 verify=NOT) for
 <linux-arch@vger.kernel.org>; Mon, 25 Mar 2019 03:20:32 -0400
Received: from localhost by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted for
 <linux-arch@vger.kernel.org> from <rppt@linux.ibm.com>; Mon, 25 Mar 2019
 07:20:30 -0000
Date: Mon, 25 Mar 2019 09:20:23 +0200
From: Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 0/4] provide a generic free_initmem implementation
References: <1550515285-17446-1-git-send-email-rppt@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550515285-17446-1-git-send-email-rppt@linux.ibm.com>
Message-ID: <20190325072022.GD2925@rapoport-lnx>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org
Message-ID: <20190325072023.WI9MHbw52YkR9HgrC-Q20ySHBfe8lgg2Wq1dHl7mbUk@z>

Any comments on this?

On Mon, Feb 18, 2019 at 08:41:21PM +0200, Mike Rapoport wrote:
> Hi,
> 
> Many architectures implement free_initmem() in exactly the same or very
> similar way: they wrap the call to free_initmem_default() with sometimes
> different 'poison' parameter.
> 
> These patches switch those architectures to use a generic implementation
> that does free_initmem_default(POISON_FREE_INITMEM).
> 
> This was inspired by Christoph's patches for free_initrd_mem [1] and I
> shamelessly copied changelog entries from his patches :)
> 
> v2: rebased on top of v5.0-rc7 + Christoph's patches for free_initrd_mem
> 
> [1] https://lore.kernel.org/lkml/20190213174621.29297-1-hch@lst.de/
> 
> Mike Rapoport (4):
>   init: provide a generic free_initmem implementation
>   hexagon: switch over to generic free_initmem()
>   init: free_initmem: poison freed init memory
>   riscv: switch over to generic free_initmem()
> 
>  arch/alpha/mm/init.c      |  6 ------
>  arch/arc/mm/init.c        |  8 --------
>  arch/c6x/mm/init.c        |  5 -----
>  arch/h8300/mm/init.c      |  6 ------
>  arch/hexagon/mm/init.c    | 10 ----------
>  arch/microblaze/mm/init.c |  5 -----
>  arch/nds32/mm/init.c      |  5 -----
>  arch/nios2/mm/init.c      |  5 -----
>  arch/openrisc/mm/init.c   |  5 -----
>  arch/riscv/mm/init.c      |  5 -----
>  arch/sh/mm/init.c         |  5 -----
>  arch/sparc/mm/init_32.c   |  5 -----
>  arch/unicore32/mm/init.c  |  5 -----
>  arch/xtensa/mm/init.c     |  5 -----
>  init/main.c               |  5 +++++
>  15 files changed, 5 insertions(+), 80 deletions(-)
> 
> -- 
> 2.7.4
> 

-- 
Sincerely yours,
Mike.
