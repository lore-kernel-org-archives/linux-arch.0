Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Sun, 6 Feb 2005 22:50:20 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch 19/24] TASK_SIZE is variable.
Message-ID: <20050206215020.GJ18245@wotan.suse.de>
References: <200502050150.j151osl11380@mail.osdl.org> <Pine.LNX.4.58.0502041806120.2165@ppc970.osdl.org> <Pine.LNX.4.58.0502041919300.2165@ppc970.osdl.org> <20050205090619.C30866@flint.arm.linux.org.uk> <20050205154448.1cc89ee9.davem@davemloft.net> <20050206105047.GB6819@wotan.suse.de> <20050206131947.6524ece9.davem@davemloft.net> <20050206213148.GI18245@wotan.suse.de> <20050206133110.528ce713.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206133110.528ce713.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andi Kleen <ak@suse.de>, rmk@arm.linux.org.uk, torvalds@osdl.org, akpm@osdl.org, dwmw2@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Feb 06, 2005 at 01:31:10PM -0800, David S. Miller wrote:
> We're talking about 5 or 6 instructions on x86.
> If it's getting too big, put it out-of-line.  It probably
> belongs out-of-line in it's current form anyways.

I don't think that's a good idea, sorry - make a very common
inline considerably bigger and/or slower just to make sparc64 debugging 
easier.

And yes this stuff does matter - i remember i got LM benchmarkable
improvements in signal latency by optimizing __copy_to_user
to use optimized inlines for small stores.

-Andi
