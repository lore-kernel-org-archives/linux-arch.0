Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322063;
	b=5dtYV22hoZArbMWND3FAw1Yt5k0n4cVIMjOodbZpz2hbCvQLeAmg9OiMOxP6P7VDbnWh
	 MhdnPS/sFktRbNhACFAmM22xr0eDLLKhGq9zk9ltiEBZF+FCXfjK1msidqdDiGMGxkPV+
	 hjeR/9zL2fQKZPDCQGHfR1SF12UQoLKZXytx8qAZuNhYVm9M2oopgs00D4M/lYtIjZTjb
	 iK4oshfOGz+sdnVCJmLPQW1dwKryRxL4GdlP7A1hocWnucCIuVmdsfOjFdyjs/kbDFU6K
	 sDs4r0L1st2cgvdZzRbXIdX2sjZMhSvOS+k/1ilpOgRovLQWtymc3/brGotenso+g9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=ZFEAJe5RSOFhQbOQqwNvxFPxejburOXhpBzwnwwZqdo=;
	b=309s5AGWOR9XFntMv7h2vmF08kcQthtsf1NXIZdROlSe4Pe8VXgnMK8vAqsUgD+2E8tB
	 +kSDLs8IlFfd9qenEZflRW6q1pXv37qWZy6GgUhAwI5Th13P85RdofWNG6skwh3G7PD8v
	 gCgXq9VCZV241pxCdp6AmJrehLijs0evhSXqkeWEUbjg4DD2VHamI+Bi7HCt+w5JzCve5
	 dzlJR37ojPrgKKfAA4pUY0wo20yNRDg3ZBMGIVZli4/wkLNkaNz6FpaslLZGeBkgQB9ym
	 SjZrdrwyxs75OyV3k0ovfct8FtOeZ4F94o8ZK2OO+Tb2MngBFrkfPK+UGJAIrgtE1GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b="f0p/9ton";
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5B60A2618
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 14:47:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CA5B60A2618
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=f0p/9ton
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7d2e14babc8so1203535137.2
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 06:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794322061; x=1794926861; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZFEAJe5RSOFhQbOQqwNvxFPxejburOXhpBzwnwwZqdo=;
        b=f0p/9tono6w5KMbcB2YOWm+TL1bShXXnItauTtZcZIA3ZauQXIbiJ6XJ3s2djH87ip
         I++QPXZ24umXJMRImSi8/Qtd6+iFrcnT1HCa/uiivkfR0qrd/97rzFC1hadvLbEESsaB
         etu/IGSL3ldDcWfkSkPBixVVJFSZv3iv/bSMW1Rio9VCub4uYaphZ0lH5RCS/fOG3ABi
         /O6QwjFsFbHtDlsKHFz0JeXBwhyg7Z7sLtN8pt+pKSeElAl0i1sTmRS4FRBJVDtQlrzt
         EhBrv7K/eUdt9HAfk01RcYnkVOJY9hzzR0qNueqX0ulGGRpYW+6IC8NOTlwyCaBHLrkt
         cfqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322061; x=1794926861;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZFEAJe5RSOFhQbOQqwNvxFPxejburOXhpBzwnwwZqdo=;
        b=yjyJnnEmTSKh7dfhz1s/271gNot7gnF1d55fhxe6y7CueQEXu2mazDNF/tPtXwhFM+
         N8shJF2wyA7qnTojdLozBvgqT7DV7DBdAX03DPh0Zaewb2kJqfeeX9EeCmFE21eQUIg+
         3Be0CsstJBNJxqRupSEis49v0gznYzwFWU0m6/2UMfBbu8w0jS4OPflGerq4r41mHpcl
         FEWY2lXHZBEtmeZwWIqMzre9U8YULKdkcjwLcSNF2uM3q/UEVFSImRC6VLs7iKMsI9nh
         b9j8dhqiNsnDBtfRbeprq4I6dBFt8aqnvrAGq3DzdlKPy27mMDhuIc58de5xoRwH1njL
         VlMQ==
X-Forwarded-Encrypted: i=1; AL+hErGfOkPaHU538SJuVH/zHaiffhJavzMRCHVVmyOfV29UITcOUSQeyRvfIp47IQey4JJGUYCPPp8NSpFh@vger.kernel.org
X-Gm-Message-State: APuU4Z96RjxE8xEciuPRYt+C72Sta5rgRCH9UcgAgu99pZOfdp8Ljcgn
	C34XHkaGvDLrowUUapkJUYz6iF2Y4M31XsFSwsTmw7NMRb8QSRR33qwLxT4nhewUjpk=
X-Gm-Gg: AYBFou37AIxU3rBLsYYOexfJVmBjy98qf7ZNg7sBsJwLi/2m8vTOs0mZjZja9GOBbmX
	N2M8sVdi3IH82scbmK+fV1IXbKmTgLiO6BbSIx73S/R15z/3fCw9UbaIpm7xNZFs/Cljo3rcWwM
	0i5QczZ84AW6JsQRwMYXfql8iEC0/kbExHKUGjPpBmO3YuYhiglipo3PvSR34ziuM+UTqVTI54b
	U5b1M7r1igoc15xNo7QXAx/iPmS0SMwQGjbxCfVFJQJ0Y7dcxnDMKfI9J4okxdDROpSlo08Thi/
	Jjb8mpMZy8rB16VfnD4PxSkJn32qCRqk68zUMqTs31qK62cOpScs4LzGIoyEN3OVAyS1qrPwCMp
	c3m1l/0DaoGO75qmi0tiL2zObhi0D8UKcK1M34e4fBeVZREnyEN1UPCi9mB3oAmuCbhg5MCKCT7
	ttM1Q0B7MNtWay5V+n/uyrYdeQxUro56nOYwUewAZFze8KXAeD5iLHKkBZZQd8RZxNgo/S0mthS
	NnrzKg3hw7cm2B1scH5fZ0ePDW4aAWda2VxkAZBCh+R/lJqdRxlbRLzexTjis+bnrV7gj7GiSVr
	BGOW8hHecF42KZrPn2TY0o6pdsK4c8+NSCKUJ4lDrPMhqrP0jNaK10vg8mFNBU90tmtKpG9200a
	HfSnaZsOzGWgHXsSJ+y2bzkcjd19hlrlFEI+et+2p32OdQWA=
X-Received: by 2002:a67:e706:0:b0:7cc:26a8:e716 with SMTP id ada2fe7eead31-7d301c2b6b9mr1064638137.18.1794322061210;
        Tue, 10 Nov 2026 06:47:41 -0800 (PST)
Received: from soleen.c.googlers.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c2003b37csm1895903241.6.2026.11.10.06.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:47:40 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 04/19] liveupdate: Reference struct luo_file_set_ser
 via serialized pointer
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: Tarun Sahu <tarunsahu@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, 
 will@kernel.org, David Matlack <dmatlack@google.com>, 
 Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, 
 loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, 
 baolu.lu@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>, 
 oupton@kernel.org, alex@shazbot.org, gle.com@google.com, 
 pbonzini@redhat.com, Andrew Morton <akpm@linux-foundation.org>, 
 kevin.tian@intel.com, joro@8bytes.org, kvmarm@lists.linux.dev, 
 linux-pci@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
 kexec@lists.infradead.org, kvm@vger.kernel.org, iommu@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, skhawaja@google.com, sagis@google.com, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261110050202.529473-5-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-5-tarunsahu@google.com>
Date: Tue, 10 Nov 2026 09:47:35 -0500
Message-Id: <179432205559.2329176.7688399969919556416.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=791;
 i=pasha.tatashin@soleen.com; h=from:subject:message-id;
 bh=qYrWWLSjrMyi3btEEyRhgD14ybrNmyQeqN8ETOUOvP4=;
 b=owEBbQKS/ZANAwAKAbt3KEzbc3reAcsmYgBq8y6LmPCnN2SrnZCSda58BBnTZsMnjk7g+kA/g
 6Wo/AVJiseJAjMEAAEKAB0WIQRBMaqT7LRvGvB/NmK7dyhM23N63gUCavMuiwAKCRC7dyhM23N6
 3qrED/9liUyRUpQr+Sv1ioZ2pUvLcetyB+2JoLxaB/0UYYNHqDXpwWtEHhSP3eAYwEET2WAzSzb
 cINjQ0UdR20OJBBxpWT+3R6jrxl6smFx5lA1+CtzCdBONdl5NiW3+NITRy2Ip//vGFZKdNjWFk/
 5Y0ii3L7iz6hVXT9R9y6mqGOo2TBCSa84xWnOGrVJ8ijAnCqgOeAMhmqVN+rkl/dWCvzMcCFZZP
 AYRuSxmCQaOa9GxsOttPL5pX10r/UbwioXQZu/aJ6RcG+ql2liIZFv1+3mcSyInleN3SlnUZOVi
 inOQM3Yp2D1a6ekPH7F6Uzb45X4qnnJ8DSfO2LkVSWgmzzpsKuXUePJ8Pe0a7FfO9mUYj5Fp9wg
 IxfJUyigWzzPN0aOcgePZcZBT4fLUlw+zQV3UGnfTiTzevMagmFWU2+B/s0Zt7u6TidXvFQsMFI
 6ZlD5aySuQGLYM3+UdGdp96SY6FEGgvqmSCG63zPbq7Y2WqSBl153diBep17zLt4CJ8n3Fd+YrU
 E2rPF9GR7k6MT1Qc2tSSvCCk+cTjcDt4Fm3op7Z6LrxP3BQDFa0Fh2afBgG5mCHbK8fSxd2uggj
 NuHbXeBNgQpe1vKYQQd97AUSoFlymseer2cfqgpdkxtIZwGdPAYPchrVuPHKx6mZDNkSz6VZZ49
 k5DwAzPXt9kz4Og==
X-Developer-Key: i=pasha.tatashin@soleen.com; a=openpgp;
 fpr=CAAAB722DD22A081F0D49F35633A6A993D43B569

On Tue, 10 Nov 2026 05:01:47 +0000, Tarun Sahu <tarunsahu@google.com> wrote:
> struct luo_session_ser currently embeds struct luo_file_set_ser directly
> by value. Embedding struct luo_file_set_ser couples the session layout's
> size and field offsets to struct luo_file_set_ser, preventing either
> structure from appending fields independently across kexec.
> 
> Convert struct luo_session_ser to hold a DECLARE_KHOSER_PTR pointer to
> struct luo_file_set_ser instead of embedding it by value. Reserve space
> for both structures in each session block-set entry, placing struct
> luo_file_set_ser immediately after struct luo_session_ser, and bump
> LUO_ABI_COMPATIBLE from luo-v5 to luo-v6.
> 
> [...]

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

-- 
Pasha

