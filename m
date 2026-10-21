Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792605391;
	b=maUHLjYiwkG1eC5Zb+Cm4G12QmG3nAutfbV85Exn7OfrLcH/l5C5Cn6EOhRX4+SUf9Nz
	 //tHHk0Jp8zogRummPbR58qolasiu7zyC5A9Bt/GpVgpggkxkjfxBUDr3OrANZWpAjP3N
	 ohIhbqY29skXnovZqYW9cbGuSfp10rb2di2ZpiAyif621HBgeSS1ZAxCZZJ5hzDOrFPvR
	 oi51zjxEMrMwmit0N79kgkyEBS+EI1n7LIDaNuTzjd2BbJKxGmRPs2geid/HwkfkjxnDm
	 JMplIsaKC1U+tnV4B25mf9ZEfcb1/yzM6dEXn4JN2IA8oTyHSU2EgCBC1El7yDR3psQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792605391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
	b=hMlm34GPbL2V2pNTe+rPovPmsJEHFE/L6xiqEnwb4LZxpn5oGxXWU5QoqVdiO2LDC07c
	 jPhmobyeOu5FrzbRVJxbUGUmmg1kV4P4V+Vebq7k/KqIOHY60LouK9VmYCTHauMrswiYg
	 gwSi80xOiEcGKyfGtEz0DdKP3y6YfZLkY7epamCf5b2vv7oRz3mUyv96UgPDW7FW+4cSj
	 s3O2CKgzJy1d2fb5hdjS3uPoANHlhEikIXs2om2AGf9oI4A3APdeRjoZzAWVlQIh7Cl2B
	 n8PkhP1+7Ul4W868CNoFpodtgvXDhLTomFcvRv/ylhSyHzpAiC+wgKGj6XKBg++jjiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=CsnNkHId;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F99606A329
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 17:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35F99606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=CsnNkHId
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so1510149a12.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 10:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792605389; cv=none;
        d=google.com; s=arc-20260327;
        b=dpNSCRHopZ8vJlkUSg3s/zY/eFPmGBp2VnE124TSjHNy71hphFkR2oWw00ZNZYgVds
         XebCTit1s7oLAmliMvlAgc4R+nY6yuQiRNCjHGufHzoG47kUVGTkw1+X4Mr/mncTEuQk
         WzxR1fCu108iu19ZwPg2tTvbhkJViRb24WrO5NBacvujHHQcA2oRMTfxb+aVvzPJisJU
         cyRy6LUpP4Nx0GULaxUbm4lQKNEP2+S7TPUBUJeKM2ufvfvRkvHF2oSWs1WvgYFl6G2I
         3TN7MTre4rn0iajTr+zl3Brn4sVg2XqlGs2FJLdL+gEtVXFqobgHpFhGwD9EdSKjnaar
         BfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        fh=lFqFzz0YmjfKYSdBOPQsJE8iQ6JrpmCnT0UCKTgpHpE=;
        b=hchHuYmY59C9NanSEudmjVXCYul00SViWI1LjE+YSdf36eRZhv79U5Kb0WKHDSJhwt
         uOIRCkRHPqKcQOqrf40tfLkqGFDx83+tFvQCnxIZ0v7ZYcNa1bvZH6iAJUMVLB3H8X1z
         18VbiZIgJ03GUGsgIWdM5XyBUcl3iOkKioIZHSjfesVQ1vhWXLMY6DYL3VQt2pCAQ9pt
         emaNDqZUuwBGy3lXg5rVejDjr5srSmLhJ5M7zFjgxLVz1WRz/yn3+B0FLCLkZAdHR3nw
         xdvvwz7LzlfT/eBgTCKd19Ufkq1CQhtln0I4wNNcAF7tnEo3tw0Lf5i9U4HV3GVHqBZA
         +GIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1792605389; x=1793210189; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        b=CsnNkHId/2HmaPxBHjb/0jR2Ogy9CW+152Se+WQyag2dh21j8P/RHssb1Z44QC5yWC
         C4QlKQrH5IzSaG/OPVbhWVM3PA/cIm1fOy/fqHgVzQMXB+wzQ3KobKxzNHWIF4yHaCSD
         txHLa8F1uvqOKW0HUcSBT/UKnibnqOmjYCzuBGkNyTsfn4IHOirM/RQrbSf1aiLT2X7E
         TgvGTfdyJp6KjZJ9KdiumiVokiBpI9M4awk2Pc8IDRALgaKADIzg57iXw0Hqhfl8ts2G
         zkyDtGt7WXsJ0Qmo6uDo8E2S2BXyQ30jWJlFRuBusxShLi3wKYksnzRG7ma3ngGkK7xJ
         oUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792605389; x=1793210189;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l/9Q6vwSpHzLOuQcu+iZE9ek6ulZ0fAfcC9lHWm1vuA=;
        b=vp7BOl4xGpyvdFTLR6R0zgFE9tYVBR14bN1ZIs5pBEWB5gckDlqvi5T9ashGKK3DVW
         MS/rF3eETrvvDlIXUcHqHbTFkmw7e25TehrjUqS4zpihjolOYqehSSLEBqGjzsQSYipC
         h/y2VYxaM8n0BMXwkR4BMqUDh7mV6z0zO8TchTkAmqlZSGe5ucNeHImyZt3p6a7Ul8ZJ
         Qq4MW87+y5hhts1Q06BAHBbjUwVLgkxoZJjBLr1n/kXg+0B8K+uMZPZtvee01tZ8YiX/
         dU81V8b9a8yDvdq3Lgq+JRzwDI8M/2HDrdvPRbURWQ9hZvD6mOw3AQKXpcvmMarF63o+
         7oxg==
X-Forwarded-Encrypted: i=1; AKwUvBxANmCL+SRLDLnTfUbXr2vfZfIZlDGsdRxavEg9o/f2RhNLzZtnEGaxbOX2pJdQW2ISVobkox46GDrM@vger.kernel.org
X-Gm-Message-State: AFq9FYL9o4FwW6Za8jK5CBw/Tzp9YkuyPQXX1Tu+CtbHF7D08CtfxcBW
	sbNo4rOo5Osw0LGM/uj/Lz6vHhvP48ZkaWbVjpSs3tAWyBK2NW118a8uTNVO52wVsDTW8/X1Uhd
	PxmW3KsB/mGy/QRt3KrAp2pYMDhSBcMDT43OyZS0yiw==
X-Gm-Gg: AYBFou1RBUls6+iQt2FsrVzei0hJK1d79YBrqMnr9ATGQsOpOp380DBsvTCt+aQ1c8Z
	ge1wFgHx4iuna3+QCFncX3GiK1KnOO5EjQtgirM2t4sX8qPlo9zUtqjjCeL8UL1DFV62gSDhul4
	HccOj4EkNsmjt/5bI++1p3eAl5W6+M/3FmEoMGd+ykOI9f2F40o9QzyPQY/ejzqp7dUx3OTCS/R
	IKSGeeKFq8HYwhXkDqdd36L0Fwvv3r9Kl6af81rWnXzm9CUAIGjFenDP9O+cP6fAJ/PfQBbd4h3
	4R4iKVDMjT8P1N0Lv47obAcrk38NpiaC1q3kCa+7WrdesOzN7QDUgft1JII7DgoNnIWQDAKHF07
	GjAMkmPmE+IiNoF6lLcLGQYp6o3JOXq11PIXccyHWsWUO7H0GlVv7ujaIbGmKAKkYcNs=
X-Received: by 2002:a05:6402:458e:b0:6ac:686f:91db with SMTP id
 4fb4d7f45d1cf-6b408e9f045mr1964734a12.11.1792605389455; Wed, 21 Oct 2026
 10:56:29 -0700 (PDT)
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
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com> <20261021174006.GU3008132@nvidia.com>
In-Reply-To: <20261021174006.GU3008132@nvidia.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 21 Oct 2026 13:55:52 -0400
X-Gm-Features: AclHuK-Q6MQhxMIMUURzzci_OOwzGik9EFivN3YqqlGA_5OHu0xT6GsF67-BzDw
Message-ID: <CA+CK2bDJzo44K0X-+5F77E9g2dmqKdwZvrUf-1SkC7ewrgEgzA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Tarun Sahu <tarunsahu@google.com>, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	David Matlack <dmatlack@google.com>, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 1:40=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Oct 21, 2026 at 01:27:22PM -0400, Pasha Tatashin wrote:
> > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.c=
om> wrote:
> > >
> > > LUO and its file handlers validate handed-over state with monolithic
> > > compatibility strings ("luo-v5", "memfd-v2"). Any change to a seriali=
zed
> > > structure, even an optional additive one, must bump the string, which
> > > breaks live update between adjacent kernels. Replace the string in
> > > struct luo_ser with a feature header, so that the target kernel can
> > > accept or reject the source kernel state per feature.
> > >
> > > struct luo_feature_hdr is a fixed 128-byte header: the serialized
> >
> > This patch is all wrong; 128 bytes is far too large. For every _ser
> > struct, we only need 8 bytes instead.
> >
> > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > 30 feature flags + 2 reserved bits for flags extension). The last two
> > bits of the flags indicate whether an extended flags field is present.
> > Each extended flags field is 8 bytes, and its last two bits indicate
> > that yet another extended flags field follows.
>
> I thought we agreed not to loose the string too, it was a tree
>  string -> feature flags -> individual values
>
> The string is the emergency if we really badly mess it up.

Yes, we'll still have the file-handlers/flbs compatibility strings.

>
> Jason
