Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9791035DA6E
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 03:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133426; cv=pass; b=rWy7QsAx2HcKK1tCAMWR2RObJLAtfumcXYp0cJgi99dCt+ZXsfNz4vZj+EcCaWgwIbdwhuuTI+ui9AMCfOWW1/pXKVAL6nopFbrjLhRiaUMZ1PtBbGjGRdOVPGcouLnjp2m0TPYq06+4lYYQEhilzKme2jbrSXThCXhR8TDTDn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133426; c=relaxed/simple;
	bh=KG/kULUSkGGTWQ7Czp6s9J65DZmahWdvwQ3IxUCl0kU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJcu+Vqfrgbr8Q0Q4KD6yqEBGR+PD8DWwsrbE/4ibROcjtbMqkuo67poJ0F6qloqEb0n97LIT6dMK7XFvLVEIykagdu6GOVklTngql5Vk+K+RicppnlQrIE6XYqQqqite2IlIuDK8eU2zXm7KrhFIRffjHV+pHpoAvFfn1eizR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NvR6TKS6; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvR6TKS6"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so4408625e9.1
        for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2026 20:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790133423; cv=none;
        d=google.com; s=arc-20260327;
        b=H7TZsAv3qG0zf6g+OXGZoSUEMTx4BI8UTILbG84cmJpj8zlu06NOiKaFuV7APysg9E
         OG93hTgmSDcB7YuRiWw66w9dGsEo/2g2D2ImGn5pYBo17DIF2hiyzvuGWYOZ+Dgnxsxp
         6qP5cNVJ5qopm91I+V8BXumJnl/dCUdAa0QhO5Q64QVdO+o885wksIDbUIKo1qAC1oUY
         dBLS8q2UwCJFbqPfZMBOiY48nDYmjAI9nAKAFQllzsn0mCJsxm2XF8VJlpHILwgiuedV
         0U7crw8Qk4HREahOpRc2oG0t0j8WtvEfk8dsCvKVmcY4b6zMcsg/+OzWBbLLG1AqkVKF
         3C5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+jFJKH+klmzjOj5frTRQKSQgJPIi6Sp1AqwDk53J1oY=;
        fh=RFx4h7PdPf7X4ezkUYo77ompEwc8hCNB+iAjIqTGDbY=;
        b=SJqCwLbHwDE8HktQVvJrsHtRWs8851To6MXrYS9fxULMM2+C85FBYLCWa3YU+VZ1lF
         xzUOkr0ZnKAtYS1nYmlanT/6oKukn6BzOxX9MlU2axlfNvdyipQMKyLyhGtOmu10POJB
         bhgK8A8/ZVtLHr6nfNFr0z1LuUNb3+4V1MUOKv7hrUsMLXlljUID9fNrKJC0B2gcOJhI
         37g+JPhzwhGH7YS+Jz62LtEgboW7Njq1H4sEfHXRz8lYekcWutl06V+P62Sz1ylsQmDF
         W5T9Tkw+w3UIBQ83QdMMGetETfevdFw0TEhIwrTLBAnc1CMn13yqgUfOl8ojC01ILbQq
         YKZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790133423; x=1790738223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+jFJKH+klmzjOj5frTRQKSQgJPIi6Sp1AqwDk53J1oY=;
        b=NvR6TKS6laO4yOaChsmcKJGTIr47baLzBrWhQiIf+Ktx/UEnzxluU7sU+0ZCugCU3D
         BPkd/xBfkcZVVRYMaW4zrQ8RiyDEVzT3pAP7WwDzO3nhH1/f3v5TPizv3WfIbfLNtltL
         4fKa9aD71Gv3eHkzKQyI6T4/9IDsqf4dlxKoaWwoQTDz5gIt6Qb36GCbxgqjJMb9I/5M
         /bT2JJUiTP+xg9ep/oB5iyD2Y9TQsQzSWRZs2nS/m0a/WU8GKeTyP3oBAAHOC6/d7PVg
         XCbKgBM/AfU3cyTknQ7J9Pa19kVzempNa8bsEGcm53KIZevewOxt65xjIGdh5kx2XdAJ
         Vabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790133423; x=1790738223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+jFJKH+klmzjOj5frTRQKSQgJPIi6Sp1AqwDk53J1oY=;
        b=A/I4TUC9oC7Kp35fdCR80A5R7sK8YbCUb/ti5+yIcwc1bPp6g9J9585EJHsiJiSaCT
         UXUWHt2DZaeBf8mSXcnNn7yNht5GSSt9wGiQRRR6AFWivmfS/y6+0AaizcCDmaqYIIXt
         B5ouyeiIlgGIYBMtT5uJP44yn4BnPdDRsW/Qx+lgUp1VlERBUe5UkIqhDik8z9QTrebe
         uup9T2WhcPDkX0Ns1g2nrJ6ZNd8qpWQWQDU9kolAdBfvlPbLpwdiaUDU3V0BPSSqO6Q3
         2YGcY9jsCwtZmwARpaxYJj36XL4QYTCMUz92+Fp4nRZILsQMmM/FfVR62nRM1tt57rpM
         RJwg==
X-Forwarded-Encrypted: i=1; AKwUvBzUZ17srC0hKy4p9WDEXRxqfLNIKGtfTUj9ZDmQaHDxyW2O9SBTpiuwdqUs5AOZkuy8eIFnaAUNW9GK@vger.kernel.org
X-Gm-Message-State: AFuF++m3jGkglS4rqc/31w1LuBGg1fGw2rjBlDA3+8ugNKAfhymc6ZSG
	qvcbjws9DBOS/KIq8Q/qQC2X0jt1THlmXC6XIYKfteSHt7f8+iFV6ze52uPTu6yji8Kq1I6rRH4
	rasUKipb/c1y7S9gkY4soRnEL16YAqm0=
X-Gm-Gg: AYBFou0mi7+6f0awczWm+Doq3NdrIZv5iURpMltVbPj1WrdqLlpjufw6TEp8SxoEaTo
	Nfsfp41aueWT0uIAa9ChyypzWdntLAR3yaQ9LQIqpRVwIfAXlXMbtNP8vL+pfrEtb4/aaiSHnWc
	i/Yl+jgdLbb5O1qtpfvUKpDSsWgGwSEk+oDer8JCQwWC6e31/RedGjd0ZPELU2MWNW8vRrPH66k
	kjxp/bzQQs2Ru5t8FixioPgFnigBB2JfBh1vhctVZ7LIchUO0lWyl9HmcEqsw841W7++YP0y6gn
	E+2mi/V82t+LSguGIxmf3dNnajXTDspQQzbgZWikCOTCMtISQWcJTdnOzQuvvdCaCW0X9Q80lFD
	gIxkO0EcUMwCKcoKD4132cdXW
X-Received: by 2002:a05:600c:1d0a:b0:49e:7cff:f8ca with SMTP id
 5b1f17b1804b1-49fdf13cf54mr11647155e9.29.1790133422322; Tue, 22 Sep 2026
 20:17:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922070950.4173245-1-kunwu.chan@gmail.com>
 <20260922070950.4173245-2-kunwu.chan@gmail.com> <arI8KNUjYNFBwKf8@MacBook-0RXW5>
In-Reply-To: <arI8KNUjYNFBwKf8@MacBook-0RXW5>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 23 Sep 2026 11:16:48 +0800
X-Gm-Features: AcwNN1VjBnSZre544q1ZjonBGQMIqMVHorHG9Rp1bgUiYjZdhN-GJiVdtsmIajE
Message-ID: <CAN_Opa_Sjp40TRzAbCozS_GkTzi0phzeiKjUEeeZ+VGT7v25rg@mail.gmail.com>
Subject: Re: [RFC/WIP PATCH 1/4] hazptr: add shared-scan kthread
To: Boqun Feng <boqun@kernel.org>
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org, 
	peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com, 
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, paulmck@kernel.org, 
	corbet@lwn.net, mingo@redhat.com, dave@stgolabs.net, josh@joshtriplett.org, 
	frederic@kernel.org, neeraj.upadhyay@kernel.org, urezki@gmail.com, 
	akiyks@gmail.com, dlustig@nvidia.com, joelagnelf@nvidia.com, 
	skhan@linuxfoundation.org, rdunlap@infradead.org, longman@redhat.com, 
	rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	qiang.zhang@linux.dev, include@grrlz.net, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org, 
	rcu@vger.kernel.org, lianux.mm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 4:28=E2=80=AFPM Boqun Feng <boqun@kernel.org> wrote=
:
>
> On Tue, Sep 22, 2026 at 03:09:47PM +0800, Kunwu Chan wrote:
> > Batch concurrent hazptr_synchronize() callers into a shared scan
> > cycle, avoiding redundant scans of the per-CPU slots.
> >
> > Queue waiters to a kthread and let each scan cycle make one pass
> > over all CPUs.  Each waiter tracks per-CPU progress for both
> > wildcard generations, allowing multiple waiters to share the same
> > scan.
> >
> > Flip the wildcard before scanning.  New acquires then use the new
> > generation, so the old-generation mask makes forward progress even
> > under a steady stream of readers.  Waiters that remain blocked are
> > retried after a short delay.
> >
> > Fall back to the existing direct two-phase scan if the scan kthread
> > is unavailable or waiter state cannot be allocated.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  kernel/hazptr.c | 274 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 274 insertions(+)
> >
> > diff --git a/kernel/hazptr.c b/kernel/hazptr.c
> > index d3d1050d92cf..ce553a61b119 100644
> > --- a/kernel/hazptr.c
> > +++ b/kernel/hazptr.c
> > @@ -12,6 +12,10 @@
> >  #include <linux/mutex.h>
> >  #include <linux/list.h>
> >  #include <linux/export.h>
> > +#include <linux/completion.h>
> > +#include <linux/kthread.h>
> > +#include <linux/slab.h>
> > +#include <linux/swait.h>
> >
> >  /*
> >   * The current hazard pointer wildcard. Flips between 1UL and 2UL to g=
uarantee
> > @@ -209,12 +213,251 @@ void hazptr_scan_period(void *addr, void *scan_w=
ildcard)
> >       }
> >  }
> >
> > +/*
> > + * Batch hazptr_synchronize() callers through a shared scan kthread.
> > + */
> > +
> > +struct hazptr_waiter {
> > +     struct list_head node;
> > +     void *addr;
> > +     struct completion done;
> > +     /*
> > +      * Per-wildcard-generation progress masks.  A CPU bit is
> > +      * cleared when the scan observes neither @addr nor that
> > +      * generation's wildcard on the CPU.
> > +      */
> > +     unsigned long *cpu_mask;        /* 2 * BITS_TO_LONGS(nr_cpu_ids) =
*/
>
> This would requires allocation during hazptr_synchronize() and I would
> like to avoid that (it's going to introduce a "allocating memory to free
> memory" case).
>

Thanks boqun, this is a useful direction.

> Mathieu brought up a useful data structure for the scan: A Bloom filter:
>
>         https://en.wikipedia.org/wiki/Bloom_filter
>
> , which is basically a bitmap set + k hash functions. Let's say we have
> a struct bloom_filter (you can still with a page as the bitmap and k=3D3)
> and put it in hazptr_scan_state. Then the scan would become:
>
>         bloom_filter_clear(); // <- reset the bloom filer.
>
>         for_each_possible_cpu()
>           hlist_for_each_entry(b, &list->head, overflow_node) {
>             bloom_filter_set(*b->slot.addr);
>             // ^ add the hazptr_acquire() adress into the bloom filter
>           }
>
>         list_for_each_entry(w, &hazptr_scan.scanning, node) {
>           if (!bloom_filter_contains(w->addr)) {
>             list_move(&w->node, &done);
>           }
>         }
>
> Of course, there are some additional handling or optimizaiton we can do
> with the per-CPU slot and wildcard, but this is the idea. It also makes
> a potential call_hazptr() work.
>
> Willing to give it a try?

Sure, I'll give it a try. I'll rework the scan state around the Bloom
filter and address the per-CPU slot and wildcard handling in the next
version. I'll also credit your 2025 patch design in the commit message.

Thanks,
Kunwu

>
> Regards,
> Boqun
>
> > +};
> > +
> > +/* Return waiter @w's progress mask for wildcard generation @gen. */
> > +static unsigned long *hazptr_waiter_mask(struct hazptr_waiter *w, int =
gen)
> > +{
> > +     return w->cpu_mask + gen * BITS_TO_LONGS(nr_cpu_ids);
> > +}
> > +
> > +struct hazptr_scan_state {
> > +     struct task_struct *kthread;
> > +     struct swait_queue_head wq;
> > +     bool wakeup;
> > +     struct mutex lock;
> > +     struct list_head pending;
> > +     struct list_head scanning;      /* kthread only */
> > +};
> > +static struct hazptr_scan_state hazptr_scan;
> > +
> > +/*
> > + * Check a CPU's overflow lists.  A backup slot can hold a wildcard
> > + * because __hazptr_acquire() writes the wildcard to any slot,
> > + * including backup slots from hazptr_chain_backup_slot().
> > + *
> > + * @addr:     address the waiter is waiting on
> > + * @old_wc:   wildcard value of the pre-flip generation
> > + * @new_wc:   wildcard value of the post-flip generation
> > + * @has_old:  set if any overflow slot holds @old_wc
> > + * @has_new:  set if any overflow slot holds @new_wc
> > + *
> > + * Returns true if @addr is present.
> > + */
> > +static bool hazptr_ovf_list_blocked(int cpu, void *addr,
> > +                                 void *old_wc, void *new_wc,
> > +                                 bool *has_old, bool *has_new)
> > +{
> > +     struct hazptr_overflow_list_flip *ovf =3D per_cpu_ptr(&percpu_ove=
rflow_list_flip, cpu);
> > +     bool found_addr =3D false;
> > +     int i;
> > +
> > +     for (i =3D 0; i < 2; i++) {
> > +             struct hazptr_overflow_list *list =3D &ovf->array[i];
> > +             struct hazptr_backup_slot *b;
> > +             unsigned long flags;
> > +
> > +             raw_spin_lock_irqsave(&list->lock, flags);
> > +             hlist_for_each_entry(b, &list->head, overflow_node) {
> > +                     /* Pairs with smp_store_release in hazptr_release=
(). */
> > +                     void *val =3D smp_load_acquire(&b->slot.addr);
> > +
> > +                     if (val =3D=3D addr)
> > +                             found_addr =3D true;
> > +                     else if (val =3D=3D old_wc)
> > +                             *has_old =3D true;
> > +                     else if (val =3D=3D new_wc)
> > +                             *has_new =3D true;
> > +             }
> > +             raw_spin_unlock_irqrestore(&list->lock, flags);
> > +     }
> > +     return found_addr;
> > +}
> > +
> > +/*
> > + * Move pending waiters to ->scanning, flip the wildcard, then make
> > + * one pass over all CPUs.  Clear per-waiter bits for CPUs that no
> > + * longer hold the waiter address or the corresponding wildcard.
> > + *
> > + * After the flip, new acquires use the new wildcard.  The old
> > + * generation therefore makes forward progress and is fully cleared
> > + * after enough scan cycles.
> > + */
> > +static void hazptr_scan_do_cycle(void)
> > +{
> > +     void *old_wc, *new_wc;
> > +     unsigned int old_idx, new_idx;
> > +     int cpu;
> > +     struct hazptr_waiter *w, *n;
> > +     LIST_HEAD(done);
> > +
> > +     mutex_lock(&hazptr_wildcard_lock);
> > +
> > +     mutex_lock(&hazptr_scan.lock);
> > +     list_splice_tail_init(&hazptr_scan.pending, &hazptr_scan.scanning=
);
> > +     mutex_unlock(&hazptr_scan.lock);
> > +
> > +     if (list_empty(&hazptr_scan.scanning)) {
> > +             mutex_unlock(&hazptr_wildcard_lock);
> > +             return;
> > +     }
> > +
> > +     old_wc =3D READ_ONCE(hazptr_wildcard);
> > +     new_wc =3D flip_wildcard(old_wc);
> > +     WRITE_ONCE(hazptr_wildcard, new_wc);
> > +     old_idx =3D (unsigned long)old_wc - 1;
> > +     new_idx =3D 1 - old_idx;
> > +
> > +     /*
> > +      * One pass over all CPUs for the per-CPU slots, checking
> > +      * overflow lists for the remaining waiters.
> > +      */
> > +     for_each_possible_cpu(cpu) {
> > +             struct hazptr_percpu_slots *slots =3D per_cpu_ptr(&hazptr=
_percpu_slots, cpu);
> > +             void *vals[NR_HAZPTR_PERCPU_SLOTS];
> > +             bool has_old =3D false, has_new =3D false;
> > +             unsigned int idx;
> > +
> > +             for (idx =3D 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx++) {
> > +                     /* Pairs with smp_store_release in hazptr_release=
(). */
> > +                     vals[idx] =3D smp_load_acquire(&slots->items[idx]=
.slot.addr);
> > +                     if (vals[idx] =3D=3D old_wc)
> > +                             has_old =3D true;
> > +                     else if (vals[idx] =3D=3D new_wc)
> > +                             has_new =3D true;
> > +             }
> > +
> > +             list_for_each_entry(w, &hazptr_scan.scanning, node) {
> > +                     bool has_addr =3D false;
> > +
> > +                     if (!test_bit(cpu, hazptr_waiter_mask(w, old_idx)=
) &&
> > +                         !test_bit(cpu, hazptr_waiter_mask(w, new_idx)=
))
> > +                             continue;       /* Both bits already clea=
r. */
> > +                     for (idx =3D 0; idx < NR_HAZPTR_PERCPU_SLOTS; idx=
++) {
> > +                             if (vals[idx] =3D=3D w->addr) {
> > +                                     has_addr =3D true;
> > +                                     break;
> > +                             }
> > +                     }
> > +                     if (!has_addr)
> > +                             has_addr =3D hazptr_ovf_list_blocked(cpu,=
 w->addr,
> > +                                     old_wc, new_wc, &has_old, &has_ne=
w);
> > +                     if (has_addr)
> > +                             continue;
> > +                     if (!has_old)
> > +                             __clear_bit(cpu, hazptr_waiter_mask(w, ol=
d_idx));
> > +                     if (!has_new)
> > +                             __clear_bit(cpu, hazptr_waiter_mask(w, ne=
w_idx));
> > +             }
> > +     }
> > +
> > +     mutex_unlock(&hazptr_wildcard_lock);
> > +
> > +     /* Complete waiters whose masks are both empty. */
> > +     list_for_each_entry_safe(w, n, &hazptr_scan.scanning, node) {
> > +             if (bitmap_empty(hazptr_waiter_mask(w, 0), nr_cpu_ids) &&
> > +                 bitmap_empty(hazptr_waiter_mask(w, 1), nr_cpu_ids))
> > +                     list_move(&w->node, &done);
> > +     }
> > +
> > +     list_for_each_entry_safe(w, n, &done, node) {
> > +             list_del_init(&w->node);
> > +             complete(&w->done);
> > +     }
> > +}
> > +
> > +/*
> > + * Shared scan kthread for hazptr_synchronize() waiters.
> > + */
> > +static int hazptr_scan_kthread(void *unused)
> > +{
> > +     for (;;) {
> > +             bool idle;
> > +
> > +             swait_event_idle_exclusive(hazptr_scan.wq,
> > +                                        READ_ONCE(hazptr_scan.wakeup))=
;
> > +
> > +             hazptr_scan_do_cycle();
> > +
> > +             mutex_lock(&hazptr_scan.lock);
> > +             idle =3D list_empty(&hazptr_scan.pending) &&
> > +                   list_empty(&hazptr_scan.scanning);
> > +             if (idle)
> > +                     WRITE_ONCE(hazptr_scan.wakeup, false);
> > +             mutex_unlock(&hazptr_scan.lock);
> > +
> > +             if (idle)
> > +                     continue;
> > +             /* Waiters still blocked: retry after a polling delay. */
> > +             schedule_timeout_idle(1);
> > +     }
> > +     return 0;
> > +}
> > +
> > +/*
> > + * Queue @addr for scan-thread processing, then sleep until the scan
> > + * thread observes that @addr is no longer held by any hazard pointer.
> > + * Returns false if the waiter masks cannot be allocated, in which
> > + * case the caller falls back to the direct scan.
> > + */
> > +static bool hazptr_synchronize_queued(void *addr)
> > +{
> > +     struct hazptr_waiter waiter =3D {
> > +             .addr =3D addr,
> > +     };
> > +     unsigned long *masks;
> > +     unsigned int mask_longs =3D BITS_TO_LONGS(nr_cpu_ids);
> > +
> > +     masks =3D kcalloc(2, mask_longs * sizeof(unsigned long), GFP_KERN=
EL);
> > +     if (!masks)
> > +             return false;
> > +     bitmap_fill(masks, nr_cpu_ids);
> > +     bitmap_fill(masks + mask_longs, nr_cpu_ids);
> > +     waiter.cpu_mask =3D masks;
> > +
> > +     init_completion(&waiter.done);
> > +     INIT_LIST_HEAD(&waiter.node);
> > +
> > +     /* Enqueue and wake the scan kthread. */
> > +     mutex_lock(&hazptr_scan.lock);
> > +     list_add_tail(&waiter.node, &hazptr_scan.pending);
> > +     if (!READ_ONCE(hazptr_scan.wakeup)) {
> > +             WRITE_ONCE(hazptr_scan.wakeup, true);
> > +             swake_up_one(&hazptr_scan.wq);
> > +     }
> > +     mutex_unlock(&hazptr_scan.lock);
> > +
> > +     /* Sleep until the scan thread completes this waiter. */
> > +     wait_for_completion(&waiter.done);
> > +     kfree(masks);
> > +     return true;
> > +}
> > +
> >  /*
> >   * hazptr_synchronize: Wait until @addr is released from all slots.
> >   *
> >   * Wait to observe that each slot contains a value that differs from
> >   * @addr before returning.
> >   * Should be called from preemptible context.
> > + *
> > + * If the scan kthread is running, the caller is queued and the scan
> > + * thread performs the work, allowing multiple concurrent callers to
> > + * share a single scan cycle.  Otherwise, the existing direct
> > + * two-phase scan is used as a fallback.
> >   */
> >  void hazptr_synchronize(void *addr)
> >  {
> > @@ -235,6 +478,13 @@ void hazptr_synchronize(void *addr)
> >       /* Memory ordering: Store A before Load B. */
> >       smp_mb();
> >
> > +     /* Use the scan thread if available. */
> > +     /* Pairs with smp_store_release in hazptr_scan_init(). */
> > +     if (smp_load_acquire(&hazptr_scan.kthread) &&
> > +         hazptr_synchronize_queued(addr))
> > +             return;
> > +
> > +     /* Fallback: direct two-phase wildcard scan. */
> >       guard(mutex)(&hazptr_wildcard_lock);
> >       scan_wildcard =3D flip_wildcard(hazptr_wildcard);
> >       hazptr_scan_period(addr, scan_wildcard);
> > @@ -282,3 +532,27 @@ void __init hazptr_init(void)
> >               }
> >       }
> >  }
> > +
> > +/*
> > + * Initialize the scan kthread.  On failure falls back to the direct
> > + * scan (busy-wait) path at synchronize time.
> > + * core_initcall ensures the scheduler is ready before kthread_run.
> > + */
> > +static int __init hazptr_scan_init(void)
> > +{
> > +     struct task_struct *t;
> > +
> > +     init_swait_queue_head(&hazptr_scan.wq);
> > +     mutex_init(&hazptr_scan.lock);
> > +     INIT_LIST_HEAD(&hazptr_scan.pending);
> > +     INIT_LIST_HEAD(&hazptr_scan.scanning);
> > +
> > +     t =3D kthread_run(hazptr_scan_kthread, NULL, "hazptr_scan");
> > +     if (!IS_ERR(t))
> > +             /* Pairs with smp_load_acquire in hazptr_synchronize(). *=
/
> > +             smp_store_release(&hazptr_scan.kthread, t);
> > +     else
> > +             pr_warn("hazptr: scan thread failed, using direct scan\n"=
);
> > +     return 0;
> > +}
> > +core_initcall(hazptr_scan_init);
> > --
> > 2.43.0
> >
