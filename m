Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793208282;
	b=sPfG6uYRzopXYYOXRZ+qX7yU2gdyn0niPHBIY/C92UGWa9TVO7pV5+2RNsqClQhVH0JZ
	 XnIpgqFfkuQ4RRVVAPio1BhnkvP120LpklvGah31BBeWn80ehmhX4IZkwXATf39/D1zPX
	 6wEI1ua4O6B6/zwLtCFRQ1wDXk0kREY9IbajSzYxdZC1KRb1b9caQJOO6VqZx3ef7D3wn
	 GOPd2vcJN4xnOkilpPR0neOiVZ0Gmmk3eXAvcHU4azd1HbRvwsuDvuxrrp2dLoV43DNyv
	 aWmPk3GOa4yVzgxS1IWHPXdmIRVxuOwY+PSVe/twgLa+U6vmvOEP8J2ha4Y7KH6xSJw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
	b=zJzC5Tqktls49cJUOCqf7hQXpJkIXJjOkeHBKIz7cPA2pIMkZWvX/VbFNwa0TdgX1zgY
	 tt+CGmGuMBmWNqmkR2FHwbHLM8qrKXO8fWb5vhNigeyGXdRRDoWcipqh0Yf4TmOVfEzgM
	 r6HZnyRUBjn5nyzGqClSFrtCXDn9YJqjJ189933jV1l3YtDEZb60GUjZ1FnNQlki3zKGT
	 m4lybrDar5YUJEFDROSwTQeOSsUwgkH0wiA/tLfW8WSaXvhd8++ccoLW1iEuyVEXDUSZF
	 jAKM1Yqr7YWE+XjHZ/dfWPBqdCzs6NDZsVOZ4Zx4IR2tzoqjCZthRg6WUoD6urIRAZw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YTEmwqKv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E3C2606A326
	for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 17:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E3C2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YTEmwqKv
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-14fc585291cso1102406c88.1
        for <linux-arch@vger.kernel.org>; Wed, 28 Oct 2026 10:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793208282; cv=none;
        d=google.com; s=arc-20260327;
        b=faka75Cjd9UecrJJPpPDErUDgr54UhxSK9E6Be7U27gyD5UuCTI6F1Cj19Rq2LHknl
         mX1dAsy70jMZepf87Nn4DuxmmJPN8TArGhKX+zlSeL0RIrV0e3cGbBg3D/1V1qVJ71vO
         itBnMacLBL30gN0jEGJnI5+K3QGHzApRRYbmdcDEwjosRGyWXAf2sFnJzMX174QAsijO
         4XSPzZ8+MOipXwzHSHCHR+WaTXrOf8UKPq1JmlTnMO4blXmDaoW7TymWU/KeHDHYCrty
         BfIFFOEqmzn/xT/fZi3Hi7KV1oJO8JuNXW1k9mSR29MtDADGjB8OyxrP+XKeB7zSsamx
         mQxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        fh=Tc+QESEVcmGCf/FwaVVOZolg4qBHh9t39M1wH9I2K/Y=;
        b=E0gUSJEPB+mpnC/JPqDe6zj9dNyiNPTojVGQiG1t/Pp4d4IiRpZCXApZ5PEzHAy+2l
         IxQYVOcUx7ewMB1eeQCBqutF02127kPJ2b2YEAv0SCV6LlVILL+4VvUK3ZK5E1NOtjj4
         a9tpymNXWhJ9q2pj+03/X7IGWZXrm1OB1sNSgqU46MfInqhf55MEhpBDRxqo3Wnexmjy
         PCiPTb2VLHZhkEOuwG+g6FJJweYxDJB+IUPk8+BsKXGcsPamvg4O3uWGnT1L3Hf9uOFb
         vDpGUZr5y0EFHpYUaF58tny5zkKUBzN1rPesA644Zh80QLeusrYeAUQk9QrEfWUNbhQT
         s6hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793208282; x=1793813082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        b=YTEmwqKvUSdnC+hS4b0vibOxIpmGakM3GonBTipKjmgXAv02ptb1Vy8uP+4aUMBPns
         gZNosqX3uAXrNbcVQ8R9hdrBtd3oSu13hrmentv85sdRt33GEt/KoljlvKtg47NP/Gt6
         AhwUwVhxCmN0lKLj30d45Ypyo+T0SOx/hytd7VYgp+RromGQBh6bOr4sl1ec9H9aPPZd
         zNxKiJQ2yUaILf9HYEMWLXSrH3c8SJZ412vkomzSiqQiIESjeTooAznhU3TUiQlkczP8
         qFKV/bpX+B9T8G7m+G5/evMF641ACRS1xaFwPNKNFPNhiI/zMD6BE/r9ssZ5f6gTi54J
         0QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793208282; x=1793813082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyXQkDiJLA3YYqZszI0OfYQ8KLsTyrFUAC1H8iKGZm8=;
        b=MBwU2GCZ+lva0+CPuX+KmCEULsJfLFyMS2qvV98p5iI0wE+tAkhxNZS4Q7UTYjGa2j
         //WSlx+hJKg/s2T+R8FplkwmMFlnXbZLbk57rHKIaSASlmMqKjjtvGZSNg480dObXbgD
         H14r2ihzF+UA7/nfWkclEhNW3K9VP0pvLQM5uquq0wRn7Zc6OSAsYuQl2Eh+0lTIliI2
         DR0MGf1zgytoZxJh1niIAy6BB+iW8qSheFtFNRb8nIWYREslqFVUvhBPjMtfZZzCSLJr
         t/ewNiwUZ5KPcMFG7DJkTtFoyDsznIRnCMVIazer+95XLJDr7/RI4sIjfLWmImpC0z2W
         TD9g==
X-Forwarded-Encrypted: i=1; AKwUvBwCWLQflPtw9Kp9vJjRwxfDCQBPFTlT3byJJ+c09wC8Ua9zjNmDSu/7CuxhS7zxIZK/OJdbVL3PEL8E@vger.kernel.org
X-Gm-Message-State: AFq9FYKNq2qCoGcnbhB2a9KGcJZxlAWnT1uTX5Lt03vR/qroyDMz4OBW
	WdQc7y1knkYhasbH0OnI5a5eS+OsSepv4M3yM9B3rFKlKKs2fPHrUUwKGKgPUXOnWndk70h1ETf
	LNmOKcJQ2RtLqOsxtwHOTLMBsGkjbXrpOfTBiwddP
X-Gm-Gg: AYBFou0wO+YJAMyQqpQnKJe1b7r9DtUyyaJNkIvYrfqyEiD3QlISPCHmWhTsgwAgVNV
	vou55nTqiS1CjjjEVPwPpxcE0su47GlpSMqDxSQ2CdfAWmxKejADWWwsA1up42KuxO3LIpc18m2
	8izklHoHYpo/azpWgsNwYlW3Byix1or9CLmW5HytZlI7o2su5a0KjVDWswLY/xXxomCgMCPgo0o
	6c+pZkjdNrj0htSNwkER3M9gHJzlKG/oGv02akCXb/xbJ6aA4MLzEaxaEmxMjNwS3AyOEProXU/
	mCnZlbWdt1lfjjYpiF1EeM3hj0cWB3p0REKyJL0jPq0zCbQuuX74EWRQxrKHtu7BCbCjWFLY0Np
	1QkYXmyJuG7AdIBJs1lI1f0vRTCQ2iI87BoIaxw==
X-Received: by 2002:a05:701b:2813:b0:143:6525:f9f6 with SMTP id
 a92af1059eb24-1a6cd3a1575mr3454907c88.13.1793208280541; Wed, 28 Oct 2026
 10:24:40 -0700 (PDT)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <atlKsD-aJB3mJr2j@google.com> <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com> <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com> <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com> <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com> <2vxz8q3hoicx.fsf@kernel.org>
In-Reply-To: <2vxz8q3hoicx.fsf@kernel.org>
From: David Matlack <dmatlack@google.com>
Date: Wed, 28 Oct 2026 10:24:10 -0700
X-Gm-Features: AclHuK8mtDBrFSk6j3m-QjfmBC0Hg3WdAbJ_jeR4OTytlWOkEsZuDbAniPHpdm0
Message-ID: <CALzav=eG5j2n5omO2Mxqw8xA4sZLduxdbBYFcnHpPn0PDpt9Hg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, tarunsahu@google.com, 
	Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, maz@kernel.org, arnd@arndb.de, jgg@nvidia.com, 
	robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, 
	kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, 
	pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:17=E2=80=AFAM Pratyush Yadav <pratyush@kernel.or=
g> wrote:
>
> On Mon, Oct 26 2026, David Matlack wrote:
>
> > On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
> >> On Fri, Oct 23, 2026 at 9:50=E2=80=AFAM David Matlack <dmatlack@google=
.com> wrote:
> >
> [...]
> >> The reason I care about keeping the header compact is that we are
> >> defining a foundational kernel ABI and want to use this header across
> >> almost every serialized data structure so we can evolve them later
> >> without breaking compatibility. While some top-level structs are on
> >> sparse folios today, other serialized structs are tightly packed, and
> >> we are looking to add KHO slab support in the future where tightly
> >> packed allocations will be common.
> >
> > My intuition is we will have a small number of headers per preserved
> > file and per preserved FLB. One for the top-level struct and then
> > optionally a few more for sub-structs like arch-specific data. That is
> > why I am less worried 8 bytes per header, even if we fix the folio
> > problem.
> >
> > Maybe where our visions differ is when there are collections of
> > serialized structs, like KHO blocks. For collections I don't think the
> > elements will each have their own headers. Otherwise the elements could
> > be different sizes.
>
> kho_block today doesn't store entry_size in the serialized payload. It
> relies on its caller to do so. With extensible structures, this can get
> messy. Sure, the owner of the kho_block_set can track the size somewhere
> in its payload, but perhaps we should store the size in
> kho_block_header_ser to begin with?

+1000

KHO block should track the entry size automatically and not rely on
the caller. Otherwise every caller is going to have to store the entry
size in the struct that owns the KHO block, like I had to do in the
PCI v10 series :(

> Anyway, not a problem this series needs to solve, but something we
> should eventually do.
