From: Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 2/2] mm/sparse: add common helper to mark all memblocks
 present
Date: Thu, 6 Dec 2018 10:40:31 -0700
Message-ID: <71168447-7470-d2ba-d30e-200ff6202b35@deltatee.com>
References: <20181107173859.24096-1-logang@deltatee.com>
 <20181107173859.24096-3-logang@deltatee.com>
 <20181107121207.62cb37cf58484b7cc80a8fd8@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107121207.62cb37cf58484b7cc80a8fd8@linux-foundation.org>
Content-Language: en-CA
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Stephen Bates <sbates@raithlin.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
List-Id: linux-arch.vger.kernel.org

Hey Andrew,

On 2018-11-07 1:12 p.m., Andrew Morton wrote:
> Acked-by: Andrew Morton <akpm@linux-foundation.org>
> 
> I can grab both patches and shall sneak them into 4.20-rcX, but feel
> free to merge them into some git tree if you'd prefer.  If I see them
> turn up in linux-next I shall drop my copy.

Just wanted to check if you are still planning to get these patches into
4.20-rcX. It would really help us if you can do this seeing we then
won't have to delay a cycle and can target the riscv sparsemem code for
4.21.

Thanks,

Logan
