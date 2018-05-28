From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: LKMM litmus test for Roman Penyaev's rcu-rr
Date: Mon, 28 May 2018 15:08:11 -0700
Message-ID: <20180528220811.GA5221@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com, will.deacon@arm.com, peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com, mingo@kernel.org, torvalds@linux-foundation.org, roman.penyaev@profitbricks.com
List-Id: linux-arch.vger.kernel.org

Hello!

The litmus test below is a first attempt to model Roman's rcu-rr
round-robin RCU-protected linked list.  His test code, which includes
the algorithm under test, may be found here:

https://github.com/rouming/rcu-rr/blob/master/rcu-rr.c

The P0() process below roughly corresponds to remove_conn_from_arr(),
with litmus-test variable "c" standing in for the per-CPU ppcpu_con.
Similarly, P1() roughly corresponds to get_next_conn_rr().  It claims
that the algorithm is safe, and also claims that it becomes unsafe if
either synchronize_rcu() is removed.

Does this in fact realistically model Roman's algorithm?  Either way,
is there a better approach?

							Thanx, Paul

------------------------------------------------------------------------

C C-RomanPenyaev-list-rcu-rr

{
	int *z=1; (* List: v->w->x->y->z. Noncircular, but long enough. *)
	int *y=z;
	int *x=y;
	int *w=x;
	int *v=w; (* List head is v. *)
	int *c=w; (* Cache, emulating ppcpu_con. *)
}

P0(int *c, int *v, int *w, int *x, int *y)
{
	rcu_assign_pointer(*w, y); /* Remove x from list. */
	synchronize_rcu();
	r1 = READ_ONCE(*c);
	if (r1 == x) {
		WRITE_ONCE(*c, 0); /* Invalidate cache. */
		synchronize_rcu();
	}
	smp_store_release(x, 0);  /* Emulate kfree(x). */
}

P1(int *c, int *v)
{
	rcu_read_lock();
	r1 = READ_ONCE(*c); /* Pick up cache. */
	if (r1 == 0) {
		r1 = READ_ONCE(*v); /* Cache empty, start from head. */
	}
	r2 = rcu_dereference(*r1); /* Advance to next element. */
	smp_store_release(c, r2); /* Update cache. */
	rcu_read_unlock();

	/* And repeat. */
	rcu_read_lock();
	r3 = READ_ONCE(*c);
	if (r3 == 0) {
		r3 = READ_ONCE(*v);
	}
	r4 = rcu_dereference(*r3);
	smp_store_release(c, r4);
	rcu_read_unlock();
}

locations [0:r1; 1:r1; 1:r3; c; v; w; x; y]
exists (1:r1=0 \/ 1:r2=0 \/ 1:r3=0 \/ 1:r4=0) (* Better not be freed!!! *)
