From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC][PATCH] spin loop arch primitives for busy waiting
Date: Fri, 7 Apr 2017 21:26:26 +1000
Message-ID: <20170407212626.59f68530@roar.ozlabs.ibm.com>
References: <20170404095001.664718b8@roar.ozlabs.ibm.com>
        <CA+55aFzdUMZHzXtn9PyhJg7GjYNQ5fy6=LzBNJx==Ab=U=YYjw@mail.gmail.com>
        <20170404130233.1f45115b@roar.ozlabs.ibm.com>
        <20170405.070157.871721909352646302.davem@davemloft.net>
        <20170406105958.196c6977@roar.ozlabs.ibm.com>
        <20170406141352.GF18204@arm.com>
        <CA+55aFwgNhF=QUKMKLc9TfQ=cgF2mvMEVx9hJms4wQqCsib9Rw@mail.gmail.com>
        <20170406163651.hj7apd63uxupgdb3@hirez.programming.kicks-ass.net>
        <CA+55aFzTn9e=F68SOtEvvZLdT6zCj9+gLc-OS7qhDKdM7zaasA@mail.gmail.com>
        <20170407094349.f4hdqibbgl36s776@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33819 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753883AbdDGL0m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Apr 2017 07:26:42 -0400
In-Reply-To: <20170407094349.f4hdqibbgl36s776@hirez.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Will Deacon <will.deacon@arm.com>, David Miller <davem@davemloft.net>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Anton Blanchard <anton@samba.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>

On Fri, 7 Apr 2017 11:43:49 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Apr 06, 2017 at 10:31:46AM -0700, Linus Torvalds wrote:
> > But maybe "monitor" is really cheap. I suspect it's microcoded,
> > though, which implies "no".  
> 
> On my IVB-EP (will also try on something newer):
> 
> MONITOR	~332 cycles
> MWAIT	~224 cycles (C0, explicitly invalidated MONITOR)
> 
> So yes, expensive.

Interestingly, Intel optimization manual says:

  The latency of PAUSE instruction in prior generation microarchitecture
  is about 10 cycles, whereas on Skylake microarchitecture it has been
  extended to as many as 140 cycles.

In another part this is claimed for efficiency improvement. Still much
cheaper than your monitor+mwait on your IVB but if skylake is a bit
faster it might become worth it.
