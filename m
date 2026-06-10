Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808F34CFDD
	for <linux-arch@vger.kernel.org>; Wed, 10 Jun 2026 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781117675; cv=pass; b=t4oVRwCsLOpRpy3Czj2iDFAso8muso49cY7bb6OwP/14EZseWfKw9uYk0BxzHQTy/u92mGy2APFC/fhawuHYDVfBtGsZVpmRRxr/QEjh+paxzoLATV5kFzFiDjwrdh7t0gCnYeIOg316MuSaFmE27/lREEXqetoeXx+nvCCq9oc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781117675; c=relaxed/simple;
	bh=cgzuUt7ncEeJkZLZeGVj0VRwA/zEB/YALvzUchYaIoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oy1YuLE6SLfKXIiEhMq/27qnwM5F7d5ayF3B3qWUQ5fXUwPJ5KJIfQs4ZoaaAwLNRQe12jfuW2PQMcmMfhtjDYgMlPMafbwvynXNxWZExTH+HIf92zHzbNSQspNr/Rwom1Bh9+NYf0xJKUxXC3/7SOFzLSTaEZ8qdWVEHHXBVBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sbfms+K0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tOW4RCny; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sbfms+K0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tOW4RCny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781117673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+HrgbQKgRjgYI+/QuG22Ke3UaXcF24qAYTblaPDHSWM=;
	b=Sbfms+K04d8KLVzemBg5WCQyPGJRVi1qRHsGi5mH7WO5JUaydfZZPYo7a1JfXNFjK6yQ/u
	d39eJnlKDSUtW2ZPx+MSvCsMPuUY9JH/FRPo9mhjevjYk8NvJcBWnQyYJNnuoTrSTRx01q
	hb3WPNGWZtlzbwoAjtlExxeytOMRLH4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-QZAZ0WbUM_eNmp0LrvDZ1Q-1; Wed, 10 Jun 2026 14:54:32 -0400
X-MC-Unique: QZAZ0WbUM_eNmp0LrvDZ1Q-1
X-Mimecast-MFC-AGG-ID: QZAZ0WbUM_eNmp0LrvDZ1Q_1781117671
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-bef1e83c990so688670066b.1
        for <linux-arch@vger.kernel.org>; Wed, 10 Jun 2026 11:54:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781117671; cv=none;
        d=google.com; s=arc-20240605;
        b=WagU9OfoD5SGU1+kquqjWzZGXkLANdizcJy1AxwStcX4vhlv3QK3Et0UXxVY7wDnTB
         wyu8an48S+719OVz9xabilPun1yrKfXsaGSc19fVnIjAimFMwvKKKKCZDmqpsr8VB76s
         2RfbkDpYRf02RW7AxD3aIQiEv+dGpc7GbAVVWPGZhg+EXMEs70eqrsDvc0+OP3rFLXYO
         so8HgepDm7HBYvXhPFv31qilinrM6ved2mMUc1meSWbjFxwPooHTb8nBbTwQVHE0CEfe
         qaQNDbVWDPW9Jj+i39tyKPTHKj6qDQ6YLbNcmn7kdBi2wQ5pUUA6X7c1HYYDQzOVJs9E
         HlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+HrgbQKgRjgYI+/QuG22Ke3UaXcF24qAYTblaPDHSWM=;
        fh=PGAXFCL5WQeZ1rp5Am2XTcTT4dkhSepRf8+uMTxDlHE=;
        b=ZrjIL3ytO9XHw/QK09rU4+CYrmEV+vm+dRs3vLuiTWwaWRBqtO/HT39Uap+lYWE3SB
         xQQvhj/VzR7VQotJDecjEKFo5TsqnUBjr+VdiYjNBT9DIo7yAj8hMRRIicelSKyUEvVV
         rvecEa1SYqFn50Cboou13vfoFuj6H8pTi+Gp3dXW/gTY9/obKD+BQcli+3Vi7R8NT808
         1UrFu7Bm0rQstVlqyN0R2ym358UC+sVcegdJCZujKQJqfn+YMp1AcPgpkR+LYhTdEc3P
         EnftJXRfwhgzWXo/f1RF/GgUVYCuy6htPEIRmhdBwO1hTNtgs5hico7tXQi9FppGp1Vt
         fSVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781117671; x=1781722471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HrgbQKgRjgYI+/QuG22Ke3UaXcF24qAYTblaPDHSWM=;
        b=tOW4RCnyFlEaohLmX5QR+WpT2b9Xta1HFreSYoOJYb2Hx9UpDGOIohTrLAkgk4LTgp
         CxeVQsZQzt0y4SQQM9vOdcu2RLROqiudXaeob/dLrwQAI9p7XSNPWD+O56svSO8vvWZJ
         DgkfTlMSaF8Jv39S+iskGaoBTZXfgfqrRZHrGCClh8e9EYjNZ8l9500ASDquPBWdLc0R
         ALNb08nJbUcJORy/WJjTDF1TDiNOri2+wCwTx1VBtG6OXs3sSIIpgc4gXSAfoRNxts8S
         SP3phOMBFVHG4eKkljCSr+GFvBPqCrUn9L4tNEckxltXb+qSP97zzU4InBUAHs4l760D
         +RIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781117671; x=1781722471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+HrgbQKgRjgYI+/QuG22Ke3UaXcF24qAYTblaPDHSWM=;
        b=IY5gW46GqTdrkjPSHHpaxbZgcbw/kzc7/Twbhx15zb5L4CEyGp+C6tOlZFlM+G24nH
         +LbUgcptJl6tdirgOXHpe7DWCDL+ei7PTkYj4UfCgYNcsB77FwUyWlgTAn4bLLfkgYLA
         X7Chg4e66knYyyp9miPeYWneb5BGQ/hoQ9cOEcF8Hfz3kSsa9T3+c8IVgaFHou7y9aKm
         4wgVmUk3n6q1xHagEsNy3UmpTTwqFAjiEJl2LUUmH7bsVyhT6rtxFFEYUDV2iqebuYUo
         8EeCwV/5EZtM0S6URLByaG7RDK3UEwG2P1YTPWiB3Lg5V35I+1DNsADeob0Gk+wEMCus
         y6Bw==
X-Forwarded-Encrypted: i=1; AFNElJ8sULVg+mFiYIohLekqUTAn2diSHOXDybStvolpP7aAdY1phZyY5uMxHVRCfhDf7S/Vakch58SEW+6j@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5nlZ1z8CWzBBpdrpMneYk9Mxzlkh9Pov9/26JIDegMOjkVcCZ
	NgfhBv2v4u/NkA9uWqfKYMtkEHZaXDvVHKXpGmP3RvyvRlyv6+vnT9u6JPm4ZNw6U6hIRsF4XWN
	A5Sn1fHDKUTAuNkH52wdDyoWvcPECQw++ZqmDU+7sXPcPcNBJgeDbO7GVyNJ4dZliJ2wUS7+0E8
	z4x5Z70rZPXh/DBG5rlTFkVWK2yEe5nvdTnV/SRg==
X-Gm-Gg: Acq92OHZyt7ZOIarDwsezhk8M0wPbvwgcCwnpHRNDD2MGvSOTdCdnXIT+X7Lr/BokZ0
	eAurCPqden1KAjVtzNtWSeEXs5vyfql2WMkdLwEaTuqYxLxtKhdb+W0AQKkzyfwIHn9TKo2f1n2
	8euRa4GwrYhpyZ7RvfRpRlSovR4AnNRC0HaIW/3NkpLVU1VPDz5nWVzO53mfRvHojExqNluwGxN
	D2x8PeSewfFhl/lVv7J2fg+qmLGwO7+oooggRu7Jrepu4F9zDKD+VBDOjFerCPgPdFBTBdDExSe
	32Kl2oy1ITx9SdXmxpbSJgIup80r+raTxvY=
X-Received: by 2002:a17:906:4fd6:b0:bd8:f776:6980 with SMTP id a640c23a62f3a-bf9366be1a2mr537539466b.10.1781117670691;
        Wed, 10 Jun 2026 11:54:30 -0700 (PDT)
X-Received: by 2002:a17:906:4fd6:b0:bd8:f776:6980 with SMTP id
 a640c23a62f3a-bf9366be1a2mr537539166b.10.1781117670362; Wed, 10 Jun 2026
 11:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610164719.2668906-1-rrobaina@redhat.com> <476e0a44-c6fb-4e6a-af56-a9f1d054518a@app.fastmail.com>
 <CAABTaaBBVP6eY8D+a1KTgfZ3x8v3egnKTiQLRQfXPiOhpmQXjg@mail.gmail.com> <2021591.7Z3S40VBb9@x2>
In-Reply-To: <2021591.7Z3S40VBb9@x2>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 10 Jun 2026 15:54:15 -0300
X-Gm-Features: AVVi8Ce8xxpRaTWMyB7SeZgDc5i1KVJQZnVyycI-Lojf1NSNcrzCog82htkEkFQ
Message-ID: <CAABTaaB8QRmVKyzRz6r4VaKOAkOxdHV62HxzYHu_Fx8WKs-ZZw@mail.gmail.com>
Subject: Re: [PATCH] audit: add missing syscalls to PERM class tables
To: Steve Grubb <sgrubb@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 3:13=E2=80=AFPM Steve Grubb <sgrubb@redhat.com> wro=
te:
>
> On Wednesday, June 10, 2026 1:40:47=E2=80=AFPM Eastern Daylight Time Rica=
rdo Robaina
> wrote:
> > On Wed, Jun 10, 2026 at 2:05=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> > > On Wed, Jun 10, 2026, at 18:47, Ricardo Robaina wrote:
> > > > diff --git a/include/asm-generic/audit_read.h
> > > > b/include/asm-generic/audit_read.h
> > > > index fb9991f53fb6..8feebc5b4c50 100644
> > > > --- a/include/asm-generic/audit_read.h
> > > > +++ b/include/asm-generic/audit_read.h
> > > > @@ -18,3 +21,19 @@ __NR_fgetxattr,
> > > >
> > > >  #ifdef __NR_readlinkat
> > > >  __NR_readlinkat,
> > > >  #endif
> > > >
> > > > +#ifdef __NR_file_getattr
> > > > +__NR_file_getattr,
> > > > +#endif
> > > > +#ifdef __NR_stat
> > > > +__NR_stat,
> > > > +#endif
> > > > +#ifdef __NR_lstat
> > > > +__NR_lstat,
> > > > +#endif
> > > > +#ifdef __NR_fstat
> > > > +__NR_fstat,
> > > > +#endif
> > > > +#ifdef __NR_newfstatat
> > > > +__NR_newfstatat,
> > > > +#endif
> > > > +__NR_statx,
> > >
> > > There are additional variants of 'stat' that I think you need
> > > to cover here:
> > >
> > > scripts/syscall.tbl:79  stat64  fstatat64
> > > sys_fstatat64 scripts/syscall.tbl:80  stat64  fstat64
> > >      sys_fstat64 arch/x86/entry/syscalls/syscall_32.tbl:18       i386
> > > oldstat                 sys_stat
> > > arch/x86/entry/syscalls/syscall_32.tbl:28       i386    oldfstat
> > >        sys_fstat arch/x86/entry/syscalls/syscall_32.tbl:84       i386
> > > oldlstat                sys_lstat
> > > arch/x86/entry/syscalls/syscall_32.tbl:195      i386    stat64
> > >        sys_stat64                      compat_sys_ia32_stat64
> > > arch/x86/entry/syscalls/syscall_32.tbl:196      i386    lstat64
> > >        sys_lstat64                     compat_sys_ia32_lstat64
> > > arch/x86/entry/syscalls/syscall_32.tbl:197      i386    fstat64
> > >        sys_fstat64                     compat_sys_ia32_fstat64
> > > arch/x86/entry/syscalls/syscall_32.tbl:300      i386    fstatat64
> > >        sys_fstatat64                   compat_sys_ia32_fstatat64
> > > arch/alpha/kernel/syscalls/syscall.tbl:224      common  osf_stat
> > >                sys_osf_stat arch/alpha/kernel/syscalls/syscall.tbl:22=
5
> > >    common  osf_lstat                       sys_osf_lstat
> > > arch/alpha/kernel/syscalls/syscall.tbl:226      common  osf_fstat
> > >                sys_osf_fstat
> > Hi Arnd,
> >
> > Thanks for reviewing this patch! You're right, it seems all these stat
> > variants should be added as well. Steve and Paul, correct me if I'm
> > wrong here, please.
>
> Alpha is unsupported. Those are True64 compatibility syscalls. You can
> include it and #ifdef will filter it everywhere else.  But, yeah. I guess=
 the
> rest are ok. I don't pay much attention to the 32 bit arches.

Thanks, Steve.

>
> -Steve
>
>

