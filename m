Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:36392 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbeI0PTP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Sep 2018 11:19:15 -0400
Date: Thu, 27 Sep 2018 11:01:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V5 06/30] csky: Cache and TLB routines
Message-ID: <20180927090134.GG5254@hirez.programming.kicks-ass.net>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <7cd7abcd2acf5c61435589338ff80a75a13173ca.1537789737.git.ren_guo@c-sky.com>
 <20180925072407.GA6999@hirez.programming.kicks-ass.net>
 <20180927052737.GA28407@guoren>
 <20180927070859.GC5254@hirez.programming.kicks-ass.net>
 <20180927081138.GA308@guoren>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927081138.GA308@guoren>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, palmer@sifive.com
Message-ID: <20180927090134.1FHOJdFp5xrHKE9NKqPHUETNTot0XGUuS4Pf9Aju9Ig@z>

On Thu, Sep 27, 2018 at 04:11:42PM +0800, Guo Ren wrote:
> On Thu, Sep 27, 2018 at 09:08:59AM +0200, Peter Zijlstra wrote:

> > That's not what I meant; I meant you need something like:
> > 
> > #define flush_cache_range(vma, start, end) cache_wbinv_range(start, end)
> If you remove the tlb_start_vma in my tlb.h, I want to use cache_wbinv_all() is
> more safe. And I'll improve it in future.
> 
> My cache_wbinv_range(start, end) won't care vma->mm's asid and they just use current
> asid in mmu reg. If current_mm != vma->mm, then flush_cache_range will be broken.
> Perhaps, I need improve flush_cache_range first ...

Ah, ok. In that case I'll leave it to you to either use
cache_wbinv_all() or improve the range flush. My only request would to
stick on a comment to explain the reason you're not using
cache_wbinv_range() if you choose to use cache_wbinv_all() for
flush_cache_range().

Thanks!
