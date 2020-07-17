From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] tools/memory-model: document the "one-time init" pattern
Date: Fri, 17 Jul 2020 07:49:02 +0200
Message-ID: <CA+icZUVztkBRBhs_NQpTOg7rc34VkBQ1GCr5iXgw+P9XORwd9A@mail.gmail.com>
References: <20200717044427.68747-1-ebiggers@kernel.org>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200717044427.68747-1-ebiggers@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>, linux-fsdevel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, "Darrick J . Wong" <darrick.wong@oracle.com>, Dave Chinner <david@fromorbit.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, Nicholas Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Jul 17, 2020 at 6:48 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> From: Eric Biggers <ebiggers@google.com>
...
> This is motivated by the discussion at
> https://lkml.kernel.org/linux-fsdevel/20200713033330.205104-1-ebiggers@kernel.org/T/#u
...
> +In where cases where taking the mutex in the "already initialized" case

"In cases where..." (drop first "where")

> +presents scalability concerns, the implementation can be optimized to
> +check the 'inited' flag outside the mutex.  Unfortunately, this
> +optimization is often implemented incorrectly by using a plain load.
> +That violates the memory model and may result in unpredictable behavior.

- Sedat -
