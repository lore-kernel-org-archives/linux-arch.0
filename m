Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809EA476071
	for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2026 08:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789548382; cv=pass; b=Z5qxhUjj69lxpcTMYFOl2w56G92XqIxvVs34uUr3628+FW2WX5ebt67KeTsenTgJxb9JP5jM0JkgT7ZZYSOik76urWXcSgCjVTNjKtvDqd7e3sPSN2g0b8WYvkJQEJx8ufUNWl9D+kMZhdP8IyaULVifjeD8BkGq0u8EkfhBMDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789548382; c=relaxed/simple;
	bh=IEjLqaIu8AkCAZFWhjQLI5kBxN9JYLswj17xjaCSYi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWypGQfMbUStPgNXTDkGxvCdCerfxlTedmJnYXXMhoSx4P1qY7614NwLPcYqGDIsvHfzarlBDJCnKjGKwT9CQ3f8zO59qoZ4Jnthc0q3M3iLltpef8s9i1frfVpMCUHDzwn58AVJoInPBPbmqTPOxkx9wgsn5UU/TGTBgjFMD4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2VAZkqV; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2VAZkqV"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so330355f8f.1
        for <linux-arch@vger.kernel.org>; Wed, 16 Sep 2026 01:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789548378; cv=none;
        d=google.com; s=arc-20260327;
        b=sBiwo3O+Vund031C5nz0qS+pDkrkSgRL2f/a1NuDHm8aiJ4rfKiGaTdrQiPVSUfQsl
         51DePlWGzOgYjMi70IBXQcOjzHSa7yaW28u355mFLlG4uKCx/zr3TKMGmo9/ooPhROjv
         HeMSZwQwTsyZZz9LGddGyYLTH7KDmltGPObbqXrEAZATcvuXuQ1GFrPaPKUCRmTu0X7G
         qRIlYBq+KfEqfJXPXWGVCoJ5H5aVzG6pFWpWUju32eWpzsbb7z5iajYME7Xr/IxL8ra1
         UsiUdzPX047M+HciJEje1c+vlbkduDVYw96t2LMC0m/Jcq6JQxL9zK23uyFKZ187fiar
         vk6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rSiQZTcfAtXGEaMMQ863f3u/xpmDXOVO366eO3VYe58=;
        fh=qdJbZaj8HBDO5EDvmIzbp7dKZQV9J3Sm4fn9mz3Sht0=;
        b=BsvvGu8/gwFISQaxGfhMSpyn6XOCIq12JZRmS1q1TNCXxxpUpmSt4Dcf/iQi3K1HYj
         0ydY8OBo/fqkHNRsUIWPHJX+HKjvE+vJIfD73XdFTE+RnvJ3Jltzz0ZSe2tdY3+R/MqA
         3aKUsUwDclSD/9985VI7f49O5EDhdyUqgxPVWOo7UR+zdNEdM9nhaXkJUUP5c3uiSaMP
         kXXlT1hI0SPlagbxdXaYqZ4GVyj6hqzQO338llPZW7gy3C1RqnMBfuQRJ7t9S65cJA+9
         r8t4FhC7Zoi/dKoGTmgZAAPoyCmsMWmMG1jM5GAIfrvwwKrgCuETVI0+fq0mZUhnUusF
         zqJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789548378; x=1790153178; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rSiQZTcfAtXGEaMMQ863f3u/xpmDXOVO366eO3VYe58=;
        b=N2VAZkqV5+JSOZ5Jtm5yk2cmFQ4uand3SrsnCCtlVdELHPhAH7+zEX7mG5O2b2H8NS
         yWytJk3M9UqT9vjsEqVTotaHykKi0YfzH23oPYRqaVxVV6Ne+ofzcsr6ue6+2hYLKOxz
         6smrcezlzJfXxtMgfYMA4TibzlgEP+Rw2I80rXFJc9ox5QyVaJ5do44pQP6lEva3JLzS
         lEYfXQyzgFxPlvwq0fEO1H82LJmxrFy4f30k/9ORaFwOPgd7qHvBEULjq/0o3BChz+SG
         5zcThGu7IeMoAkg0IUetesCseqjVShO1bSEb+qujNls5ss1oCZiiNEn0sCTNZVXpAQgs
         M7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789548378; x=1790153178;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rSiQZTcfAtXGEaMMQ863f3u/xpmDXOVO366eO3VYe58=;
        b=WADWUKRF1mSl6QM9Z8UVnKFULmKWGiPYz0Oo6ZzXD+kCQv0BZ1gyLDAZl4NrIWhyzG
         qxgMOEW9spfA3ImOWAg8S+7PQ68Qw10dWokB4cDWjmr9rB4PsR+a54rf5e243S/Wwfge
         56QtFzOPCFtTXx5UnexhtHGXbRdgwT2F4JRAGRi7dgii3ieK+wctbVgWhpwjiSsslwIx
         yUOHYT+0stemfeppRe6gAV5iNDTIN/VGmFj/IfnBMbS7ViFOu34XhO1dfzz400I0apfQ
         7Xko65owLJ083dt4V0t9b65AGbpsoAn431Mk5gBbyTBMRokNzdouy6PDw0rVO4h3Mw84
         6lOg==
X-Forwarded-Encrypted: i=1; AKwUvBzUrik5kLS+/H2ZAKKgk+oaQcJvheaLPObpGfBtSdlu9W9Nz/qL+GKT7oQz7GOwvq4RyjGlL0lR3kFf@vger.kernel.org
X-Gm-Message-State: AFuF++nSKRFxxowbmsZAjESGEgRqjksm5l6i/2ucujUJHwTWKi82XpfN
	IE+nuAgFznC7CelQ0WIeT0QivxMhCnQqUHSJJlMosFM+sW28O6NfvHE/UxN+3qfsR+XfnKgVOOd
	+6/x6Vc5Cmkfc7PRcM9onJeuYhi60c/U=
X-Gm-Gg: AYBFou1CsspoJQHjcfVeEKFuZdteHEhOP8tbxjwTPEK/tdESgXt/8/MaFWqVIYtPoPX
	6o8cFe+To/Nk04hqaDfvbVR6+c9JKe9kLre+xIItrZygCaVk1xhd9H7hWiF6qkSF9GC3NYaBg8j
	30iWneKUAaHiIdAD0dCxYXkA9//Xxp/y6ACJWVtP1ruf0OfgXhOVf/XlXR7u2iEqYDfME+NW65W
	EtD430iPIJ/GvD9T9PQZrU16ffQ5J8AICEiZRMk+L+I6SdpwENUx12RJIXBPfnGrsOipyQaaLBw
	f78MrH/my9hbmKnmmF2EpDg99gt/E5v4hXSCoNFKTXSZdi2IvV3o8DDda0y1B0mzVrE1omNv487
	yLYF2Dzca5BRkdmOCibga2q/R
X-Received: by 2002:a05:600c:1da8:b0:49c:fc6c:be09 with SMTP id
 5b1f17b1804b1-49eb7345517mr18152035e9.32.1789548378291; Wed, 16 Sep 2026
 01:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914143943.1503066-1-kunwu.chan@gmail.com>
 <20260914143943.1503066-2-kunwu.chan@gmail.com> <9106d07e-a8e5-4379-bec6-eb4ee9f0df5c@gmail.com>
In-Reply-To: <9106d07e-a8e5-4379-bec6-eb4ee9f0df5c@gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Wed, 16 Sep 2026 16:46:07 +0800
X-Gm-Features: AcwNN1X9jYkXw3kugvUA-Sbwd9dezj6tZoTKrloGClMvzUYrftm_f3hZejBHjCU
Message-ID: <CAN_Opa-s-4f_7FRHL_WdUQERP2wZ9N5X5ie0o=DZ5QQektiAxA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] Documentation/litmus-tests: Add SRCU fastpath
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

On Tue, Sep 15, 2026 at 4:34=E2=80=AFPM Akira Yokosawa <akiyks@gmail.com> w=
rote:
>
> Hi,
>
> On 9/14/26 23:39, Kunwu Chan wrote:
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
> > increment and its smp_mb() from __srcu_read_lock(), which orders
> > the increment against subsequent critical-section access.  P2 models
> > an observer that sees the reader's increment before seeing the
> > anchor.
> >
> > The outcome is forbidden by LKMM, and herd7 reports "Never".  See
> > SRCU-fastpath-scan-before-anchor.litmus for the reversed ordering,
> > which permits this outcome.
> >
> > Tested with herd7 7.58 using linux-kernel.cfg.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
> > ---
> >  .../SRCU-fastpath-anchor-before-scan.litmus   | 58 +++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 Documentation/litmus-tests/srcu/SRCU-fastpath-ancho=
r-before-scan.litmus
> >
> > diff --git a/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-befor=
e-scan.litmus b/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before=
-scan.litmus
> > new file mode 100644
> > index 000000000000..e0492a4d8e07
> > --- /dev/null
> > +++ b/Documentation/litmus-tests/srcu/SRCU-fastpath-anchor-before-scan.=
litmus
> > @@ -0,0 +1,58 @@
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
> > + * increment and its smp_mb() from __srcu_read_lock(), which orders th=
e
> > + * increment against subsequent critical-section access.  P2 models an
> > + * observer that sees the reader's increment before seeing the anchor.
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
> > +P1(int *ctr, int *x)
> > +{
> > +     WRITE_ONCE(*ctr, 1);
> > +     smp_mb();
> > +     WRITE_ONCE(*x, 1);
> > +}
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
>
> Another knee-jerk reaction with exaggeration  :-)
>
> Why does P1() have an access to an un-shared variable x ?
> smp_mb() in P1() can't pair with any of other thread's smp_mb().
> This doesn't make sense!
>
> Let me rephrase.
>
> Litmus tests is supposed to be minimal.
> Every memory access and memory barrier is expected to
> have some effect in the outcome of the test.

Thanks Akira, you are right.

>
> In this case,
>
> P1(int *ctr)
> {
>         WRITE_ONCE(*ctr, 1);
> }
>
> should be good enough, I guess.

I'll change in v4.

Thanks,
Kunwu

>
> (That is, IF I understand what you are testing here...)
>
> Regards, Akira
>
