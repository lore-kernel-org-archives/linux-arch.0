From: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v2] mm: add VM_STATIC flag to vmalloc and prevent from
 removing the areas
Date: Tue, 18 Apr 2017 08:59:46 +0200
Message-ID: <20170418065946.GB22360@dhcp22.suse.cz>
References: <1492494570-21068-1-git-send-email-hoeun.ryu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751233AbdDRG7w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Apr 2017 02:59:52 -0400
Content-Disposition: inline
In-Reply-To: <1492494570-21068-1-git-send-email-hoeun.ryu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hoeun Ryu <hoeun.ryu@gmail.com>
Cc: hch@infradead.org, khandual@linux.vnet.ibm.com, Andrew Morton <akpm@linux-foundation.org>, Roman Pen <r.peniaev@gmail.com>, Andreas Dilger <adilger@dilger.ca>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Chris Wilson <chris@chris-wilson.co.uk>, Ingo Molnar <mingo@kernel.org>, zijun_hu <zijun_hu@htc.com>, Matthew Wilcox <mawilcox@microsoft.com>, Thomas Garnier <thgarnie@google.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Tue 18-04-17 14:48:39, Hoeun Ryu wrote:
>  vm_area_add_early/vm_area_register_early() are used to reserve vmalloc area
> during boot process and those virtually mapped areas are never unmapped.
> So `OR` VM_STATIC flag to the areas in vmalloc_init() when importing
> existing vmlist entries and prevent those areas from being removed from the
> rbtree by accident.

Has this been a problem in the past or currently so that it is worth
handling?

> This flags can be also used by other vmalloc APIs to
> specify that the area will never go away.

Do we have a user for that?

> This makes remove_vm_area() more robust against other kind of errors (eg.
> programming errors).

Well, yes it will help to prevent from vfree(early_mem) but we have 4
users of vm_area_register_early so I am really wondering whether this is
worth additional code. It would really help to understand your
motivation for the patch if we were explicit about the problem you are
trying to solve.

Thanks

-- 
Michal Hocko
SUSE Labs
