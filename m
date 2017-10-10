From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC tip/core/rcu 05/15] percpu: READ_ONCE() now implies
 smp_read_barrier_depends()
Date: Tue, 10 Oct 2017 08:30:47 -0700
Message-ID: <20171010153047.GB3521@linux.vnet.ibm.com>
References: <20171010001951.GA6476@linux.vnet.ibm.com>
 <1507594969-8347-5-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171010140813.GK3301751@devbig577.frc2.facebook.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171010140813.GK3301751@devbig577.frc2.facebook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, torvalds@linux-foundation.org, mark.rutland@arm.com, dhowells@redhat.com, linux-arch@vger.kernel.org, peterz@infradead.org, will.deacon@arm.com, Christoph Lameter <cl@linux.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 10, 2017 at 07:08:13AM -0700, Tejun Heo wrote:
> On Mon, Oct 09, 2017 at 05:22:39PM -0700, Paul E. McKenney wrote:
> > Because READ_ONCE() now implies smp_read_barrier_depends(), this commit
> > removes the now-redundant smp_read_barrier_depends() following the
> > READ_ONCE() in __ref_is_percpu().
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Christoph Lameter <cl@linux.com>
> 
> Acked-by: Tejun Heo <tj@kernel.org>

Thank you, applied!

> Please feel free to route with other patches.  If this should be
> routed through the percpu tree, please let me know.

This depends on some other not-yet-finalized patch series, so if you
are OK with it, I will route them with that group of serieses.

							Thanx, Paul
