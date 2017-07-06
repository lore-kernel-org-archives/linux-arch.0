From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/9] RISC-V: Atomic and Locking Code
Date: Thu, 6 Jul 2017 09:26:16 +0200
Message-ID: <20170706072616.h2rs7seogejfbrod@hirez.programming.kicks-ass.net>
References: <20170704195102.3974-1-palmer@dabbelt.com>
 <20170704195102.3974-3-palmer@dabbelt.com>
 <20170705084321.hqy4qsm45mv772k4@hirez.programming.kicks-ass.net>
 <20170706110833.fkq7axoz3tf655lz@tardis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:37366 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbdGFH1l (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2017 03:27:41 -0400
Content-Disposition: inline
In-Reply-To: <20170706110833.fkq7axoz3tf655lz@tardis>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, mingo@redhat.com, mcgrof@kernel.org, viro@zeniv.linux.org.uk, sfr@canb.auug.org.au, nicolas.dichtel@6wind.com, rmk+kernel@armlinux.org.uk, msalter@redhat.com, tklauser@distanz.ch, will.deacon@arm.com, james.hogan@imgtec.com, paul.gortmaker@windriver.com, linux@roeck-us.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, albert@sifive.com, patches@groups.riscv.org

On Thu, Jul 06, 2017 at 07:08:33PM +0800, Boqun Feng wrote:
> On Wed, Jul 05, 2017 at 10:43:21AM +0200, Peter Zijlstra wrote:
> > On Tue, Jul 04, 2017 at 12:50:55PM -0700, Palmer Dabbelt wrote:
> > > +/*
> > > + * FIXME: I could only find documentation that atomic_{add,sub,inc,dec} are
> > > + * barrier-free.  I'm assuming that and/or/xor have the same constraints as the
> > > + * others.
> > > + */
> > 
> > Yes.. we have new documentation in the work to which I would post a link
> > but for some reason copy/paste stopped working again (Konsole does that
> > at times and is #$%#$%#4# annoying).
> > 
> > Ha, found it using google...
> > 
> >   https://marc.info/?l=linux-kernel&m=14972790112580
> > 
> 
> The link is broken, you miss a tailing 1 ;-)
> 
> 	https://marc.info/?l=linux-kernel&m=149727901125801
> 

Argh... thanks for fixing that!
