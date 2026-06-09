Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671733AEF30
	for <linux-arch@vger.kernel.org>; Tue,  9 Jun 2026 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021845; cv=none; b=SDQ7HcRCYxAzsB27z3d1zTFjAhtICGBx3TW4vhzxL6JJSzM6G5iGpOoL/9iPKsM3uLMB1QNJdBwdPFMjXzhwImjlJ00wgeSPwDUzM/sxgzWWn+DOCqWwe5sImgFeBVTsVzI6uU555KGS+KEvSm6E8xaseLiY3Zmf8PjG74mUUc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021845; c=relaxed/simple;
	bh=a7BaPzoHrLNvlTzQBa0bT9fKKRLcfCtzz3ZaV4BUbR4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GDDO8A3mx7IZoNHZeyg0wx2m9DL4r15QbIuWaCuIuRmdczfYCaozDKm5WL9g7tYIsGdlpBrAkJRB0EhOrv/Nv166qFC9UOsFl7qQU450SSmPup6niVQsLVQ4NOn6TNWQ9vjUfGSIpUpcwbH2atj+nsfjsxtDdJnt4xJJDHCHFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoN07nQY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DIPfDj5U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoN07nQY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DIPfDj5U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781021843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7BaPzoHrLNvlTzQBa0bT9fKKRLcfCtzz3ZaV4BUbR4=;
	b=MoN07nQYZ9dnXytcDSWB/OOJsxg3NDVorIFGnmbB/2jxQXdQ/GYu8QWQvXjj6P2EtwaRog
	COvU4a4CrlQw1bhggFQ5/PG4sD+41zZ2aCTRuT3dH5EUKMrGa7P11J3iL1R+LixGmeHzcq
	thLL4kuy18irv/e6gVMBC3AKN3zF5y0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-mfDovKy-N9-j-LoB1fqqkg-1; Tue, 09 Jun 2026 12:17:21 -0400
X-MC-Unique: mfDovKy-N9-j-LoB1fqqkg-1
X-Mimecast-MFC-AGG-ID: mfDovKy-N9-j-LoB1fqqkg_1781021840
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef4931de5so3336016f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 09 Jun 2026 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781021840; x=1781626640; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a7BaPzoHrLNvlTzQBa0bT9fKKRLcfCtzz3ZaV4BUbR4=;
        b=DIPfDj5UaiSYEOpAjhvpAeT2bzP8scfcR6fD6GtkF/Tn9Qtm5KqWJ+5giIREsE2Qhx
         LJT11ZQxu57hvwiO9FSTZTzn8ZuyjXkwdk5px16PxH8bzSohzLDRslXWtnOqyn/Zxhn0
         pthFT9pYBcwk3onIvP4in6TPPUa1D02q9lpuX6jHtl6d3qdAMexMgRqlAQWfngllL4x5
         RMzQb4GK9NJYsgoqwCvbaFbF4Nomp1+au/6A+/KPz5sAz8W2m6Dwu2EP6St5jdtKZ0uB
         yhrhLvMjCvhwdbY/vk+Mkrk0oNVtJFOfsA5xRyMOuKloatzfr+9F8O+Y3hj09yhV1Ah6
         wGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021840; x=1781626640;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7BaPzoHrLNvlTzQBa0bT9fKKRLcfCtzz3ZaV4BUbR4=;
        b=NSD7HSDGQ8zRy/4eVXcbhn37vIeTTxn5TFw69onnMvKj6M3zKLC2JyDyBL68Y2ByQh
         eqYX33QvBaortchOjgLVQ7XIkXeUZ2xDfqGxT2ZIAGQhoJ9zI8gIy1Vmw2urmpGY2zGB
         m+4SIU8FlGGBxSu74FPVJvZRCqBQ2VegYOJ8tUzEKCtGAMeatZoIuMwtObnJE/bPnuF3
         H2E6XVHZ3ys400pnsnh2SzYIfXhDuz3juEwdlIJWzb0JFi8a8+TZeRd2jMd7qsqKMuWt
         Ngo7bD7NxKw+T03wHbKGgJXoOd3HiuKu6Vi7akON7es6gWG5eINTAicUIuq8UuRzA0Jv
         PmXQ==
X-Forwarded-Encrypted: i=1; AFNElJ8v7mqoMTaiHxh1fUlu6MXfhBOsw+7zsX4xyw1/3C+Zu3PM5yER27JTDBwatjI8jY4X/rfaneV1349r@vger.kernel.org
X-Gm-Message-State: AOJu0YzFEBT34vfjXpmiOFyghgRpMBHNZ6u02vTMuhlb3BRJamLwnqGL
	4SXOszF9CznmFp3lOjtPKDAzfBle1LsEtm1bIK6bjLiEjg9pRn+sNfxV0Qfd7LLGkIK1wNOp3oc
	9hx750uyOX3aQvZAM7wJwHJOBBOr024jSZpMS4NsWuRif5efdAJ6OOPBTRZDyYdk=
X-Gm-Gg: Acq92OH3lufzVXjjEmjH8d3Uc7UmWLj9dVeC8lf94rrn0aoJbE5CiFVX8U79nuZ72HO
	7KMoHf7sk9T09PhwIhVs9N4rFzWVP82w2+vO2a3HmAwDi1IRz/QfpcH4JCtv96DDZ2W95r42eUp
	h15nQ6g+Cetu1qreZsx79PWkJDet76SQQkMXKeb9TkGdk5wiqMxR0fomLzgzkdjkpg+Avk1vf7+
	mGELtld+n8syGT/HGS/oh1SzUIYOma6NqA0hlOjo5r56DQAuymP8LOHFTUYEhLAlesy+LV/IaB6
	KN1YR/FK+MgaXUwAadCXcACGjBeMMCQydr8nL023C3kNULM1AoZ+CwJMSU+h1ueu88wQsowaa6R
	cNFQ/y79P/bt1agLvGgLTDA+O5HZsHyS879T1
X-Received: by 2002:a05:600c:1986:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-490c2cc27bdmr286472415e9.6.1781021839834;
        Tue, 09 Jun 2026 09:17:19 -0700 (PDT)
X-Received: by 2002:a05:600c:1986:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-490c2cc27bdmr286471965e9.6.1781021839417;
        Tue, 09 Jun 2026 09:17:19 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm532407115e9.8.2026.06.09.09.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:17:18 -0700 (PDT)
Message-ID: <b9562bea557a68981b6a9400ec33072330ae621f.camel@redhat.com>
Subject: Re: [PATCH] rqspinlock: Fix order in raw_res_spin_(un)lock_irq to
 allow schedule
From: Gabriele Monaco <gmonaco@redhat.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Arnd Bergmann
 <arnd@arndb.de>,  Alexei Starovoitov	 <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko	 <andrii@kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,  Linux-Arch
 <linux-arch@vger.kernel.org>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>, Waiman Long
 <longman@redhat.com>
Date: Tue, 09 Jun 2026 18:17:17 +0200
In-Reply-To: <DJ4LJ3T8PYRG.3TG272FHH78RM@gmail.com>
References: <20260609094941.56122-1-gmonaco@redhat.com>
	 <d40ba64d-78d9-45f5-99b9-4bfb1fc27f6c@app.fastmail.com>
	 <defc6b1339dea2f64f936902dd6e1f850cff9f4e.camel@redhat.com>
	 <DJ4LJ3T8PYRG.3TG272FHH78RM@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-09 at 16:42 +0200, Kumar Kartikeya Dwivedi wrote:
> On Tue Jun 9, 2026 at 3:04 PM CEST, Gabriele Monaco wrote:
> > On Tue, 2026-06-09 at 13:22 +0200, Arnd Bergmann wrote:
> >=20
> > > Did you see this cause measurable performance problems,
> > > or did you find it through inspection?
> >=20
> > I noticed it while debugging an ENOMEM issue in the test_maps BPF
> > selftest on PREEMPT_RT and this was an obvious cuplrit (irq_work
> > not scheduled during a stress run). Turns out the problem is still
> > there after this fix though.
>=20
> I would imagine this to be the least of your problems, I think
> there's a bunch of blockers for complete selftests passing with
> PREEMPT_RT support in BPF.
>=20

Well, I'm starting to believe that too..
At the moment on well tuned machines we are only observing ENOMEM
issues in the test_maps and only when it's literally hogging the
allocator (preallocation is off and 100 treads do updates in parallel).

What else are you expecting to fail under PREEMPT_RT?

> > > > Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> > >=20
> > > Acked-by: Arnd Bergmann <arnd@arndb.de> # asm-generic
>=20
> The patch makes sense to me as well.
>=20
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Thanks,
Gabriele

