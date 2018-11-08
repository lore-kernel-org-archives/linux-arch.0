From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v2 1/2] mm: Introduce common STRUCT_PAGE_MAX_SHIFT define
Date: Thu, 8 Nov 2018 18:04:33 +0000
Message-ID: <20181108180432.GH144107@arrakis.emea.arm.com>
References: <20181107205433.3875-1-logang@deltatee.com>
 <20181107205433.3875-2-logang@deltatee.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181107205433.3875-2-logang@deltatee.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@sifive.com>, Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>
List-Id: linux-arch.vger.kernel.org

On Wed, Nov 07, 2018 at 01:54:32PM -0700, Logan Gunthorpe wrote:
> This define is used by arm64 to calculate the size of the vmemmap
> region. It is defined as the log2 of the upper bound on the size
> of a struct page.
> 
> We move it into mm_types.h so it can be defined properly instead of
> set and checked with a build bug. This also allows us to use the same
> define for riscv.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christoph Hellwig <hch@lst.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
