Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: Consolidation of asm/unaligned.h
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20050317104744.4be7e550.davem@davemloft.net>
References: <20050317104744.4be7e550.davem@davemloft.net>
Content-Type: text/plain
Date: Fri, 18 Mar 2005 00:25:07 +0000
Message-Id: <1111105507.18450.203.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2005-03-17 at 10:47 -0800, David S. Miller wrote:
> Any suggested changes or objections?

There remains the question of _when_ it's sane to cross over from a
direct dereference (and possible trap) to using get_unaligned().

This in fact differs violently between architectures. On i386 we might
as well _always_ just dereference, while on a large number of MMU-less
machines the needle is at the other end of the scale -- we now support
machines on which we _cannot_ fix up alignment traps (bonus points, btw,
to whomever came up with _imprecise_ alignment exceptions for FR-V).

At the moment, the decision of whether to use get_unaligned() or a
direct dereference seems to be largely random -- there are no real
guidelines on when to make either choice. I'd like to see the
get_unaligned() macro take _two_ arguments; the first being the pointer,
and the second being the estimated probability that it'll _actually_ be
unaligned. That probability doesn't have to be particularly accurate;
just enough to let the architecture code take the hint. Some
architectures will need to do the manual load in 100% of cases; some in
0% of cases, and others in between. We'd accept only constants rather
than being silly about it, so the appropriate path can be chosen
entirely at compile time.

-- 
dwmw2
