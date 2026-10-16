Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F962F8EA1
	for <linux-arch@vger.kernel.org>; Fri, 16 Oct 2026 03:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792120231; cv=pass; b=mX8FPYunTkDVxGSxU/usXL/ihNx6ZzlNzIxeJMY8/oIKqqhv8fhbSiUDIcYg0EcQhDlA2nNOufmt3UuOCvgYmUxtwkootZmVxJsgfPfaawfcOVJx5lbcxcEPjkPbyLnLRcVa9NIAGJDlaSVqRmIFBDB6Mrqh0+FhXePdvxDBhvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792120231; c=relaxed/simple;
	bh=WVQ/j1d2JaRchY/iDZaPslSfywaOQoJpll8D3v4G/LQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L87obhKVbim910V0lpsXUwxaovqJgZqn8nszhNSPxYgFj8Z3bhOScU2CdQyYXAAq45k4ZmsxZXzjC45O1pcfGBDoB1Zdjd/lFQFWJNzRlIfEs78hDQXfAvEfd6694M5ww1i/axByXjTqpGqmbuLVivR6Ye2P36KZuWEMnSKi9RE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDQUGevn; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDQUGevn"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso6169825e9.0
        for <linux-arch@vger.kernel.org>; Thu, 15 Oct 2026 20:10:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792120227; cv=none;
        d=google.com; s=arc-20260327;
        b=CYcujvHTzd2gEpT5MS/31uMzEdGs5GJ3gLpaIWAbWZTGG8kqF2GDHo3nPHVyY0wVF9
         kKa37sibrDK4WP/NEWhmHUEYmAt0Kerh6O2louf/PzEZ+8WJU9D2NuNjq3W6FRuIEpth
         OAEMeLjAHiNrd47RQutuqLuXycMWajQpAwytdJsJ5DkGUInD7ysS4nv99S++cbSxdrxt
         a1hxOt5VDy8BPFyloLok4m6fx9FmKDvdtVAj2kPM7s8X24b3qgv6mN1aFyj2+mvbz3Bf
         1tzFYuysmKZBANmtyV0WMG2soK/hVW2mB8Vn+F5G0a9oJmAouI+2kMiCANVUdzr/PDJL
         t9uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xlTg1ZA1llUS+f5Z9F7BKuAG/CC4v+1NC0B32dFPZWI=;
        fh=Z34K4Z8AkBN8jovxMePiOhdZTthGOdYIUV6XglF70RM=;
        b=Fo6GcQ+B0DOnSfdx0vmIlLunfjBnlnp61h73b2CxAghLiK5q5ncauOCBrKr5CJK/nI
         pMb5boaFG+iIyTC9NYPHph5U2l80Ghc2E8RCkdYcarqHxPdp0+Ma+aBeuI5HvZHW8Qnw
         ZpELIMB1ge27HLPFKFdMezK48oTZtVaL2yittIO09s/vFnbzlKsUDBNZu7vFmhxLmHcZ
         +iQoWujDnLzwVFA/+kk+sDGw5rshM9uEvF5sOmQouoU833oJw+b4YJOgjeYKuW87LUJz
         G4/j4UuzONR5rPF9Qxhl79rmqrsY5NCDrLhBX/A7b72fNBUPv47wIj6gIneGbNJ+W38V
         uDnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792120227; x=1792725027; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xlTg1ZA1llUS+f5Z9F7BKuAG/CC4v+1NC0B32dFPZWI=;
        b=HDQUGevnZicrjXUQrDR0JNaZLlrGx1TGZvw2y7u6iZekbSseMFxveLn8swWGq1zjpN
         Js73iJYQq9ZzzQGA7t6FwrpLoiTljo1i7FMyylM9qou4b2YHQY3+A+DbS277bj+id060
         gv9udJfWoYoqykpiW101e2yQGd7YHD/ZRoitndm/YTiTTn5seJ4m1AL+WcpqF34o91eD
         JRkDs7XB5apZEcKSpZam0EbpxK5fYBDAwdFB3tYwQEwmJjuvWVyZjEmS+pBrWoY6asai
         kgp5AXsLMkPNgkc+eZa/tph9BCWt3keKTyZFOFEmQYdxIKD6TF3u0ptyDx/5GAltlH3g
         FQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792120227; x=1792725027;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xlTg1ZA1llUS+f5Z9F7BKuAG/CC4v+1NC0B32dFPZWI=;
        b=GyAr0VDe9m1aktdjBBvVTIfZ/7wyyeroGKwBIPeafCG03Ek6KHMyiIeruc3sl/qDFz
         It/G4F8V6omcdcDhs190pRDzwDLcfi4+pFg9O/YHmB8hwxzjFcwr9PnZ6Fd6eaVB+efL
         SsR80YipPktYaYG9uq3m/QAjZsUlmxm8brg7iCkXyfsR4yr+HAH5FBgs1XQ0gYjwC8dN
         uA9AkK04tpqDBZw3SvFWD5xkHwImEWoNZnWqeK+o1I3nYPPb9ym4bVwOjEoYSqAI5SsC
         o9AVSsYMYsycAW3w25rqh5qSL9U5xkH5D99UI5InOI+SujWrGo4PS4CT23YyIxTztI0g
         jGHQ==
X-Forwarded-Encrypted: i=1; AKwUvBz6w7jvX0dLmZpdhTNu2KRbRF/nAQN+rOdDscPvAFWKUdGL3TFEGZB2C2FxCinOPgsHemN9CTw+QM/Q@vger.kernel.org
X-Gm-Message-State: AFq9FYKyMzaJB15BXlB0ffKpV8s/1eEcx3pHlYf5ZkIStaeEOasBtBk4
	cA0IHFypVDG3sC0TNBYqrYuF5BIQQmKt34gNxFcUlVkx1Wtnvp5MYG5Zyfq+IY0/axjflkEfBfP
	h7fJgcookp11sdkNQmadc/ddxlSMwEb0=
X-Gm-Gg: AYBFou3L7CDjkxqa9y/2LHwqlPpeWZpg9Pra34bk/JhPjIbZ0j1wOZTt2fBSyFHDtuE
	Py26KM3aWmDmSEgGXFl3yF6Ul2FwqMV9y63Tlekbrt+Jd2W+mn0UpVrEZD2slWWKwdUmMDi2ueE
	R87Mk3hwQa55pBLJGQ7ztaWyyc3yrTyc8AsZkBsbtV2gOQcApIGZCIPYAX8Sr2SkrLoDMHANaFM
	y6PXfGF/Uk0GkeWMdXK5P1rgoBAmL4juh3FzNZpob4SKfzAS6jMpeVYkceRsuOoFiC/uiz3YOOZ
	OUhPengSq4CLXzmDCZOB5bUIsXAFMoog3ph4F2pnOUX/zK93oOFKEZDX1AiktxMlR1Q=
X-Received: by 2002:a05:600d:82f3:b0:4a0:ec5:46d9 with SMTP id
 5b1f17b1804b1-4a1c65b9d1cmr49895815e9.0.1792120227297; Thu, 15 Oct 2026
 20:10:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
 <20261005171529.1378809-9-kunwu.chan@gmail.com> <as3aMmPdCHCXW6Ci@U-YXDQC754-96.local>
In-Reply-To: <as3aMmPdCHCXW6Ci@U-YXDQC754-96.local>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 16 Oct 2026 11:10:14 +0800
X-Gm-Features: AclHuK-luj00YvB6W0gzUZaHST8ZYYHX_eNK_3NZlyZFFvQwwdxXevqOtbkN0mU
Message-ID: <CAN_Opa9V-nXQ8-PyntDGaQDw4jQs0Z99J07pdApH3+EoTHyTcQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 08/15] locking/lockdep: use hazptr to wait for
 dynamic key lookups
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: paulmck@kernel.org, corbet@lwn.net, mingo@redhat.com, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, josh@joshtriplett.org, urezki@gmail.com, 
	dave@stgolabs.net, lianux.mm@gmail.com, stern@rowland.harvard.edu, 
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, 
	boqun@kernel.org, npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, 
	joelagnelf@nvidia.com, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	longman@redhat.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com, 
	qiang.zhang@linux.dev, brads@mainlining.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 3:40=E2=80=AFPM Lai Jiangshan <jiangshanlai@gmail.c=
om> wrote:
>
> On Tue, Oct 06, 2026 at 01:15:22AM +0800, Kunwu Chan wrote:
> > lockdep_unregister_key() waits for is_dynamic_key() callers with
> > synchronize_rcu_expedited(), which requires system-wide coordination.
> > Make is_dynamic_key() protect the hash bucket with a hazard pointer
> > and use hazptr_synchronize() to wait for traversals of that bucket.
> >
> > The hash bucket returned by keyhashentry() has a stable address, so
> > it can be used as the hazptr synchronization target.  Keep the key
> > hashlist lifetime RCU-based with hlist_del_rcu() and call_rcu().
> >
> > Protect the traversal with the hazptr scoped_guard() added earlier
> > in this series.
> >
> > This adapts the lockdep use case from Boqun Feng's shazptr series
> > to the current hazptr API.
> >
> > Link: https://lore.kernel.org/lkml/20250625031101.12555-1-boqun.feng@gm=
ail.com/
>
> Hello,
>
> I think this is a misuse of hazard pointers.
>
> The bucket has a permanent, static address; its lifetime does not
> need hazard-pointer protection. Instead, this patch combines a
> hazard pointer with that address to construct a read-side/synchronize
> mechanism in the same category as RCU. However, this construction
> lacks the generation distinction needed to separate pre-existing
> readers from subsequent readers.
>
> The object being removed is the key, but the synchronization target
> is the bucket. Unlinking the key does not prevent new lookups from
> acquiring the same bucket address, including lookups for unrelated
> keys that hash to that bucket.
>
> This breaks the forward-progress argument used by the underlying
> hazptr implementation: after removing an object from publication,
> there should not be a continuing stream of new readers acquiring
> that same object. Here, the bucket is never unpublished.
>
> For example, let B be the bucket containing key K:
>
>   Updater                    Reader                 Scan kthread
>   -------                    ------                 ------------
>   Unlink K from B
>   hazptr_synchronize(B)
>                              Acquire B
>                                                     Observe B;
>                                                     retain waiter
>                              Release B
>                              Acquire B again
>                                                     Observe B;
>                                                     retain waiter
>                              Release B
>                              ...                    ...
>
> Every reader critical section can finish, and the scan kthread
> can keep running, while the updater waits indefinitely. Readers
> that could have observed K may already have completed; later
> lookups alone can keep the waiter pending.
>
> RCU does not need the reader population to become empty. Its
> generation (grace-period) machinery allows pre-existing readers to
> drain without letting a continuous stream of subsequent readers
> indefinitely extend that wait. This address-based construction has
> no equivalent distinction.
>
> So this is not merely protecting a different object with hazptr:
> it is using hazptr as a different synchronization primitive without
> providing the corresponding progress guarantee.
>
> I think we should retain the RCU wait here. If the intention is to
> implement bucket-scoped read-side synchronization, that needs an
> explicit protocol to distinguish the readers being drained from
> new arrivals; a permanent bucket address is not sufficient.
>
> Sorry for the lengthy reply, which was written with the help of an AI
> agent. I noticed this issue when this use case was first proposed, but
> I struggled to articulate my concerns clearly back then. Well, now we
> have AI. :)
>

Hi Lai, thanks for pointing this out.
And thanks Boqun, Mathieu, and Paul for the helpful replies.

I'll look into adding an RCU-stall-like mechanism to detect
long-lived pointer waiters, and work with Boqun and Mathieu
to find a more suitable scenario to exercise this case.

Thanks,
Kunwu

> Thanks
> Lai
>
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  kernel/locking/lockdep.c | 25 +++++++++++++++----------
> >  1 file changed, 15 insertions(+), 10 deletions(-)
> >
> > diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> > index c56a7f91d72e..d1ce5ace7fbf 100644
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
> > @@ -1280,14 +1281,19 @@ static bool is_dynamic_key(const struct lock_cl=
ass_key *key)
> >
> >       hash_head =3D keyhashentry(key);
> >
> > -     rcu_read_lock();
> > -     hlist_for_each_entry_rcu(k, hash_head, hash_entry) {
> > -             if (k =3D=3D key) {
> > -                     found =3D true;
> > -                     break;
> > +     {
> > +             struct hazptr_ctx ctx;
> > +             void *bucket =3D hash_head;
> > +
> > +             scoped_guard(hazptr, &ctx, &bucket) {
> > +                     hlist_for_each_entry_rcu(k, hash_head, hash_entry=
, 1) {
> > +                             if (k =3D=3D key) {
> > +                                     found =3D true;
> > +                                     break;
> > +                             }
> > +                     }
> >               }
> >       }
> > -     rcu_read_unlock();
> >
> >       return found;
> >  }
> > @@ -6683,11 +6689,10 @@ void lockdep_unregister_key(struct lock_class_k=
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
