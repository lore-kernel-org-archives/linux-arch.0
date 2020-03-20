From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/3] LKMM: Add litmus test for RCU GP guarantee where
 updater frees object
Date: Fri, 20 Mar 2020 10:59:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.2003201049230.27303-100000@netrider.rowland.org>
References: <20200320065552.253696-1-joel@joelfernandes.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200320065552.253696-1-joel@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, linux-arch@vger.kernel.org, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 20 Mar 2020, Joel Fernandes (Google) wrote:

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

The following comment needs some rewriting.  The grammar is somewhat
awkward and a very important "not" is missing.

> + * This litmus test demonstrates that an RCU reader can never see a write after
> + * the grace period, if it saw writes that happen before the grace period.

An RCU reader can never see a write that follows a grace period if it
did _not_ see writes that precede the grace period.

>  This
> + * is a typical pattern of RCU usage, where the write before the grace period
> + * assigns a pointer, and the writes after destroy the object that the pointer
> + * points to.

... that the pointer used to point to.

> + *
> + * This guarantee also implies, an RCU reader can never span a grace period and
> + * is an important RCU grace period memory ordering guarantee.

Unnecessary comma, and it is not clear what "This" refers to.  The 
whole sentence should be phrased differently:

	This is one implication of the RCU grace-period guarantee,
	which says (among other things) that an RCU reader cannot span 
	a grace period.

Alan
