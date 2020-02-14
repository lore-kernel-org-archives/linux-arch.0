From: Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC 2/3] tools/memory-model: Add a litmus test for atomic_set()
Date: Fri, 14 Feb 2020 09:12:13 +0100
Message-ID: <20200214081213.GA17708@andrea>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <20200214040132.91934-3-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200214040132.91934-3-boqun.feng@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

> @@ -0,0 +1,24 @@
> +C Atomic-set-observable-to-RMW
> +
> +(*
> + * Result: Never
> + *
> + * Test of the result of atomic_set() must be observable to atomic RMWs.
> + *)
> +
> +{
> +	atomic_t v = ATOMIC_INIT(1);
> +}
> +
> +P0(atomic_t *v)
> +{
> +	(void)atomic_add_unless(v,1,0);

We blacklisted this primitive some time ago, cf. section "LIMITATIONS",
entry (6b) in tools/memory-model/README; the discussion was here:

  https://lkml.kernel.org/r/20180829211053.20531-3-paulmck@linux.vnet.ibm.com

but unfortunately I can't remember other details at the moment: maybe
it is just a matter of or the proper time to update that section.

Thanks,
  Andrea
