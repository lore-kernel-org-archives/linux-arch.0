Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327836;
	b=slQKD5oejgdcXHC1EtidOIymC27DGkd2uA17sDMUzQywY5s7rndflTt9NmQmNLqR7aII
	 G5m8vr3JaXVqaY9UPUterIFI5VCHicZ8RhgVDw2KIIG3vn0jDtFdVZeb6vUCLRoPowuFx
	 zaOfc6tlXfS/ca+QLN7MD/4UtSi50PbOLpouGsLycw432txdC4lNmEwtMxO97ODdJJGEY
	 F//yMwp3Y9VhCw4xF+yDxA+poXALv9Gt/zYaHVrnf5i2HU+xNvCt/fbA/TqI0yT60do9I
	 SnVI4wTn3cyV2dzYsh+ksS0LGzmwnWtNHYcdmcpvRpNXFagUjJH6Ha1KAIhC2FTaYBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=Mw9iOCkEBWkvxdLSgoJVCB6jT3T4ThA8jIPRTFH0lnY=;
	b=cz3bhI6ZVWwq1nTp33/iEQiVQdscoeG6DF4s9DMEuYOfsTsJADT6EJWhyypveJSjhntN
	 d1x2pCprrNVR8zUSgp/J6BAycLm04bndlS5wXhMxBE9JvqB5+Nl1BNGYes2Z/a5cHXfjl
	 xsz2KLd96lBnzTfD7OJlXQZAdJ8tAWVMlJBCWf08+qy4KTNm6+fTW5GyG4ddbUytqqlkg
	 E+ngEyjsu15cQ9eg9QIeTnCUjqFnBla+TZ2VvrZfHKrcdyqY+ReT+/nHr5/OmoYsBUYq4
	 JTpPB4SwroocGwP+EN7bhpPpYD+1XFUlzOq6EUCiaZLVOeGjR1G1w8ZKfcsaNBPeRzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VSPzJL76;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34188606A321
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 16:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34188606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VSPzJL76
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ea138a3497so14295335ad.2
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 08:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794327836; x=1794932636; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Mw9iOCkEBWkvxdLSgoJVCB6jT3T4ThA8jIPRTFH0lnY=;
        b=VSPzJL76+wTF7+tRHaTvgknu/rdXasZus90UA5dew9kegykwMMzKH/F1V6GxO7RQBH
         4/OoTFVOHyB4E03Dq2sjac2puiHJm+c4fvoFKJLJ6EEpCLTW90+KxQKP8Xk4x1JCosEq
         Qn1NC6kr4qdwt4JzE8ObsRxCsUeZmKjtT2SBeeizeKBMIl7bOARS8kw8yLezlhGZJVv0
         o52jzOWxsMkIIBT3ThUaLCPi/QAmSZxKSqqb6hMrak99PMeAxD3u0dk/TP7xs21D2Iw/
         Ez/eieBRGPY5ouf/XdRZ3e00nlnuno9Ot9UU0ZRzVZtwWy7hL9Ca1MHSbWRqNGS8EsIb
         6SQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327836; x=1794932636;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mw9iOCkEBWkvxdLSgoJVCB6jT3T4ThA8jIPRTFH0lnY=;
        b=BV/ADBGwWhFnvtDJ5b3opHv4BNKQLzcy5LLE/YURrLWm87tvK+MceweHECw4wm8FcK
         5+zTMq0d1x4587BGTN0hK6TIiC+RqUvNrWmp5YlzfKwQGL7VVOp75n8aT6WuY/q5nN9E
         78RLufjAQShvsP3nTvATAVVAs+W+2MQPgLIT/a4wB+F5iMtaQy5eBzLsGz9e3z8RySn4
         QncVy1JqW/npEp5+RQqOi/Wm6QVlSsUAgVM1lx3wbwLjxjn+GfKe1UYMGKyp1R0rJVAa
         XOWAXsystKgT1IflrJIQyAZbAxgtxEVNsvcz8/RJTu6+O9QXwEKlHxXFfw+8XktUyRA/
         9Hjg==
X-Forwarded-Encrypted: i=1; AL+hErH0+JguEfkHAtPcMPEUbRxiAr13x1D9mEaIHbU1ZbWZHGRvq9UoIQCwMgWBYWRKY+0paA4nG3KQOsxw@vger.kernel.org
X-Gm-Message-State: APuU4Z/Z5og4UgJ2APU1GzN0fM4DNv2qGLDxsmbvp9o4POZIWSaYGlpw
	3Vts/tFdiHw7PN/5Ooyfaqk7NbjlCSkmaVO0dRtYbNm49/JVz7UK6hZ0O1bUxg2/ZA==
X-Gm-Gg: AYBFou0xTitMVufpjICItjenuxUvO6x0rZ2Bb2kTPPFsjT0M7aMcVqBZ4ITfrVFK0Di
	I9Hf89VEyB9fCspKtHJX2i6bW6yUumBBwCpC47ja+ylhKo0zWWdj2dUzJVjKHFH9CA2WHsYd9M0
	8eouqF7YgE6fTOLp4HHvTKbbqITiS06az0Py8/HYmR1Rf1cKsQd0Q9+x2avvhzqBetn0n+D3Yug
	SeMuhH6eJ6HqxafX3XK+QLCy4YeszkvT2guH412yPK7vBf5AW8+inaJH/z3Wnd/0C7sWsTAhlEl
	DMsgh6i6QhmDEUT/34CPSOb6mMW8JQRQtlao1xzE8s2wyL6UOGBvbLrrG96jchM41X/yejUmHdT
	Z1MD6gAUFBAJZNS+i6Jz2x8guDfjyc+p4lHOSDRdSVzBtAIjHWoa5Mk+UDihd+qTAFmUu06y0DO
	tE6aglZboM1ltAMiBpXVi/DQM/U6jD3QyTa2kvQxA9CH0z/Yiear1qXdty/gnJDS8yrb7w8zXjc
	0NLBiJsU5Bd1QV3ZQldtcXrzk9vRNogTBVm0Y3BPXb4VB80Re4LzVEnR7Z1g6WBsDb7fZ8l6CN7
	NqGrRLpuAMj/jbXKO2YEgEIGjHCSseXKo1pNMgvLWtP38W44o0R1e6ZBiOMvlcaS
X-Received: by 2002:a17:902:d4cc:b0:2e8:18ca:5f46 with SMTP id d9443c01a7336-2edb9146ba8mr28990585ad.14.1794327834955;
        Tue, 10 Nov 2026 08:23:54 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d7d964sm11306915ad.32.2026.11.10.08.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:23:54 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 16:23:53 +0000
Message-Id: <DMRO4QXXB8H4.127C1CPT3RZ18@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 16/19] PCI: liveupdate: Add feature header to struct
 pci_dev_ser
From: "David Matlack" <dmatlack@google.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-17-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-17-tarunsahu@google.com>

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> Precede each serialized PCI device entry in the PCI Live Update KHO block
> set with struct kho_ser_hdr via DECLARE_KHO_SER so future per-device PCI
> Live Update features can append fields to struct pci_dev_ser without
> breaking compatibility between adjacent kernels.

Elements of a collection should not have their own feature headers. This
applies to patches 10, 12, 14, 16 and 18. I raised this during the v2
discussion [1][2], but I don't think it was addressed.

All entries in a KHO block set are written by the same kernel using the
same struct, and the block set has a single entry_size, so every entry
header is necessarily identical. They don't convey anything that the
header of the struct that owns the collection can't. In this case,
struct pci_ser's header can define features that describe fields in
struct pci_dev_ser, and the PCI core checks them once before iterating.
If a feature only applies to some devices, the field's value in each
entry says whether that device uses it.

Per-entry headers also cost a lot for small entries. struct pci_dev_ser
goes from 8 to 16 bytes, and to 24 bytes once the first feature is
added. Patch 18 does the same for every preserved memfd folio, which for
a large guest backed by 4K pages adds gigabytes of preserved metadata.

They also add new ways to read out of bounds. kho_ser_payload() trusts
nr_required/nr_optional in each entry, and nothing checks that the entry
header plus payload fit within entry_size. In patches 14 and 18 the walk
uses each entry's fhdr->size to find the next entry, so one bad header
throws off every entry after it.

Instead I would keep struct pci_dev_ser as a plain struct, take the
entry size from the KHO block header (patch 2), and in pci_flb_retrieve()
check once that the entry size covers the base fields, plus the fields
of any features set in struct pci_ser's header, e.g.:

	entry_size =3D kho_block_set_entry_size(&incoming->block_set);
	if (entry_size < offsetofend(struct pci_dev_ser, refcount))
		panic(...);

That also restores the minimum entry size check that the v10 PCI series
had with PCI_DEV_SER_MIN_SIZE, which this version drops.

[...]

> -	kho_block_set_init(&incoming->block_set, sizeof(struct pci_dev_ser));
> +	kho_block_set_init(&incoming->block_set, kho_ser_size(pci_dev_ser));

This size is never used. kho_block_set_restore() overwrites it with the
entry size recorded by the previous kernel. Passing this kernel's size
here is misleading: pci_flb_retrieve() (and the LUO session/file restore
paths) read as if they iterate incoming entries with the outgoing entry
size, which would be a bug.

Incoming block sets should not take an entry size at all.
kho_block_set_restore() should initialize the block set itself from the
incoming block headers, and the incoming paths should drop the
kho_block_set_init() call.

[1] https://lore.kernel.org/kexec/atl6K2Juy6Bh29lh@google.com/
[2] https://lore.kernel.org/kexec/at-8vkVpN2SF3XgB@google.com/

