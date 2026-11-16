Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794803668;
	b=HRSVrzNB6A5yFXw6mr30BNEMmId6DTtESMsFb7kmzhHb130GdDgr2Eh9fZQQIZP6nTKw
	 xdBexsUVZe/Vva0NQRqNqotOQaXcPQTF/CnHH5r10a8VuAJyOwj4Y2piJvUrwpHzMl5Gi
	 Kk7uXS9qSqYaywMLMDkdz1zGayoLtfhwEdcdgxzVzXX97TktAO5mfs5nYA5sZy4AKuR8d
	 LbOSC7CDiPdGUFHlGI238NkxROgGih8wj4VlmJ0Cri2FwIU7s8m1Do9z5yZySol6+7ZAM
	 zcJQDZv45h/Q6I9RlLDQ2RPkK6GiFvsTv4HDX0Fv3PgFmgrW46i3vbHSZyf7YKzOodA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794803668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=;
	b=JZlpwGdbfvZLg5xTWR8BcZYKofWv8Tq1wmZp1MG4nLCrK9KnAGBMogqFyPpxTOJVNFLB
	 flBjxFC6TzqzJxUXbksoAwSwWFnNoSKmQiTffrelkPY+9bMVlO0PBFfUmULGHYpj0WwU9
	 XcCck9DUC6ywwby9wDZoZhab24cVTwz9prS1lG7Qf8yRdge2UPdNo1v6SicXc9RDkBcXn
	 235LmQFXlp9UOq1IaQk2Ye5+lfiwqV3qB+88S0Z+qkWuEGQOj/RlW4wQc42jQBfgpKjV2
	 u63MZV7DRS1R0OV7nrwgLmraEDgm4i3facMnmBNzqBMnvOC4OBUkXzf8xTyoydvYs2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Hf3+VtbD;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF95F606A32F
	for <linux-arch@vger.kernel.org>; Mon, 16 Nov 2026 04:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF95F606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=Hf3+VtbD
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1438d9363fbso1418581c88.0
        for <linux-arch@vger.kernel.org>; Sun, 15 Nov 2026 20:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794803667; x=1795408467; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=;
        b=Hf3+VtbDTfzgXLI/sO1VMbmiG3HjPWLPXQC9K/x0cUqbiQ8byVDXCgJVkDqWGH94aR
         b30c7OGKR5Ve2w8uFEu7hCMIH5aAu5hXb4FYyBCKKc8AKtr3mECcpxs948DTD0bMi/BB
         Zn5fcARDQKEQQ52hBvf9q416lDQQd52msqG+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794803667; x=1795408467;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yb0ouDgf9S/OdWev3vcVfqdIAaKZrYAoDUUyKNG3AEU=;
        b=Kjuk/M/AhH3mT1XLvOxZobe3MgU8r+Uwujht/ptB5S3GkieAhjS5+b0LUJFFMxGkRp
         t06hIy+KMfMNd2RmvhWrAfN7zlPJQ/yWvbstgtBqoi5vm8S6yvxbXBlBtPtYmjUhelc9
         +G6+lkSd0lE/9IuDcE5xQXKgYiYtM8TBGfEPvkA4ksT5XCKx3hQy5+QejlyEfsMNa39i
         n8b5eeX+7aQXdlYP+ooOb//pjEumj/e7uBbqFc0hI3pn5JVE/XuK9VhtQl02OEMhe07V
         N1JoqLpC6R7v/WMVJsxD70qC0iOWldCVschtctyBlKcYj/s4Is7NonJ72a3fjxM0h2lq
         26yw==
X-Forwarded-Encrypted: i=1; AL+hErGA4EiqVASaPS5SHElgCSEPR08ImwndUJJYH93Ab3vZLyKyDzjNRvm4d+5F28PVLME4HHdLo0XhGjnn@vger.kernel.org
X-Gm-Message-State: APuU4Z90myl5gVPfnT1+8B67vRm6n/9Hc3iL+m1+w3LQ5RtLp2TfkjGD
	hmhGNoNfMzmZusNEI8x5NuqS4/SENtZD3szdB02sOULipRYIzzMH9wf/zBSUJvVkjuk=
X-Gm-Gg: AYBFou2OCGOGFjuPTMfCnusXuIae5AIQ+A4J5b49OhgSsgQqy6WNXKF1WqEFciMbmcj
	dYKCWXfmB7coJymDo1D5G63FkSE8TYQtBL6K6RCCNrHQuKwOuLn+DUCvES07jFiVDOZuvMxb9ul
	OjLAf+no8qk6QayACk39DypcJes74V1B1jTBuLjmSvt8rxYu1qxGBINU9re7EvItLRO58Q70XZx
	smYYpE+rsm41hKX1adr110w5ABhjiLofUHdiOHlZO7Qi/1sfepTSVVzmMFyA+JUksez3otV9Q2s
	esYPVnY6IiKDNfp/Wdapze6DOe9W597WBAzZ/6emJR9maG8ntGbTjhj31PS1QLSIKgKKwHE3ppJ
	Ogv/rpH0rE6MRyftnpv5nRR/tgAczkUsXmTs9LTDyimNPghAsn/EDoIm9VhoLHukHAZqXeEMhBS
	GdXrOzYkwsOf1hf/DvakoWcnO5Eat1CsVuV5r4qmyfd0J7ovAZ0zwgmhkxo5HYGnLs6cYHDn9bT
	q2/73dwsMJAepvjQBbFkvFNiJIlDXDQQ7b9o1ltwUQ4fVCwgmiN0mi74xKPh3a1auuZk6WSHfeV
	RWiCRIDzRF02Dnkb3tKWjQfxBgQeXs15fvYihx2Aez1s+3nExBkkfQlKqU2Jxom2O7lQl5ao5V/
	NSk5UmakIAa0t2bHWa28fFAyVFxq8NCgS2/mBVUQL3zYmruptRNMyx9/f6WH4Ra9Kc9OdIt1bp0
	Y8rKMZULlKNueeYriHGPUpK6F70EJT/9rcZG+V6wPgfh5YCk4s789j3ujA+cRGd+gM
X-Received: by 2002:a05:7022:b0c5:b0:181:6b8:31f1 with SMTP id a92af1059eb24-1b4f5f3475fmr11110443c88.10.1794803667022;
        Sun, 15 Nov 2026 20:34:27 -0800 (PST)
Received: from [172.18.0.2] ([172.56.232.151])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031918c7sm38362148c88.9.2026.11.15.20.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 20:34:26 -0800 (PST)
Date: Sun, 15 Nov 2026 20:34:21 -0800
From: Chris Down <chris@chrisdown.name>
To: tarunsahu@google.com
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
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
	compatibility
In-Reply-To: <9huz5wy4tufo.fsf@tarunix.c.googlers.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
	<20261110050202.529473-6-tarunsahu@google.com>
	<DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
	<9huz5wy4tufo.fsf@tarunix.c.googlers.com>
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
Message-ID: <20261115203421.38c206b35f5b12e6@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Tarun,

tarunsahu@google.com writes:
>Techinically this is just for readability.
>
>WDYT?

It doesn't help readability in the generated docs, though. kernel-doc
splits the parameter list on the comma inside the macro, so
kho_preserve_vmalloc() comes out as

     int kho_preserve_vmalloc (void *ptr, DECLARE_KHO_SER_HDR(kho_vmalloc# *fhdr))

and the struct memfd_luo_ser and struct luo_session_ser definitions in the
ABI docs end up with a member like

     DECLARE_KHO_SER_HDR(kho_vmalloc folios_fhdr;

I'd go with Pasha's suggestion and use struct kho_ser_hdr directly. The
pointer can then say which payload follows it with a comment.

Chris
