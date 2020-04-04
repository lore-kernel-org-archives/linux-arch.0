From: Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v4 0/4] Documentation/litmus-tests: Add litmus tests for
 atomic APIs
Date: Sat, 4 Apr 2020 15:57:55 -0400
Message-ID: <20200404195755.GB83565@google.com>
References: <20200326024022.7566-1-boqun.feng@gmail.com>
 <20200327221843.GA226939@google.com>
 <20200331014037.GB59159@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
 <20200402035816.GA46686@google.com>
 <20200402080358.GC59159@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200402080358.GC59159@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
Sender: linux-doc-owner@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 02, 2020 at 04:03:58PM +0800, Boqun Feng wrote:
> On Wed, Apr 01, 2020 at 11:58:16PM -0400, Joel Fernandes wrote:
> > On Tue, Mar 31, 2020 at 09:40:37AM +0800, Boqun Feng wrote:
> > > On Fri, Mar 27, 2020 at 06:18:43PM -0400, Joel Fernandes wrote:
> > > > On Thu, Mar 26, 2020 at 10:40:18AM +0800, Boqun Feng wrote:
> > > > > A recent discussion raises up the requirement for having test cases for
> > > > > atomic APIs:
> > > > > 
> > > > > 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> > > > > 
> > > > > , and since we already have a way to generate a test module from a
> > > > > litmus test with klitmus[1]. It makes sense that we add more litmus
> > > > > tests for atomic APIs. And based on the previous discussion, I create a
> > > > > new directory Documentation/atomic-tests and put these litmus tests
> > > > > here.
> > > > > 
> > > > > This patchset starts the work by adding the litmus tests which are
> > > > > already used in atomic_t.txt, and also improve the atomic_t.txt to make
> > > > > it consistent with the litmus tests.
> > > > > 
> > > > > Previous version:
> > > > > v1: https://lore.kernel.org/linux-doc/20200214040132.91934-1-boqun.feng@gmail.com/
> > > > > v2: https://lore.kernel.org/lkml/20200219062627.104736-1-boqun.feng@gmail.com/
> > > > > v3: https://lore.kernel.org/linux-doc/20200227004049.6853-1-boqun.feng@gmail.com/
> > > > 
> > > > For full series:
> > > > 
> > > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > > > 
> > > > One question I had was in the existing atomic_set() documentation, it talks
> > > > about atomic_add_unless() implementation based on locking could have issues.
> > > > It says the way to fix such cases is:
> > > > 
> > > > Quote:
> > > >     the typical solution is to then implement atomic_set{}() with
> > > >     atomic_xchg().
> > > > 
> > > > I didn't get how using atomic_xchg() fixes it. Is the assumption there that
> > > > atomic_xchg() would be implemented using locking to avoid atomic_set() having
> > > 
> > > Right, I think that's the intent of the sentence.
> > > 
> > > > issues? If so, we could clarify that in the document.
> > > > 
> > > 
> > > Patches are welcome ;-)
> > 
> > 
> > ---8<-----------------------
> > 
> > Like this? I'll add it to my tree and send it to Paul during my next
> > series, unless you disagree ;-)
> > 
> > Subject: [PATCH] doc: atomic_t: Document better about the locking within
> >  atomic_xchg()
> > 
> > It is not fully clear how the atomic_set() would not cause an issue with
> > preservation of the atomicity of RMW in this example. Make it clear that
> > locking within atomic_xchg() would save the day.
> > 
> > Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Thanks!
> 
> Acked-by: Boqun Feng <boqun.feng@gmail.com>

Thanks for the Ack, will send it to Paul during next series with your tag.

 - Joel
