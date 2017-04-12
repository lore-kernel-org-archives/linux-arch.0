From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] mm: add VM_STATIC flag to vmalloc and prevent from
 removing the areas
Date: Wed, 12 Apr 2017 10:31:51 -0700
Message-ID: <20170412173151.GA23054@infradead.org>
References: <1491973350-26816-1-git-send-email-hoeun.ryu@gmail.com>
 <20170412060218.GA16170@infradead.org>
 <AC5E3048-6E2B-4DBE-80BA-AAE2D3EED969@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:35485 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752304AbdDLRcV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Apr 2017 13:32:21 -0400
Content-Disposition: inline
In-Reply-To: <AC5E3048-6E2B-4DBE-80BA-AAE2D3EED969@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hoeun Ryu <hoeun.ryu@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Andreas Dilger <adilger@dilger.ca>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Chris Wilson <chris@chris-wilson.co.uk>, Ingo Molnar <mingo@kernel.org>, zijun_hu <zijun_hu@htc.com>, Matthew Wilcox <mawilcox@microsoft.com>, Thomas Garnier <thgarnie@google.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Wed, Apr 12, 2017 at 08:42:08PM +0900, Hoeun Ryu wrote:
> 
> > On Apr 12, 2017, at 3:02 PM, Christoph Hellwig <hch@infradead.org> wrote:
> > 
> >> On Wed, Apr 12, 2017 at 02:01:59PM +0900, Hoeun Ryu wrote:
> >> vm_area_add_early/vm_area_register_early() are used to reserve vmalloc area
> >> during boot process and those virtually mapped areas are never unmapped.
> >> So `OR` VM_STATIC flag to the areas in vmalloc_init() when importing
> >> existing vmlist entries and prevent those areas from being removed from the
> >> rbtree by accident.
> > 
> > How would they be removed "by accident"?
> 
> I don't mean actual use-cases, but I just want to make it robust against like programming errors.

Oh, ok.  The patch makes sense then, although the changelog could use
a little update.
