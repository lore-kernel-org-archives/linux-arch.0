Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792608448;
	b=LG/MkzYzbm8FPnntci+7erKJGxzTHD1yFijKeqH1LMDKML4acaCIDeo4MsQgynMrV1+4
	 nRE1kfu22ckhhtOHz595DmQ8yDJCJ9WBmbQuiYDjPmvEzB9oTVyV7ovc1elIrZbXN+R/L
	 88d8UISSULAEQybcG6emjFHhJtyKtoF7YoK/0YRR8cWn8MyrgQf6DqFBu7qlu1Dc/TQcb
	 QIcYVULI683AaOOGNgPqG2e2DOhRMDqPnb02bLrxUH3IgPLytBWzAvE4bQqLJGp8BrkWs
	 LNDcJMSVWBJo/KaW4bCzaTXf7hrnWpsZnALE/KS0ha7bAwVjBynS7tIB3uoHvnuO1Ug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792608448;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
	b=4sY6qicAm+oBTHuBzOOv0ol8oFAj/6WfVu6dxSeUWCe8f6js+ok1PxdMvPEnLXpYOwDR
	 pBTej/fgugR6LvW3V76OkUMirffP0eIaBuXzqGBajAvgMCZPlOeLFnj9uFKxn9ZFlLUSo
	 Ne9O/Gjo3keZuNQLYablxVCIpd6dx85b7JiqI9LVDIJ+834I+Sl1tlozsa46W/II2SqR8
	 PTNANXDqFRLj0tn7HwqmmW2vgl/bEsNaQtzMEM0JDkIbWZZrcR4VFhWl1ih59+VPuBNV3
	 +8sPd5hclaJCjSzdnLHErWVgItp31SL1kmmNNh9dhDzeHSkxSQB5oxFmzOtlRVrGtZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DR2OOg7C;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD8A606A31D
	for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 18:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AD8A606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=DR2OOg7C
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1517bda04a0so1076346c88.0
        for <linux-arch@vger.kernel.org>; Wed, 21 Oct 2026 11:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792608447; cv=none;
        d=google.com; s=arc-20260327;
        b=Y0Rpf+ZLOFqyem0bf29DHROHyILsUEKEh/Dtg6AbCJPZdjkRxGhoOzzARC7QdiGGCj
         ewKKU5WePPiSwzeIsw2PRuhRRwaykxVp+UjQWG1rODDX3STt4sBFFfeDOlWWenkeaqZJ
         t4bkFA/U50SmaKQQU7SyC1stYDrkOgGMYrkdiAo9Uwpy1pxwGG1fUFKbQc63bmUGVF3V
         zasKD8BQxmsh4AKDu7LTvYRRumBOJR7XCpkAT8nh0QLEC2MFiYXf1fAJ3YKbett0sVll
         tMPaOBfUcgHwsnNGSm4AIiczh9zO9mnRzY4ieF1HAiNsUGrOJg+RlrAO1lQQB3Uxjjao
         Ap/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        fh=gTbFI0qJVLkjlPzfYK2tbcyWO9VvrdwnTAb8KhATy3g=;
        b=RjFE0dRERuzGFVDqZKAac3XYMRTvDDvH7BEa8JW2cm8TYGhDVSkoZk6xk3FRJyyUeZ
         NduK1hxqBFCK6HPWMAAZuRnoq7kbaudha9tEPat6BRUOvy3eIkZC6RcV9u96qADsNoYn
         lVwnsUqHdqBt2rpZdv1LXqJ7WVVQhMPPkczxUVhXh9365oycctDrcsYJP2WvYuskN3K6
         0gCjqzvD72EOU3CfqlAVDc4kBG/keJqgQo/t6Ipv2TFDlTIFcmqVh5HnaqbADM8xhgfn
         3o7lwjCXu3xY/MJFEpRWfhcK7F79UG4HgD7Q+a6QtAQOdy+XEBOzon3ZP4nBeQnHviG3
         WQkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792608447; x=1793213247; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        b=DR2OOg7Cokd9wnC8bGWcf8lnE2DgANN4OCX47zntm6YeIxiIKdkNlSyMxGIzvsC8Yi
         +nu2MxLclS6ixH5D2q6uhakgMGBvLuPrRsev9q7rp0TNMBZWLaYyjH6GNRMU3+3bgYS+
         EChGinr+36jPwXttho3bWPBhPi/180HSIH22UBjN0HNhSsGeFnp3Zp3WBQ9ISO4qaWSE
         HVGLY8cSkGFARoh78a43yh3zx5g3O2U4glOPTARO9x5/Sker60qfPLmgksJmd3PLAlKk
         4Obt94H05egCn92XPZL1YpBXXtsyOexkNhnCmVkqiwNzUFxWUOBeJaGGzRVlc3miZe/8
         0meQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792608447; x=1793213247;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dSTZtcyPK3yzGl0K7b9zLKEzjIcPw2EBeTAvW8QX6I8=;
        b=RUOKylzXpWbEkJ6qj3TmPQKryAcTzXwk0MDf1hYKS4CsBP6UI3MUUI01dBr204hker
         4KxvVX0DFLb0N485timaN5yKdjhJDlrscmhanvTvSSvySrDxP3GDY44xj4ABYAnkBYxi
         2SVhthTtu4/03Ui4Mo2IYlKhaWi3z2uZKRqI4v01nkw0PLRikZyblyEjRPTHAyGWMrGD
         GALiffu9C9kcDlyJs2d93aJJdAk3Hc9q+z+I0RkDBuVa7wWnAGtAJmVu8FYXFEaZ6zpS
         eZHaVXhs67ZTfj1hIoTTkFJrkKsEAO4viNB74DPrMIfMf/paxpp5dvwuiL6WFCScWSsn
         ajTA==
X-Forwarded-Encrypted: i=1; AKwUvBxCHTgGRZ77ND3BBLRQWNjOh6ouyACqAulQIF8ZJSOfFoz+JWGB0VneI0QPOhFYKxLNboGRxFnXPW7k@vger.kernel.org
X-Gm-Message-State: AFq9FYILBiir8FMXD5CloW1u+nMvmtIzFBvrNCpihw2E86kLFoFekeET
	wLeAF/VHIfc5OubxVMI8YgWIQLF9PuXUXIv9moHYUWNSzwqSs8dDt8H2k3HsrCfl7D/wZMII4JB
	gIs6pyvd//P873lyEBrvqq7ybV/o3ykErWEjbCvMV
X-Gm-Gg: AYBFou0wbwSmPgYP7nL7uc5ni+hbAUvhBy3ksQv6BMw8/Mvlvxi1veaPPRtvxKEyH2P
	dNZXYdMIx/p8TMEG1tHvrbEvhQjX0HNL4YYcMyjPAIrNjVLpQyuUVzsY1nM7WnZJTTn8euVFFOL
	JmXJq8rOj9sVAjC3SKPI4x39FALN4iV0hBmGv0NHEaitXn75fnQFohgWLK+CIMsRICaLlL7vn+g
	Bj0vYFQloEg/WEgfHa4m6zv7YzlphjSbR1xZoYyDRsOwXH04kkZjxwOPPjYSFpNyaOmAr4CkhHg
	iZ5Z25ozAEfM00wS9lWMnu5SBn8Safij6fM6zjJTwTl4CjfLn5ne+96sX4EKHCJaJ7rfkxu6er0
	tKNHqWNNzvZ336snLl+R0JEAm8OnXJwKU1igq2kQTtI1NGSTXi4h1v2t9QTQ=
X-Received: by 2002:a05:7022:2507:b0:14c:efa5:ee7 with SMTP id
 a92af1059eb24-190a4d18cc9mr4696437c88.14.1792608446024; Wed, 21 Oct 2026
 11:47:26 -0700 (PDT)
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
 <CA+CK2bAQbmq3ArP3XMErF_8RC2CUwvgpLY0H83D0nCJTaVKYyA@mail.gmail.com> <9huzecdi6go0.fsf@tarunix.c.googlers.com>
In-Reply-To: <9huzecdi6go0.fsf@tarunix.c.googlers.com>
From: David Matlack <dmatlack@google.com>
Date: Wed, 21 Oct 2026 11:46:56 -0700
X-Gm-Features: AclHuK9GVWu4pH4tc-A36maNXu-EHT2uwChCmCT-hqS2EBFk28gxkLJBLwcVEzg
Message-ID: <CALzav=dLdJoVy=B1pv0FAurD9OhAzLSTjJNbtjTdJRmSqaB0yw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: tarunsahu@google.com
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Andrew Morton <akpm@linux-foundation.org>, 
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, 
	arnd@arndb.de, jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:40=E2=80=AFAM <tarunsahu@google.com> wrote:
>
> Pasha Tatashin <pasha.tatashin@soleen.com> writes:
>
> > On Wed, Oct 21, 2026 at 11:25=E2=80=AFAM Tarun Sahu <tarunsahu@google.c=
om> wrote:
> >>
> >> LUO and its file handlers validate handed-over state with monolithic
> >> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serializ=
ed
> >> structure, even an optional additive one, must bump the string, which
> >> breaks live update between adjacent kernels. Replace the string in
> >> struct luo_ser with a feature header, so that the target kernel can
> >> accept or reject the source kernel state per feature.
> >>
> >> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> >
> > This patch is all wrong; 128 bytes is far too large. For every _ser
> > struct, we only need 8 bytes instead.
>
> NOO, It is not. It is intended to avoid complex mess with unnecessary
> over-engineering.
>
> >
> > The first 4 bytes are the size, and the next 4 bytes are flags (i.e.,
> > 30 feature flags + 2 reserved bits for flags extension). The last two
> > bits of the flags indicate whether an extended flags field is present.
> > Each extended flags field is 8 bytes, and its last two bits indicate
> > that yet another extended flags field follows.
>
> If we will have dynamic extension of flags, Think about this.

To support dynamic extensions in a backward compatible way you want
something like this:

struct luo_feature_hdr {
   size
   flags
   extensions  // offset of first luo_feature_extensions (or 0)
}

struct luo_feature_extentions {
    flags
    extensions // offset of next luo_feature_extensions (or 0)
}

And then an example serialization struct would be:

struct foo_ser {
    struct luo_feature_hdr header;
    ... fields ...
    struct luo_feature_extension extensions1;
    ... fields ...
    struct luo_feature_extension extensions2;
}
