From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 0/6] powerpc: queued spinlocks and rwlocks
Date: Thu, 9 Jul 2020 10:31:13 +0200
Message-ID: <20200709083113.GI597537@hirez.programming.kicks-ass.net>
References: <20200706043540.1563616-1-npiggin@gmail.com>
 <24f75d2c-60cd-2766-4aab-1a3b1c80646e@redhat.com>
 <1594101082.hfq9x5yact.astroid@bobo.none>
 <20200708084106.GE597537@hirez.programming.kicks-ass.net>
 <a9834278-25bf-90e9-10f2-cd10e5407ff6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <a9834278-25bf-90e9-10f2-cd10e5407ff6@redhat.com>
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
Cc: linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jul 08, 2020 at 07:54:34PM -0400, Waiman Long wrote:
> On 7/8/20 4:41 AM, Peter Zijlstra wrote:
> > On Tue, Jul 07, 2020 at 03:57:06PM +1000, Nicholas Piggin wrote:
> > > Yes, powerpc could certainly get more performance out of the slow
> > > paths, and then there are a few parameters to tune.
> > Can you clarify? The slow path is already in use on ARM64 which is weak,
> > so I doubt there's superfluous serialization present. And Will spend a
> > fair amount of time on making that thing guarantee forward progressm, so
> > there just isn't too much room to play.
> > 
> > > We don't have a good alternate patching for function calls yet, but
> > > that would be something to do for native vs pv.
> > Going by your jump_label implementation, support for static_call should
> > be fairly straight forward too, no?
> > 
> >    https://lkml.kernel.org/r/20200624153024.794671356@infradead.org
> > 
> Speaking of static_call, I am also looking forward to it. Do you have an
> idea when that will be merged?

0day had one crash on the last round, I think Steve send a fix for that
last night and I'll go look at it.

That said, the last posting got 0 feedback, so either everybody is
really happy with it, or not interested. So let us know in the thread,
with some review feedback.

Once I get through enough of the inbox to actually find the fix and test
it, I'll also update the thread, and maybe threaten to merge it if
everybody stays silent :-)
