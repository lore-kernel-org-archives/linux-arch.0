Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B569240BCD0;
	Tue,  9 Jun 2026 13:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781010549; cv=none; b=NOkrfwwZrJvfc++gCMUMNbkii7btQxPgqBQm8TcP7Whd+qjX7M2sXRr14Khpj+7IWJfQFWRueJqEvi2YSMjxJdiHar5Wh+RF9Xg5M7D/hYIOphIPlqQb8JCK0sEJS+Ko/FZlZjh68fyGLs+2rC0BB6u+YEAstS2+BLV/kJWqeaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781010549; c=relaxed/simple;
	bh=1WSdNihG2hlHtswr5nr1x4M286nV1U00IzeEXjGpIR0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qsSxFUo8kweRL7fiePsTJVwSGy1tnjU4eIQhr/6iyHnT47jCJtDoo+H5Rc48S24zAdncsJoJU17wjm0YZOwjSXOvpgf6JxA97hM8N9esMa1i5dHfaW69p7K6IChD/2LXrXxq56qBrUoN+MNvVtQVm7k6OvMBaFl1mR/A2ACMw3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=MW9rMPso; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jylBLqej; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="MW9rMPso";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jylBLqej"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 732437A018A;
	Tue,  9 Jun 2026 09:09:06 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Tue, 09 Jun 2026 09:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1781010545;
	 x=1781096945; bh=c16TIIba6yuBUv6EB0M3c/VoSio+y6VjjvsXrzOnibk=; b=
	MW9rMPsoKoiFfm0qtMVt+DX+xVHKXV70e02B5oBFiHNRsNwZrbLjk/d8Bhc69/I2
	ewCEAqmluDmaFmtvthEKt54q/mlESWSoEFhANe5jI6ZweoQ4BOEcYnQO3W3MIQCm
	HURTseqM3dJ2LJ8ASypmbLnU0on9jZn4Z9dItliQee79a+HDrxE4qtdGzTWbroox
	kzDQp93XCOfx6d1RPYniTpvo4zH1dwrZcmA2M3fmNwnIN5m+mVuYjbIPIS3mhD1c
	wJB1Rm4v8mc8J5Mf9LJnB5XUFAI2lRul9W1StfCGu7ExfRzumExqvmpZjbMRGXVF
	Hpe5UyJ5Jh4DhacMrD5FbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781010545; x=
	1781096945; bh=c16TIIba6yuBUv6EB0M3c/VoSio+y6VjjvsXrzOnibk=; b=j
	ylBLqejpG9Ou2+ga3UlNNM99QtZx4sERrtN/8OUv6s6/EIrDXVSQENGrbCvptSLZ
	gfjRtVS5WGB2BEkJJw6o6NLQeZfYwO9DQoe015cuwZrDHGbF6l/2ov3zcv7lZ5gY
	77mlVV9zApOVCImRolHmkZ2yiFt4EXrGaUxV9qfzshHLy37BaZLtmDhhjviB/0Q4
	KbNwzksSkRrBAjtDZ1pf0Ev1+pbSP1FwKjfcrr/kza4e2ArRgmTNiAYf6UYiXeim
	/w45fRZmmdyv7a2LMGSi/42Cksnez7NKHXByzcmCg1J/gvUT2cxDJ5fF04Vl7VHZ
	j7cBsg/ktjP9MyRfelumA==
X-ME-Sender: <xms:cRAoaiuKTQRkuWlVRKylznAsNYOYdxb6hV6bPVkTYTle5RGuKiRElw>
    <xme:cRAoaiRKWQQWzUHtEwM-r1xKtKq90G_u0cEviw1aI5TMIZmBYzo3s7KIC567aU9lx
    e18nkQFo90PsTHz6rInSW32PYo5ufhwg04ODHRdHyEIqQTR-iAM6Go>
X-ME-Proxy-Cause: dmFkZTEwzBbeWbxPV+DtJz9wRCnV8k+/6ZDn2QjQhLonipiml/WF3aer4F/DbgUhyyK1NJ
    LScwo6GMYWASD/eDzamCqo1/6MwTEuDrkaq7kWT7QfI+u0PaO6TIgZ19kztRYd2HDBKN8s
    KhQTX8yo69eMjItZcw/PDFUTgX9cAhoBsEVAfmgVxuzaZrqz2qNOfSMFAZGfMGXqzUEIxO
    ilsF3+Zo75C/UaarYQiNPwjtPBnUz/6sBJfBNMGFPLw8FTDZRGImg0W+ThKhsP610ZEQW5
    CweZ9rw/lFg94glbaQ7jSLX44Axvy3zWQWjnUTFcJWrj/lxTues7A7SyBHVAa6nPx43CBR
    G9mPUcEXyVUytvgj9c9U8ji5pBmwJj3CBqxxWs4iTah3paJMDmtUONT7Zb1p3Bu85hpMRF
    75gBHBVhFvICGkGsQ6vlR3p4wLw+HUh8ocq70GOmx636liEYXd4L5ts/YBibdGLYEqmEdl
    udL64vghK8GB18fjHfmgW4axKgILWC9MJWp7yPrb0n11DNJ4X9/01hE+xsnV5a9YTTMWEj
    mBLFKJDacJDkjGwZ9valeurnbq91Dr6Q5F+cGTAkHIgcN3nCoqNWlVBdV38m6488+R0MCo
    zgVewD28jp864oQb0PRQNM/+dvC9Tk6LYKvlwsAP/q+jdxeWXoWfS0CS7DEQ
X-ME-Proxy: <xmx:cRAoal95xTFS3dTlcRx9uksCnjpFBz1wL1ugpyfXb4yKAXoDSFyeKw>
    <xmx:cRAoamGHlCIKLxjiNckY7h9PN_e89pvq394EMpfEfhwiqMoRaE25Rw>
    <xmx:cRAoandbBlnSjnVd6gmtzK_TBwtpOoi8O6gx0VdPrLDJzGzbQXOwKw>
    <xmx:cRAoannwyqjdB56GmS4eFHpolCX4XkK3VFjwVGuxySYTuEacCDSi8Q>
    <xmx:cRAoas4WpQEgqSkdqcT5BFu8DeHeBiMgEoqOSa5M8Ggd3U3GVD68ZE7X>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0F4191820086; Tue,  9 Jun 2026 09:09:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ANX22ru2X65k
Date: Tue, 09 Jun 2026 15:08:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Gabriele Monaco" <gmonaco@redhat.com>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc: "Peter Zijlstra" <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Will Deacon" <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Waiman Long" <longman@redhat.com>
Message-Id: <caa4faff-68ad-4601-9f80-68551b015615@app.fastmail.com>
In-Reply-To: <defc6b1339dea2f64f936902dd6e1f850cff9f4e.camel@redhat.com>
References: <20260609094941.56122-1-gmonaco@redhat.com>
 <d40ba64d-78d9-45f5-99b9-4bfb1fc27f6c@app.fastmail.com>
 <defc6b1339dea2f64f936902dd6e1f850cff9f4e.camel@redhat.com>
Subject: Re: [PATCH] rqspinlock: Fix order in raw_res_spin_(un)lock_irq to allow
 schedule
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026, at 15:04, Gabriele Monaco wrote:
> On Tue, 2026-06-09 at 13:22 +0200, Arnd Bergmann wrote:
>> Should this be Cc:stable@vger.kernel.org=C2=A0to get backported?
>
> Not sure if the Fixes: is enough to trigger the automation, I rarely
> remember to Cc:stable@vger.kernel.org and they're usually picked.

There is always human interaction. If you just have 'Fixes',
this means someone will have to look at the patch carefully
and make a decision, since a lot of bugfix patches either don't
apply to old kernels or don't fall under the rules for stable
backports.

If the patch gets tagged Cc:, this means it is expected to be
backported and needs less manual work.

> In case I guess I'd need to re-submit the patch right?

It can be added by whoever picks up the patch.

>> Did you see this cause measurable performance problems,
>> or did you find it through inspection?
>
> I noticed it while debugging an ENOMEM issue in the test_maps BPF
> selftest on PREEMPT_RT and this was an obvious cuplrit (irq_work not
> scheduled during a stress run). Turns out the problem is still there
> after this fix though.

Ok

       Arnd
