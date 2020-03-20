From: Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH 1/3] LKMM: Add litmus test for RCU GP guarantee where
 updater frees object
Date: Fri, 20 Mar 2020 11:26:03 +0100
Message-ID: <20200320102603.GA22784@andrea>
References: <20200320065552.253696-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34228 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgCTK0M (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 06:26:12 -0400
Content-Disposition: inline
In-Reply-To: <20200320065552.253696-1-joel@joelfernandes.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>

On Fri, Mar 20, 2020 at 02:55:50AM -0400, Joel Fernandes (Google) wrote:
> This adds an example for the important RCU grace period guarantee, which
> shows an RCU reader can never span a grace period.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  .../litmus-tests/RCU+sync+free.litmus         | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 tools/memory-model/litmus-tests/RCU+sync+free.litmus
> 
> diff --git a/tools/memory-model/litmus-tests/RCU+sync+free.litmus b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
> new file mode 100644
> index 0000000000000..c4682502dd296
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/RCU+sync+free.litmus
> @@ -0,0 +1,40 @@
> +C RCU+sync+free
> +
> +(*
> + * Result: Never
> + *
> + * This litmus test demonstrates that an RCU reader can never see a write after
> + * the grace period, if it saw writes that happen before the grace period. This
> + * is a typical pattern of RCU usage, where the write before the grace period
> + * assigns a pointer, and the writes after destroy the object that the pointer
> + * points to.
> + *
> + * This guarantee also implies, an RCU reader can never span a grace period and
> + * is an important RCU grace period memory ordering guarantee.
> + *)
> +
> +{
> +x = 1;
> +y = x;
> +z = 1;

FYI, this could become a little more readable if we wrote it as follows:

int x = 1;
int *y = &x;
int z = 1;

The LKMM tools are happy either way, just a matter of style/preference;
and yes, MP+onceassign+derefonce isn't currently following mine...  ;-/


> +}
> +
> +P0(int *x, int *z, int **y)
> +{
> +	int r0;

This would need to be "int *r0;" in order to make klitmus7(+gcc) happy.


> +	int r1;
> +
> +	rcu_read_lock();
> +	r0 = rcu_dereference(*y);
> +	r1 = READ_ONCE(*r0);
> +	rcu_read_unlock();
> +}
> +
> +P1(int *x, int *z, int **y)
> +{
> +	rcu_assign_pointer(*y, z);

AFAICT, you don't need this "RELEASE"; e.g., compare this test with the
example in:

  https://www.kernel.org/doc/Documentation/RCU/Design/Requirements/Requirements.html#Grace-Period%20Guarantee

What am I missing?

Thanks,
  Andrea


> +	synchronize_rcu();
> +	WRITE_ONCE(*x, 0);
> +}
> +
> +exists (0:r0=x /\ 0:r1=0)
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 
