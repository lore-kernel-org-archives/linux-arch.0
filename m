Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A7C2248BE
	for <linux-arch@vger.kernel.org>; Tue, 13 Oct 2026 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900323; cv=pass; b=fcUDNP3+sKhjzBlr/TX1eOfbTF7AsLwED7Oqqx43+y0q1R21nceJZP+TiO3ZFeBrek9v7v+wPtRFmqs2PzoJ7TzkfuFEredWjH4flncrKrvgF9Z8SXRg4oKuSN7czA/1wleNM1oij5lzzWlhguSUceZPEIryJH5DyiALDTbR3Aw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900323; c=relaxed/simple;
	bh=efwpqbn4KqWJ83/+b8Z3Sx2CVCm9Kiqp5MA7PhTFAxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kVWrFuLIyCVWWHjI6X2oBB5HiOnwUGLvT6YPdOVDDZATaE6TCa+CVyGcmXVOmnC/3DWtVO4uKDVkxKrXv91nh8wxPkbE/FUx8lloALl8AY3IABTpUbXNX1tj3jqJVU29js9NoD2RgC+210Qd/vLtyD+4g4xnV7gBQtPv9emmFrI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OILuzQQN; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OILuzQQN"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93cbc3ab2fdso130596885a.3
        for <linux-arch@vger.kernel.org>; Tue, 13 Oct 2026 07:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791900320; cv=none;
        d=google.com; s=arc-20260327;
        b=L5U75Ef2lD4spUQUQ+b6P3gAZIedpFFpFYZxG56imNBq3WOAdrT41A2DFclz7107CT
         m8O8w+ubOeB/LJv/9hAO6Od1uCJArn3W1bdcMGheVlpYcaikv9+I1rzMoGsQF+v//OYO
         RxxoNQomXtwTA6piIiTxzXUnLigPi442RiZBjzGMzhR+ndPATY+WCZQ5/T5bgvveLys7
         FDhRCtoTjdihZtX234Sltyip2a7CXbYoJUj+iaUQMK/aALVuiZUnJ2MMIaLm6Oxodbr2
         bHU27Et5bhCpJ1HP4/xEsfaePDuw5FR5vqZE+O0B9/TaIfpmxozug8cuJgX64vd0x9ZZ
         0wjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GPXKi2ja3hfSSIKvSqSAyf4VTe85ag1sZhdhO7l5KOM=;
        fh=O6WKU+Uk4BIA1SE5wOVBJwzh2xnro5rpNx0sXKaQ374=;
        b=OpUZS4YUl/qVDOyNwBa6/mMsbCdBFpO/ztE0+eQR6223gSyrSWnBCVDnmYPEHuugap
         GVUaXYOXEVXNZvM9GsKF0oZK7jSFu9AnDVqQ7ccQk3YyqGErCr3or3O2l26EJLxRq9wz
         QRh6Y8XBwLQ+51pMWOy14zl2J9Ej0PrS9CBMxWBOERxEB/hmORPSDri/tjAnQC2YnUJM
         O5ccy+M6TzmLE9/rYBHmMatECjghVYfObw+qYoyiI+rSV4oOatUdR80xSLZK/wR53Vzd
         pVEr4/V2bAKIB8XHBkcpT1EwyDEcI/pNfPtO7F/vhKyXCOpPPjD5QzIMYLMoLpT81/Mq
         j3Eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791900320; x=1792505120; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GPXKi2ja3hfSSIKvSqSAyf4VTe85ag1sZhdhO7l5KOM=;
        b=OILuzQQNGHitUqKN6lSOHQRrLS5lHihOw7H22eT0VBoJwPqFgkweGJNKLeMOqKAjf4
         zvfkgJfM+GXapEQwdQkKBKXeJCp5lVdeKdkQnQ8CeODyN6OfoFsrNvgqGBwLJndNn3yv
         lsdEd0lkmZcaMkxR7sHIQeCzd7PdTPDXo5C8Z2oelqXgQbv7VmWVf94YaXpUjQD9N/I9
         VlniGbbz3zrOHWwP2aVA8tc5tsr72LpZ7gfdg2fJlXEhly2gmVTsSLGJGZfwpb5dI321
         pwTxc8xC7xTcvLqstvZghpwoK/b2LINceM4Sla6EoH8sec8hDHYlfhL1h1W8J28OVIG9
         71iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900320; x=1792505120;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GPXKi2ja3hfSSIKvSqSAyf4VTe85ag1sZhdhO7l5KOM=;
        b=fgr0qsmLqg8H4ij3qMAOeL93yyAvJ1/OaQclsODy4QPdy4RPF6LHSb6mqiGWwe/M2e
         aHunX3b8ERKUrnbCsyV0rO0yYVM84hKdEXnv3z4CGEvUh1dFkYM/zek1X2mBrcXa+jUw
         DLhS02d/AADjEyl505OqlXKL7Wg+5TFIT7LYACLHbpTXUYvrZqo3ypxvUeG20DvM9frb
         ZCHlRZvgsOWtE7FXtaJ1O6NAn+2gEkZAg7r8JsA0qfr3rXmMvmWGDomMFyj0OVVZVLKH
         UY7xKzD9dlDjPR3srxPwsMhIGWGOzTBZBd4RBeVbjPmmkJZNFPNukOtdQC87tSqKfg3n
         3sOg==
X-Forwarded-Encrypted: i=1; AKwUvBxkiofk/1Ws+GO9MBQ5uoHntnekdsa0sRiGjDgnu1C4jfbgVLSjhpBS4rNPra+iYLOwLND6DL5mest0@vger.kernel.org
X-Gm-Message-State: AFq9FYLC3mbuZhmM5PQpByGcj7+jmsG9M8PwbGc3JaCtSvG1/ZIFwZfg
	B0eN3h2u71AehOLhV5L5HyhstFzcxpGDfzyPROS6YaEYSewYEzgbhiQbLD1/t/18GgQoTWukw8R
	kP0aQgmsVpxPoDcLHw6d1FievAyYgorU=
X-Gm-Gg: AYBFou2hMXm9FYjeNbJUNdCwDInz5c8aqBbbCcbdS2pGYHi1+dVj9dtxZ55eShUZUgI
	qEBuDhUmIelPBFy7whFb3Jo/jhwCXWruomaM9jnRETAwPyFnviapULyPqg8J4Xt2Ra22A/GhN7P
	0N+c3Vk0EAFULih4hNhJUBnwMz+DM/I/RqzZcnMWkHo2NliXdlTLEno+dva8KQchnmAwIhLZ8DT
	rS9tzLOBZ+eeJYfSh6s/8q6V+9Hl+kfFZXCRhb3e09LLxnT/3pVIInvRHW7hEGyxtdGA74Ru/hF
	nbtBHUgM2T4XsmqEIe9T7+p5a0G6wWhGBi/cNA9ybsAmB8q89GwoR2Gl06CLUkrh+7uZ74yzeKV
	kKMIpXMl1HaewvU5zISEOWM0=
X-Received: by 2002:a05:620a:3947:b0:93e:78b7:fa4e with SMTP id
 af79cd13be357-93ebd24b2fcmr2220976385a.37.1791900320079; Tue, 13 Oct 2026
 07:05:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005171529.1378809-1-kunwu.chan@gmail.com>
 <20261005171529.1378809-9-kunwu.chan@gmail.com> <as3aMmPdCHCXW6Ci@U-YXDQC754-96.local>
 <as4ooZSWA2lAIceu@tardis.local> <ef3fd68d-f35e-4071-9523-0cd14396d860@efficios.com>
In-Reply-To: <ef3fd68d-f35e-4071-9523-0cd14396d860@efficios.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 13 Oct 2026 22:05:08 +0800
X-Gm-Features: AclHuK9Y6wjNtKPnooCMgRZOapMzF0kyKCufRscUU_wsuFWoqVB6jP59bjMM3m0
Message-ID: <CAJhGHyBd5wuLO9H7bHJDO==2=z8MGQ3ehvszLiB1brztpRXu8A@mail.gmail.com>
Subject: Re: [PATCH RFC v3 08/15] locking/lockdep: use hazptr to wait for
 dynamic key lookups
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Boqun Feng <boqun@kernel.org>, Kunwu Chan <kunwu.chan@gmail.com>, paulmck@kernel.org, 
	corbet@lwn.net, mingo@redhat.com, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, josh@joshtriplett.org, urezki@gmail.com, 
	dave@stgolabs.net, lianux.mm@gmail.com, stern@rowland.harvard.edu, 
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org, 
	npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, 
	joelagnelf@nvidia.com, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	longman@redhat.com, rostedt@goodmis.org, qiang.zhang@linux.dev, 
	brads@mainlining.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 9:04=E2=80=AFPM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2026-10-13 08:48, Boqun Feng wrote:
> > On Tue, Oct 13, 2026 at 03:40:36PM +0800, Lai Jiangshan wrote:
> [...]
> >>
> >> This breaks the forward-progress argument used by the underlying
> >> hazptr implementation: after removing an object from publication,
> >> there should not be a continuing stream of new readers acquiring
> >> that same object. Here, the bucket is never unpublished.
> >>
> >> For example, let B be the bucket containing key K:
> >>
> >>    Updater                    Reader                 Scan kthread
> >>    -------                    ------                 ------------
> >>    Unlink K from B
> >>    hazptr_synchronize(B)
> >>                               Acquire B
> >>                                                      Observe B;
> >>                                                      retain waiter
> >>                               Release B
> >>                               Acquire B again
> >>                                                      Observe B;
> >>                                                      retain waiter
> >>                               Release B
> >>                               ...                    ...
> >>
> >
> > This is more of an implementation issue,
> I agree with Boqun about the point that this is really an implementation
> issue.
>
> If we care about forward progress in the scenario of a repeated
> address reuse, we just need to wire up a "0/1" low bit phase tag and
> make hazptr acquire pick it up and set it within its hazptr slot. This
> will ensure forward progress in that scenario. hazptr synchronzie
> would therefore flip this phase between 0 and 1, and check that the
> pointer it's looking for is not set in the other phase, in alternance,
> handling both phases within one synchronize. Indeed, this phase concept
> comes from the realm of RCU implementations.

Regardless of which implementation approach is adopted, this would effectiv=
ely
introduce a new read-side synchronization mechanism based on hazard pointer=
s.
I would prefer to see it introduced under a distinct name in the
kernel, so that its
semantics and intended usage can be clearly distinguished from those of
conventional hazard pointers.

Thanks,
Lai

>
> I think that the overall mindset so far has been "RCU does this" and
> "Hazard pointers do this" as if those were entirely predefined
> mechanisms. I think the way forward is not "one or the other", but
> rather to combine the strengths of each of those mechanisms into
> something better.
>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
