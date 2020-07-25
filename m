From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 5/6] powerpc/pseries: implement paravirt qspinlocks
 for SPLPAR
Date: Sat, 25 Jul 2020 19:26:30 +0200
Message-ID: <20200725172630.GF10769@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <20200706043540.1563616-6-npiggin@gmail.com>
 <874kqhvu1v.fsf@mpe.ellerman.id.au>
 <8265d782-4e50-a9b2-a908-0cb588ffa09c@redhat.com>
 <20200723140011.GR5523@worktop.programming.kicks-ass.net>
 <845de183-56f5-2958-3159-faa131d46401@redhat.com>
 <20200723184759.GS119549@hirez.programming.kicks-ass.net>
 <20200724081647.GA16642@willie-the-truck>
 <8532332b-85dd-661b-cf72-81a8ceb70747@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <8532332b-85dd-661b-cf72-81a8ceb70747@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Boqun Feng <boqun.feng@gmail.com>, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, kvm-ppc@vger.kernel.org, Anton Blanchard <anton@ozlabs.org>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 24, 2020 at 03:10:59PM -0400, Waiman Long wrote:
> On 7/24/20 4:16 AM, Will Deacon wrote:
> > On Thu, Jul 23, 2020 at 08:47:59PM +0200, peterz@infradead.org wrote:
> > > On Thu, Jul 23, 2020 at 02:32:36PM -0400, Waiman Long wrote:
> > > > BTW, do you have any comment on my v2 lock holder cpu info qspinlock patch?
> > > > I will have to update the patch to fix the reported 0-day test problem, but
> > > > I want to collect other feedback before sending out v3.
> > > I want to say I hate it all, it adds instructions to a path we spend an
> > > aweful lot of time optimizing without really getting anything back for
> > > it.
> > > 
> > > Will, how do you feel about it?
> > I can see it potentially being useful for debugging, but I hate the
> > limitation to 256 CPUs. Even arm64 is hitting that now.
> 
> After thinking more about that, I think we can use all the remaining bits in
> the 16-bit locked_pending. Reserving 1 bit for locked and 1 bit for pending,
> there are 14 bits left. So as long as NR_CPUS < 16k (requirement for 16-bit
> locked_pending), we can put all possible cpu numbers into the lock. We can
> also just use smp_processor_id() without additional percpu data.

That sounds horrific, wouldn't that destroy the whole point of using a
byte for pending?

> > Also, you're talking ~1% gains here. I think our collective time would
> > be better spent off reviewing the CNA series and trying to make it more
> > deterministic.
> 
> I thought you guys are not interested in CNA. I do want to get CNA merged,
> if possible. Let review the current version again and see if there are ways
> we can further improve it.

It's not a lack of interrest. We were struggling with the fairness
issues and the complexity of the thing. I forgot the current state of
matters, but at one point UNLOCK was O(n) in waiters, which is, of
course, 'unfortunate'.

I'll have to look up whatever notes remain, but the basic idea of
keeping remote nodes on a secondary list is obviously breaking all sorts
of fairness. After that they pile on a bunch of hacks to fix the worst
of them, but it feels exactly like that, a bunch of hacks.

One of the things I suppose we ought to do is see if some of the ideas
of phase-fair locks can be applied to this.

That coupled with a chronic lack of time for anything :-(
