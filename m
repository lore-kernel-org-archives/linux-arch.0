Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 25 Feb 2005 14:59:58 -0800
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Changing  update_mmu_cache()
Message-ID: <20050225225958.GR15648@holomorphy.com>
References: <1109047997.5327.70.camel@gaston> <20050222090741.B16786@flint.arm.linux.org.uk> <20050222100858.27d05a86.davem@davemloft.net> <20050225201538.B27842@flint.arm.linux.org.uk> <20050225134322.43274a9a.akpm@osdl.org> <20050225224809.F27842@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050225224809.F27842@flint.arm.linux.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, davem@davemloft.net, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Feb 25, 2005 at 10:48:09PM +0000, Russell King wrote:
> I'm sorry, I'm completely at the end of my rag over this.  I, for
> one, can't operate with keeping up with the mainline kernel while
> having these kinds of invasive patches outstanding for 4+ months
> with zero help, and little prospect of them getting merged.
> The same happened with the DMA mmap API.  With that, I've now
> resorted to merging the ARM version of it and said "bugger the
> other architectures."
> What it basically comes down to is that a stable kernel series is
> not the place for development.  It's obvious we're trying to meet
> opposing demands with the existing development model, and it just
> isn't working.  Well, it isn't for me at least.

Well, my efforts on the DMA mmap() issue got completely thwarted by
holy penguin pee, so it wasn't for lack of trying.


-- wli
