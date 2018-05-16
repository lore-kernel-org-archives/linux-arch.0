Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33733 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbeEPQoG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 May 2018 12:44:06 -0400
Date: Wed, 16 May 2018 18:44:03 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v3 0/2] mm: PAGE_KERNEL_* fallbacks
Message-ID: <20180516164403.GI27853@wotan.suse.de>
References: <20180510185507.2439-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510185507.2439-1-mcgrof@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de, gregkh@linuxfoundation.org, willy@infradead.org
Cc: mcgrof@kernel.org, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20180516164403.umYjoy_f-EHgSqOYacumDJ1t-B2BUjpNHkfhG6FeduM@z>

On Thu, May 10, 2018 at 11:55:05AM -0700, Luis R. Rodriguez wrote:
> This is the 3rd iteration for moving PAGE_KERNEL_* fallback
> definitions into asm-generic headers. Greg asked for a Changelog
> for patch iteration changes, its below.
> 
> All these patches have been tested by 0-day.
> 
> Questions, and specially flames are greatly appreciated.

*Poke*

Who's tree should this go through?

  Luis

> 
> v3:
> 
> Removed documentation effort to keep tabs on which architectures
> currently don't defint the respective PAGE_* flags. Keeping tabs
> on this is just not worth it.
> 
> Ran a spell checker on all patches :)
> 
> v2:
> 
> I added a patch for PAGE_KERNEL_EXEC as suggested by Matthew Wilcox.
> 
> v1:
> 
> I sent out a patch just for dealing witht he fallback mechanism for
> PAGE_KERNEL_RO.
> 
> Luis R. Rodriguez (2):
>   mm: provide a fallback for PAGE_KERNEL_RO for architectures
>   mm: provide a fallback for PAGE_KERNEL_EXEC for architectures
> 
>  drivers/base/firmware_loader/fallback.c |  5 -----
>  include/asm-generic/pgtable.h           | 18 ++++++++++++++++++
>  mm/nommu.c                              |  4 ----
>  mm/vmalloc.c                            |  4 ----
>  4 files changed, 18 insertions(+), 13 deletions(-)
> 
> -- 
> 2.17.0
> 
> 

-- 
Do not panic
