Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794803663;
	b=zvG3H9o3t427eLLJsTjvU66lemGyDd81NVdEW2JPujawuTVjlbA/2SJqdCBUTzdN6kgW
	 +QsKLrbNfaMSErMUPbQP65FZ1Cuun/9Hkrn75EnE68inT1VvjTWM2fxiOYNfaRaA5ELcO
	 /xPA2uHcFdiQtHS0v03WImsqdLD3EBGsUZlFruV1GRXorcAaq+9RYqF5ZysmDu0L26vIu
	 QMZA6z9i/Q3HlP9C7RyBRkqDTuquXFPwDXDLKCZp+LO1xFGOCvMr4DRNqyWYn4RHhLBo4
	 13bwBEVpf6rSCVPH+i/VBkSAvlu+3LWUMbIRklzqxszAxzUkyjzCDHH1hLwg70D0NWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794803663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=;
	b=4YcTCRuUbHNaxgqnEwgbAUGxNccWnWyCCCvVmhDDnF7qkGPPb64AdZC/wmAFBLNERypP
	 NihD/ADXUYvTzDcq0CxDtSIBW702Jr4hJ9BWAUQJD/R6z5bGRHRdZvOPU/5NlFJs5BgHe
	 F/kJzG06/L6dqTpnAXoAvtTfPIhCPcfICUWkT7UvjdKa7qIdCxH61HzZTdpxzBhp+/t1t
	 XoBTUt8cu1GLm4l1Vf0s5HdqsNnDVFld2r/i0BOwvrwVvQQZHUia7wXyLlfEp49m1J9sD
	 WvELZldE4a3hUUVvpuitb79CEV89csZXpyWQ1nQrhuhDoIW8wE/HHeRPV6atlODTifQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=IvrpsDuj;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16874606A323
	for <linux-arch@vger.kernel.org>; Mon, 16 Nov 2026 04:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16874606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=IvrpsDuj
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1b3b4bcbfc9so3268146c88.1
        for <linux-arch@vger.kernel.org>; Sun, 15 Nov 2026 20:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794803662; x=1795408462; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=;
        b=IvrpsDujkb8+xQxkW8bH57B/Njtz9j5nrLpeGfuYrBi6nX1JKFJylBRC6sdQEERIVw
         HtGcx7CHi/CiN1Fk2bHltHeShULSWGB/FJStMTLzNEcxESGvjONp2O5O4N9PClo7TcFu
         4beF6ymkhsh8+wfAWm4UkR+WNqUZfV0HV7UcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794803662; x=1795408462;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0RTPkBSn8aHOwll0NIb+MH6Rxh2TXo2nlFC6RRntyeU=;
        b=shIvCP3Ut/5oNd9augBTcOznxEn+9lUtuQK2utbqLwKpBfHRHD2Y1aBNdLLgo1Xqi9
         7em/0lmr9DsElHz02QLuY3GYZVflY+Bw9FeAKjec9ETMrxe6qEuBIBxupu2zqHfTBeog
         59/q2RO7U6/EuEtHYSeZK8Ysn25IUz+tPzyEX72Z9rnoYuxxbx1wQpKMQ3NhshOWtUlR
         sj3xKo9DxSwIzRePUp1VTDHAXwAkVkIQzKjhs2xvNf7cjb06E3wAwPEaqTgW2qvEGYtz
         pNWeB3MLkkfGCoSLX9uyVz9+A5ufLj/iYhRdr5uDvj40QtWfd1cubp7+M1Zcty/aWLKc
         i9bA==
X-Forwarded-Encrypted: i=1; AL+hErEkLnvw1bqrH1dVHFNaGXvqh+/Z9NcbDqT/Fk2A8wo6d5vXApv4zGuFl/bWxO05ASt24T3Brg+c2BZA@vger.kernel.org
X-Gm-Message-State: APuU4Z8XOJ7KQmvIklW5jaGzG2lUq5MeKVLCS1eHg9ydz7P/Hn+Um9/K
	VoVZTgN6gkxkNjR/leYFKF01GMQS16uTbVHHF3fNqN0yYUXSPtlkm5CguwfPIFkBuxY=
X-Gm-Gg: AYBFou1vaLZsnBU29wDFc0Ecmc/pYmuSp7Uyx1uDpY/0PkXNwb6DD4bewzxNuW1zCIM
	RpBE5gGtNyCMXV2KhbkXQq7Sm9Xrg7B+4WSQjn0bC3x4EoE9fLgy56tuLrnVAGsUsfcOsrcFvtQ
	hDHiK/VGesGmLVuqqMVtT342c1tuknq/OK5SIrcZkTZwZypfArY2tYYCHgIUAuBAY4qrhJKOZd2
	2ciIZ1lPuK5fECfI4ee5hMJgjV0Nt6lUBVgRzAhpa9JSb2tFwxF1qy9eTfq88kUeLlej9y6PYrP
	aE2pPaH2AWgyIeGI/64gf09tGnVQKMpJ7kbukICYCKASXX2MwEj8c1WTDRtmYI8rLsrqqFDabSx
	53paczOu1y3wUQq5K1RWWsYpLRNW45GZLDya8Xpw/4gcTJEr/B+3ZvcrFXKtNHn/6DpBjRgDe7b
	zfD4M5w6kV7aveZ6J7PIB0okiGMErVDYs6J3PRAmI2FDYfzopPFvQ8FNk7b655TycABfxxBCMwL
	pHn0pqU5CNJi9rhpDtFRNJ0RoFVUuHebOqObTz36Pz7lvBII/v++Xa/Npqt5JICKcd/QRY7QgsI
	R/QrlxHMc4bFpTNtInHVbk+fSarhslDaN313+oLZv5ENvkNRA1bFmHNTN8ZEHfgcpywgUA8A7gi
	tAm3zwZdiPLdvB4mCUQPK3eFtZ+t54taL4SFMEfpAQkueDhY4zQg/JX6uV8+eWb+hyuSMm2+BVy
	dM5ZjCC4Sjrbrz2225UoLi0K6GTtPebnVVGgTAhJ+XBa+AcpR/RKawejqF1xJaT8zU
X-Received: by 2002:a05:701b:4508:20b0:194:9e7a:3ba2 with SMTP id a92af1059eb24-1b50306c4d3mr9813315c88.2.1794803662025;
        Sun, 15 Nov 2026 20:34:22 -0800 (PST)
Received: from [172.18.0.2] ([172.56.232.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5329ec87bsm2576204c88.0.2026.11.15.20.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 20:34:21 -0800 (PST)
Date: Sun, 15 Nov 2026 20:34:13 -0800
From: Chris Down <chris@chrisdown.name>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org,
	will@kernel.org, David Matlack <dmatlack@google.com>,
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com,
	loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org,
	baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com,
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com,
	joro@8bytes.org, kvmarm@lists.linux.dev, linux-pci@vger.kernel.org,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/19] liveupdate: Add feature header to struct
	luo_flb_ser
In-Reply-To: <20261110050202.529473-15-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-15-tarunsahu@google.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261115203413.eaa54fcba43adc22@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Tarun,

Tarun Sahu writes:
>+	for (u64 i = 0; i < fh->header_ser->count;
>+	     i++, fhdr = (void *)fhdr + fhdr->size) {
>+		struct luo_flb_ser *ser;
>+
>+		err = kho_ser_validate(fhdr, luo_flb_ser);
>+		if (err)
>+			return err;

I think there's a problem with returning this error as it is. For an
unknown required feature kho_ser_validate() returns -EOPNOTSUPP, but
callers of liveupdate_flb_get_incoming() already take -EOPNOTSUPP to mean
that live update is disabled. pci_liveupdate_flb_get_incoming() returns
NULL for it, so instead of panicking, PCI carries on as if nothing was
preserved, even though those devices may still be doing DMA.

 From a quick test with an outgoing kernel hacked to set an unknown
required bit on its luo_flb_ser entries, that is what happens after the
kexec, in that the PCI FLB is never retrieved and boot carries on.

Could you validate the entries once in luo_flb_setup_incoming() instead?
They are all written with the same header by luo_flb_serialize(), so
there's no need to check them on every lookup. Going by the code, a
failure there would panic through luo_restore_fail(), like a bad
luo_flb_header_ser already does. If the per-entry headers end up going
away as David suggested, then this check goes away with them, of course.

Thanks!

Chris
