From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v4 0/4] Documentation/litmus-tests: Add litmus tests for
 atomic APIs
Date: Tue, 31 Mar 2020 09:40:37 +0800
Message-ID: <20200331014037.GB59159@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200326024022.7566-1-boqun.feng@gmail.com>
 <20200327221843.GA226939@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40605 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgCaBkp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2020 21:40:45 -0400
Content-Disposition: inline
In-Reply-To: <20200327221843.GA226939@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org

On Fri, Mar 27, 2020 at 06:18:43PM -0400, Joel Fernandes wrote:
> On Thu, Mar 26, 2020 at 10:40:18AM +0800, Boqun Feng wrote:
> > A recent discussion raises up the requirement for having test cases for
> > atomic APIs:
> > 
> > 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> > 
> > , and since we already have a way to generate a test module from a
> > litmus test with klitmus[1]. It makes sense that we add more litmus
> > tests for atomic APIs. And based on the previous discussion, I create a
> > new directory Documentation/atomic-tests and put these litmus tests
> > here.
> > 
> > This patchset starts the work by adding the litmus tests which are
> > already used in atomic_t.txt, and also improve the atomic_t.txt to make
> > it consistent with the litmus tests.
> > 
> > Previous version:
> > v1: https://lore.kernel.org/linux-doc/20200214040132.91934-1-boqun.feng@gmail.com/
> > v2: https://lore.kernel.org/lkml/20200219062627.104736-1-boqun.feng@gmail.com/
> > v3: https://lore.kernel.org/linux-doc/20200227004049.6853-1-boqun.feng@gmail.com/
> 
> For full series:
> 
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> One question I had was in the existing atomic_set() documentation, it talks
> about atomic_add_unless() implementation based on locking could have issues.
> It says the way to fix such cases is:
> 
> Quote:
>     the typical solution is to then implement atomic_set{}() with
>     atomic_xchg().
> 
> I didn't get how using atomic_xchg() fixes it. Is the assumption there that
> atomic_xchg() would be implemented using locking to avoid atomic_set() having

Right, I think that's the intent of the sentence.

> issues? If so, we could clarify that in the document.
> 

Patches are welcome ;-)

Regards,
Boqun

> thanks,
> 
>  - Joel
> 
> > 
> > Changes since v3:
> > 
> > *	Merge two patches on atomic-set litmus test into one as per
> > 	Alan. (Alan, you have acked only one of the two patches, so I
> > 	don't add you acked-by for the combined patch).
> > 
> > *	Move the atomic litmus tests into litmus-tests/atomic to align
> > 	with Joel's recent patches on RCU litmus tests.
> > 
> > I think we still haven't reach to a conclusion for the difference of
> > atomic_add_unless() in herdtools, and I'm currently reading the source
> > code of herd to resovle this. This is just an updated version to resolve
> > ealier comments and react on Joel's RCU litmus tests.
> > 
> > Regards,
> > Boqun
> > 
> > [1]: http://diy.inria.fr/doc/litmus.html#klitmus
> > 
> > Boqun Feng (4):
> >   tools/memory-model: Add an exception for limitations on _unless()
> >     family
> >   Documentation/litmus-tests: Introduce atomic directory
> >   Documentation/litmus-tests/atomic: Add a test for atomic_set()
> >   Documentation/litmus-tests/atomic: Add a test for
> >     smp_mb__after_atomic()
> > 
> >  Documentation/atomic_t.txt                    | 24 +++++++-------
> >  ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
> >  ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++
> >  Documentation/litmus-tests/atomic/README      | 16 ++++++++++
> >  tools/memory-model/README                     | 10 ++++--
> >  5 files changed, 91 insertions(+), 15 deletions(-)
> >  create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
> >  create mode 100644 Documentation/litmus-tests/atomic/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> >  create mode 100644 Documentation/litmus-tests/atomic/README
> > 
> > -- 
> > 2.25.1
> > 
