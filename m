Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792608694;
	b=yZ0I/7XkvNu6J+3s/3fEJWbHDoHE0zRmABd65gz6ekxCrZ54yDqQuzJ7ZTgzNepYokm9
	 AeIEGpPyzBGo7jA3Bg2VItiN8/mTv3PIxcwAwxKRESbmy+P1vo3Rxfcl1svSSIqkOXAS3
	 y98lXcaDp0MjGqjgNIoIbwzQW2qjWy4nqN7qLmexwcEU7eTlyTBvvKgF9s4pLXvrnbCob
	 pvcyfwwBinW4qSr7Uw9vXkwaoGfWdZLvjHsTQppeuQV63fGAK7V4/Y2xOil3WOF6tK62w
	 KAPqC7TQPN6Ef2ti2xrRQHhmp8CGwlkfQOWRwgwERS0fbRhY1pMUq/i+L2QqAkRJX6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608694;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
	b=4frT+XVPfhKYnUt32xvtI99uA0BTwJPuQLYdigJGrJLpSgCt8tkqsXzU8wLL4uYWUGPj
	 iYStTLQ8eXrLBY7CH8Q4VYGz22ZxVN3vY19w4pS1QWG0dHRg/arYbtTHCpTYyXziZP61L
	 yfuDY54H7GNuAb0Xo3+ov9emP7aLsvzeUQjH0ZWv/HTI/x9a+xnNU6tdrMIKLOE1bUSVR
	 jtbmkuJy1nR1PSiGLg1dGYgm3FPimxnWyNfAfTxGrTl81ozqsRcR2Z+xUaAAG+1g+tJGy
	 FNUARovf40GJaqTcLJYBWI2XBohioCFfPceabEOxG/Umr2Ghqd0X4dFgTaxPnFn/MWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=HlE8O8AN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4033606A320
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 18:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F4033606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=HlE8O8AN
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b3f7763d88so1427841a12.2
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 11:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792608692; cv=none;
        d=google.com; s=arc-20260327;
        b=dAxsTSPdpSV/VRbxm/iA9ZvEcUUm7zAM9LuRit+GYWLcvvyp7pmIhguLRRaNXe92+p
         i8qZi0rQClhZSFOAauqwkiy3hKuz9hX/mxqWyGAibdSgs78uWlDsvmhO1vb6GIh5qyfr
         aslGVpDngbIER/KyGjZRBAGt4JNHosDR6eb1kVNkJ/+g/RNUtx/QFAQniEsrLQuQiGaQ
         Bgujzz0BydVbn9c7PBOlOEeAOzKEHHpozcuODdbWy/VJut8+EOPjlVpaSRa9pNuwMizH
         RQ5KvE40ceZM7w19QR2ZN/rz92yUEgVLbklOWUoh8WGHrqT5Y4kaH41UdvmP2XrOq06o
         4efA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        fh=BMCWTnz++DHrNqL0w88HMKV4LMqypcwIS2cpP1Qi2sU=;
        b=RxOyLGVg2v7FlMYiYni0HEuteDpiK/PaPkoy+dD8kafmtkkGf4F22B849DKvE+leXG
         CpF3GWk7CMltYYs8wOYIPlcU5QCMMa4f2FuvT/sWZB3acSn1+++TawCBp2JttU9fBAJg
         IBFxeqmoMPWzKs1zUI2leLQ4dpRjmR1ttEnoRHLTNo9Hzeo8ytqcfYi9toAveIjOMNZb
         vu0QEyfvfG7UkUEsBF/JjZCMhM4GZyDSAn3B8zxeU+zYClotYl8esaC7TtErFSvHGBhC
         2hIdcqHU7PY6bewzYjbf4OnNZboAtWU7wp2khUSb1PK3hpNuGlsI4Nh2Lvd0ZmyYhTKx
         jpAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792608692; x=1793213492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        b=HlE8O8ANX0EKpSe16g+iBaKuq+PflNI/nF8nfZx6q4OaNXjnD3WcfTP3ZxUZ6C5yww
         AQBlVf8uKRAHdsAZlJ3nOI2KRDtgeKEzjh6KweWDxu1SToMmLpwutL5+Lhr+woZoPbMT
         N1VnHlS+CynNKAT7F1IUt5thcgbaiveM8ggBR3Nw16XMDjcQGNRcVcNo5SDcaGJ27VgC
         SQZcks2KlihqbrkzWQ6XLWFtJ/xz9Gpgi9JXe2qQ02aMC2CNEezI26fvbSwiRyYprEUe
         g6GxU5sGPGr92AGt2GfoO7lQG5xEts7k+b+8LB52OVC6Pn4O+EIbicTODb4yWZNAA2oj
         0ngQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608692; x=1793213492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2oW+YxRWdAsPD4uJs1XKcHYT7T/4QzyNKf44tXuYtg=;
        b=FqAEz9OAPKJR9VjtjAJY4kzn6B2MKa/Yu/scs8+jvsKs+qbWLNExz6fcxw/jUyzWan
         pKhwiXVaAlSneu03KFloatB69py6qwnhSX50MkDglauVfMc1q087BrEjiWZs2YxH5HbZ
         hFGXX9y6KfSJBEHTnz9yQcWtEItVDV32eC/g/zY6WxXFBGcAgZvMZLHtbh+5Xqj2xIt4
         3IkjtOgP10GZJmPIZnYoqivjmQcZrc8dPvIRxssuLvni54fpSl0XH02FE5AikherKmZy
         kRzo1soF+uL10hgza8HdIz7YhU3kVah+ev+hDOWKoJ5gycWtYuyoOaiEBFV5dzPhYUgt
         KeVA==
X-Forwarded-Encrypted: i=1; AKwUvBwCdo/tH3HAzvCGfyIKrKwl9m5MfdziCbeiCZFIuUep4HT5ctv1VR14bWP7QeXKiEx2oZiCNvX5wYBU@vger.kernel.org
X-Gm-Message-State: AFq9FYI4wGPAK2LK6PiBZjgB+cuHuvPWCU6W915RxboFNH44BcC85OXb
	3NTJmsiTJzAIHEaV5vAyrl/zJ3P5ED91knTL81iTSgYYQHb9ngGclxPFHlTt91uLT9H8WNbLfIC
	21wabtkol20pwk4EsFe//ANecLHGHgOenbvne4CPNoQ==
X-Gm-Gg: AYBFou0EcYSluIdaKI5+iucVHkt4seZI271uMTLHbdzkighg1QISeN1wNwjvF/QrZHd
	H7tuSZiHptaahrwEDi+b4ncMWRVhL98zuekP9TLs1jBkZgymkfPIVnWGDDDxjZF/LA5SoGRRjSB
	gGxpAefX+uhIZe19JD2e9gB3AcQn5A+2H0VLH/C/Wn9I4cd15ASYzHQ33vtt3B/A3CCi2FZZvzh
	bojcDKS+XditN5GYFh04CGhGEfA5P35eMVFv0LWG4NnUcRBmXpdPF9Tj3KMba/hvPQC+YnDEHvu
	oi/mSYCivBB7ycTDm2UXTMd1LfgkICA+6YNE0cyTXpMFUDftu/vju/E+KvPsjpUPM3TZP95ifsa
	zC68vQ8I2vXaJ2o9HOBzmEgRtYhIPXx67qcvM+aDI6PMxXEwAG0w1jATWwgQpzNmWj4k=
X-Received: by 2002:a05:6402:241a:b0:6b4:1df2:244e with SMTP id
 4fb4d7f45d1cf-6b41df242e6mr53870a12.38.1792608691873; Wed, 21 Oct 2026
 11:51:31 -0700 (PDT)
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
In-Reply-To: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 14:50:54 -0400
X-Gm-Features: AclHuK9td__2XcAMViewCe_NhDoA_TjTC8gr4y8u3SANqGewpEKZoTgIKv6iXME
Message-ID: <CA+CK2bAQRMAEXZyHTEuUN0_Fo59Sn0hBmYbme_J9ewjx6gPyJQ@mail.gmail.com>
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

On Wed, Oct 21, 2026 at 2:47=E2=80=AFPM David Matlack <dmatlack@google.com>=
 wrote:
>
> On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote:
> >
> > Pasha Tatashin <pasha.tatashin@soleen.com> writes:
> >
> > > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google=
.com> wrote:
> > >>
> > >> LUO and its file handlers validate handed-over state with monolithic
> > >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serial=
ized
> > >> structure, even an optional additive one, must bump the string, whic=
h
> > >> breaks live update between adjacent kernels. Replace the string in
> > >> struct luo_ser with a feature header, so that the target kernel can
> > >> accept or reject the source kernel state per feature.
> > >>
> > >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> > >
> > > This patch is all wrong; 128 bytes is far too large. For every _ser
> > > struct, we only need 8 bytes instead.
> >
> > NOO, It is not. It is intended to avoid complex mess with unnecessary
> > over-engineering.

128-byte per serialized struct is not starter.

> >
> > >
> > > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > > 30 feature flags + 2 reserved bits for flags extension). The last two
> > > bits of the flags indicate whether an extended flags field is present=
.
> > > Each extended flags field is 8 bytes, and its last two bits indicate
> > > that yet another extended flags field follows.
> >
> > If we will have dynamic extension of flags, Think about this.
>
> To support dynamic extensions in a backward compatible way you want
> something like this:
>
> struct luo_feature_hdr {
>    size
>    flags

__u32 size
__u32 flags

>    extensions  // offset of first luo_feature_extensions (or 0)

__u64 extensions[0]  --> but the size should be specificed in
declaration macro that I showed in the next patch.

> }
>
> struct luo_feature_extentions {
>     flags
>     extensions // offset of next luo_feature_extensions (or 0)
> }
>
> And then an example serialization struct would be:
>
> struct foo_ser {
>     struct luo_feature_hdr header;
>     ... fields ...
>     struct luo_feature_extension extensions1;
>     ... fields ...
>     struct luo_feature_extension extensions2;
> }
