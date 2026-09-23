Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE253563FB
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 04:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790136937; cv=pass; b=kVS01D/yMu2syOx2FPgiBiVAd0K76xelNy/MHrVT0s0KT35TKX/Ubcb3vwNDW1V+gaFmxBYrCnUwfrQsZ+IKRg9ebyK6yc0d2CHl9BvaTsaKNYOlXEnFpuuWJpmpTj9T1jPy+ASP2WNsQM0BfIYFybitYjlsrOCh/4hx15PW/fI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790136937; c=relaxed/simple;
	bh=oUewmwn77TqWmsD8jxMMcsLsXwJkucdFvCNJu5PgVaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGJhx6nUS/Ij5y9c5CALS/6V5c6kDTY4E/p9cFkt7d44Hup1hDvRC2IYdaJbS68fTuxVvfGDq4xACSYB88Q2GVuM/6J4jyUmORtq1w80b4bsrq999dZJdzMhHD19f22xjfPJ01XHhV0x1txSUWo897gO7qYRR5A79lp4+zoIE3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FwzOicOX; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FwzOicOX"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccff31419so3650095e9.3
        for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2026 21:15:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790136933; cv=none;
        d=google.com; s=arc-20260327;
        b=d3dR0JP2rvRRFwGYfG2QbxM5q1HI++dVRDkPcJzISWnlD9tb0whhoQE3aPjMySCKiw
         ialWqtBFl3iCcCc05dXnJIlkAJhZe364vGJswVsJ+0Qhh4MHyNfFplx4805nbAANORbx
         UbE1pFUF1HG+jlqHacU3aY65TULpF4IlVfLvd8mIzhALnr0yanvhwoRpoKjQhB3X5BCE
         56rxBEqY1t1QhQc06nBGWz1vFGBW5TehlseaCkAMFhuoVCw7hEGAPkPJBcMDnNHEWJ1r
         ELoyLgdpo7FW690gU0AR5HrZiycWd7KhRjhUgLpGaxoXd1l0s+VCHaslywCXgFimc4PX
         B6Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i36f7xtnWKpVJBn7KVPs9Rgrmv9naoWJLljKyz9tnJM=;
        fh=JKaFePvbxaK4H6u/Qba/1bBvNdL33nXNK9nikCtlwa8=;
        b=RV8fpiIag9PziYnqSyNEnzNzFez6imhK08QMebzfWtsZ3ivNITw0jWwPt0KTQpTy2y
         y1kjQcLh02K7X/A/dJ/sutOhCKvLlKUVRLdY0dFvCYjiXgKLChjZu9epiuofWyhn/NZ3
         k1OkCtgWMD5dgbkX5OL/X5I/HWghOKeXpjbdNt3XCFgoUet/z8HDi9KIhmkYLrGy7FGz
         zIi/M6TRSAlnFwx/PvwbhBgOCcL7iwQiRWYKBG4qxkSvbOhiOYJLVKMRFgl5MyKppRxn
         PvvLqHPfJINg7p1Ln6fartRHv8EfIbIgJ5QmRr1OdWI6U5u3yOOhElLVj27nNZ2LAoPj
         3FVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790136933; x=1790741733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i36f7xtnWKpVJBn7KVPs9Rgrmv9naoWJLljKyz9tnJM=;
        b=FwzOicOXBvQWomnpL+aYG0N+i5jLMO8MrDsiVI8l1fVS6XdW9fDMl1F8zGPSRyu1l6
         9pXV3H5lJPr/F6LU6XohEkHofNQNHW+AI/wfR3LWzUa8/qCs4rmigEc7HPdLaowwehw/
         8m3gECfEYmr3+ncR4W7x4fdVYGE9EqBTLckDN+i1iTbZc0gNk7Xcmc1JPgOOQBs0pNq3
         2YwQnj97ivnt6ArNZvaCwLeAO+TBECusObiifCgVDruPsc6JGbU0VDLU/1z6Qo+bk9gB
         bho5bmJJXRvC54EGqGbs5HXmdV2r2uCM2ZMPREqsnCKBi8GXCWzWlZ46L7takwwiqtSc
         TcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790136933; x=1790741733;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i36f7xtnWKpVJBn7KVPs9Rgrmv9naoWJLljKyz9tnJM=;
        b=xc4iqCzWyWneg5XLs//tXkepjK5idJ6B5OEFVkDrq9D57sAr7LHpDLOOIioW8QVi1l
         WVUUUEmweK2Icbbmd90rXWVAV2IQGVHB8tDFe0SXYJYlnMyojBXwXADJHhLVM5GvqerX
         T/0slFXaMFdbj0Qzn1qlT+91SX5LLKh+T5jSoxTgjszYcCPXK2Hl8h3r71hHyyyfq783
         flffxDf/g5WT5z5+7I0F/QnODc3R5MnJZ5g11DkkhsJjZ+QH1tWMyaTl72w/n879cC94
         C8LjM8kA9Qsx01olZ1boKsvSgrVqv2rrSTfp1i06SpevzvCcYJ09SRR3dpP10lNHY/lG
         JZVw==
X-Forwarded-Encrypted: i=1; AKwUvBymjgEVtPAySbFcXa6bydqyjqAF1dJu634gQG8T2qWKNxcEp7QcxH5i5jQYAbn/G12GcOuN7Nrq5r3S@vger.kernel.org
X-Gm-Message-State: AFuF++kp5HHVh1XJpFCExavhFVrSlXZiTt/xoaeRnzlLZD/hRO3qsAbk
	psg3oIbaFagV0oRol2Jq73pl/RhXAaeF5QguNfGfs1MSRRtKPyhC9+GGzP6gVHtpNQHLXQ3svqa
	P7hqVCXgKPzauX7YDT2ycwcpDNA4Yux8=
X-Gm-Gg: AYBFou3m/xz9qKTIglO3rGq6igCU/zxUIoYnZVqWQOmzK0USrI1yFYeB16eAbScpaKJ
	nJxWO7+eVLfvAQX8aUDG03tCXzjummknMGg65sMitT7178cSouCxeyWXDDR6xadPgrr+mm9zWGb
	yPV0BaqAVYTNgTtpHdV+ovtb3Nvu0BfkB68IWM6UEhIdzh2KQ4XnN9nyeLfycnagaa2BnS35V1P
	3xoB6y2n/h5BG9iJ4Y43NRJgCrDkL5sw7pG/oS+qE7qC+gH1C1A4ispIqEoTnS8qeLmeepEfolB
	i5nbTXG3NJ/WbPSnrBHcUs4P6xLOqrbxjN/XdPDxhQJuGKAFkHv+roQjlPcr4gERhbThPhCuysz
	IQQoHrJRN4SFj1Q==
X-Received: by 2002:a05:600c:46cf:b0:49d:797:8488 with SMTP id
 5b1f17b1804b1-49fdeff7112mr14786765e9.1.1790136932220; Tue, 22 Sep 2026
 21:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922070950.4173245-1-kunwu.chan@gmail.com>
 <20260922070950.4173245-3-kunwu.chan@gmail.com> <arJBpQyOQf3AJ4cA@MacBook-0RXW5>
In-Reply-To: <arJBpQyOQf3AJ4cA@MacBook-0RXW5>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 23 Sep 2026 12:15:21 +0800
X-Gm-Features: AclHuK_nckJ12y6T2Aoov6rc7a6r-smUS_AxTu-iCekyh8CIGeC66Dch7H_GWTo
Message-ID: <CAN_Opa9fyOApv8u-WxcdHDgYDLkOkv4tKLacGsuHgnz7GdNVTQ@mail.gmail.com>
Subject: Re: [RFC/WIP PATCH 2/4] locking/lockdep: use hazptr to wait for
 dynamic key lookups
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

On Tue, Sep 22, 2026 at 4:51=E2=80=AFPM Boqun Feng <boqun@kernel.org> wrote=
:
>
> On Tue, Sep 22, 2026 at 03:09:48PM +0800, Kunwu Chan wrote:
> > lockdep_unregister_key() waits for is_dynamic_key() callers with
> > synchronize_rcu_expedited(), which sends IPIs to every online CPU.
> > Have is_dynamic_key() mark the hash bucket with a hazard pointer
> > and use hazptr_synchronize() to wait specifically for those
> > traversals.
> >
> > The hash bucket address from keyhashentry() is stable, making it a
> > suitable hazptr synchronize target.  The rest of the key hashlist
> > lifetime (hlist_del_rcu/call_rcu) remains RCU-based.
> >
> > This adapts the lockdep use case from Boqun Feng's hazard-pointer
> > series to the current hazptr API.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  kernel/locking/lockdep.c | 30 ++++++++++++++++++++----------
> >  1 file changed, 20 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index c56a7f91d72e..f67d847f9abf 100644
> > --- a/kernel/locking/lockdep.c
> > +++ b/kernel/locking/lockdep.c
> > @@ -58,6 +58,7 @@
> >  #include <linux/context_tracking.h>
> >  #include <linux/console.h>
> >  #include <linux/kasan.h>
> > +#include <linux/hazptr.h>
> >
> >  #include <asm/sections.h>
> >
> > @@ -1280,14 +1281,24 @@ static bool is_dynamic_key(const struct lock_cl=
ass_key *key)
> >
> >       hash_head =3D keyhashentry(key);
> >
> > -     rcu_read_lock();
> > -     hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
> > -             if (k =3D=3D key) {
> > -                     found =3D true;
> > -                     break;
> > +     /*
> > +      * The traversal is protected by a hazard pointer rather
> > +      * than an RCU read-side critical section.
> > +      */
> > +     {
> > +             struct hazptr_ctx ctx;
> > +             void *bucket =3D hash_head;
> > +             void *addr;
> > +
> > +             addr =3D hazptr_acquire(&ctx, &bucket);
> > +             hlist_for_each_entry_rcu(k, hash_head, hash_entry, 1) {
> > +                     if (k =3D=3D key) {
> > +                             found =3D true;
> > +                             break;
> > +                     }
> >               }
> > +             hazptr_release(&ctx, addr);
>
> This looks good to me. However, we probably want to use scoped_guard()
> here, that means cleanup.h support for hazptr.
>

Thanks for the suggestions. That makes sense.

I'll add a DEFINE_CLASS wrapper for hazptr so is_dynamic_key() can use
scoped_guard().

> The other thing that could be added is a debug option that force we
> skip the fast path, so we always go into the show path in
> hazptr_acquire(). This occurs to me because the slow path here means
> acquiring a lock inside lockdep code, it should work, but I just want to
> be careful. So something like:
>
>         void *hazptr_acquire(..)
>         {
>                 ...
>                 if (IS_ENABLED(CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH) ||
>                     unlikely(slot->addr))
>                         return __hazptr_acquire(ctx, addr_p);
>                 ...
>         }
>
> Thoughts?

Agreed on the slow path. I'll add CONFIG_HAZPTR_ACQUIRE_FORCE_SLOWPATH to
always enter __hazptr_acquire(), and exercise it with lockdep-heavy
workloads under
CONFIG_PROVE_LOCKING.
The existing hazptrtorture module can also cover the forced-slowpath
path for additional
stress, including per-CPU slot contention that can trigger the backup-slot =
lock.

Thanks,
Kunwu

>
> Regards,
> Boqun
>
> >       }
> > -     rcu_read_unlock();
> >
> >       return found;
> >  }
> > @@ -6683,11 +6694,10 @@ void lockdep_unregister_key(struct lock_class_k=
ey *key)
> >        *
> >        * Some operations like __qdisc_destroy() will call this in a deb=
ug
> >        * kernel, and the network traffic is disabled while waiting, hen=
ce
> > -      * the delay of the wait matters in debugging cases. Currently us=
e a
> > -      * synchronize_rcu_expedited() to speed up the wait at the cost o=
f
> > -      * system IPIs. TODO: Replace RCU with hazptr for this.
> > +      * the delay of the wait matters in debugging cases. Replace the
> > +      * expedited RCU wait with hazptr_synchronize().
> >        */
> > -     synchronize_rcu_expedited();
> > +     hazptr_synchronize(keyhashentry(key));
> >  }
> >  EXPORT_SYMBOL_GPL(lockdep_unregister_key);
> >
> > --
> > 2.43.0
> >
