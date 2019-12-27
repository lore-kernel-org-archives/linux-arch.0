Return-Path: <rppt@kernel.org>
Date: Fri, 27 Dec 2019 13:07:37 +0200
From: Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 0/2] fix recent nds32 build breakage
Message-ID: <20191227110736.GA30363@rapoport-lnx>
References: <20191223110004.2157-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191223110004.2157-1-rppt@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Mike Rapoport <rppt@kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20191227110737.VAfUTZ94efpIDmt821SljFq2mLfoGs-_dMx2AWqqT6k@z>

Arnd,

Can you please take these via asm-generic tree?

On Mon, Dec 23, 2019 at 01:00:02PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> Hi,
> 
> The kbuild robot reported build breakage of nds32 architecture [1] that
> happens with CONFIG_CPU_CACHE_ALIASING=n and CONFIG_HUGHMEM=y.
> 
> There are two issues: one with a missing macro during conversion of page
> folding and another one is a conflict between cacheflush.h definitions in
> arch/nds32 and asm-generic.
> 
> [1] https://lore.kernel.org/lkml/201912212139.yptX8CsV%25lkp@intel.com/
> 
> Mike Rapoport (2):
>   asm-generic/nds32: don't redefine cacheflush primitives
>   nds32: fix build failure caused by page table folding updates
> 
>  arch/nds32/include/asm/cacheflush.h | 11 ++++++----
>  arch/nds32/include/asm/pgtable.h    |  2 +-
>  include/asm-generic/cacheflush.h    | 33 ++++++++++++++++++++++++++++-
>  3 files changed, 40 insertions(+), 6 deletions(-)
> 
> -- 
> 2.24.0
> 

-- 
Sincerely yours,
Mike.
