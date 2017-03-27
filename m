Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:56826 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbdC0FDB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Mar 2017 01:03:01 -0400
Date: Mon, 27 Mar 2017 14:01:34 +0900
From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v3 5/7] zram: Convert to using memset_l
Message-ID: <20170327050134.GA19601@bbox>
References: <20170324161318.18718-1-willy@infradead.org>
 <20170324161318.18718-6-willy@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170324161318.18718-6-willy@infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>
Message-ID: <20170327050134.-DHZNiEDMBVIt3vbE3QbFJgPpcGjgAaou5K9JLY2LXA@z>

On Fri, Mar 24, 2017 at 09:13:16AM -0700, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> zram was the motivation for creating memset_l().  Minchan Kim sees a 7%
> performance improvement on x86 with 100MB of non-zero deduplicatable
> data:
> 
>         perf stat -r 10 dd if=/dev/zram0 of=/dev/null
> 
> vanilla:        0.232050465 seconds time elapsed ( +-  0.51% )
> memset_l:	0.217219387 seconds time elapsed ( +-  0.07% )
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> Tested-by: Minchan Kim <minchan@kernel.org>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks!
