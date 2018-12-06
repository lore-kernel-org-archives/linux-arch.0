Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:44146 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725898AbeLFRkz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Dec 2018 12:40:55 -0500
References: <20181107173859.24096-1-logang@deltatee.com>
 <20181107173859.24096-3-logang@deltatee.com>
 <20181107121207.62cb37cf58484b7cc80a8fd8@linux-foundation.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <71168447-7470-d2ba-d30e-200ff6202b35@deltatee.com>
Date: Thu, 6 Dec 2018 10:40:31 -0700
MIME-Version: 1.0
In-Reply-To: <20181107121207.62cb37cf58484b7cc80a8fd8@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] mm/sparse: add common helper to mark all memblocks
 present
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, Stephen Bates <sbates@raithlin.com>, Palmer Dabbelt <palmer@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Oscar Salvador <osalvador@suse.de>
Message-ID: <20181206174031.wzJBPdlX_LgOpRgovYsgA9W6xa5nhCrzJA0oPAnfb8Y@z>

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
