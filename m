Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792632406;
	b=AHVlozA0YrINXZlJ98ZqAk6NRhK4Dshqltw8bLNfvVZkKDSgbzz6qqscWbpuK1tTUeUB
	 8Ua+9WByAwj9iIaoDnmbh4OwjA44VsTHBhBUEobYYA+XMa3N+SkkiBgaSPRqjR0PcxCoL
	 89qK1WjVhEuGEul9uIR0dHsPIBu421eyLEaWxYs45LfJa8yFFczKPo34UBmtLUKgAGH1V
	 y6/KenGFYPrEodgIiAo9YDdWIgYVVQsI8Cu6VhrojBWFpnVvymWwuSv0Kx7nbLnNlKjJ6
	 KvTDEBbNZz/uxde8c0z0PoOSTmMVG1IKwDaIKFB8AJCIjUZIFhHY5l7vmZd7IuDVRdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792632406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
	b=k2YDCstjpoBrgwM3kMxRFO5QV/A52XFEEUi6HkeW3n2/EQeCys8SqOjj5KmBEQA8BCGT
	 6m9NIkjfu1ZYjQFNfJQMvmMXTTPTLLff2JQpxWWeSODrevW3zjjL1Uh2GqAb5Ay3Yp4Tg
	 UZMSIXlmL1Zgn3Y8XY/r3YDyYU64wUcHAb9mljdoNLapu5TB9U4dAIfyNVIB7H5Zcn05i
	 Ly0toiQ3kfjL6AD13MINFhUNewtPyP+Cdlq15Tkiip/KVSJtLQ9ILima3qrYGfjJuL4i2
	 64TcVDNVM0HcKnu6Bu5gLujXkhviTdiPHG2V9ZKglGSq/grZiQ2vQ3PueMAjIP64Z4Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=UjasCW3N;
	arc=fail smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8A606A319
	for <linux-arch@vger.kernel.org>; Thu, 22 Oct 2026 01:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33A8A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=UjasCW3N
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b1ab2ad719so2162367a12.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 18:26:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792632405; cv=none;
        d=google.com; s=arc-20260327;
        b=WiCtj9qqxcKTpuo5Zh9ZsbpU+VPHCg96f5ZRckocnRxcv4I+2rrU4/q7gNKGO95MyJ
         UG1vNN5clL42J8ExVxtoEgL+0eVanCirM0W+0/IfPOT4zc/VMTaTtPngfOUfB98Rj/lb
         ZiXZX7vLLQf/q9BtknTMIrVJXpXiR0FVVbuF0FIjEMMiKT7dB89Uyey2ynX5aZpZcB9B
         EKHvMW/PO2AIVx0Dka58zyMyrnT8Qu+FDo+JnK9v/gs6RZ5try3kd8OrhidWq4jQNeO6
         wunAVxlfEFkNd1QMCVerqhWft1bVL6nLMYx02TKggg+h4X5s8Hr2LeTnKuXqaecFw1WW
         bxhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        fh=ocpSrt4VpY2NhxX5KO1BvvBjtSUGZIv4nBzXM1wiAbs=;
        b=Z0n8U+SgPAUHo2U+NJ9DfFhxFiHbS/YN2NSvK0AWWWuohgyeGrDcKREWJn0svHQ1rV
         hJYs+6KIuBWw4+yj4IbTcXNObD5aZe9keUcWYt0mX1ylo+3Ebr7U4664jTN0+DYPjVwN
         4JuyrwTi4ggm7w94d7Dtu/eI20/mgPkvkvyT6kHEnoY4h11lb47HwUZ12zn7OKhTP0lV
         WUd4VblDV5IPjRXlJIKm4hv5cgEM60T8AxUQ6DmwjEjoEu0q5UVVFuWVLDnU49UnqYlm
         NknCIDncCwhONa4aw8bgDgxSvfilfuLOldC+fXUfF91Frhgsq55H/Rjhf1O/z2q7tcZi
         ir4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792632405; x=1793237205; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        b=UjasCW3NpozzrrA3uptNAoyxN3DqKW8HmkXQNxzRnN/JTz/QnCPODSFsuQp+CU15iz
         1LkOjKGsHN11814MpjY+/WDEGC7whEmqGfcFHZilFU92hVZmd0P/jDJQsz1R1tiY1v22
         QEJjzFYaVhhlpS7AL3b9a9Eh15m7QtFtTO0PXMi0cpCfJWXwrmO20D3TU8B5QgOQt69/
         SNKIxNxzV23JLqHMuIqF+Rxhbp4ACGvPlVLutcB6tch3U6K8bn3cBIdJedvQXqJoWms3
         LTcsARGJuNIIBF49+wPKcY+NHi+T9ZqJmZfG7n2YznT0MSfnTRXZ9Wu7/w8UUAK2YMpN
         qYkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792632405; x=1793237205;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o28ydFuUHHD4c/U0AkyEgOljfI5EK57zWWg+tuRSc8Y=;
        b=Mmkin4V0VJcRHD+5MAzSogsl1SSxm+HMpmf7VFjR1tXKxHOBOqVvEelj92Ao/8Jao2
         nyfg5DIZi5rKFAD73ETmZ6Cl28J1otbAtQPWiNZ9hICxUDatPbytm5YP6H7ElaiaDNNF
         L1BJ6QZJjFxvcvNBbytL1RLvHVUU/Ts5qPPKRG7qXulRemgOsGp1T307aMor1gCYzS6U
         BTbI82F3gXIwfxumkhisbpWhUofkIME4r9Za1RMIj3BFlSARCcaTt3tlA+3YWCLe0WUD
         MwzPIzANwxHm/3nuegcgNyDXecLfEJ3ZQ11Gm90vzhH0uIfPRU/GsWCkh9EvhyU3QoWn
         iCBw==
X-Forwarded-Encrypted: i=1; AKwUvBxtfz8hoS8Zteik0ZcRP/Rbo9LrKCYm9hzX7s1tQjuAQm9sNemHg10PeSaJsDx2ZyhS2SmfFq4+duVy@vger.kernel.org
X-Gm-Message-State: AFq9FYLjxYL0D/qDzH0xXEHMSMRPB9tY4jfeBNZSQ+YTKyEpcGCMQyt1
	1ylEFJD00ALR2LUb3tQRwlNKHHvcOmpDbnOSt3XHPcNXPGS4o6bArODpQx20wF5wd0BqCerYddt
	dlLYpsUwcde2XcFTHIeyVkhETkr/9/aaR97VCzp4SDw==
X-Gm-Gg: AYBFou3Eb8+o4Hn7MGI/NyUzSzdqfiGlRS27G1xRDp1sVDer7RCkTWNJzUZvvmPwXaX
	X8dtc+eioPoP1p+v++6q0rnSsOiCjmQe00qr/PumcHNcF0uvtpS9DcQKXMucqfFcho8r7+sxGe/
	UTRn7LZf4pAjO7g9+f9RNiwdwAEGEGDVg8x6PhthllxUO7iNWFdAvCgTDDdt8NOuJ1aw/7+A0K/
	N4nvgksvSCvsUrrey4kv+LPWJUWyQVoDtLgZ7QP2gv0JUGM7zZrEdUiRVYlLPj+wGhi68ZCS2z+
	vHArn1M8nwu8xvx7AfezhJ/UnbPapvK2N37KPjRVcTYFZNYC9RS3PloJ2E9IdoMqguvYDG86QJN
	USYTWXz0dyvSLyTqxbKHYosmzOqPfqRjukz3RAdHaLGbwkpXJdsPFdQYZH1ogwCQLfm4=
X-Received: by 2002:a05:6402:2801:b0:6b3:a1ad:ef6d with SMTP id
 4fb4d7f45d1cf-6b408dcce19mr2969744a12.6.1792632404378; Wed, 21 Oct 2026
 18:26:44 -0700 (PDT)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com>
 <9huzecdi6go0.fsf@tarunix.c.googlers.com> <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
 <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com> <atlKsD-aJB3mJr2j@google.com>
In-Reply-To: <atlKsD-aJB3mJr2j@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 21:26:06 -0400
X-Gm-Features: AclHuK8Appp8OBdUFGLxu0V1hBTCm-a-9f142JZiexa4wOQOsDrRrU21F_J0R34
Message-ID: <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: David Matlack <dmatlack@google.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 7:28=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On 2026-10-21 02:50 PM, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack@google.=
com> wrote:
> > >
> > > On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote=
:
> > > >
> > > > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> > > >
> > > > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@go=
ogle.com> wrote:
> > > > >>
> > > > >> LUO and its file handlers validate handed-over state with monoli=
thic
> > > > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a se=
rialized
> > > > >> structure, even an optional additive one, must bump the string, =
which
> > > > >> breaks live update between adjacent kernels. Replace the string =
in
> > > > >> struct luo_ser with a feature header, so that the target kernel =
can
> > > > >> accept or reject the source kernel state per feature.
> > > > >>
> > > > >> struct luo_feature_hdr is a fixed 128-byte header: the serialize=
d
> > > > >
> > > > > This patch is all wrong; 128 bytes is far too large. For every _s=
er
> > > > > struct, we only need 8 bytes instead.
> > > >
> > > > NOO, It is not. It is intended to avoid complex mess with unnecessa=
ry
> > > > over-engineering.
> >
> > 128-byte per serialized struct is not starter.
> >
> > > >
> > > > >
> > > > > The first 4 bytes are the size, and the next 4 bytes are flags (i=
.e.,
> > > > > 30 feature flags + 2 reserved bits for flags extension). The last=
 two
> > > > > bits of the flags indicate whether an extended flags field is pre=
sent.
> > > > > Each extended flags field is 8 bytes, and its last two bits indic=
ate
> > > > > that yet another extended flags field follows.
> > > >
> > > > If we will have dynamic extension of flags, Think about this.
> > >
> > > To support dynamic extensions in a backward compatible way you want
> > > something like this:
> > >
> > > struct luo_feature_hdr {
> > >    size
> > >    flags
> >
> > __u32 size
> > __u32 flags
> >
> > >    extensions  // offset of first luo_feature_extensions (or 0)
> >
> > __u64 extensions[0]  --> but the size should be specificed in
> > declaration macro that I showed in the next patch.
>
> I think you may have misunderstood what I meant. In my proposal,
> extensions is an offset to the first extension, not an array of
> extensions that immediately follow the header.
>
> If the extensions immediately follow the header, then the number of
> extensions is baked into the struct layout. Every field after them sits
> at an offset that depends on how many extensions there are. If we ever
> need one more extension, all the fields shift and old and new kernels
> can no longer read each other's struct. That is the problem Tarun

We can structure it cleanly by nesting the payload: something like
struct { struct header {...}h; struct serialize_data { ... }p; };
That way, the header can expand dynamically at the front, while all
fields inside `serialize_data` stay at fixed offsets relative to the
start
of the payload.

Since the header size is self-describing via continuation bits (e.g.,
the last two bits indicating whether another flag word follows), LUO
can
easily compute where the payload begins in the incoming blob. This
keeps the implementation simple, avoids linked lists of offsets.
