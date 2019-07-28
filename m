Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33663 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfG1Pfr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 28 Jul 2019 11:35:47 -0400
Received: by mail-pl1-f196.google.com with SMTP id c14so26463922plo.0
        for <linux-arch@vger.kernel.org>; Sun, 28 Jul 2019 08:35:46 -0700 (PDT)
Date: Sun, 28 Jul 2019 11:35:44 -0400
From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2] lkmm/docs: Correct ->prop example with additional rfe
 link
Message-ID: <20190728153544.GA87531@google.com>
References: <20190728031303.164545-1-joel@joelfernandes.org>
 <Pine.LNX.4.44L0.1907281027160.6532-100000@netrider.rowland.org>
 <20190728151959.GA82871@google.com>
 <20190728152806.GB26905@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190728152806.GB26905@tardis>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org, kernel-team@android.com, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <andrea.parri@amarulasolutions.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Ingo Molnar <mingo@kernel.org>, Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
Message-ID: <20190728153544.-vBxH1dainwoVx9_HT87ENd2fWRJo7c9X6Gk_PF50ns@z>

On Sun, Jul 28, 2019 at 11:28:06PM +0800, Boqun Feng wrote:
> On Sun, Jul 28, 2019 at 11:19:59AM -0400, Joel Fernandes wrote:
> > On Sun, Jul 28, 2019 at 10:48:51AM -0400, Alan Stern wrote:
> > > On Sat, 27 Jul 2019, Joel Fernandes (Google) wrote:
> > > 
> > > > The lkmm example about ->prop relation should describe an additional rfe
> > > > link between P1's store to y and P2's load of y, which should be
> > > > critical to establishing the ordering resulting in the ->prop ordering
> > > > on P0. IOW, there are 2 rfe links, not one.
> > > > 
> > > > Correct these in the docs to make the ->prop ordering on P0 more clear.
> > > > 
> > > > Cc: kernel-team@android.com
> > > > Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> > > > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > ---
> > > 
> > > This is not a good update.  See below...
> > 
> > No problem, thanks for the feedback. I am new to the LKMM so please bear
> > with me.. I should have tagged this RFC.
> > 
> > > >  .../memory-model/Documentation/explanation.txt  | 17 ++++++++++-------
> > > >  1 file changed, 10 insertions(+), 7 deletions(-)
> > > > 
> > > > diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> > > > index 68caa9a976d0..aa84fce854cc 100644
> > > > --- a/tools/memory-model/Documentation/explanation.txt
> > > > +++ b/tools/memory-model/Documentation/explanation.txt
> > > > @@ -1302,8 +1302,8 @@ followed by an arbitrary number of cumul-fence links, ending with an
> > > >  rfe link.  You can concoct more exotic examples, containing more than
> > > >  one fence, although this quickly leads to diminishing returns in terms
> > > >  of complexity.  For instance, here's an example containing a coe link
> > > > -followed by two fences and an rfe link, utilizing the fact that
> > > > -release fences are A-cumulative:
> > > > +followed by a fence, an rfe link, another fence and and a final rfe link,
> > >                                                    ^---^
> > > > +utilizing the fact that release fences are A-cumulative:
> > > 
> > > I don't like this, for two reasons.  First is the repeated "and" typo.
> > 
> > Will fix the trivial typo, sorry about that.
> > 
> > > More importantly, it's not necessary to go into this level of detail; a
> > > better revision would be:
> > > 
> > > +followed by two cumul-fences and an rfe link, utilizing the fact that
> > > 
> > > This is appropriate because the cumul-fence relation is defined to 
> > > contain the rfe link which you noticed wasn't mentioned explicitly.
> > 
> > No, I am talking about the P1's store to Y and P2's load of Y. That is not
> > through a cumul-fence so I don't understand what you meant? That _is_ missing
> > the rfe link I am referring to, that is left out.
> > 
> > The example says r2 = 1 and then we work backwards from that. r2 could very
> > well have been 0, there's no fence or anything involved, it just happens to
> > be the executation pattern causing r2 = 1 and hence the rfe link. Right?
> > 
> > > >  	int x, y, z;
> > > >  
> > > > @@ -1334,11 +1334,14 @@ If x = 2, r0 = 1, and r2 = 1 after this code runs then there is a prop
> > > >  link from P0's store to its load.  This is because P0's store gets
> > > >  overwritten by P1's store since x = 2 at the end (a coe link), the
> > > >  smp_wmb() ensures that P1's store to x propagates to P2 before the
> > > > -store to y does (the first fence), the store to y propagates to P2
> > > > -before P2's load and store execute, P2's smp_store_release()
> > > > -guarantees that the stores to x and y both propagate to P0 before the
> > > > -store to z does (the second fence), and P0's load executes after the
> > > > -store to z has propagated to P0 (an rfe link).
> > > > +store to y does (the first fence), P2's store to y happens before P2's
> > > ---------------------------------------^
> > > 
> > > This makes no sense, since P2 doesn't store to y.  You meant P1's store
> > > to y.  Also, the use of "happens before" is here unnecessarily
> > > ambiguous (is it an informal usage or does it refer to the formal
> > > happens-before relation?).  The original "propagates to" is better.
> > 
> > Will reword this.
> > 
> > > > +load of y (rfe link), P2's smp_store_release() ensures that P2's load
> > > > +of y executes before P2's store to z (second fence), which implies that
> > > > +that stores to x and y propagate to P2 before the smp_store_release(), which
> > > > +means that P2's smp_store_release() will propagate stores to x and y to all
> > > > +CPUs before the store to z propagates (A-cumulative property of this fence).
> > > > +Finally P0's load of z executes after P2's store to z has propagated to
> > > > +P0 (rfe link).
> > > 
> > > Again, a better change would be simply to replace the two instances of
> > > "fence" in the original text with "cumul-fence".
> > 
> > Ok that's fine. But I still feel the rfe is not a part of the cumul-fence.
> > The fences have nothing to do with the rfe. Or, I am missing something quite
> > badly.
> > 
> > Boqun, did you understand what Alan is saying?
> > 
> 
> I think 'cumul-fence' that Alan mentioned is not a fence, but a
> relation, which could be the result of combining a rfe relation and a
> A-cumulative fence relation. Please see the section "PROPAGATION ORDER
> RELATION: cumul-fence" or the definition of cumul-fence in
> linux-kernel.cat.
> 
> Did I get you right, Alan? If so, your suggestion is indeed a better
> change.

To be frank, I don't think it is better if that's what Alan meant. It is
better to be explicit about the ->rfe so that the reader walking through the
example can clearly see the ordering and make sense of it.

Just saying 'cumul-fence' and then hoping the reader sees the light is quite
a big assumption and makes the document less readable.

I mean the fact that you are asking Alan for clarification, means that it is
not that obvious ;)

thanks,

 - Joel
