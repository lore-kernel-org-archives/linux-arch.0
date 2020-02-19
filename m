From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC v2 3/4] Documentation/locking/atomic: Add a litmus test
 for atomic_set()
Date: Wed, 19 Feb 2020 10:07:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.2002191004420.1514-100000@iolanthe.rowland.org>
References: <20200219062627.104736-4-boqun.feng@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20200219062627.104736-4-boqun.feng@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 19 Feb 2020, Boqun Feng wrote:

> We already use a litmus test in atomic_t.txt to describe the behavior of
> an atomic_set() with the an atomic RMW, so add it into atomic-tests
> directory to make it easily accessible for anyone who cares about the
> semantics of our atomic APIs.
> 
> Additionally, change the sentences describing the test in atomic_t.txt
> with better wording.

One very minor point about the new working in atomic_t.txt:

> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index ceb85ada378e..d30cb3d87375 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -85,10 +85,10 @@ smp_store_release() respectively. Therefore, if you find yourself only using
>  the Non-RMW operations of atomic_t, you do not in fact need atomic_t at all
>  and are doing it wrong.
>  
> -A subtle detail of atomic_set{}() is that it should be observable to the RMW
> -ops. That is:
> +A note for the implementation of atomic_set{}() is that it cannot break the
> +atomicity of the RMW ops. That is:

This would be slightly better if you changed it to: "it must not break".

The comments in the litmus test and README file are okay as they stand.

Alan
