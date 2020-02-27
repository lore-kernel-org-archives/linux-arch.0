Return-Path: <SRS0=WXCa=4P=vger.kernel.org=linux-doc-owner@kernel.org>
Date: Thu, 27 Feb 2020 18:54:41 +0100
From: Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [PATCH v3 0/5] Documentation/locking/atomic: Add litmus tests
 for atomic APIs
Message-ID: <20200227175441.GB12046@andrea>
References: <20200227004049.6853-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227004049.6853-1-boqun.feng@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Jonathan Corbet <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200227175441.OwqaIN3QUA7p1z7rPB4rrUh59THl-2yoA993sXtGY-E@z>

On Thu, Feb 27, 2020 at 08:40:44AM +0800, Boqun Feng wrote:
> A recent discussion raises up the requirement for having test cases for
> atomic APIs:
> 
> 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> 
> , and since we already have a way to generate a test module from a
> litmus test with klitmus[1]. It makes sense that we add more litmus
> tests for atomic APIs. And based on the previous discussion, I create a
> new directory Documentation/atomic-tests and put these litmus tests
> here.
> 
> This patchset starts the work by adding the litmus tests which are
> already used in atomic_t.txt, and also improve the atomic_t.txt to make
> it consistent with the litmus tests.
> 
> Previous version:
> v1: https://lore.kernel.org/linux-doc/20200214040132.91934-1-boqun.feng@gmail.com/
> v2: https://lore.kernel.org/lkml/20200219062627.104736-1-boqun.feng@gmail.com/
> 
> Changes since v2:
> 
> *	Change from "RFC" to "PATCH".
> 
> *	Wording improvement in atomic_t.txt as per Alan's suggestion.
> 
> *	Add a new patch describing the usage of atomic_add_unless() is
> 	not limited anymore for LKMM litmus tests.
> 
> My PR on supporting "(void) expr;" statement has been merged by Luc
> (Thank you, Luc). So all the litmus tests in this patchset can be
> handled by the herdtools compiled from latest master branch of the
> source code.
> 
> Comments and suggestions are welcome!

A few nits (see inline), but otherwise the series looks good to me;
with those fixed, please feel free to add:

Acked-by: Andrea Parri <parri.andrea@gmail.com>

to the entire series.

Thanks,
  Andrea


> 
> Regards,
> Boqun
> 
> [1]: http://diy.inria.fr/doc/litmus.html#klitmus
> 
> Boqun Feng (5):
>   tools/memory-model: Add an exception for limitations on _unless()
>     family
>   Documentation/locking/atomic: Fix atomic-set litmus test
>   Documentation/locking/atomic: Introduce atomic-tests directory
>   Documentation/locking/atomic: Add a litmus test for atomic_set()
>   Documentation/locking/atomic: Add a litmus test smp_mb__after_atomic()
> 
>  ...ter_atomic-is-stronger-than-acquire.litmus | 32 +++++++++++++++++++
>  ...c-RMW-ops-are-atomic-WRT-atomic_set.litmus | 24 ++++++++++++++
>  Documentation/atomic-tests/README             | 16 ++++++++++
>  Documentation/atomic_t.txt                    | 24 +++++++-------
>  MAINTAINERS                                   |  1 +
>  tools/memory-model/README                     | 10 ++++--
>  6 files changed, 92 insertions(+), 15 deletions(-)
>  create mode 100644 Documentation/atomic-tests/Atomic-RMW+mb__after_atomic-is-stronger-than-acquire.litmus
>  create mode 100644 Documentation/atomic-tests/Atomic-RMW-ops-are-atomic-WRT-atomic_set.litmus
>  create mode 100644 Documentation/atomic-tests/README
> 
> -- 
> 2.25.0
> 
