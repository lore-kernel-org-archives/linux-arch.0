From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 2/2] Documentation/litmus-tests: Add note on herd7 7.56
 in atomic litmus test
Date: Tue, 23 Jun 2020 21:05:04 -0700
Message-ID: <20200624040504.GB9247@paulmck-ThinkPad-P72>
References: <20200623005152.GA27459@paulmck-ThinkPad-P72>
 <20200623005231.27712-13-paulmck@kernel.org>
 <e3693dec-213a-3f65-eb1c-284bf8ca6e13@gmail.com>
 <20200623155419.GI9247@paulmck-ThinkPad-P72>
 <b3433b44-29af-4ef4-d047-b0b0d51a9fbd@gmail.com>
 <9e1d448a-cf3c-523d-e0a6-f46ac4706c48@gmail.com>
 <20200623232425.GB418699@andrea>
Reply-To: paulmck@kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgFXEFF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 24 Jun 2020 00:05:05 -0400
Content-Disposition: inline
In-Reply-To: <20200623232425.GB418699@andrea>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org, stern@rowland.harvard.edu, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr

On Wed, Jun 24, 2020 at 01:24:25AM +0200, Andrea Parri wrote:
> On Wed, Jun 24, 2020 at 07:09:01AM +0900, Akira Yokosawa wrote:
> > From f808c371075d2f92b955da1a83ecb3828db1972e Mon Sep 17 00:00:00 2001
> > From: Akira Yokosawa <akiyks@gmail.com>
> > Date: Wed, 24 Jun 2020 06:59:26 +0900
> > Subject: [PATCH 2/2] Documentation/litmus-tests: Add note on herd7 7.56 in atomic litmus test
> > 
> > herdtools 7.56 has enhanced herd7's C parser so that the "(void)expr"
> > construct in Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus is
> > accepted.
> > 
> > This is independent of LKMM's cat model, so mention the required
> > version in the header of the litmus test and its entry in README.
> > 
> > CC: Boqun Feng <boqun.feng@gmail.com>
> > Reported-by: Andrea Parri <parri.andrea@gmail.com>
> > Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
> 
> Frankly, I was hoping that we could simply bump the herd7 version in
> tools/memory-model/README; I understand your point, but I admit that
> I haven't being playing with 7.52 for a while now...

Maybe in a few years it will no longer be relevant, and could then
be removed?

> Acked-by: Andrea Parri <parri.andrea@gmail.com>

I queued both, thank you both!

						Thanx, Paul

>   Andrea
> 
> 
> > ---
> >  Documentation/litmus-tests/README                                | 1 +
> >  .../atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus       | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/litmus-tests/README b/Documentation/litmus-tests/README
> > index b79e640214b9..7f5c6c3ed6c3 100644
> > --- a/Documentation/litmus-tests/README
> > +++ b/Documentation/litmus-tests/README
> > @@ -19,6 +19,7 @@ Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
> >  
> >  Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> >      Test that atomic_set() cannot break the atomicity of atomic RMWs.
> > +    NOTE: Require herd7 7.56 or later which supports "(void)expr".
> >  
> >  
> >  RCU (/rcu directory)
> > diff --git a/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus b/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> > index 49385314d911..ffd4d3e79c4a 100644
> > --- a/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> > +++ b/Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> > @@ -4,6 +4,7 @@ C Atomic-RMW-ops-are-atomic-WRT-atomic_set
> >   * Result: Never
> >   *
> >   * Test that atomic_set() cannot break the atomicity of atomic RMWs.
> > + * NOTE: This requires herd7 7.56 or later which supports "(void)expr".
> >   *)
> >  
> >  {
> > -- 
> > 2.17.1
> > 
> > 
