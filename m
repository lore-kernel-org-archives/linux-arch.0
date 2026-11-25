Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795567195;
	b=ElV2J2mElDs71x7Cj0DKT34uBY00IzGXhJJo8ZzcNfVmQuNomIlmgXx983s04vceucmr
	 trKnEtLfF5KQ5CK6dHfCSmpbtWm4fOIex8KxvGyomHXT8k2JamgM1lf2w3Ab/UPdMcRp+
	 rJ9EOjyRzL+QH0IXDYC4sKdEnKkAz8adL6Hv/AztlTSL1eF4TEj+aex6iCA9sp9hEv2Xq
	 lEIsRxKLcs2khSjxWVg7Fcx9fY8HCQ7GVHE+WCiHapeoEbZwBjyLQMWDK+b662Xa958+d
	 PtrmvhsOl4FeJaK/WMFiXUsAGJDX6fk3zb+srXMSMYRGnnrxK6gs59Zx/SNM3x1+Vjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795567195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=;
	b=EBLt+qmJenscIcws/as/tKTRKqYNTXKAQh1CpNxwGTIe5yTFdVg6nlIJoq+0MKH6shV7
	 9d8tE5YWb+KSppvsbM25F3Sbzpl1dcgTY0qa/cYcH0BXulgbrNtP8K3U9pZ9kokQ0/LoH
	 /UcrNNyYZuYke5TOFZG5RfJs+jaA/UAopMiIAk/NNwYIU83UIPVBw8IlXUiFuJ7KEHv1N
	 JqytyW4NPwFNB6g0AdSpdG0orLbAxnYIzQcvQ0qDwWqH+NuXR/H7MlMB1aeXM7eMAK04W
	 bv5KXYne1YV3FzuQlaNelEuOJJouu8g5hKydJadC+jtz+gP6TAwxdILI0dAvJu3zHGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iU0dIwTv;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A576C606A32C
	for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 00:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A576C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iU0dIwTv
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2f066274caeso21643955ad.2
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 16:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795567194; x=1796171994; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=;
        b=iU0dIwTvZSJ3oZDT4s2CYWT8eyLf6vImduktWp4JC7yaK0FWQ2FlJA+deyc742kbWF
         QVwexeYViuIyKn++vmTxSfx/1MkWT+BOkKb3tF+tY959jNCyiwk8qs55tnTEDfhJ0M2T
         mvnq7CHLh2b3871yyE6nyAJzzjpQccc6OxjVrFjxtVafR4t2HxJzOoXkgYgYzH0J7Unq
         lggF1KAHJ2om0xtla7kj5dkZHHx6ItR9cpmK9okF7uEZxkN/GaJ4MOCIFXX0rIQtRv/H
         NeyLLGLYEUpwQs+E+lM1o8DK94HnoIZUoNjbfz6QB/NYepP1Pt/oTy6DP3ErzH5Cpi0B
         qK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795567194; x=1796171994;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YKxHcqUXjQp/1J5J8B8/Kkrmh8UptW8ucEK7buHNuos=;
        b=tf1UCiRKwhv0w/Ozhb21u19lDi9ePpgMQiRqHTU6LTLkuA3GKwqaSLruFVjzJUg+fh
         0PHgg9aQKgQWI2pD8/Y8e4HUnBoBSkZDpGXRkMJoOLzW0NggSp9yWXNp/5QzXOGPvdRm
         g4wwVE9CpgMw/Q7xsdYEL78es/TZ8PInkAD0UOES5/1w64/5mEmZ/9w1/ZHL9qrvK/Vm
         Tz2AfX1waNJM+3NyEf88UjWlvNs+sFYFVwEYBLxxB/V6MbZ4NvVTiQeKX9RNtDErCNLG
         0mlvld/BSs0i+ld6499zeS3Gq7Iv89U/9W8IbNM7osBE0vTSlk+9AfuqJQunDpaa2e3Q
         +07w==
X-Forwarded-Encrypted: i=1; AL+hErHKfK+gsx+IpvzQvx8eXLGQqZVeiQp15Oz0C5F//Z2eUGs9NO/sS67usCu5jrZqi5xHQ90nAD7x/fI7@vger.kernel.org
X-Gm-Message-State: APuU4Z9ebiZbIOx0zZzax1rs72v/bJ4FLCkVK00BDKL+7y64iQ88NQy3
	27G+NElupT1gaB7jdirMHa1paNEyqXWxdoiF1we4hvvZUoJdHY+g2iorHyXYCy6UqQ==
X-Gm-Gg: AZFdTZcFKgXsnfELk/7+W23gZW3K+JgZxxU+NAdVVjgDdQWElb9ufP8DHINs8SghYfe
	YKVjF8EFdMae7jbNE6EbwwLhD2qY8wmaAFSa0jYb2vox4ND/lhOZggTS7HskMdut+bTqAQ6oqsW
	W1aXlm5plW2huy4vPLBBzIk9QYHCgVFyquIoHrf+D/djlTRzLbxWy7zfFcb5QygJoOxDfQYh24Q
	QKO96sDrDdEOgG3USonUZrJaRhXikCyTyYnp2s6Enf/oAXdZRqAab6VA00W7cgHF8XGVlTe2S6q
	W+Yp+yIrAvbyubyiBmA5Meto3KmW1XZIKLsE42FVuebLZD3wafXIhDTkagxNBwtGMP8wAkQ0XNn
	GJfRA3tFd/+0cTjywkMNVi0to+GeKfH/ggW6qf5WWu4Aaxh/xlngQ2Mq0qi+G3kPlvB4BJwOf+D
	vO+gyZOyP/gXz5nHQTdE/q+mw1xKMUyCC+ePrapwP7bOxI5vyysrIJ1Sql3yOlAInWi+AkVJH0U
	BGjrfDXeiI0drKP0NDRo77obIM7f9nDSZLsGKxFnbw9tQGciUMO0rSTWPq1McJFdWjQxLK5ewTC
	9SAEjsY3x56mvi5brPhUC3R3HWP+In7uYtwQDEqaApzOPtDI42SXDF1sojyRjFzu
X-Received: by 2002:a17:902:eccf:b0:2f0:25ea:8fa8 with SMTP id d9443c01a7336-2f03f176abamr169618335ad.19.1795567193320;
        Tue, 24 Nov 2026 16:39:53 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee848c1sm75603595ad.10.2026.11.24.16.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 16:39:52 -0800 (PST)
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
Date: Tue, 24 Nov 2026 16:39:52 -0800
Message-Id: <DN3VG4JCILOO.YN40XHHSWRPH@google.com>
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "Tarun Sahu"
 <tarunsahu@google.com>
Cc: "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike Rapoport"
 <rppt@kernel.org>, <robin.murphy@arm.com>, <maz@kernel.org>,
 <will@kernel.org>, "David Matlack" <dmatlack@google.com>, "Alexander Graf"
 <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
 <loganodell@google.com>, <arnd@arndb.de>, <dwmw2@infradead.org>,
 <baolu.lu@linux.intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <oupton@kernel.org>, <alex@shazbot.org>, <gle.com@google.com>,
 <pbonzini@redhat.com>, "Andrew Morton" <akpm@linux-foundation.org>,
 <kevin.tian@intel.com>, <joro@8bytes.org>, <kvmarm@lists.linux.dev>,
 <linux-pci@vger.kernel.org>, <kexec@lists.infradead.org>,
 <kvm@vger.kernel.org>, <iommu@lists.linux.dev>,
 <linux-arm-kernel@lists.infradead.org>, <skhawaja@google.com>,
 <sagis@google.com>, <linux-arch@vger.kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-4-tarunsahu@google.com>
 <2vxz4idb1i2w.fsf@kernel.org>
In-Reply-To: <2vxz4idb1i2w.fsf@kernel.org>

On Fri Nov 20, 2026 at 10:19 AM PST, Pratyush Yadav wrote:
[...]

>> +static size_t memfd_luo_ser_size(void)
>> +{
>> +	return sizeof(struct memfd_luo_ser) + sizeof(struct kho_vmalloc);
>> +}
>> +
>> +static struct memfd_luo_ser *memfd_luo_ser_init(void *mem)
>> +{
>> +	struct kho_vmalloc *kho_vmalloc =3D mem + sizeof(struct memfd_luo_ser)=
;
>> +	struct memfd_luo_ser *ser =3D mem;
>> +
>> +	KHOSER_STORE_PTR(ser->folios, kho_vmalloc);
>> +	return ser;
>> +}
>> +
>
> Hmm, I am not a huge fan of this. This makes doing such allocations
> quite annoying, and I reckon we will be seeing a fair bit of them in
> many places.
>
> The key observation here is that most file handlers need to allocate a
> bunch of preserved memory, but they usually can free it all at once. So
> we can get away with a very simple allocator that hands out memory
> linearly.
>
> I have sketched out some code for this, take a look at the patch below.
> Note that it is only compile tested.
>
> Perhaps give it a try and see if it does the job better.

I agree the manual packing in memfd_luo_ser_init() isn't great, but I'm
not sure we need an arena. This seems like something KHO slab support
will solve properly, and since kho_alloc_preserve() already takes a
size, KHO slab can be dropped in underneath it later without changing
any callers.

Until then, maybe we should just allocate struct kho_vmalloc separately
with kho_alloc_preserve() and accept wasting a folio per object. For
memfd that's one extra page per preserved file.
