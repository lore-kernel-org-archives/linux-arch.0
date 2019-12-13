Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:38607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfLMVdH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Dec 2019 16:33:07 -0500
MIME-Version: 1.0
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <875zimp0ay.fsf@mpe.ellerman.id.au> <20191212080105.GV2844@hirez.programming.kicks-ass.net>
 <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck> <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <CAK8P3a2QYpT_u3D7c_w+hoyeO-Stkj5MWyU_LgGOqnMtKLEudg@mail.gmail.com>
In-Reply-To: <CAK8P3a2QYpT_u3D7c_w+hoyeO-Stkj5MWyU_LgGOqnMtKLEudg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 13 Dec 2019 22:32:48 +0100
Message-ID: <CAK8P3a014U76S+t3rKyPghepOT_fYHBExuMC27MoGMNffjczEw@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Daniel Axtens <dja@axtens.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Christophe Leroy <christophe.leroy@c-s.fr>, linux-arch <linux-arch@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20191213213248.HjYIu8Mqtvk2rOhjexrofU9lEi9Nt3AF4xPmixNnd2w@z>

On Fri, Dec 13, 2019 at 2:17 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Dec 12, 2019 at 9:50 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> I'll have my randconfig builder look for instances, so far I found one,
> see below. My feeling is that it would be better to enforce at least
> the size being a 1/2/4/8, to avoid cases where someone thinks
> the access is atomic, but it falls back on a memcpy.
>
>       Arnd
>
> diff --git a/drivers/xen/time.c b/drivers/xen/time.c
> index 0968859c29d0..adb492c0aa34 100644
> --- a/drivers/xen/time.c
> +++ b/drivers/xen/time.c
> @@ -64,7 +64,7 @@ static void xen_get_runstate_snapshot_cpu_delta(
>         do {
>                 state_time = get64(&state->state_entry_time);
>                 rmb();  /* Hypervisor might update data. */
> -               *res = READ_ONCE(*state);
> +               memcpy(res, state, sizeof(*res));
>                 rmb();  /* Hypervisor might update data. */
>         } while (get64(&state->state_entry_time) != state_time ||
>                  (state_time & XEN_RUNSTATE_UPDATE));


A few hundred randconfig (x86, arm32 and arm64) builds later I
still only found one other instance:

diff --git a/net/xdp/xsk_queue.h b/net/xdp/xsk_queue.h
index eddae4688862..1c1f33447e96 100644
--- a/net/xdp/xsk_queue.h
+++ b/net/xdp/xsk_queue.h
@@ -304,7 +304,9 @@ static inline struct xdp_desc
*xskq_validate_desc(struct xsk_queue *q,
                struct xdp_rxtx_ring *ring = (struct xdp_rxtx_ring *)q->ring;
                unsigned int idx = q->cons_tail & q->ring_mask;

-               *desc = READ_ONCE(ring->desc[idx]);
+               barrier();
+               memcpy(desc, &ring->desc[idx], sizeof(*desc));
+               barrier();
                if (xskq_is_valid_desc(q, desc, umem))
                        return desc;

       Arnd
