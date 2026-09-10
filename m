Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BCF3264F6
	for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2026 22:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789080159; cv=none; b=DMHCfzxkjpmKJaWqmZU8mNL20j/TPhOD5MRpvKdsKFwNb9mU4qxxInNkCT9eOBIXg3F802GLRiZqb4ZE4hu0RmFjhUpZxI6Rf1rIEgYfeXB3ZPrv1wYAUkDEB8JP4nt4KNpQQ6e0zK3zcIIK4U4DmfqQZ/ZI1SRTFxGGZNQzjAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789080159; c=relaxed/simple;
	bh=/aQU18oU+Q9C30URZ29BYUyvxpIe+2DWhRjMH6ZLftw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ap09Wd6tDNj3Mha9/YOc83RLAkGK94wlaiVoEIVl/0juMlbGUMPXvaA0t26CMf3h+cLo2Y1uVUGkUwNjcaXKCq/7G1sYObOoQ8iee3WOMpYyiLYIm8AXe/perP2gdtyxyKK7CYeqIuUxgrzGWySbZu4R2mBzzD2GHi/udIHNwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tsBpdtO2; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tsBpdtO2"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1b8088203so388989a12.3
        for <linux-arch@vger.kernel.org>; Thu, 10 Sep 2026 15:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789080157; x=1789684957; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4UDtbunOd+y403pbt73/1ep0N3wlp/Y+kJJQS/7bASM=;
        b=tsBpdtO2UhcYfXbvehfjpuBqnI5GImZCs0U5rkYAIaJGj3jR8oRxKz3iLppDnLZzF6
         q17zXqBiyTWKOMAzRzd078dBisvlz6XcqCB/cD0rAH6CnXB6Or/vB41x9eWoAKyS4M7+
         mu64GFA50JAaYEYWcTUWxluMIckAebSlPGHj0WoUnaVfCXLs3IeOmDYjXtvSbs7GMvkY
         3EltZ3zc+jRVSRfFWlhuBo4HC13Dqkumt2lOngIVwqFX/Y0qWrobMjD4KuztFn+v831A
         UptmPSTsT5uVhiyiDspMaz0rDdHDy3VBqjNqhAI4Jgf8O8yupfKXG2KDE3ZUbEdhlEu3
         tKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789080157; x=1789684957;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4UDtbunOd+y403pbt73/1ep0N3wlp/Y+kJJQS/7bASM=;
        b=WgQIY82zS8myt5ayvLLKjwbqKIfb9PGIcpPgVumd17yhmLfUVVdy1oPwKq5BncXXxH
         sGgg2b0AVe8iUZEAFP8rngiy9tcxGWRVf4ji/5JdX2K+uiCIuISpGEQDIIvNymkONDYN
         9WS3rWmKu/7OZcCNsVy9Y8AH5azcFNkm8/sdRQ93JKxFh/QyytcdyJ/FA0FhT8/H+2Tz
         rtVKTVkJR+NAVLtHrwEUF6ipQGLwI9xbY14WaWaEykxIyAru18SAHIDvCA9ILxn9pDHX
         +C9Wsi//4/nEK5ewiAJytXd8XU1Qk6vzI4C/xoTvZV7JoEXAbw9R75qXYHeIKYfZi2r+
         UkaQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1uUkgcSOY63srbrZbSTqKXtaiqwfouoIabPDSRZtjnumq+ZVfc/qNlkoZpaDfLyqjwXJTe+4jhszw@vger.kernel.org
X-Gm-Message-State: AFuF++lv5e1r9QANUfo6Nu9iOK1/B7QDLeDwCA1dckPiz2zzdmQ/fuHe
	2UwJbxn90lnw4YAB8cm8Z0k9o0VQ6xt9NfQCMo7fS9ovUvqh3PNUrFP3fxKaxGnoKaWP1GY+GzF
	0IR0kiQ==
X-Received: from pgdh15.prod.google.com ([2002:a05:6a02:518f:b0:cc4:3b8d:ea37])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:22d4:b0:857:73e2:9103
 with SMTP id d2e1a72fcca58-86b336d6a0bmr1513199b3a.19.1789080156858; Thu, 10
 Sep 2026 15:42:36 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:42:36 -0700
In-Reply-To: <20260910221832.GH3968357@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903023452.721732-1-loganodell@google.com>
 <20260904160009.GV4157646@nvidia.com> <aptFFYqcSiBdMLE8@google.com>
 <20260905012403.GX4157646@nvidia.com> <aqIAtOoew-_6jw29@google.com>
 <20260910143448.GD3968357@nvidia.com> <aqLOWkuVKccR-I7W@google.com>
 <20260910171210.GF3968357@nvidia.com> <aqMgjXfTJ8u3n7Kj@google.com> <20260910221832.GH3968357@nvidia.com>
Message-ID: <aqMyXE-fD-UN6w5L@google.com>
Subject: Re: [RFC PATCH 0/3] liveupdate: Move to feature flags for LUO and
 memfd ABI compatibility
From: Sean Christopherson <seanjc@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: David Matlack <dmatlack@google.com>, Logan Odell <loganodell@google.com>, arnd@arndb.de, 
	pasha.tatashin@soleen.com, rppt@kernel.org, pratyush@kernel.org, 
	graf@amazon.com, akpm@linux-foundation.org, pbonzini@redhat.com, 
	maz@kernel.org, oupton@kernel.org, bhelgaas@google.com, alex@shazbot.org, 
	kevin.tian@intel.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kexec@lists.infradead.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-pci@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 10, 2026, Jason Gunthorpe wrote:
> Sean's initial email was asking for strict never-break ABI compatability
> rules on top, and that is what I've been reacting to.

No, I was never asking for that.  I think we just have a different interpretation
of ABI, or rather are talking about different pieces of ABI.

I am still asking for never-break serialization format compatibility, i.e. the
more literal save/restore ABI.  I'm not asking for full backwards/forwards
compatibility across all kernels version, i.e. the higher level "kernel" ABI.

To phrase things differently: I am a-ok if kernels are inherently incompatible
because they fundamentally operate differently and/or support different features.
I am not ok if we end up with incompatible kernels because the save/restore
interfaces and payloads are poorly designed, lack abstraction, etc.  
