Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753497AbeEJGHt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 May 2018 02:07:49 -0400
Date: Thu, 10 May 2018 08:07:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/2] mm: PAGE_KERNEL_* fallbacks
Message-ID: <20180510060733.GA23098@kroah.com>
References: <20180510014447.15989-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510014447.15989-1-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: arnd@arndb.de, willy@infradead.org, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20180510060733.O-F3_IsZfdM4G2JN33Wmm2XPR7nqsGlYnFNAR4BWSgs@z>

On Wed, May 09, 2018 at 06:44:45PM -0700, Luis R. Rodriguez wrote:
> While dusting out the firmware loader closet I spotted a PAGE_KERNEL_*
> fallback hack. This hurts my eyes, and it should also be blinding
> others. Turns out we have other PAGE_KERNEL_* fallback hacks in
> other places.
> 
> This moves them to asm-generic, and keeps track of architectures which
> need some love or review. At least 0-day was happy with the changes.
> 
> Matthew Wilcox did put together a PAGE_KERNEL_RO patch for ia64, that
> needs review and testing, and if it goes well it should be merged.
> 
> Luis R. Rodriguez (2):
>   mm: provide a fallback for PAGE_KERNEL_RO for architectures
>   mm: provide a fallback for PAGE_KERNEL_EXEC for architectures
> 
>  drivers/base/firmware_loader/fallback.c |  5 ----
>  include/asm-generic/pgtable.h           | 36 +++++++++++++++++++++++++
>  mm/nommu.c                              |  4 ---
>  mm/vmalloc.c                            |  4 ---
>  4 files changed, 36 insertions(+), 13 deletions(-)

No list of changes that happened from v1?  :(
