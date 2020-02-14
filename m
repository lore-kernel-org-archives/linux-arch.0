From: Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [RFC 3/3] tools/memory-model: Add litmus test for RMW +
 smp_mb__after_atomic()
Date: Fri, 14 Feb 2020 14:15:37 +0800
Message-ID: <20200214061537.GA20408@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <20200214040132.91934-4-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200214040132.91934-4-boqun.feng@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 14, 2020 at 12:01:32PM +0800, Boqun Feng wrote:
> We already use a litmus test in atomic_t.txt to describe atomic RMW +
> smp_mb__after_atomic() is "strong acquire" (both the read and the write
> part is ordered). So make it a litmus test in memory-model litmus-tests
> directory, so that people can access the litmus easily.
> 
> Additionally, change the processor numbers "P1, P2" to "P0, P1" in
> atomic_t.txt for the consistency with the processor numbers in the
> litmus test, which herd can handle.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  Documentation/atomic_t.txt                    |  6 ++--
>  ...+mb__after_atomic-is-strong-acquire.litmus | 29 +++++++++++++++++++
>  tools/memory-model/litmus-tests/README        |  5 ++++
>  3 files changed, 37 insertions(+), 3 deletions(-)
>  create mode 100644 tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> 
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index ceb85ada378e..e3ad4e4cd9ed 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -238,14 +238,14 @@ strictly stronger than ACQUIRE. As illustrated:
>    {
>    }
>  
> -  P1(int *x, atomic_t *y)
> +  P0(int *x, atomic_t *y)
>    {
>      r0 = READ_ONCE(*x);
>      smp_rmb();
>      r1 = atomic_read(y);
>    }
>  
> -  P2(int *x, atomic_t *y)
> +  P1(int *x, atomic_t *y)
>    {
>      atomic_inc(y);
>      smp_mb__after_atomic();
> @@ -260,7 +260,7 @@ This should not happen; but a hypothetical atomic_inc_acquire() --
>  because it would not order the W part of the RMW against the following
>  WRITE_ONCE.  Thus:
>  
> -  P1			P2
> +  P0			P1
>  
>  			t = LL.acq *y (0)
>  			t++;
> diff --git a/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus b/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> new file mode 100644
> index 000000000000..e7216cf9d92a
> --- /dev/null
> +++ b/tools/memory-model/litmus-tests/Atomic-RMW+mb__after_atomic-is-strong-acquire.litmus
> @@ -0,0 +1,29 @@
> +C Atomic-RMW+mb__after_atomic-is-strong-acquire
> +
> +(*
> + * Result: Never
> + *
> + * Test of an atomic RMW followed by a smp_mb__after_atomic() is
> + * "strong-acquire": both the read and write part of the RMW is ordered before
> + * the subsequential memory accesses.
> + *)
> +
> +{
> +}
> +
> +P0(int *x, atomic_t *y)
> +{
> +	r0 = READ_ONCE(*x);
> +	smp_rmb();
> +	r1 = atomic_read(y);
> +}
> +
> +P1(int *x, atomic_t *y)
> +{
> +	atomic_inc(y);
> +	smp_mb__after_atomic();
> +	WRITE_ONCE(*x, 1);
> +}
> +
> +exists
> +(r0=1 /\ r1=0)

Hmm.. this should be "(0:r0=1 /\ 0:r1=0)", I will fix this in next
verison.

Regards,
Boqun

> diff --git a/tools/memory-model/litmus-tests/README b/tools/memory-model/litmus-tests/README
> index 81eeacebd160..774e10058c72 100644
> --- a/tools/memory-model/litmus-tests/README
> +++ b/tools/memory-model/litmus-tests/README
> @@ -2,6 +2,11 @@
>  LITMUS TESTS
>  ============
>  
> +Atomic-RMW+mb__after_atomic-is-strong-acquire
> +	Test of an atomic RMW followed by a smp_mb__after_atomic() is
> +	"strong-acquire": both the read and write part of the RMW is ordered
> +	before the subsequential memory accesses.
> +
>  Atomic-set-observable-to-RMW.litmus
>  	Test of the result of atomic_set() must be observable to atomic RMWs.
>  
> -- 
> 2.25.0
> 
