From: Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH v3 5/7] zram: Convert to using memset_l
Date: Mon, 27 Mar 2017 14:01:34 +0900
Message-ID: <20170327050134.GA19601@bbox>
References: <20170324161318.18718-1-willy@infradead.org>
 <20170324161318.18718-6-willy@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <20170324161318.18718-6-willy@infradead.org>
Content-Disposition: inline
Sender: sparclinux-owner@vger.kernel.org
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, x86@kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>
List-Id: linux-arch.vger.kernel.org

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
