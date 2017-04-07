From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Date: Fri, 7 Apr 2017 11:43:49 +0200
Message-ID: <20170407094349.f4hdqibbgl36s776@hirez.programming.kicks-ass.net>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
 <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
 <20170404130233.1f45115b@roar.ozlabs.ibm.com>
 <20170405.070157.871721909352646302.davem@davemloft.net>
 <20170406105958.196c6977@roar.ozlabs.ibm.com>
 <20170406141352.GF18204@arm.com>
 <CA+55aFwgNhF=QUKMKLc9TfQ=cgF2mvMEVx9hJms4wQqCsib9Rw@mail.gmail.com>
 <20170406163651.hj7apd63uxupgdb3@hirez.programming.kicks-ass.net>
 <CA+55aFzTn9e=F68SOtEvvZLdT6zCj9+gLc-OS7qhDKdM7zaasA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:59083 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754581AbdDGJn5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2017 05:43:57 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzTn9e=F68SOtEvvZLdT6zCj9+gLc-OS7qhDKdM7zaasA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will.deacon@arm.com>, Nicholas Piggin <npiggin@gmail.com>, David Miller <davem@davemloft.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>

On Thu, Apr 06, 2017 at 10:31:46AM -0700, Linus Torvalds wrote:
> But maybe "monitor" is really cheap. I suspect it's microcoded,
> though, which implies "no".

On my IVB-EP (will also try on something newer):

MONITOR	~332 cycles
MWAIT	~224 cycles (C0, explicitly invalidated MONITOR)

So yes, expensive.
