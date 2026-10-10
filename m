Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F86367B71
	for <linux-arch@vger.kernel.org>; Sat, 10 Oct 2026 03:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791601627; cv=pass; b=dVNq1Fz8LvcQrb1RBXdU83VRGpwY3giuhProWclRLLb+GybMQ88qX1Grly5lJSYd/0qmNC27pdI0JoAwA69wMkAu25rX68JEBkdz3ETHSF4xwUIf3jc1qDsI/qRHujLkwfdEYAIrGDBOmS5vfsHGpG9ZhUZMJDfbelO3/3prUjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791601627; c=relaxed/simple;
	bh=R6kdKGPzHjoG5KZKNq2uo8LKEj9Go4FuT1d2+2J7s5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LIkdy6kJOvPGo3Q0p4RaVK/xD0Sv9hl9gd2whhJTJCVvlkmdcKTWX2Mul8B3bL1iuUDfl/JcnoPyPhpDNH4ovyCR60r0JHmdZ4JIMi6b53HrDk3OIfNwGDp+uDcueFgChW1bELdCN8NJy9i1ltchB9n/TUIKOqKO2IKwwJdZolw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sPUNvBga; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPUNvBga"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a161d9b8c7so2217755e9.3
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2026 20:07:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791601623; cv=none;
        d=google.com; s=arc-20260327;
        b=nrsNvR+zOezISHajecs4IbLxO+nzoYgXrY5PqWyShWHQfUFmx7a6KSDZHVTPzrYG3Q
         ErYThjJEPCwPNJTmZ1ISfQgM28Ncq37f+1FzT1gl7h136XKPqus/6TBiKlYV3EmsbHsX
         KrnDKb35OmMl25l5klO0GpGWyfan1uAYig3hceCb2SQsuYXLika+vkiIKS+41L8hraM4
         rDPYLw32vToClIA5dz7Q2G7TTr1BZHd3YQVIdeBIaBna03+Ip79WDrO121tg/aDYtBKe
         H+WMB5Gbv8jPDH1uSl2c1SZmrZY5It5EsJfNJimCQ9bZ2YZ3uW/HvIPhNduYYLEZ3e0H
         mPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DqBvVGuFj0GZrAgGWRG+Z1DSJ+1TnkbYLAFeT5xo12I=;
        fh=0sot99E1evqjewYQD78auutC+Ea6lmBaw0iu3NeLkMQ=;
        b=QpLZJy1daEeX2VTGc/rHIwN5hV1pW7vrUVnF6yxUeFiMBxWkD41HlnhyCEKGQ3BaU+
         8tpIsvwUd9g0zKnpUvnX6kBiiQnC+wuOu1NtotroQAjNH529lH745lUmTVSIP8bG6gJI
         QeQUZwOkHARRs6QqdtAFgIE36TWmaqdK0jaEkkUfrMVIM3fHjulLQK6Qyk4YTJ08ooLU
         iFFpSyaVXOiyG3FTCa1ZTe87AYKrSrt1ZLn+MA3ct6zVsOoP6EJB5P0c9ElRjyTU59CZ
         pKu9+IurNECtNbR6XattduQU3Y9LuCI6RZl9GDE+f6XTJs2KEBOWG8vhbFvne5SV0gZ+
         oOYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791601623; x=1792206423; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DqBvVGuFj0GZrAgGWRG+Z1DSJ+1TnkbYLAFeT5xo12I=;
        b=sPUNvBgaLCkSRBNytttrTwdYEnhRQ60ZUO3A6pleOplw9/XkWo7FWyZNWmpEAXsLje
         nnT9jAG+grc2Oq6wAx2spJfQSYGXEhDzHQwn2ZzufM5xHmhaZZrI8BpqYb2uKreRza4e
         bRCMO5OVUe2QsPBkdDO/7V16ATF7++ASWdc+IL8rvxw99OBhmin/OhONkHvuQ7y67okf
         dOYc/adrro23l8tJ/CwiMoXJ628GXT+BhN12OQMGsTO48tVErBA6wHqL3zwnNAtGmd26
         E9SBAG4AVluaIgJ6RsZjj99r3zM+9i/P9ESp3/ayJT12EfAWnfue27NP4JG/szw7tF9i
         D/EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791601623; x=1792206423;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DqBvVGuFj0GZrAgGWRG+Z1DSJ+1TnkbYLAFeT5xo12I=;
        b=bXIN4F5PUOY5i1zT5MfHQa7JRXVsvvyEpr49c9tUgXH9vLqX3kq1z0HFh2YV3jSNxR
         olaQwm7h7xeCVqkTt6wmSEddyl6ogof3/2inFd6UiN7sDdEiGgRr4+L5V/UEPSA7CV+o
         q0ldky+T0LBZVlmDrhc411wVPPOaiWQj+gCdsMTG/3L0iiIPGmKVWrBZTjvV1lwwtBub
         TOdWb49W72jqquOHuwCNGF8kzSvz91ZvPf4f6twZK3PQXpIKNhpBtKs+dBamDH7MPhBP
         +SSgubjOESBOAEIhT59xE+2DJ2BdcdjVWNkUxM5ElxZkvyfea1Rz90QXr1udc1iFMG/F
         f9yg==
X-Forwarded-Encrypted: i=1; AKwUvBy2PgGxiCNtH1i5TrBrjtiKbsUjGb4cGJptN6ot6e14UF/l7XYdhwKcTXRDzYZhMOv1vhtVtI183pBS@vger.kernel.org
X-Gm-Message-State: AFq9FYJLhFj/9JWQXOn8O6t0MNwyqYRN4Fpxl7jjJS/7lfeO0PQm7aU3
	QoYa71v8dOldP4kZnXsUGd95GHz8PNQhHgLd5v6zTVq+34RFDEBun5Ub6Ei03rWkGckd5pJ8579
	EaAgxJDfru8qiOurhT5oLOujjMnVmimc=
X-Gm-Gg: AYBFou30irYC0MGTROFjd95zsP73gw1OZ4fFkCz49EYvHoL51PWSilkHIbfmcO+CGRl
	lr8fOpBL/UC7M6RsJ7B24UiQnOrIR5a+DWkWSj3i3OBCiQ8OLAY6v+ERymWedlNYV9NnjnrcNpE
	l8o6SzkaUdE+RFa351KRJtAy0zBaazuL60RlqadXa3Aa6FeSlKd+0+KlE2o0NdeEh+5BLyTpt2X
	0JvwVn6F1WXuYF7IsJY+USw4AaLDvYDzXddmb1G+l13gvi+pFXIFdfMDrLQJ9ONWkZ9q/IlNCC0
	YLMd5YwgmfAnMt4yqNUr5KAZSXi2ig2n9f4u2pOpRkKM+5tAtKqOL9nh
X-Received: by 2002:a05:600c:548e:b0:4a0:1aa0:7cfa with SMTP id
 5b1f17b1804b1-4a18e4aa724mr72284475e9.12.1791601623170; Fri, 09 Oct 2026
 20:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
 <20261005171529.1378809-3-kunwu.chan@gmail.com> <bedc399a-151c-42e5-b33e-d78221702fa5@efficios.com>
In-Reply-To: <bedc399a-151c-42e5-b33e-d78221702fa5@efficios.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Sat, 10 Oct 2026 11:06:52 +0800
X-Gm-Features: AclHuK8NpqoYHGNF8qem9_9ttNaOwl-7fp6vIe9jVutVGCveZrXPQMrRKkOozbM
Message-ID: <CAN_Opa99g5MiWp6L8d_c=eUNcfxH8eb1Am6MKRjx+zjUTYXs0w@mail.gmail.com>
Subject: Re: [PATCH RFC v3 02/15] hazptr: use Bloom filter for shared scan waiters
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: paulmck@kernel.org, corbet@lwn.net, mingo@redhat.com, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, josh@joshtriplett.org, urezki@gmail.com, 
	dave@stgolabs.net, lianux.mm@gmail.com, stern@rowland.harvard.edu, 
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, 
	boqun@kernel.org, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, 
	joelagnelf@nvidia.com, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	longman@redhat.com, rostedt@goodmis.org, jiangshanlai@gmail.com, 
	qiang.zhang@linux.dev, brads@mainlining.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 1:51=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2026-10-05 13:15, Kunwu Chan wrote:
> > Replace the per-waiter exact-match scan with a shared Bloom filter
> > built during the second drain pass: each observed non-wildcard
> > address sets three bits, so a waiter whose address hashes to an
> > unset bit can be completed without another slot walk.
> >
> > A Bloom filter has no false negatives, so an address absent from
> > the final drain scan cannot be held by an observed slot; false
> > positives only delay completion to a later scan cycle.
> >
> > The filter uses a one-page bitmap with three multiply-shift hash
> > functions.  It lives in the hazptr_scan_state and is only touched
> > by the scan kthread, so waiter state remains on the caller's stack
> > and no dynamic allocation is needed.
> >
> > Suggested-by: Boqun Feng <boqun@kernel.org>
>
> I actually suggested that to Boqun in the first place. Feel
> free to add my suggested-by tag as well. :)
>
> Did you run your Bloom filter in a test program on the side to
> see how it behaves with pointers, and confirm that the false
> positive rate is not too high due to hashing algorithm/constants
> concerns ?
>

Hi Mathieu,

I ran a standalone test using the hash functions and constants from
the patch, with random,
page-aligned, cacheline-aligned, sequential, and two synthetic
kernel-like address patterns.

With 768 inserted addresses, the measured false-positive rates were
0.025%=E2=80=930.034% across
these patterns, compared with an ideal Bloom-filter estimate of about
0.031%. I also tested larger
 insertion counts as stress cases. The results were consistent across
three seeds,
with only minor variation for the random distribution.

These are synthetic address distributions rather than measurements
from actual kernel waiter
 addresses, but they provide an initial check of the hash functions
against several structured
address patterns.

Thanks,
Kunwu

> Thanks!
>
> Mathieu
>
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >   kernel/hazptr.c | 93 +++++++++++++++++++++++++++++++++++++++++++-----=
-
> >   1 file changed, 83 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> > index 9e274a691af5..900ba35de2cb 100644
> > --- a/kernel/hazptr.c
> > +++ b/kernel/hazptr.c
> > @@ -7,6 +7,7 @@
> >    */
> >
> >   #include <linux/hazptr.h>
> > +#include <linux/bitops.h>
> >   #include <linux/percpu.h>
> >   #include <linux/spinlock.h>
> >   #include <linux/mutex.h>
> > @@ -16,6 +17,7 @@
> >   #include <linux/kthread.h>
> >   #include <linux/swait.h>
> >   #include <linux/sched.h>
> > +#include <linux/bitmap.h>
> >
> >   /*
> >    * The current hazard pointer wildcard. Flips between 1UL and 2UL to =
guarantee
> > @@ -213,6 +215,55 @@ void hazptr_scan_period(void *addr, void *scan_wil=
dcard)
> >       }
> >   }
> >
> > +/* Number of hash functions for the Bloom filter. */
> > +#define HAZPTR_BLOOM_HASHES 3
> > +
> > +/* Number of bits in the Bloom filter bitmap: one page. */
> > +#define HAZPTR_BLOOM_NBITS (PAGE_SIZE * 8)
> > +
> > +struct hazptr_bloom {
> > +     unsigned long map[PAGE_SIZE / sizeof(unsigned long)];
> > +};
> > +
> > +/*
> > + * Multiply @addr by a per-hash odd constant and use the high bits
> > + * as the Bloom filter index.
> > + */
> > +static unsigned long hazptr_bloom_hash(void *addr, unsigned int i)
> > +{
> > +     static const u64 mult[HAZPTR_BLOOM_HASHES] =3D {
> > +             0x9E3779B97F4A7C15ULL,
> > +             0xC2B2AE3D27D4EB4FULL,
> > +             0x165667B19E3779F9ULL,
> > +     };
> > +     u64 hash =3D (u64)(unsigned long)addr * mult[i];
> > +
> > +     return hash >> (64 - ilog2(HAZPTR_BLOOM_NBITS));
> > +}
> > +
> > +static void hazptr_bloom_reset(struct hazptr_bloom *bloom)
> > +{
> > +     bitmap_zero(bloom->map, HAZPTR_BLOOM_NBITS);
> > +}
> > +
> > +static void hazptr_bloom_add(struct hazptr_bloom *bloom, void *addr)
> > +{
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < HAZPTR_BLOOM_HASHES; i++)
> > +             __set_bit(hazptr_bloom_hash(addr, i), bloom->map);
> > +}
> > +
> > +static bool hazptr_bloom_contains(const struct hazptr_bloom *bloom, vo=
id *addr)
> > +{
> > +     unsigned int i;
> > +
> > +     for (i =3D 0; i < HAZPTR_BLOOM_HASHES; i++)
> > +             if (!test_bit(hazptr_bloom_hash(addr, i), bloom->map))
> > +                     return false;
> > +     return true;
> > +}
> > +
> >   struct hazptr_waiter {
> >       struct list_head node;
> >       void *addr;
> > @@ -226,17 +277,26 @@ struct hazptr_scan_state {
> >       struct mutex lock;
> >       struct list_head pending;
> >       struct list_head scanning;      /* kthread only */
> > +     struct hazptr_bloom bloom;      /* kthread only */
> >   };
> >   static struct hazptr_scan_state hazptr_scan;
> >
> >   /*
> > - * Check per-CPU slots before overflow-list slots to match the
> > - * acquisition ordering of promoted slots.
> > + * Walk all slots and return true if @watch is present.  If @bloom
> > + * is non-NULL, record observed non-wildcard addresses in it.
> > + *
> > + * Per-CPU slots are examined before overflow-list slots on each CPU
> > + * to preserve the acquisition ordering required by the promote path:
> > + * synchronize must observe the per-CPU slot release before the
> > + * overflow-list entry can be missed.
> >    */
> > -static bool hazptr_value_present(void *val)
> > +static bool hazptr_scan_walk(void *watch, struct hazptr_bloom *bloom)
> >   {
> >       int cpu;
> >
> > +     if (bloom)
> > +             hazptr_bloom_reset(bloom);
> > +
> >       for_each_possible_cpu(cpu) {
> >               struct hazptr_percpu_slots *percpu_slots =3D per_cpu_ptr(=
&hazptr_percpu_slots, cpu);
> >               struct hazptr_overflow_list_flip *overflow_list_flip =3D =
per_cpu_ptr(&percpu_overflow_list_flip, cpu);
> > @@ -244,10 +304,14 @@ static bool hazptr_value_present(void *val)
> >
> >               for (idx =3D 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
> >                       struct hazptr_slot_item *item =3D &percpu_slots->=
items[idx];
> > +                     void *v;
> >
> >                       /* Pairs with smp_store_release in hazptr_release=
(). */
> > -                     if (smp_load_acquire(&item->slot.addr) =3D=3D val=
)
> > +                     v =3D smp_load_acquire(&item->slot.addr);
> > +                     if (v =3D=3D watch)
> >                               return true;
> > +                     if (bloom && v && !is_wildcard(v))
> > +                             hazptr_bloom_add(bloom, v);
> >               }
> >               for (int i =3D 0; i < 2; i++) {
> >                       struct hazptr_overflow_list *list =3D &overflow_l=
ist_flip->array[i];
> > @@ -256,11 +320,16 @@ static bool hazptr_value_present(void *val)
> >
> >                       raw_spin_lock_irqsave(&list->lock, flags);
> >                       hlist_for_each_entry(b, &list->head, overflow_nod=
e) {
> > +                             void *v;
> > +
> >                               /* Pairs with smp_store_release in hazptr=
_release(). */
> > -                             if (smp_load_acquire(&b->slot.addr) =3D=
=3D val) {
> > +                             v =3D smp_load_acquire(&b->slot.addr);
> > +                             if (v =3D=3D watch) {
> >                                       raw_spin_unlock_irqrestore(&list-=
>lock, flags);
> >                                       return true;
> >                               }
> > +                             if (bloom && v && !is_wildcard(v))
> > +                                     hazptr_bloom_add(bloom, v);
> >                       }
> >                       raw_spin_unlock_irqrestore(&list->lock, flags);
> >               }
> > @@ -276,7 +345,7 @@ static bool hazptr_value_present(void *val)
> >    */
> >   static void hazptr_drain_wildcard(void *wc)
> >   {
> > -     while (hazptr_value_present(wc))
> > +     while (hazptr_scan_walk(wc, NULL))
> >               cond_resched();
> >   }
> >
> > @@ -309,12 +378,16 @@ static void hazptr_scan_do_cycle(void)
> >       WRITE_ONCE(hazptr_wildcard, scan_wildcard);
> >       old_wildcard =3D flip_wildcard(scan_wildcard);
> >
> > -     /* Pass 2: drain the old wildcard. */
> > -     hazptr_drain_wildcard(old_wildcard);
> > +     /*
> > +      * Pass 2: drain the old wildcard while collecting observed
> > +      * addresses into the Bloom filter.
> > +      */
> > +     while (hazptr_scan_walk(old_wildcard, &hazptr_scan.bloom))
> > +             cond_resched();
> >
> > -     /* Complete waiters whose address is no longer held by any slot. =
*/
> > +     /* Complete waiters whose address is not in the filter. */
> >       list_for_each_entry_safe(w, n, &hazptr_scan.scanning, node) {
> > -             if (!hazptr_value_present(w->addr))
> > +             if (!hazptr_bloom_contains(&hazptr_scan.bloom, w->addr))
> >                       list_move(&w->node, &done);
> >       }
> >
>
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
