Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57A0C433EF
	for <linux-arch@archiver.kernel.org>; Fri,  3 Jun 2022 14:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245193AbiFCOsR (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Fri, 3 Jun 2022 10:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245192AbiFCOsQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Jun 2022 10:48:16 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7973E1D0D7
        for <linux-arch@vger.kernel.org>; Fri,  3 Jun 2022 07:48:15 -0700 (PDT)
Received: (qmail 303183 invoked by uid 1000); 3 Jun 2022 10:48:14 -0400
Date:   Fri, 3 Jun 2022 10:48:14 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Marco Elver <elver@google.com>
Subject: Re: (Non-) Ctrl Dependency in litmus-tests.txt?
Message-ID: <YpofLjYu5W0yI2uE@rowland.harvard.edu>
References: <YpoW1deb/QeeszO1@ethstick13.dse.in.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YpoW1deb/QeeszO1@ethstick13.dse.in.tum.de>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 03, 2022 at 04:12:37PM +0200, Paul Heidekrüger wrote:
> Hi all,
> 
> I was going through litmus-tests.txt and came across the following:
> 
> > LIMITATIONS
> > ===========
> > 
> > Limitations of the Linux-kernel memory model (LKMM) include:
> > 
> > 1.Compiler optimizations are not accurately modeled.  Of course,
> > 	the use of READ_ONCE() and WRITE_ONCE() limits the compiler's
> > 	ability to optimize, but under some circumstances it is possible
> > 	for the compiler to undermine the memory model.  For more
> > 	information, see Documentation/explanation.txt (in particular,
> > 	the "THE PROGRAM ORDER RELATION: po AND po-loc" and "A WARNING"
> > 	sections).
> > 
> > 	Note that this limitation in turn limits LKMM's ability to
> > 	accurately model address, control, and data dependencies.
> > 	For example, if the compiler can deduce the value of some variable
> > 	carrying a dependency, then the compiler can break that dependency
> > 	by substituting a constant of that value.
> > 
> > 	Conversely, LKMM sometimes doesn't recognize that a particular
> > 	optimization is not allowed, and as a result, thinks that a
> > 	dependency is not present (because the optimization would break it).
> > 	The memory model misses some pretty obvious control dependencies
> > 	because of this limitation.  A simple example is:
> > 
> > 		r1 = READ_ONCE(x);
> > 		if (r1 == 0)
> > 			smp_mb();
> > 		WRITE_ONCE(y, 1);
> > 
> > 	There is a control dependency from the READ_ONCE to the WRITE_ONCE,
> > 	even when r1 is nonzero, but LKMM doesn't realize this and thinks
> > 	that the write may execute before the read if r1 != 0.  (Yes, that
> > 	doesn't make sense if you think about it, but the memory model's
> > 	intelligence is limited.)
> 
> I'm unclear as to why the documentation sees a control dependency from
> the READ_ONCE() to the WRITE_ONCE() here.
> 
> Quoting from explanation.txt:
> > Finally, a read event and another memory access event are linked by a
> > control dependency if the value obtained by the read affects whether
> > the second event is executed at all.
> 
> Architectures might consider this control-dependent, yes, but since the
> value of the if condition does not affect whether the WRITE_ONCE() is
> executed at all, I'm not sure why this should be considered
> control-dependent in LKMM? 
> 
> I might have another question about explanation.txt's definition of
> control dependencies as per above, but will address it more thoroughly
> in another email :-)

You're right; strictly speaking this isn't a control dependency.  In 
fact it's not a dependency at all, just an ordering restriction that's 
connected with a conditional test.

If you would like to submit a patch updating the text, please feel free 
to do so.

Alan
