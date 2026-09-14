Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26DC1DE8BF
	for <linux-arch@vger.kernel.org>; Mon, 14 Sep 2026 04:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789359005; cv=pass; b=TJMGeAHxS2HELj58psCzBhBPRU66ynFaKpOR7vzrBkhxm4K2GjusKkGA19KdLgycL+2Md7bJZ6eiQSZR4cEVkanRSdj8Ti8j1OvDVqNiDR96xpOFSrWz00PBcNApH/zFe2afNg43lI8uUlLd444QtMR5GAvXvX54wcona66kQe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789359005; c=relaxed/simple;
	bh=OuocpLdMNPQW3Fx2t6L/bKgKdcwFNsKd1HJmgA5pc9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qsz7SxUc26emFZCZlZVRQARRDvDxet0BFAJ2fyH4AAf1fpm0MCnOz3OtTJVwkZdlrK7icXMNKduwVKozakAs/EZW9om3m0HfgijD0O9NC94WFaZ0mYv8hucGDJTqo617r8FYTQWNRjGV5kpFS8/+Dk8UprdsU1f1ZQrolzy0QmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ri77OcEB; arc=pass smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ri77OcEB"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso10473825e9.2
        for <linux-arch@vger.kernel.org>; Sun, 13 Sep 2026 21:10:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789359001; cv=none;
        d=google.com; s=arc-20260327;
        b=Q4GNz7NUNwTXZUn+fS6eMANtR/3UYXiApNiow9QICbrnGra9t7RoZ1SiOhOnvs2Hm6
         pUClcSL7CpOtmQk4FiG5s0Kfpsm9y+vCi0SnPAXk4X7SxKti1as6Lm8VgWgScKhQa1Zo
         wiKbQC3yo/SdXwAYJ5c0xkfbpYjFXr98RgrjyEqPXpXV06dSGmgBkEcrbrI1gIzTGOTf
         enttXqe7nj5C9MA4ugqjzVTeIIiZNCcYi3BeCfpaP/z0j36t8i89j/ygTmIR+tzetL56
         Mmb6K3qw4ApKZWfyMg9hhVKicOHKeLU8KTl2paa1kFqS3MpLNgSMqsNunIdaFYjFn9Vo
         Mk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QtqliJ4xhgZPrGv7aDR1sY82Ecpr9o/c+cAlkpJq1QM=;
        fh=Zbep7qBeRKVFKx5yiVP3UrDdQdDpAI4BGN3dfM1PRMk=;
        b=dXlAySgp4SUE48qR1tQb7mWxVxWSkNRAySLWxyS13f8gCDUYPaVi4G54A7EuYLxRie
         0hmdPA6JgmbLVK2PfERAUmBiemoIIjr3yX2WWQWGIbtB84Saa98rIinHFihrhvjCTBYq
         bzJBIWfEnIRDqPwZVq8AWIO2jraZjzmnrewjtN8uM7aEiT4DYlfWZcaxENt6Jd0ODTVW
         OEDyufEQU6wav9EMxxE7DKYlCXj3OGCyWq3c94VzKycC6QFP0owQvddKj6+tNsVWHsyY
         IoxM067NfpIXL/sbntk6v+DhM4QnqhuGipD55yEnJ0g5i8/TtdGgNCYYNlKJyFf1ugN2
         CoJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789359001; x=1789963801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QtqliJ4xhgZPrGv7aDR1sY82Ecpr9o/c+cAlkpJq1QM=;
        b=ri77OcEBJSqUsoM6YYvlzR4cddlX/zbZ2Uaw+ACwCz7t8MW00/LAIOLOb8Kh09P8Hr
         f9ivYqMysVpbTVlC3Iwh5T4+BURmduexD0BwFyZCv+G2MWfO5DLvR8QdQPHUD9fg8mxf
         VFJ5YcMPR7J+7w+RH0u9YK0s2QXzgl3hN6lDi0piaKGQASirkAp3t6gpWxljDJuut/TN
         rKPiMvQ4jnl56A0a1gqgf16+dHdm9HKJ3fZHLImQYPQCzpGztAdjL6mIvdbOl/pbpsja
         zZ/jdPf1Q+o+olbdMJznoHgDzSOT3FJe1FSuZHGj3Wc2Mnp5zpeIm9i/RVbVk1pe7Oc0
         qNXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789359001; x=1789963801;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtqliJ4xhgZPrGv7aDR1sY82Ecpr9o/c+cAlkpJq1QM=;
        b=CM7eHlZVJoHjEKgi+HyOq7HNOCUU1hLdGt3jEDFfymHSXoyVCNQezOy2akgWihagmt
         4Z9r+6Q9JzE44L363Nt65bn6soVagAsEaqDIWFKuA+g3/xVeDW18k7ForNIxQrYB6bWB
         AUfM4lGmiWItvqBFsJg/R3Olm5Y/RCx9RKMq1B79wuRTqoFkFk3PUcd+r8XJKkJA/Bak
         UWFY2i/2V6RIR47kTFyHLkJqRyPeYoOqEyW7dgZ0UlMJjGhzg1yS/SysgU5NwROsTerv
         Aw6IFam5FcVfzrktBYna2lLtZCsBMFmv/LEqLfjViZuD2UqAVtg41HnngmWQI0qMq+RN
         5Hyg==
X-Forwarded-Encrypted: i=1; AKwUvBwjpuajGtikbkcN4+nOWwz8xGZ/vFzo+91EbEjv0OYyQVWzeE2XjLo9MuFJxabmW6rtTozANH6VSN/3@vger.kernel.org
X-Gm-Message-State: AFuF++llYK6Hj7JHFq8b+0guDT6LnEBitay5npBrGTP8Stk/Q9pMTKyu
	IdSpZf9Exf+BEVi6ivOpUGIqbM3PXPzJcVP8i3XiD/B30+NISdFg1Xv8b2bnjP7H4T/6BlgpIHb
	P7/iZpvNAp/NRUCapafhH5CiQwOSNeHA=
X-Gm-Gg: AYBFou1ICF8oRyAKUg6x2a3/inPnrdgts7IyqM+FReDJNsPIfn8NXMEww1TGerSINb6
	oM5D5yrICr58Pm83QlnW/mmp3m+wktNWRvd2iyDE50nwZFa1LgJFcppiWebrBsoNO+q2vHxenjN
	slZXICTcQWYGwArT+UA09uHR/Rf6J4JJOHf7EKT6j2dNQRH2pq5S7n0WuMr2EWjY6qBdcfATTrc
	I9fNUhOtn71r3OkmZjCKSM5+cWSHFoGbe5a60xu/8hUfVrgL33d5MIPBXQ/6lh/zz823G1Ts0rF
	DnCnE3Xe7bDePihXAK7wvBNBtUt/0Wa9WAOw4pQ2ZaPLUn3j4zvF9UFmcO27KUB4kAWzgrMyKRZ
	KTEKzLSh5tzYCiA==
X-Received: by 2002:a05:600c:19d2:b0:49c:fa21:1c8b with SMTP id
 5b1f17b1804b1-49e7a69c84dmr7218505e9.32.1789359000887; Sun, 13 Sep 2026
 21:10:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912024225.2872265-1-kunwu.chan@gmail.com>
 <20260912024225.2872265-2-kunwu.chan@gmail.com> <892d82bf-aff4-4b0c-9585-8438280b45b1@gmail.com>
In-Reply-To: <892d82bf-aff4-4b0c-9585-8438280b45b1@gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Mon, 14 Sep 2026 12:09:49 +0800
X-Gm-Features: AcwNN1XWLLaBfaxSIDxW2V2ijIMl_XRWS1t07_7EbkNNIYKP6enYpyX1l6ij_8I
Message-ID: <CAN_Opa-Rr=R1JfuPb+o=DQTHjQEp_0ceKUU=qSPkJbw6HMcnTg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Documentation/litmus-tests: Add SRCU fastpath
 anchor-before-scan test
To: Akira Yokosawa <akiyks@gmail.com>
Cc: linux-doc@vger.kernel.org, lkmm@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rdunlap@infradead.org, skhan@linuxfoundation.org, paulmck@kernel.org, 
	dlustig@nvidia.com, joelagnelf@nvidia.com, corbet@lwn.net, 
	luc.maranget@inria.fr, j.alglave@ucl.ac.uk, dhowells@redhat.com, 
	npiggin@gmail.com, boqun@kernel.org, peterz@infradead.org, will@kernel.org, 
	parri.andrea@gmail.com, stern@rowland.harvard.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 5:48=E2=80=AFPM Akira Yokosawa <akiyks@gmail.com> w=
rote:
>
> Hi,
>
> This is more of a knee-jerk reaction, but
>
> On Sat, 12 Sep 2026 10:42:24 +0800, Kunwu Chan wrote:
> > synchronize_srcu_atomic() may end its grace period immediately when
> > its scan of the per-CPU lock counters finds no readers.  Correctness
> > requires the grace-period anchor written by srcu_gp_start() to precede
> > the smp_mb() ordering the lock scan.  This ordering ensures that any
> > reader whose lock increment is missed by the scan cannot have
> > incremented its lock counter before the grace-period anchor, and
> > therefore cannot be a pre-existing reader of this grace period.
> >
> > This litmus test models the key ordering between the grace-period
> > anchor and the lock counter scan, where "seq" models the
> > grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
> > ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
> > smp_mb() and the lock scan.  P1 models the reader-side counter
> > increment, with the smp_mb() of __srcu_read_lock() following the
> > increment.  P2 models an observer that sees the reader's increment
> > before seeing the anchor.
> >
> > The outcome is forbidden by LKMM, and herd7 reports "Never".  See
> > SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
> > which permits this outcome.
> >
> > Tested with herd7 7.58 using linux-kernel.cfg.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  .../SRCU-fastpath-anchor-before-scan.litmus   | 57 +++++++++++++++++++
> >  1 file changed, 57 insertions(+)
> >  create mode 100644 Documentation/litmus-tests/srcu/SRCU-fastpath-ancho=
r-before-scan.litmus
> >
> > diff --git a/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-befor=
e-scan.litmus b/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before=
-scan.litmus
> > new file mode 100644
> > index 000000000000..efa9c0c4e047
> > --- /dev/null
> > +++ b/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.=
litmus
> > @@ -0,0 +1,57 @@
> > +C SRCU-fastpath-anchor-before-scan
> > +
> > +(*
> > + * Result: Never
> > + *
> > + * The synchronize_srcu_atomic() fastpath may end its grace period
> > + * immediately when its scan of the per-CPU lock counters finds no
> > + * readers.  Correctness requires the grace-period anchor written by
> > + * srcu_gp_start() to precede the smp_mb() ordering the lock scan.
> > + * This ordering ensures that any reader whose lock increment is misse=
d
> > + * by the scan cannot have incremented its lock counter before the
> > + * grace-period anchor, and therefore cannot be a pre-existing reader
> > + * of this grace period.
> > + *
> > + * This litmus test models the key ordering between the grace-period
> > + * anchor and the lock counter scan, where "seq" models the
> > + * grace-period anchor in ->srcu_gp_seq and "ctr" models the per-CPU
> > + * ->srcu_ctrs[].srcu_locks counter.  P0 writes the anchor before the
> > + * smp_mb() and the lock scan.  P1 models the reader-side counter
> > + * increment, with the smp_mb() of __srcu_read_lock() following the
> > + * increment.  P2 models an observer that sees the reader's increment
> > + * before seeing the anchor.
> > + *
> > + * The outcome is forbidden by LKMM, and herd7 reports "Never".  See
> > + * SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
> > + * which permits this outcome.
> > + *)
> > +
> > +{}
> > +
> > +P0(int *seq, int *ctr)
> > +{
> > +     int r2;
> > +
> > +     WRITE_ONCE(*seq, 1);
> > +     smp_mb();
> > +     r2 =3D READ_ONCE(*ctr);
> > +}
> > +
> > +P1(int *ctr)
> > +{
> > +     WRITE_ONCE(*ctr, 1);
> > +     smp_mb();
> > +}
>
> As P1() has a single memory access, this smp_mb() can't have any
> effect on the outcome.
>
> The one you see in "__srcu_read_lock() following the increment" is
> there for other ordering requirements, I guess.
>
> Ditto smp_mb() in P1() of 2/2.

Hi Akira,

Good catch =E2=80=94 P1's smp_mb() is indeed vacuous as written.  I'll add =
a
critical-section access after it to match __srcu_read_lock()'s
semantics.  The verdicts don't change, but the barrier now has
something to order.

Will include the fix in v3.

Thanks,
KunWu

>
> Thanks, Akira
>
> > +
> > +P2(int *seq, int *ctr)
> > +{
> > +     int r3;
> > +     int r4;
> > +
> > +     r3 =3D READ_ONCE(*ctr);
> > +     smp_mb();
> > +     r4 =3D READ_ONCE(*seq);
> > +}
> > +
> > +filter (0:r2 =3D 0)
> > +exists (2:r3 =3D 1 /\ 2:r4 =3D 0)
> > --
> > 2.43.0
