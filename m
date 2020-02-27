From: Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH v3 4/5] Documentation/locking/atomic: Add a litmus test
 for atomic_set()
Date: Thu, 27 Feb 2020 18:43:04 +0100
Message-ID: <20200227174304.GA11666@andrea>
References: <20200227004049.6853-1-boqun.feng@gmail.com>
 <20200227004049.6853-5-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33920 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbgB0RnO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Feb 2020 12:43:14 -0500
Content-Disposition: inline
In-Reply-To: <20200227004049.6853-5-boqun.feng@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org

On Thu, Feb 27, 2020 at 08:40:48AM +0800, Boqun Feng wrote:
> We already use a litmus test in atomic_t.txt to describe the behavior of
> an atomic_set() with the an atomic RMW, so add it into atomic-tests
> directory to make it easily accessible for anyone who cares about the
> semantics of our atomic APIs.
> 
> Additionally, change the sentences describing the test in atomic_t.txt
> with better wording.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 +++++++++++++++++++
>  Documentation/atomic-tests/README             |  7 ++++++
>  Documentation/atomic_t.txt                    |  6 ++---
>  3 files changed, 34 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> 
> diff --git a/Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus b/Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> new file mode 100644
> index 000000000000..5dd7f04e504a
> --- /dev/null
> +++ b/Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> @@ -0,0 +1,24 @@
> +C Atomic-set-observable-to-RMW

Nit: s/Atomic-set-observable-to-RMW/Atomic-RMW-ops-are-atomic-WRT-atomic_set


> +
> +(*
> + * Result: Never
> + *
> + * Test that atomic_set() cannot break the atomicity of atomic RMWs.
> + *)
> +
> +{
> +	atomic_t v = ATOMIC_INIT(1);
> +}
> +
> +P0(atomic_t *v)
> +{
> +	(void)atomic_add_unless(v,1,0);

Nit: spaces after commas


> +}
> +
> +P1(atomic_t *v)
> +{
> +	atomic_set(v, 0);
> +}
> +
> +exists
> +(v=2)
> diff --git a/Documentation/atomic-tests/README b/Documentation/atomic-tests/README
> index ae61201a4271..a1b72410b539 100644
> --- a/Documentation/atomic-tests/README
> +++ b/Documentation/atomic-tests/README
> @@ -2,3 +2,10 @@ This directory contains litmus tests that are typical to describe the semantics
>  of our atomic APIs. For more information about how to "run" a litmus test or
>  how to generate a kernel test module based on a litmus test, please see
>  tools/memory-model/README.
> +
> +============
> +LITMUS TESTS
> +============
> +
> +Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
> +	Test that atomic_set() cannot break the atomicity of atomic RMWs.
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index ceb85ada378e..67d1d99f8589 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -85,10 +85,10 @@ smp_store_release() respectively. Therefore, if you find yourself only using
>  the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
>  and are doing it wrong.
>  
> -A subtle detail of atomic_set{}() is that it should be observable to the RMW
> -ops. That is:
> +A note for the implementation of atomic_set{}() is that it must not break the
> +atomicity of the RMW ops. That is:
>  
> -  C atomic-set
> +  C Atomic-RMW-ops-are-atomic-WRT-atomic_set
>  
>    {
>      atomic_t v = ATOMIC_INIT(1);
> -- 
> 2.25.0
> 
