Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898014DE703
	for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2026 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070979; cv=pass; b=sQMzyoQ+qKv6ck2RkNhv1cehfZvbFpmYe3bJkh8cMtvxrhIP7YWPAN3uyw/ckNalVxlCgE87Y16I6Ja+DT6/1rqUd1Z79TDCZ89+9ddPK1p6B+r6dMOW/nznA3H7inQGsibR2214Pl46qRz2Sme759AE9f0UwVfjT2APs+nOeqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070979; c=relaxed/simple;
	bh=xCgswTJ/xMHw1lRSMwJ1pqZUnBBu1pooak+t1aa0pNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Eqs8J0vKNmJ61P8keixUNk22bseQnMqZfOOF7HVLupNktYS99AVpgZmf24oWZCHuXDJCbqYDty+REtIg04Pj8w/Fbu9cUxwg4a6tG7RR1xicFFgZfyvH1G/Q+Gi4vyETbOF5dEUwgcwq8/GWOvBKSSGFagO6/5XZNIRSvN+4G5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tr9vi+MC; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tr9vi+MC"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f633ece3so3004306f8f.3
        for <linux-arch@vger.kernel.org>; Tue, 22 Sep 2026 02:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790070975; cv=none;
        d=google.com; s=arc-20260327;
        b=Cz+SQCUP92W13I4pHaYnQDePREj/yHSy9nT3Vihlnh+ihLeEawawGZY19JjskebqLq
         T2xc4HL0UVMgaCTJPHt9ILwSBdtHgE++142eEljmZD0bkRooAoveHkE5KWTBJtkKEeCl
         LOYDxwAhd2diOtvTIkREt0JTs6gDVbtVzTNe56TqOc1x5jfOxJgIHNy7ikGOiA58ZFsz
         PjizfOVc92vANRb2Glqt0yNBg9SgaGrTUgSfYR/L5szOQXVCffNyGLMJ+UZdhptdJZVO
         B6JdnFY7fhK5E9UljTJg8Rv5k5hJCVfJMbSMWJtuU3Bz01dBCgtvhGHYFnllecVGR1AT
         1Lnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mpmxz+siGJavhOivfMHQvVZY8OjM6RnPvSbr/e5q99c=;
        fh=zuYuvaDF5x9i7RenMbhSiyoysgM9EPLAqvkWT/qUVQk=;
        b=Wg1DWL8hDoZNT0Ddnnj9Fz1ERlKdfSXkGyEBOggJdxi1Vckr+59Pw5viDJiZU6tnmk
         yXfkBB/W0G6p2phQ0FTlT39JtnFiWKpkHUPZ0gd/ntEnD5Gh1EF3Si6vMmpMzsNOS1ya
         fTZJUsiCUE9VNjY4NPwunAxtuOCN2eohTch6u6DIF4tE41G6Q4V+LrJFDm6e3cs47wHg
         BxeogbM0mHIkLqz3VbXjzzcFSl/JfAIqVWdtuKfMQB3tpa//6w3zF4tfRCROL1uNPBdl
         m2yamKh8D7wy3wYvQDXciP9Qe0Yq1377E+UIgaZXI+00ZGUdpzMpsgqGvsvxK0W4lhMB
         iFgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790070975; x=1790675775; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mpmxz+siGJavhOivfMHQvVZY8OjM6RnPvSbr/e5q99c=;
        b=Tr9vi+MC1ZSYhmvt8E8gHvXsuhiW+RwZCfAMbQ/4V40afkFLSEiDdizYHLUZ1krG6F
         NP0gUq6QrxFqW28XXdCaJ5zgMyirdsX8n1hmxKv+Kx8SzmZ+ze4L80KNPssOZJ+vc7L1
         PTMwNdkk4tzM9y1AI9cODJIC6/A/zBXFzdJ9Xbi3kP2SBDSsIurfTpY1SDYgbl84w+Ul
         pavxN7mZUSFode3gfihnLcT6/6K2FedIhqX7YbmuZxj/Ou8lbsp2oA1IEaOQ3oChgk9V
         Uh/xXZlxX40csubm46oOVjMci2h31t7t94lSw/b9bv4IMfU5iuogVxy3dpmCbTrAEOUz
         d/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790070975; x=1790675775;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mpmxz+siGJavhOivfMHQvVZY8OjM6RnPvSbr/e5q99c=;
        b=khTUkgqIavPugfMybtzaSIXxi7BPIqp1/zlEzpE+FFwdD8Z4sbWkqf+7ILBY660hSA
         m8oYWt8HvtjOl4UsZGyNWPUcpQ//ZinkMWBp/nOevP5+lTmsP5gzlPP8NaNmTboi8TYV
         oh8VmC5wJFbv1WM938mSRYhvBg+/mlp2z1aNZaSocTau9TCH1hU1DUS0oNsP6CTAr01q
         jgMx+P0YVprphUtRv7J8liZ5lYj/Zri7edNX18wJZ+IW7/U7GRCm1+VDeNUcZeegFvSU
         QAoJww27cFJ3hBjVTnMMBrgV5AXaLdiG01XGlW3y7BSJkTiyqObAjFB9Rw7Nx3Fc2R4c
         FjSA==
X-Forwarded-Encrypted: i=1; AKwUvByiktybV2e9gvkuyl9zI9IX5fYvxUyiaejaTzaLtEkUY3zGa2+f8Q0Zej5c63va7xGKp0GX2djH4AwY@vger.kernel.org
X-Gm-Message-State: AFuF++mtdPFYpIoPIgBxLhdBzDipopqKmk4wMlwkQIYWb/wRqIzVY3yX
	neIWjHJNKl8z2njq0r5uBLZc+ESDv5OXeUIaZD+tOCcbBFa7QpPzHlAqBE1S3S8wqEHvBhqCtGg
	AFzhDqAaB++kaEcAaSg0lxaPu4pvEeQg=
X-Gm-Gg: AYBFou3JiN9KpGDzbZNkbxoeEdEksgmAzO7DyievUYkygHG1BrYg7DgrvtUDWD9LfqP
	s59WVDdgrld0clxSEFA1MaSL2Fzw4pTv+aOBneuj0zmPNIDAfd+O42+8AiOFSeAaG5bl89QtVPu
	yhpQj3lqOcQ687lf89uX9J8JuGkdcHXNh+H9uLemxf1qINRkE/LLENxY38OwQdvI3xP3W3Nq2iX
	+HXTXCKFe0zimp2a6Lz7qoT1PSB6dBZxQY7RSExDW5KBU/1r+JGd8c2Zl79a31CME1OIaUsSzJC
	f5Io77hSRNLUpBPNYOcgjonDh5w/llStCb0MVn/ra35ex8csRCQf0LL62U7vGR9AwH7ygT5Dvt2
	IOKfbgNduCfiHQA==
X-Received: by 2002:a05:600c:34c1:b0:49e:799a:8951 with SMTP id
 5b1f17b1804b1-49fc56aba0dmr207997635e9.11.1790070974214; Tue, 22 Sep 2026
 02:56:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922070950.4173245-1-kunwu.chan@gmail.com> <arIyx4BaA2eArvYM@MacBook-0RXW5>
In-Reply-To: <arIyx4BaA2eArvYM@MacBook-0RXW5>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Tue, 22 Sep 2026 17:55:57 +0800
X-Gm-Features: AcwNN1WuirzzkFb6JjmLl9oXFf7utj_0mv7EZ3p-lcOEdTyD2DTvMQxEs2mG2t0
Message-ID: <CAN_Opa_kZ1bwgVw5k9E2KkLkK1WP3+J_=n8GW2m83zZMwXVEYQ@mail.gmail.com>
Subject: Re: [RFC/WIP PATCH 0/4] hazptr: add shared scan path and lockdep use case
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

On Tue, Sep 22, 2026 at 3:48=E2=80=AFPM Boqun Feng <boqun@kernel.org> wrote=
:
>
> On Tue, Sep 22, 2026 at 03:09:46PM +0800, Kunwu Chan wrote:
> > Hi all,
> >
>
> Hello Kunwu,
>
> > This RFC/WIP extends the current v3 hazptr implementation [1] and
> > adapts the lockdep use case from Boqun Feng's earlier hazptr series [2]
> > to the current hazptr API.
> >
> > [1] https://lore.kernel.org/all/20260919000056.3132131-26-paulmck@kerne=
l.org/
> > [2] https://lore.kernel.org/lkml/20250625031101.12555-1-boqun.feng@gmai=
l.com/
> >
> > The lockdep conversion replaces the expedited RCU wait in
> > lockdep_unregister_key() with hazptr_synchronize() for dynamic-key
> > lookups.
> >
> > The series also adds a shared-scan kthread for concurrent
> > hazptr_synchronize() callers, rcuscale support, and an LKMM test
> > for the acquire-before-scan ordering.
> >
>
> Thanks a lot for picking up this, much appreciated.
>
> Do you happen to play a bit with rcuscale and see any performance
> difference between hazptr_synchronize() vs synchronize_{s}rcu() on
> various configs?
>
> > I tested the lockdep path on a 96-CPU ARM64 KVM guest with Boqun's
> > original mq workload [2]. With a multiqueue virtio-net device
> > (`-device virtio-net-pci,mq=3Don,vectors=3D6`), tc mq add/del x100
> > completed in 850 ms with hazptr and 860 ms with expedited RCU.
> > The rmmod workload similarly showed no measurable difference
> > (1360 ms vs. 1380 ms over 10 runs). There were no crashes or hangs
> > in these tests.
> >
>
> You could also use /proc/interrupts to measure the IPI counts during the
> whole operation, and you should be able to see the difference there.

Hi Boqun,

Thanks for the suggestions.

I collected both the rcuscale synchronization latency and the
/proc/interrupts IPI counts from the current implementation.

On a 96-CPU ARM64 KVM guest, the rcuscale results with
nreaders=3D0 are:

                avg       p50       p90       p99
nwriters=3D1:
hazptr          98 us     96 us     101 us    110 us
rcu             8.4 ms    8.0 ms     8.0 ms   16.0 ms
srcu            8.0 ms   15.9 ms    16.0 ms   16.0 ms

nwriters=3D16:
hazptr          8.0 ms    8.0 ms     8.0 ms    8.1 ms
rcu            14.9 ms   16.0 ms    16.0 ms   24.0 ms

With a single writer, hazptr completes in ~100 us. With 16
concurrent synchronizers, the latency approaches ~8 ms, while
RCU rises from ~8 ms to ~15 ms. The shared-scan batching
appears to be effective here, while the scan-kthread polling
mechanism has a significant impact on the completion latency
once multiple waiters are present. This also motivates the
Bloom-filter redesign you suggested.

For the lockdep workload (tc qdisc mq x100):

                wall-clock    IPI/op
hazptr          ~810 ms        5.1
exp RCU         ~790 ms       12.3

The hazptr path shows substantially lower IPI activity on this
workload (~41% of expedited RCU), though the wall-clock time is
similar. The lower IPI activity does not translate into a
measurable wall-clock improvement in this workload.

I'll update the shared-scan design based on your Bloom-filter
suggestion, make the rcuscale target cover multiple objects,
and add the forced-slowpath debug option. I'll then rerun
the measurements with the updated implementation.

Thanks,
Kunwu

>
> Regards,
> Boqun
>
> > This is still RFC/WIP. I would appreciate feedback on the shared-scan
> > design and the lockdep conversion.
> >
> > Kunwu Chan (4):
> >   hazptr: add shared-scan kthread
> >   locking/lockdep: use hazptr to wait for dynamic key lookups
> >   rcuscale: add hazptr scale type
> >   Documentation/litmus-tests: add hazptr acquire-before-scan test
> >
> >  .../hazptr/hazptr-acquire-before-scan.litmus  |  49 ++++
> >  kernel/hazptr.c                               | 274 ++++++++++++++++++
> >  kernel/locking/lockdep.c                      |  30 +-
> >  kernel/rcu/rcuscale.c                         |  65 ++++-
> >  4 files changed, 407 insertions(+), 11 deletions(-)
> >  create mode 100644 Documentation/litmus-tests/hazptr/hazptr-acquire-be=
fore-scan.litmus
> >
> > --
> > 2.43.0
> >
