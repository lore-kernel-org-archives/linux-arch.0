Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628450;
	b=fWAnjGW86+o/ZbfMAmMYQK0lOoq3fItm7G2h9w46Y2MFnL2zOsIPN/4vuZhH2MysBN91
	 oVwyJl4p2dM/WWJGoGT+qw3CSL3bAw259VZGbjDjm6OByFXRUNVh2L0WBBISPUB5mBYSc
	 7JaU8Af6zLOOKzZbUCu3PG/zvo1hMhEP3QHYrYRGErFjUikZQlJkdBSXfQP91tGnJLXxN
	 l2t9clJMAFuuf3wt6c+pBwtsFca4UIc+tedrv3FZYp+pTQMXupb0+zYBzr6XoUI5ddDAr
	 8Zr8GvzWaCz7ZJf/0OeeuaEFLFZ+fWj32o4a97vGZfiMr9E/Cw4J3khH2OTdcu7zWUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=;
	b=1aI4WUnKNaypxRooOY4nlPJ+dCLGu87J/G9PB1IdjQ+OOrk+KZQdpSvilWaEamL309P7
	 qNgjta5MGdwpXZHUNHQRjd6HurytX/LAyG4VLQeoGaGGVv+XIuQLysYKRScVpykSLOXAC
	 tlc4BgSNSOWfLxU9V3Tuk7jbj8CQX09tZ0rp6SYZWF3si0im+fKFQerM5nOB109DS+uxT
	 fs1fxzIFI+La7y2HkFBU1sNrDRrPOxmO0sEMbm+hRYsTfdf+i6frDn9TDXy5g63nec5Jw
	 w5s6smbmVy2gUWCFAw9FHcHL7HtTbA6un9gG771I5j7/NbgsQtlWC5j7QovtCVWrWFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J6lRI967;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2E6606A326
	for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 17:40:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D2E6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=J6lRI967
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ae2b7e1e17so3915225a91.3
        for <linux-arch@vger.kernel.org>; Wed, 25 Nov 2026 09:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795628449; x=1796233249; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=;
        b=J6lRI9671S+o15WG57jtbE/KuSY4T4iIA1gf+hf2b+40FxycDJyeHlTheKGvsyZGQK
         fJvPkABnJYFxfWmcAFQqd+t3sJfu0oS8H0gzUHV1fv8YMTYZ5//NjSeQdPQY4Ls6PRqx
         KmoKjtS162gIt7De89P6JkUDoeojnQQwKnKU7ul1xknEzCdeHs7DrfGqwqI7pbNM/aHA
         qO+RTSMiEr+Vn3sNwlnp5LgH+hrEJyBhpKTl6R0MK6BJMMjAnthPX60zdqpzYzAnT/eR
         wbvI+Bg82vPpJy0+LZPZMf9P/9OIJ9LLA64hDBzeWmqqouG7niwNbHSEpYB3k4wchpgm
         fMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795628449; x=1796233249;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYycouvr6zOSJsdG8B1rvzwHCG0khxitcfoXgjaouMs=;
        b=RFZxX5u3L8gi3G0QMjimO4eSjtDGFk9kVWlawYLWpEFEexOwOXpyXx8GHqaiuhR1YN
         N2mRzddDEUFoE4L/y/IMGZx/OldkE7kl0ggydE6glynpXppQO8KT7V5sSENhDa9TKgD8
         Zk613cQuKCStuSKA+wPnqXVyCqF+JRI2jZNNxxdCSKh+jj6sAMuaasr3tXmkx/MdzymY
         qEfcOnTvbE7Tk8Tm4BIkGd7TBzE9rWQ6otXrcwEUf/hfkUujlrSGZxXOI6K7xzJrjVPD
         b83Fa7gbJVRyZGmNfbU/PinKSLgq9a109XpRENS3Pv1h47gYjYo6d7bm8tvQ9Q+Wi2FA
         D+Qg==
X-Forwarded-Encrypted: i=1; AL+hErEG4nx4HHQ77q0rDf4j+Em3q/Q+AkgZWfianHSthVZaeYHYABrTJD50akOAf2+B8dyWHDmQqwfjjv8p@vger.kernel.org
X-Gm-Message-State: APuU4Z+3n6XP6ezrJfXgYciU0PIGnvAAdZVvnY91w7SFd4SFL60uuL+w
	mCJEA03/bBnWcPpszauiJP55liz9X3dDHQ6ZufPZq5glQn26WXOOYKV9uOYNZ/NlBw==
X-Gm-Gg: AZFdTZfbXCEGIHmoM9EeD+oodPZCGoAv6nMBuvWpxSlC6ExuYw8SumEyurE+R/t6bBW
	ZQMvibfnKdps0mTo1+GhVzyZT20PgoMg0cUPRYU86u0BwSO5XM11MkEgyAkg2xK3ZwjcRy99WUC
	CGEDkYpzSjA/sMTafuDRT2q72FmkPIiy+3Y6mOvcHBJ3weHKnSC8mEEwC54t2/1KUYA/nOTmd8P
	FQsDQYEIvp2qXfPsKTWaiTJLbou0h7qNPvhInUmpgvmqnTBxE3glC6hB/63GlOsfqiZ5Z5Sl5IE
	bkeJYnxqekBDTXVNFmh/oN1k6Xv9QcuAOak8SeQeDQ+mR3PHUT8M46rRW48OzU3pQXA9e46BPwx
	1xUsTwzkEo7/WI/vgyWkI5vWXW4ZOJxj65YLBcOaFavhxKhcxy0KkkrKfqPgGr8o9xJo9y/YX/N
	OBufH+iTP6EY0zRh9DmdEkHwLDQT4L/QE7Vf6krMLfTx0/r5zer+3R0qcaKFVu0IUD8BGd768da
	vpw4N7h57TLwTQ/15hFp1bcHNnFelEw/pXentIQ1F2oKX9gEL+xvtLd/jWOr2d1cVHy2L14DDL0
	VwyDQteH3kVntbJGZgsR0G+pZZlztNUXGAxclnAx3OZeBB8oCE4F854238bEPXXr
X-Received: by 2002:a17:90b:390b:b0:3b3:fe22:2745 with SMTP id 98e67ed59e1d1-3b41c933edamr18216503a91.45.1795628448898;
        Wed, 25 Nov 2026 09:40:48 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405ecbd0bsm31676002a91.15.2026.11.25.09.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 09:40:47 -0800 (PST)
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
Date: Wed, 25 Nov 2026 09:40:47 -0800
Message-Id: <DN4H5ST3X9L1.3IUEC1CA5QI8H@google.com>
Cc: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "Alexander
 Graf" <graf@amazon.com>, <seanjc@google.com>, <jgg@nvidia.com>,
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
Subject: Re: [PATCH v4 03/19] kho, memfd_luo: Reference struct kho_vmalloc
 via serialized pointer
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-4-tarunsahu@google.com>
 <2vxz4idb1i2w.fsf@kernel.org> <DN3VG4JCILOO.YN40XHHSWRPH@google.com>
 <2vxzld6hx97g.fsf@kernel.org>
In-Reply-To: <2vxzld6hx97g.fsf@kernel.org>

On Wed Nov 25, 2026 at 6:43 AM PST, Pratyush Yadav wrote:
[...]

> So I wouldn't want to support slab until we have file handlers that
> churn through a lot of preserved objects.

Makes sense. If KHO slab isn't coming, then I'm fine with the arena.

One thing I realized is that the choice between the two is visible to
the incoming kernel. With separate allocations, the incoming kernel has
to free struct kho_vmalloc and struct memfd_luo_ser separately. With
the arena, it must only free the top-level allocation. So we should
pick one now (while memfd is bumping its compatible string anyway)
rather than switching later.

Separate allocations leaves the door open to KHO slab but wastes memory
in the short term. It's not obvious to me which direction to go :)
