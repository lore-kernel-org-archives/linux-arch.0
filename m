Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794501749;
	b=FTuv1AqIF3qeEiBTttiDLnEjhaVYnQC9rj881tTj8zNG6MnJ+TZdl1VvBq/SGQaSbLRL
	 02QgNMm8xAYBW6TJv+oVRZPFEJGEL6rESYiZkukmHhmlLg3rqgZkqrkDvcc+MpN8Kz/A/
	 dXEcUhIcJOCMzjJpivEzOjES1/rgex10ikQvddG/h3bCuuuN+neg1PgCyvVqkmWmb5Y4H
	 87yrFIsA/O9wE++E47h+08R5KxkGVhCwNLeJyfFrGYonACvUaygDtals1s82nfTEwQfyL
	 ytThJV6fUMPI2z5AkN15XPAr6IGZ39Nmd7k8y5VblEdK04XGiNG+nGwVT9mO0dyCG/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501749;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vb58UL1JBDT0YchS0QVq3Od5hTwaDV5G0mFqoEfJZkE=;
	b=3ALmb1sj6ILG82zIGkLITQCYAygf4p43D7dA0D4ol0MypqwOGN6oBzV51T53HjXXGo39
	 JgGu3oBS7RR0OR73fj3qokGFZXTdxpTFPXYxbIGjwBUpdnu9sn2A8MSOd7eACoL//TLYi
	 TqqrHsPoebEkdG0pIalX6uEMswHwiAbCf+LyDrccZUpTVFIbR1nK8FXouXYGTfe9pA0Bf
	 sTy/IHM+TY1up3DnTQHofWzPpkDjCUsdaxSuI5qHzO4DiFKtlf+R0BRpc8ZDMvzUJjeIN
	 z8Ql3Odv/+CkTxe5kCo8vAgQtBpl2qFqe8dS95/wAP0ifXhqe4TuKO1N+3YS/vV90ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=etvsK4IG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53EC606A32A
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 16:42:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D53EC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=etvsK4IG
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso32927185e9.1
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 08:42:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794501747; cv=none;
        d=google.com; s=arc-20260327;
        b=oi1b9m54pk/TV6BsyoOkU9l4Ht1lwh+Lq1nJm7AHJNsH54iyp0ceeZPEB1ccYZnYHt
         TeYgmnDxutHYn9uS6sOu3J0Ssy4q3543Lz5pxy/pwbMOkJGLysBT4xkCar/IO+447/6U
         CVEUsBkjwtercSh9+mttDQLPnuWWRVqw3KRH5WOp6Q5hySGZXEG/lnuPwdBH4Qv4LM/z
         IiMBDYD9HYNHY19vN2BLbAJsDT9albAn3gFPDpRhQusem10xQH6RP/qScBr26dvy79Hd
         uidMI6oaD8Txq72ox/Y9R7H5r36AXo3aHX5u2gbM2NjJOCowt4T7GTzVLvqVCA9Tj2Be
         1GnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vb58UL1JBDT0YchS0QVq3Od5hTwaDV5G0mFqoEfJZkE=;
        fh=L1dhimjqDvPikW9oVCeYMiCI9oMkzG12EOoE1O+bfvM=;
        b=EnwWJuNLpDi7uBCv9X0+VunOT1pjz/34Brx7U5eyk92Sr180AY9m1woiN/Iih2hYRB
         fCODx7cHhhdty1VDEZxPJ8tf+frd/z+ZjF5IIhPfIJQzlxHtfQuMemzzuyBgxKgi1LfW
         S06eIHMZbLjZw6rULwgVskSSR1P0yxuuW9/TIX5f+YeL6sJCb2NjKOxEngnRyUeKlC0Y
         g4tNjsz4CwNRiWM7uMcUkW2IIrhRfwF75VwKzPX9W7soD3BOs8/57DAA7mFUBdlo/Xz/
         KxOCV1ePcb3v+Pgoe5XuwVpjCnntOXpsI8d9iRWvm+89uq9Xevrsb8dbGk05Q8gyhCpN
         dmiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794501747; x=1795106547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vb58UL1JBDT0YchS0QVq3Od5hTwaDV5G0mFqoEfJZkE=;
        b=etvsK4IGKtC1tmmWAGvlMBJDCobivzoekXoqFKuVsVWyGu8lShV/ecQ/M5I17JaUlL
         GIgJYMp8UmzWyFSoNcGMefWzA368T6y84Dl1UkNYt0uoWQZgdBdZG/Aiwpc7CVTIhAF/
         0JQFaTCfa2V+RNlaKbkn7+i4NAyorYBX8ybqJH3XjzPN9VMak9jeuoTXVavcz/TXTb21
         FaF8VhxNqyxbBZju9qp2Ln/N+5T7gJZ/RicqGc8poLGUIGAlMT1edOhRdpffMJ38j6/6
         qtsYNESSzPCd2ar5kLu/sN0j0+3cPO20UPb5V2eBQ/lZWth2IIrqyP4VOjINWfuUb+5N
         qDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794501747; x=1795106547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vb58UL1JBDT0YchS0QVq3Od5hTwaDV5G0mFqoEfJZkE=;
        b=Z3tPP4+8RIC/yXXzW803Xnaud56C7NeBklN8TPVgH+Bcd9LIPACjB6xzD/SpEPS4JL
         6DZqqVgEerJq8VkTO9ASEKRve+BaCZYb0AP4Js333ggAY0642/xV2xkydo5BTqVxP49H
         AwLeEXw/x2MS5Oo3bypWUaXJbW54qXuL90ShW0rPQ+clH0we97cH3e4WqJguQgYsejEy
         AoBFYyP/yI4tC98fnGGINUPNc3UTVPccvARxXjXqiLU/9q0sNlBeHxZdHJx3UlAzTWaQ
         7FNM1E1Ua/3OxIs1deiEoppRyujwkgH4AcDPqtjc9O2uPaLHrgAJDzxvfMwdVfQ1+8tW
         k/Ig==
X-Forwarded-Encrypted: i=1; AL+hErHghaogK9MCKByBnvk22xf9wio8/Vo7EuCVfScXoLTUqLdXVEz9mABy/IteSp2YJ3CGOuItuYYjUTLo@vger.kernel.org
X-Gm-Message-State: APuU4Z+rmEuMNPmsM6L+b5V1+P8aYXRX73EpR3rZ9pxYcgOHhr67+mL5
	pXxuie6ZflIN0/VVF5mZHfTUetjolG0ZupyOB7xqo7p9hgnAFk7fG2elyMJdZGmn1vXfkDBVNrf
	g5ztZNxULSYOmN1LFwgPdZS8ebLKfKHg=
X-Gm-Gg: AYBFou3xqfKWOoOhEvBfREyICbTVKTG3NjLp089NKAn0ggl2pWgc3VVkr7w8cR7kDYh
	yRQ+PkCmLf3p3GK759MEwiiqIDUhJV4u7PN9khUBVFUOv1/wNC+HJXDtxkkYNulysx1lgwzgMCR
	MxLnshZtVMDuUcq8teknMea4yrvlH+S8iRciR7XaFr6e/ng56OMsi/zgmDhDqM6BwiTA9qNB8xT
	4PI/NbUxdFgJ4ShJf4MSF/IKbML2jh9FjNzR/k2inh/qOuindUAlmk6pkMMPdazqX174ZumS0Tc
	rQV9kNTSkx7TFJODUayF5EH7wlxiu3zxyXcMXThqO/918M7oTxibb/AeVQ3UryOU12Axe/0MJop
	sL6clbT8NQJqracr1O0+mRF9jkTvKOP9byEvJ8tc73txo8BTiDK0EdoNZ75QB9aiODuIgpw==
X-Received: by 2002:a05:600c:310e:b0:4a2:c9b:9b98 with SMTP id
 5b1f17b1804b1-4ba0936d857mr116824585e9.17.1794501746962; Thu, 12 Nov 2026
 08:42:26 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
 <20261104165504.2430480-26-kunwu.chan@gmail.com> <1c2eff9d-213b-4ea2-9905-a054c6d40d97@paulmck-laptop>
In-Reply-To: <1c2eff9d-213b-4ea2-9905-a054c6d40d97@paulmck-laptop>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 13 Nov 2026 00:42:13 +0800
X-Gm-Features: AclHuK_5dn6ii1XkN_5ubWft1GmD866Yv1veX15FudsEky0EOAdtZ7tnwYRl5R4
Message-ID: <CAN_Opa-RGS=5kTnMVsj6KE=xCLS8aB=dYSqee7DuFeQ=uvDHKA@mail.gmail.com>
Subject: Re: [PATCH 25/28] hazptr: Select TRACING for HAZPTR_TORTURE_TEST to
 enable tracepoint
To: paulmck@kernel.org
Cc: boqun@kernel.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com, 
	corbet@lwn.net, mingo@redhat.com, frederic@kernel.org, 
	neeraj.upadhyay@kernel.org, josh@joshtriplett.org, urezki@gmail.com, 
	dave@stgolabs.net, stern@rowland.harvard.edu, parri.andrea@gmail.com, 
	will@kernel.org, dhowells@redhat.com, j.alglave@ucl.ac.uk, 
	luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com, 
	joelagnelf@nvidia.com, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	longman@redhat.com, rostedt@goodmis.org, qiang.zhang@linux.dev, 
	brads@mainlining.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, lkmm@lists.linux.dev, linux-doc@vger.kernel.org, 
	rcu@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 5:50=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Thu, Nov 05, 2026 at 12:54:43AM +0800, Kunwu Chan wrote:
> > The hazptr torture test registers the hazptr_waiter_enqueue
> > tracepoint for its hot-address scenario; select TRACING so
> > that the register_trace_*() API is available.
> >
> > Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
>
> It is useful to run the torture tests without CONFIG_TRACING=3Dy in order
> to quickly isolate RCU bugs that tracing related.  Is there a way to do
> this so that people wanting to register tracing can do so, but so that
> it is still easy to run the tests without tracing?
>

Agreed. Only the HOTADDR and LONGHOLD scenarios need the enqueue
tracepoint; the other hazptrtorture scenarios should remain usable
without tracing.

I'll drop the select TRACING changes, make the tracepoint-dependent
scenarios conditional on CONFIG_TRACING, and enable tracing
explicitly in their scripted runs.

Thanks,
Kunwu

>                                                         Thanx, Paul
>
> > ---
> >  kernel/rcu/Kconfig.debug | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
> > index b500e96ea1c1..8fc6434a05d1 100644
> > --- a/kernel/rcu/Kconfig.debug
> > +++ b/kernel/rcu/Kconfig.debug
> > @@ -27,6 +27,7 @@ config RCU_SCALE_TEST
> >       tristate "performance tests for RCU"
> >       depends on DEBUG_KERNEL
> >       select TORTURE_TEST
> > +     select TRACING
> >       default n
> >       help
> >         This option provides a kernel module that runs performance
> > @@ -42,6 +43,7 @@ config RCU_TORTURE_TEST
> >       tristate "torture tests for RCU"
> >       depends on DEBUG_KERNEL
> >       select TORTURE_TEST
> > +     select TRACING
> >       default n
> >       help
> >         This option provides a kernel module that runs torture tests
> > @@ -102,6 +104,7 @@ config RCU_REF_SCALE_TEST
> >       tristate "Scalability tests for read-side synchronization (RCU an=
d others)"
> >       depends on DEBUG_KERNEL
> >       select TORTURE_TEST
> > +     select TRACING
> >       default n
> >       help
> >         This option provides a kernel module that runs performance test=
s
> > @@ -117,6 +120,7 @@ config HAZPTR_TORTURE_TEST
> >       tristate "Torture tests for hazard pointers"
> >       depends on DEBUG_KERNEL
> >       select TORTURE_TEST
> > +     select TRACING
> >       default n
> >       help
> >         This option provides in-kernel hazard-pointer stress tests.
> > --
> > 2.43.0
> >
