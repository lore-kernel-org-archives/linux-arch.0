Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 25 Feb 2005 13:46:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Changing  update_mmu_cache()
Message-ID: <20050225214637.GQ15648@holomorphy.com>
References: <1109047997.5327.70.camel@gaston> <20050222090741.B16786@flint.arm.linux.org.uk> <20050222100858.27d05a86.davem@davemloft.net> <20050225201538.B27842@flint.arm.linux.org.uk> <20050225134322.43274a9a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225134322.43274a9a.akpm@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk@arm.linux.org.uk>, davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Russell King <rmk@arm.linux.org.uk> wrote:
>> The problem I now face is that we're almost at 2.6.11, and its been
>> almost three months, so I think it's safe to assume that Linus will
>> have forgotten everything about this, and will probably hate the
>> patch next time around.  But maybe I'm underestimating Linus.

On Fri, Feb 25, 2005 at 01:43:22PM -0800, Andrew Morton wrote:
> What does it do?  Just adds a pfn arg to flush_cache_page()?  We do that
> sort of thing quite a lot, and I can help.
> A typical approach would be to send me a patch for the core kernel, a patch
> for x86 and a patch for arm.  Any additional best-effort per-architecture
> patches would be appreciated as well, of course.
> I test of four architectures and compile on seven.  arch maintainers will
> develop, test and submit their bits and when all the ducks are lined up
> I'll send it all off to Linus.
> The main problem is that people are hacking on mm/* all the damn time, so
> I have to live with massive reject storms during the changeover period. 
> But that's my problem, not yours ;)

I do many-architecture testing also, and I'd be willing to help with
sweeps.


-- wli
