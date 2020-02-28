From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v3 2/5] Documentation/locking/atomic: Fix atomic-set
 litmus test
Date: Fri, 28 Feb 2020 14:30:24 +0800
Message-ID: <20200228063024.GU69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200227004049.6853-3-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002271133300.1730-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36430 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgB1Gad (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Feb 2020 01:30:33 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002271133300.1730-100000@iolanthe.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org

On Thu, Feb 27, 2020 at 11:34:55AM -0500, Alan Stern wrote:
> On Thu, 27 Feb 2020, Boqun Feng wrote:
> 
> > Currently the litmus test "atomic-set" in atomic_t.txt has a few things
> > to be improved:
> > 
> > 1)	The CPU/Processor numbers "P1,P2" are not only inconsistent with
> > 	the rest of the document, which uses "CPU0" and "CPU1", but also
> > 	unacceptable by the herd tool, which requires processors start
> > 	at "P0".
> > 
> > 2)	The initialization block uses a "atomic_set()", which is OK, but
> > 	it's better to use ATOMIC_INIT() to make clear this is an
> > 	initialization.
> > 
> > 3)	The return value of atomic_add_unless() is discarded
> > 	inexplicitly, which is OK for C language, but it will be helpful
> > 	to the herd tool if we use a void cast to make the discard
> > 	explicit.
> > 
> > Therefore fix these and this is the preparation for adding the litmus
> > test into memory-model litmus-tests directory so that people can
> > understand better about our requirements of atomic APIs and klitmus tool
> > can be used to generate tests.
> > 
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Patch 5/5 in this series does basically the same thing for 
> Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.  How come you 
> used one patch for that, but this is split into two patches (2/5 and 
> 4/5)?
> 

When I was working one the first version, I wasn't so sure that we would
reach the agreement of where to put the litmus tests, and the litmus
test in the atomic_t.txt obviously needs a fix, so I separated the fix
and the adding of a litmus test to make my rebase easier ;-). But you're
right, the separation is not needed now. 

I will merge those two patches into one in the next version, also with
the name adjustment you and Andrea have pointed out. Thanks!

Regards,
Boqun

> Alan
> 
> > ---
> >  Documentation/atomic_t.txt | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> > index 0ab747e0d5ac..ceb85ada378e 100644
> > --- a/Documentation/atomic_t.txt
> > +++ b/Documentation/atomic_t.txt
> > @@ -91,15 +91,15 @@ ops. That is:
> >    C atomic-set
> >  
> >    {
> > -    atomic_set(v, 1);
> > +    atomic_t v = ATOMIC_INIT(1);
> >    }
> >  
> > -  P1(atomic_t *v)
> > +  P0(atomic_t *v)
> >    {
> > -    atomic_add_unless(v, 1, 0);
> > +    (void)atomic_add_unless(v, 1, 0);
> >    }
> >  
> > -  P2(atomic_t *v)
> > +  P1(atomic_t *v)
> >    {
> >      atomic_set(v, 0);
> >    }
> > 
> 
> 
