Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795147224;
	b=HgAhv502LiHLcKLLaFbE1VPUH9QrMBMef35r8mq+Gi5FUvuBLRJbv2tDbL83TaThrWLX
	 IjFu7ih7oLsigkOvuFJgXZrkiJzQpVPLsCb2dcUbeyg3JR6POlui/ow71nXa0bPk/ngyW
	 mbG96/9fEIHjCWFYtLQh91g0vsd1iAvV0NBSXi8oLT5HPqYdbpqFunyHNc4xF4yh0TAxF
	 TJ4K+9HwDD1C2jQArDpLVlA3xHnzr2EcR+Oo/p0UQuOTdyo4ndSfvILrHTRr4PNszhz/z
	 kUDNmnabMm40WDhRE3eGYZgVGKoT1tXwmmvhfaeUMT28C3CHQqpCNbGbjDnQsNkVT5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795147224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=K98FROqv30LP4AMm6nG2V0NGt/4i9m8U/QmIKGR/nHA=;
	b=WFkdREkht59/CFqvIE//9ga/oiACaq8xqROnZfJd9reDZD/WJt5oNuaw+YG0uH9Ox1Qe
	 Y8SOn9/+Z8nxIfgghb0XYHwL449wQvXVQgvzvXck+PLGsQYZf9x6M3PKK4x8lHL5Ngh4n
	 vO++uD4g9HsFP4W3IkTmHbuAPy0u6C81gPV/U1RW6xXdo8HhhhSSVfAW0LsFlct7BdoCD
	 osfTaJ3dud4fAKPTx8Q7/hVZTlBb+zAjeOE7HnZhdNpTUjaLY9p1Y36Oa6vYMCIPm6fbX
	 MoP5kwK2Li6fI3RxqbBx5yrnV7GyfkbKL1nJcOnQwAUg8746j6heapwDLDcjsf8E38Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B5criCdm;
	arc=none smtp.remote-ip=209.85.208.69
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0B9606A32A
	for <linux-arch@vger.kernel.org>; Fri, 20 Nov 2026 04:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E0B9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=B5criCdm
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6b582b355eeso398063a12.3
        for <linux-arch@vger.kernel.org>; Thu, 19 Nov 2026 20:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795147223; x=1795752023; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K98FROqv30LP4AMm6nG2V0NGt/4i9m8U/QmIKGR/nHA=;
        b=B5criCdmTHpf648AOYOoTrsp7d3NtGQaXhm0wMw1FXI3k3qw+457SKF80eC5qUcEr9
         R5Jarg3tinhS/KE9BrIkFy3cbmSnVIChYpPMlyDW9+lZKO0ID9Z2fsL+JRhl6dfnl5wS
         u/0lzw3QyLg0SUhXq9kg7PJNK37zkAVLcXZFEgnPtuPAnpD+fadgjVq1GtCPSrfhUFiY
         BIgOo1wmzaloGacQItCbAPgBfbEoVgkdAr0aWujuWDehTSM49+mnRV62CDO+hXm9kMUQ
         YSTirgHtY4c5Xa8FG4gJ7p1jPWSue5VrdAxaaoO89BsEeROyX55jHwuC8zlqUq2NyrgT
         HlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795147223; x=1795752023;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K98FROqv30LP4AMm6nG2V0NGt/4i9m8U/QmIKGR/nHA=;
        b=PaEbEAKesEWsaXcAKGJ5juUCQLFCObwIpZmu0m4itaMqT7HsnZtc+T8PEVeyUwH8Qk
         bTNYJLh8dhDbD5RtXbx5nhaHnp1gX0CtWYgLf/9vKQn2imLY3JnoqJTeP4j/eellqtLG
         nt47FC71orFmvbnD73Gu9kqGwTNE1ktPDcZ0TQRbCsLSxWHd9ge4M9TZs/Aw5nH+F3BS
         /yHM64aP+dBAEpGfMfxOe05CMB8zScKkCDTtBpEP3P0KNgkPX/xTZdnWB4PnWN4erRsL
         0EEX9fn5FuON4zmJj3ekQzntlaFi9JMeuAfj6mxfn1QH7n8nDxQZF3wEDnsABD1Jz1W0
         P9RQ==
X-Forwarded-Encrypted: i=1; AL+hErHtxd/p3b7SBARnVPrwrtR3skNR8kdhygqmawjJEY1pJMWQid3Cq0aeRY6YPEMIxm1F+2mVh3siY1s2@vger.kernel.org
X-Gm-Message-State: APuU4Z/INSlAbw/t2PfgonzjMRJ3Zc9R/5fie0Gnk7VLeLZ1mJdVfxzv
	9TKzIBwQ5K2BuujxgMMmogq3qmPHY2QtvpOA04dC2EaPQ7KOJsPKw/rETeJcxQw/rg0DyZbamOf
	ThMAP8YyiFm0n1PtNpw==
X-Received: from edeg3.prod.google.com ([2002:a05:6402:5643:b0:6b8:a08a:8bad])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:501c:b0:6b8:afbd:64e6 with SMTP id 4fb4d7f45d1cf-6ba37edaf1cmr1021371a12.42.1795147222675;
 Thu, 19 Nov 2026 20:00:22 -0800 (PST)
Date: Fri, 20 Nov 2026 04:00:21 +0000
In-Reply-To: <20261115203421.38c206b35f5b12e6@chrisdown.name>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261110050202.529473-1-tarunsahu@google.com> <20261110050202.529473-6-tarunsahu@google.com>
 <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com> <9huz5wy4tufo.fsf@tarunix.c.googlers.com>
 <20261115203421.38c206b35f5b12e6@chrisdown.name>
Message-ID: <9huzmrr4f8yy.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI compatibility
From: tarunsahu@google.com
To: Chris Down <chris@chrisdown.name>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org, 
	kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Chris Down <chris@chrisdown.name> writes:

> Hi Tarun,
>
> tarunsahu@google.com writes:
>>Techinically this is just for readability.
>>
>>WDYT?
>
> It doesn't help readability in the generated docs, though. kernel-doc
> splits the parameter list on the comma inside the macro, so
> kho_preserve_vmalloc() comes out as
>
>      int kho_preserve_vmalloc (void *ptr, DECLARE_KHO_SER_HDR(kho_vmalloc# *fhdr))
>
> and the struct memfd_luo_ser and struct luo_session_ser definitions in the
> ABI docs end up with a member like
>
>      DECLARE_KHO_SER_HDR(kho_vmalloc folios_fhdr;
>
> I'd go with Pasha's suggestion and use struct kho_ser_hdr directly. The
> pointer can then say which payload follows it with a comment.

Okay that works. Thanks Chris, I will update it.

~Tarun

>
> Chris
