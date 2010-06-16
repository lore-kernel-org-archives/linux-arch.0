From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -v18 00/37] Use lmb with x86
Date: Wed, 16 Jun 2010 18:41:20 +1000
Message-ID: <1276677680.2552.205.camel@pasglop>
References: <1276666966-14259-1-git-send-email-yinghai@kernel.org>
	 <AANLkTinhO5sFs4YRP3nraC_ldZ8ZgzJBOQYYv9jLd_Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38509 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268Ab0FPImW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 16 Jun 2010 04:42:22 -0400
In-Reply-To: <AANLkTinhO5sFs4YRP3nraC_ldZ8ZgzJBOQYYv9jLd_Dw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yinghai Lu <yinghai@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Johannes Weiner <hannes@cmpxchg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Tue, 2010-06-15 at 23:10 -0700, Linus Torvalds wrote:
> On Tuesday, June 15, 2010, Yinghai Lu <yinghai@kernel.org> wrote:
> >
> >  46 files changed, 1476 insertions(+), 1282 deletions(-)
> 
> So what was the advantage again? It's adding more lines than it
> removes. Wasn't the point to simplify things, not make them bigger?

I -think- the point is that once that's done, you can remove a whole lot
of gunk that was added such as the kernel/range.c caca, etc...
(basically, x86 gunk gratuituously made generic and that should really
just die instead).

However, I do have some issues with some aspects of Yinghai port to x86,
where instead of removing the old crap, it adds a layer that turns the
LMB into that old crap which is then turned back into something else...
not too sure, it's definitely a bit weird.

So using LMB per-se is a good idea, because it replaces whatever other
range management/allocator you have there. But it has to be done "right"
and I think we need Thomas, Ingo and/or Peter to give that a good look
and see whether what we have there is "right" or not as far as x86 is
concerned.

Cheers,
Ben.
