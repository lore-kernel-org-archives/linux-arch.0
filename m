From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V5 06/30] csky: Cache and TLB routines
Date: Thu, 27 Sep 2018 19:19:59 +0800
Message-ID: <20180927111959.GA20967@guoren-Inspiron-7460>
References: <cover.1537789736.git.ren_guo@c-sky.com>
 <7cd7abcd2acf5c61435589338ff80a75a13173ca.1537789737.git.ren_guo@c-sky.com>
 <20180925072407.GA6999@hirez.programming.kicks-ass.net>
 <20180927052737.GA28407@guoren>
 <20180927070859.GC5254@hirez.programming.kicks-ass.net>
 <20180927081138.GA308@guoren>
 <20180927090134.GG5254@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180927090134.GG5254@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, palmer@sifive.com
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 27, 2018 at 11:01:34AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 27, 2018 at 04:11:42PM +0800, Guo Ren wrote:
> > On Thu, Sep 27, 2018 at 09:08:59AM +0200, Peter Zijlstra wrote:
> 
> > > That's not what I meant; I meant you need something like:
> > > 
> > > #define flush_cache_range(vma, start, end) cache_wbinv_range(start, end)
> > If you remove the tlb_start_vma in my tlb.h, I want to use cache_wbinv_all() is
> > more safe. And I'll improve it in future.
> > 
> > My cache_wbinv_range(start, end) won't care vma->mm's asid and they just use current
> > asid in mmu reg. If current_mm != vma->mm, then flush_cache_range will be broken.
> > Perhaps, I need improve flush_cache_range first ...
> 
> Ah, ok. In that case I'll leave it to you to either use
> cache_wbinv_all() or improve the range flush. My only request would to
> stick on a comment to explain the reason you're not using
> cache_wbinv_range() if you choose to use cache_wbinv_all() for
> flush_cache_range().
Ok, the comment is necessary and I'll do it in next patchset.

Best Regards
 Guo Ren
