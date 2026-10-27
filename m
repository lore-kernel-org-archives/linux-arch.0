Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118075;
	b=5AFV4ykyRsEvnFINcw2Lcjq7q8t4MfTzAamPmXlEdjYQr1jMWQwYPrjwNJh8TiSfd1rs
	 +3K+Uwnyd5/4NKif84egaSdkJ1fq7rkkvIu+pazTBQLYlmxYIQtB5LEjTootbCYvTKZUe
	 QgHqcLNtZ6ywfBr8VYHsUj1AR9IYDdITIZQGaaau0HwCyaLomZHXqfskAXBes9qouZyQP
	 gfEIz8p7dZOW5kZCvEPxXg0Dfic0o3T6evIMS0unElJqy0GHKt1BL0tXvgc1aHiGUD5Dy
	 N2nT4yZISA+ctdhyJzNHzqwzfdUHZ8crSi+kVaMiTN64iigCHxjvDvtP8ymSqNNg8Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=PxRb990Xj/uwND6b4fXh9A/3T5i+xI2zB08D/68nqZA=;
	b=idNx2XdolqjIkm7P45NsX18DJpYyrlX8itzkNs7ODG6bnk6JbqP2/HkeYSWerPlgIROM
	 LXt01THmoonAyGCEOzo3U+pD4aQqBnGmWshPL9CX0ktXrBhoOlE59CxlalJDRm0WrslSd
	 HTF5r94zzEbChXgBnQMSaSHJREpEnZ1nY3FeuEcpSTc51nopGA8P2gFUVcnI0IczA29B1
	 S4l5pj8zgzQ1aMSoE3hlG+nTISGIdvXl9rU5WHC8Z5/ZqEG2k21cDXq+ZrhJ4D7kKBk/Y
	 /oCVfkYanIYTBuVSPYQ8vk7YpTXBZmQw/729ERu212FtgU8mbrOfJIONvhxfx9SOmUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=I7Y8uOx7;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A686606A31E
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 16:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A686606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=I7Y8uOx7
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eac3b6b2ceso25011e0c.2
        for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 09:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1793118073; x=1793722873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PxRb990Xj/uwND6b4fXh9A/3T5i+xI2zB08D/68nqZA=;
        b=I7Y8uOx7weI4v4W6AXn/znpVoq60HTz4BzA4kZYqzylWKLMgWPEI/kHDMpFAJKaxEW
         dMWp56tqyuqHCMl0aXjxrglevtltP8ipvkBRGG46atadiYS/JtDW4cIxH6WwLsAUvip7
         fZ8N0S6JoWn+bDQAJdo2DtJ/gxo9c3hp/BnaS1RFijYBIda3/v4GLitqnj1Ws/B7a2Pn
         fz1qPsy0Qm6tmUdB5d3qOcYc4P2QrsfWBQLhxtBJ5rdHgq5XNcgZNUNJT5T7j4P/2JjO
         Ecm98gklWri2xQ8NhdNb1FWUN/6eG4JjOrFzPdIZ/BC1uGg6ea6CeIaDGLqn09oiPzXZ
         wVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118073; x=1793722873;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PxRb990Xj/uwND6b4fXh9A/3T5i+xI2zB08D/68nqZA=;
        b=V4ioUlKHbmEeNlpTy2CYm90R/seHoFU3M0GDkXCLV96V7meWrlfjjLfyG8ltJFJUiH
         4T3JfEAXHAq2U1JAEFhY9cP8C3QhCw04NpvmZahAInnNBNtxQ8isWKLyKEqgcnQqEL2j
         1+37Gqy0Rhk6MaTnUilOz99hJlRzSlT36Mw81EG8tpngAXNrGmNvTKl/eL63WAJM0DeR
         Qt+2mmGy2gyNd8I0PoCJwUGpD0X9ku+gAAgK1+/zkWdREBNKsQ+uAmVsg8CV9f9nGUU0
         6HEU6VUEOaeXmJi/5EaTYAztRL0s1+vwcWnxAbPBa4siWpRIRnaaRQy/enczjXdpvZqh
         1kvw==
X-Forwarded-Encrypted: i=1; AKwUvBzHBoB0rdus7fyiZggwIqT/EFkmfqc14PM+CNSYPLz2WiOefCVoQoD3xNxJNnXZq3zX713ob4gXS5XP@vger.kernel.org
X-Gm-Message-State: AFq9FYIw09epfjjmK/3Jc9b3Y5USqe5W8esSBNDHK5UxgCBFNJM2ahcd
	6WRaRcQP3nnTrmeQY7NmpTg8LZy2+ZI3Q2hjnPtdoWcd2GX5X+XxMHfCtY8tuVF81l0=
X-Gm-Gg: AYBFou18sYy3MwbJTsL/+3Hz5S88UMac5Ac3NA8iavIIYEu+NpBx4zNsvlkcH38S9iu
	D/NvpoOpiBwqIqdCJ80U+gWPEbzV1sB4wWR+KLTaGm4FwlZkM3YthfM7ox9tR+FxWphTSaFTcqg
	F7boSVQDvp1CycZ7fgTpmsDiAO4K9GHW9eX/t/soWdTIb+M1DkvWoZ0zXbahCTMcsGlP87X71m0
	n2/0itVfkkdclN45QBUOSWP/ooyScjL6y40BJivIgL9jv4GzdZ6A+UJdgT6Tqc8uQFXfZP6Vxfe
	H5LMk/E+PMQpPcOMOG0E9pDEeq/ZINW82kuBSkWl5hl9CvVMYMg0xVW9rtl4sUEvOcLvIsO8kPB
	TBJTyryBhyS/3bBNY3jdhWRkI7qRMyHeH4fFBw7cT3QMpsJ4X37HLsr8tT6pj8J8HhAg3QjDcH8
	DgwjtiPAYlF/athLDMgLe/4ybbZcxhnkfEb7U9KipRO932LLJqLxSpnH3vKu4jJM+5x7upxZPKQ
	+d4vMORp0LMIzUb6AuD1kBcer2xsrxXakPCngQbfml1NsnX253jyOFy+1LXeJZbbn6OYthT5Opo
	lIkb7PcdFa0wyWvTkUdUKJ9Ic1Tjw1Nn9Q5+p0fsPvNV146VarHUWd4v4IAe1NXFc17T/FtJeM0
	Ig6o+2sLMuAWhbLGjlHWW/STUjtjNHA==
X-Received: by 2002:a05:6122:1352:b0:5c9:c60e:3a40 with SMTP id 71dfb90a1353d-5ec232e48ecmr4515149e0c.18.1793118073126;
        Tue, 27 Oct 2026 09:21:13 -0700 (PDT)
Received: from google.com (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4a5f26c7sm304662e0c.9.2026.10.27.09.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:21:12 -0700 (PDT)
Date: Tue, 27 Oct 2026 12:21:11 -0400
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: David Matlack <dmatlack@google.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>, tarunsahu@google.com,
	Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <auDPd6tjzACQVszf@google.com>
References: <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
 <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
 <at-8vkVpN2SF3XgB@google.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <at-8vkVpN2SF3XgB@google.com>

On 10-26 20:49, David Matlack wrote:
> I still think it's not advisable to define name##_wrap since anyone
> could accidentally start using it on the incoming path and we wouldn't
> notice at first (especially since same kernel Live Update tests would
> keep working totally fine). I also don't think asserting the combined
> size buys us anything. The header size is just a function of the
> number of features, and what we are trying to protect against is
> structs embedded in the payload changing size.

Fair point.

> 
> So I would just do:
> 
>   /* Marks struct name as a KHO serialized payload with a kho_ser_hdr. */
>   #define DECLARE_KHO_SER(name, payload_size) \
>           static_assert(sizeof(struct name) == (payload_size))
> 
>   DECLARE_KHO_SER(luo_memfd_ser, 16);

My main requirement is that DECLARE_KHO_SER() in include/linux/kho/abi/ 
must be enforced by the compiler rather than being just a bare 
static_assert() that someone could forget to add. Since kho/abi/ headers 
contain both versioned structs and unversioned sub-structs, it must be 
mandatory to declare versioned structs in kho/abi/ with their 
static_assert size check before the kho_ser_*() helpers can be used on 
them.

So, how about adding enum names like this, that are going to be required 
in accessor functions later:

#define DECLARE_KHO_SER(name, payload_size, nr_feats)             \
    static_assert(sizeof(struct name) == (payload_size),          \
                  "struct " #name " size mismatch");              \
    enum {                                                        \
        __KHO_SER_SIZE_##name = (payload_size),                   \
        __KHO_SER_NR_FEATS_##name = (nr_feats),                   \
    }

> Plus helpers that allocate and initialize the header and return the
> payload as a typed pointer. Both the outgoing and incoming paths find
> the payload the same way, by computing its offset from the header,
> rather than through a struct with a fixed payload offset:
> 
>   /* outgoing */
>   hdr = kho_ser_alloc(luo_memfd_ser, LUO_MEMFD_NR_FEATS);
>   ser = kho_ser_payload(hdr, luo_memfd_ser);
> 
>   /* incoming */
>   hdr = phys_to_virt(args->serialized_data);
>   ser = kho_ser_payload(hdr, luo_memfd_ser);

These would become, where without enum, the init would fail:

#define kho_ser_init(buf, name)                                     \
      __kho_ser_init(buf, __KHO_SER_SIZE_##name,                    \
                          __KHO_SER_NR_FEATS_##name)

And payload can also check the existance of DECLARE_KHO_SER, using 
(expr1, expr2):

#define kho_ser_payload(hdr, name)                                  \
      ((void)__KHO_SER_SIZE_##name,                                 \
       (struct name *)__kho_ser_payload(hdr))

We can also add an optional kho_ser_alloc(name) to allocate, init, and 
preserve.
