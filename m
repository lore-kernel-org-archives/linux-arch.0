From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] spin loop primitives for busy waiting
Date: Wed, 28 Jun 2017 16:33:52 +1000
Message-ID: <877ezwd3jj.fsf@concordia.ellerman.id.au>
References: <20170529022223.14793-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:60373 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751457AbdF1Gdy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 28 Jun 2017 02:33:54 -0400
In-Reply-To: <20170529022223.14793-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>

Nicholas Piggin <npiggin@gmail.com> writes:

> Current busy-wait loops are implemented by repeatedly calling cpu_relax()
> to give an arch option for a low-latency option to improve power and/or
> SMT resource contention.
>
> This poses some difficulties for powerpc, which has SMT priority setting
> instructions (priorities determine how ifetch cycles are apportioned).
> powerpc's cpu_relax() is implemented by setting a low priority then
> setting normal priority. This has several problems:
>
>  - Changing thread priority can have some execution cost and potential
>    impact to other threads in the core. It's inefficient to execute them
>    every time around a busy-wait loop.
>
>  - Depending on implementation details, a `low ; medium` sequence may
>    not have much if any affect. Some software with similar pattern
>    actually inserts a lot of nops between, in order to cause a few fetch
>    cycles with the low priority.
>
>  - The busy-wait loop runs with regular priority. This might only be a few
>    fetch cycles, but if there are several threads running such loops, they
>    could cause a noticable impact on a non-idle thread.
>
> Implement spin_begin, spin_end primitives that can be used around busy
> wait loops, which default to no-ops. And spin_cpu_relax which defaults to
> cpu_relax.
>
> This will allow architectures to hook the entry and exit of busy-wait
> loops, and will allow powerpc to set low SMT priority at entry, and
> normal priority at exit.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>
> Since last time:
> - Fixed spin_do_cond with initial test as suggested by Linus.
> - Renamed it to spin_until_cond, which reads a little better.
>
>  include/linux/processor.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 include/linux/processor.h

I'm gonna merge this via the powerpc tree unless anyone objects.

cheers
