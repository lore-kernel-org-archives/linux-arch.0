Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794335150;
	b=AYaNaNW0K0TOSuC22s2RnwsnUoRJtS3wu09zJdVwYBh8/Knsslv5QeeCYNJKiGrogAdp
	 lzkTBRf4FJCqDf+vDjefOaz7rWd6hI4KrUsQqlkOWgOUQqnkhx9zKXFCBRHuF4zUFWQbK
	 NHkXGGTNV3RjYKCExD7O3E0qVvQE+AonQRQAzx6kETbVst8AHZ3aTL650zJsXbb+tLRj6
	 6hKk882p0BhEgnXHrsi45xUjwji4guRMbcplBUsBoXtm40Qy4Kr0Lvo/5aS1VSFDrE6et
	 firIYXIw3L2ep1gAj/2rdeSg1W7vAR+uM3YGUo3AutEjsrTcWqR/FsvAo+lwqcSsobg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794335150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=;
	b=Ei+o0I1EONXDedPT+hVTEIMYAKNxqxomFWpFs5N9WB/JodXrvMxgdDSnbje4W1H4pzdB
	 F7HOEfPRChOqUkhTZ+IiRskitMv3+v6xVFDjktel1XMGpmNlhuzSYZy+mg8i+EitNh/Vw
	 M+MoqXfBjABajamOMwHZovYEdbEIw4s94ASC6CFaPC3RvRxaGNOmQV1MdznQ181DanKD5
	 JbI402sft0uO7suh6TanYaT8/f/U7iVLBUx3U3qnElrwu9waaoZJ67EFGrxp/5ZdN+0i5
	 GA3KZ5wNFbxjiznsUTHRQr8CWVxcLpLQLP+TdauoGfyOwOWcrc7B17MbdI9tMr08D7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ss2sAv1Z;
	arc=none smtp.remote-ip=209.85.208.72
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABBD606A332
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 18:25:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BABBD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tarunsahu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Ss2sAv1Z
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6b706aec674so2388617a12.2
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 10:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794335148; x=1794939948; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=;
        b=Ss2sAv1Z44xGCzrouTTSNStulPTKhVCnUO+g4V7Ttgr82dioG8oDl/aa9BFjmSvCYi
         euurrMXPzpvjVfF2ZfKzD82qUQBBtXAN9f+MJkGikK45Tj4cAehpSd8POZHmWpeSUTNa
         ee90SX5pk+PyA8l2gVtwImvYurJFi/PPJudDUyeLNd3LrsGsvH6KnVfocewpXHvIiLKq
         VjnnbVpNS7FQdGG2Lc5//B4NgFsI+lF/Az+FjkxpMpXT6wrqHKPZtvcjAcfxV7sSEMxX
         WSc7JvmUyi5mGyRJmJ514aI1wQP2Xz8QRVxCIv+4tiJbD3usEEvyGPpAG5S96WBYg/hM
         99Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794335148; x=1794939948;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pg8+OEnjDNmIa2RbISOLY8VoGEN6y0ux1Fnyr8R7io4=;
        b=jpTIL/tMBCkDCKN80zYrV5PywBHo3vz3+oeGs9wx9yskYAudtoS2AdHJo09ZEf2eTa
         i9UcyLCg9+UOncHbVYY8w3TGe6wm+X4pb3EduERr9aMjAgmkSEO4bvax7hD8FGVTPAj8
         cpOW2wbvCBGLd5JjYjB7nsrK2qwtIGrR/fwP52nIytTJ87jrkXXWBSOE5cVdc3+urgVN
         J8owvn3fxzrpkP+3nA1+DSLOxY6V6uaydSM0X7HtcFFo1Utd3u92LdvbQQsNp3+X6aAH
         xWjZGrNGFRQamyvmC8Cf/sLPTj37qqK+lCiozYh3MHJchFTdgvpox2aRM1mA8NMl1Qks
         Mvyw==
X-Forwarded-Encrypted: i=1; AL+hErFLdl0DBMf+a1edRhhN5+vvorNvMJBtRFFEi05hgnQvufKpqFm+XM11c5eVC9uIQ+nDQh5CcmZ+kA0X@vger.kernel.org
X-Gm-Message-State: APuU4Z+3/K+iBdcrPhI1KwbcfIZAb9TiiJNo30Wr43KwLeoKtEpZjquI
	rDA171/KZ+ug26vQu6462I9vqG0y7cCAbdyyd9U34Qm9i6b6HOXS6EhSU3ckXrxKW1h5u09K0Ar
	N4Z9pMoP66sev+nh0yA==
X-Received: from edfg4-n2.prod.google.com ([2002:a05:6402:a244:20b0:6b5:813f:c569])
 (user=tarunsahu job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:13c5:b0:6b5:76be:be54 with SMTP id 4fb4d7f45d1cf-6b777829b2fmr85425a12.35.1794335147866;
 Tue, 10 Nov 2026 10:25:47 -0800 (PST)
Date: Tue, 10 Nov 2026 18:25:47 +0000
In-Reply-To: <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
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
 <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
Message-ID: <9huz5wy4tufo.fsf@tarunix.c.googlers.com>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI compatibility
From: tarunsahu@google.com
To: Pasha Tatashin <pasha.tatashin@soleen.com>, Mike Rapoport <rppt@kernel.org>, robin.murphy@arm.com, 
	maz@kernel.org, will@kernel.org, David Matlack <dmatlack@google.com>, 
	Alexander Graf <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, 
	arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	Bjorn Helgaas <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, 
	gle.com@google.com, pbonzini@redhat.com, 
	Andrew Morton <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: kvmarm@lists.linux.dev, linux-pci@vger.kernel.org, 
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	skhawaja@google.com, sagis@google.com, linux-arch@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

"Pasha Tatashin" <pasha.tatashin@soleen.com> writes:

> On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:
>
>> +/**
>> + * DECLARE_KHO_SER - Register a serialized payload structure with KHO.
>> + * @name:         Structure tag name (e.g. luo_ser).
>> + * @payload_size: Compile-time expected size of struct @name in bytes.
>> + * @nr_required:  Total number of defined required features.
>> + * @nr_optional:  Total number of defined optional features.
>> + *
>> + * Size and 8-byte alignment are asserted under CONFIG_64BIT: KHO and LUO are
>> + * 64-bit only, while !CONFIG_KEXEC_HANDOVER stubs pull ABI headers into
>> + * 32-bit builds where u64 has 4-byte or 2-byte alignment.
>> + */
>> +#define DECLARE_KHO_SER(name, payload_size, nr_required, nr_optional)	\
>> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
>> +		      sizeof(struct name) == (payload_size),		\
>> +		      "struct " #name " size mismatch");		\
>> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
>> +		      __alignof__(struct name) == 8,			\
>> +		      "struct " #name " must be 8-byte aligned");	\
>> +	extern struct kho_ser_hdr __kho_ser_hdr_##name;			\
>
> Remove this extern.
>
>> +	enum {								\
>> +		__KHO_SER_SIZE_##name = (payload_size),			\
>> +		__KHO_SER_NR_REQUIRED_##name = (nr_required),		\
>> +		__KHO_SER_NR_OPTIONAL_##name = (nr_optional),		\
>> +	}
>> +
>> +/**
>> + * DECLARE_KHO_SER_HDR - Declare a feature header variable, field, or parameter.
>> + * @name: Structure tag name registered with DECLARE_KHO_SER().
>> + * @decl: Declarator (e.g. *fhdr, **out_fhdr, or * inside DECLARE_KHOSER_PTR).
>> + *
>> + * Declares @decl with type struct kho_ser_hdr while checking at compile time
>> + * that @name was registered with DECLARE_KHO_SER(), documenting which
>> + * serialized payload structure a feature header pointer belongs to.
>> + */
>> +#define DECLARE_KHO_SER_HDR(name, decl)	typeof(__kho_ser_hdr_##name) decl
>
> Remove DECLARE_KHO_SER_HDR, use kho_ser_hdr directly.


I added this, because wherever in the kernel a serialized struture is
preceded with kho_ser_hdr, it will only be called `struct kho_ser_hdr
fhdr` which does not display (to readers) that this declaration of
header variable is not alone, it also holds the serialized structure
after this variable.

Using this macro, it clearly explain, that "Hey, I am header to this
serialized struct and I am compiled time initalized using
DECLARE_KHO_SER for this serialized structure and my pointer holds
location to both feature header followed by serialized structure."

Techinically this is just for readability.

WDYT?

~Tarun

>
> -- 
> Pasha
