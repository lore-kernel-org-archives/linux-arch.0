Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795546936;
	b=2mj2ceMObsIM58rcWUAdJy8p6Lu5I+Majp2QnCHr0IACByG2m+f8RoG0LSu2wVm+/YtZ
	 L3zQ4e2/0CEggkleoRLEYDZa3r3W5RXJGiPYS0EQYH3GpPaaG1rwlsjbInYHd78/su/6h
	 DqcytRHsDlLYmEJSGadQ/rdOxU+Ai1ai2tgPe419WPCW8c8s5YCRowCRtyT/h1UpzcQn2
	 vPzpsopwncT590nmguFSKwvLmiWy3Jtejk0tz9JzrbeJqGIbqXetnjzJnt81eVj8gLhjx
	 lBHKzFyoWcx5sSIKZ7XpP/DVQmErmzkC7qmU6ADLnD9mU3Ue2bm0zE2hLByIdjC/g9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795546936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=;
	b=PqX1TtOnXLUGxnFOkyfZQpjR2D7YB11+c0SGzHEMMWsEwQAKfzPsMuVwm6FRXxms6e8h
	 TiWJVIlihzNm7JCg2Iqy7O+ftz1zxOJLswJzsXBpPImhzZRciE6TCPt4DWUIggXCW0K1Z
	 cNacz37ZXi8OkcNTc1fvMXoG7weitFcco8AfuGU5hF0WdW7KIAq2fPIyp/bVozGau6/qU
	 ZPjYpN2fZzmbY8DU9WN9XIIGTda9+0QbXPRTd/d9CebtyChQAhtWtDJhDjHv0OhkO0cSe
	 /SP3bctXfFnZwQi9FgWvMFLitLOIR9GLx8L+BFOnLDUhdBaxlOo2XRO/t5OB5XQqIag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W49HLn5R;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC25606A323
	for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 19:02:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCC25606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=W49HLn5R
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a4c72951b8so3146647b3a.3
        for <linux-arch@vger.kernel.org>; Tue, 24 Nov 2026 11:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795546935; x=1796151735; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=;
        b=W49HLn5RkMaC5OffA1iNYwWj3QcXjho4bBBEYyHJ80sMc/UPULZx0is/eDJpC2N3ib
         U5411fK9H7EvaHNUiAzyNcMRaRfWUePxiO5nF6dXRnWQcakCLoOcwBez1qwCR6R1oIfe
         q4c7EtVSFXNeliYrDeUDxIDrBA9ZIJuyG39lD2tcmw1MBgaf0y6E9eqLCYzDMbFPT8aQ
         T2II96TRsePidFGcPlSyAkLQbRIPL4z8RKR0PPlfzSoiEzHTM2cY+rkptgAAFD2Cwvml
         DpAfsAN2AKGhtv05DtjXMcA4gmT2Ub8TyWWHMBLSJzr10iAYvLD8v6nEW2UiNe6xEGzX
         AF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795546935; x=1796151735;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vmPlBJsxyoTZOO9g2mmGNuUfH7b/frSSah/ZWuzVmhc=;
        b=iJMD4mZbxtSPYlafd2JzOaRpUTf2QcOhfI6GUgDfianE9++MKkQHp+RF11J3HiHIdA
         oxg26AEsKnnjMb8ezsrPFEkGHkmT6b+UrqQ+L8Q80ciHB3o5Fgv6kXmFTD6oQm3cSmrE
         AaIivrWl5rrL03CHLbjee9mLbTz+WEOn9bXoomrG/eLYLyw7+a2sM1qpABbogJfPoakb
         9xJvfKlv8wzuEej6qgaQb4qhPYPT+Tmx1QqANLVRyzxeWqWsqP4YdYIXXnfZGPaInY3C
         EgxNMPy5HavjZp5/l2EyXfGr0afh+ZCARgImB6VrrWrUSZFjgtkOd4Dbc6I2AeWDPIke
         bYBw==
X-Forwarded-Encrypted: i=1; AL+hErEOAQdJmMDAKxfrWWUHULkUsRQmK14MOGtBpVlrzG/P9rXZm2dAPfmPeMxtlZj7q9eWWsT11WsiHqxI@vger.kernel.org
X-Gm-Message-State: APuU4Z/wvPdLVgU+jMdusX4ZrqbZoYgYMUZcYH+wvC7WRWopKUbFnhRe
	ysS92KxMpcXxJ5Bmj+InBqy2RlhlqVRBbhKev6o4gWHVDtY1/0+FnslI9vrgui0hNQ==
X-Gm-Gg: AZFdTZcUc2Wd9B7YSRfvbHVAKcblgefzSJg9hMAzhwug80z/VQYJjWG74guhoUD8GpZ
	S8MQE3kZdDVDjXMu7BHYQ7sEkzvbwXBH+NFginFht9W5sVt/Gw6hq2CDpYZTHjQhEfvDb2vN9xB
	rkRnIgRFWyHGF3Z36VYCKzfXzMm2jy+Xac38ELEXm1J/h5ggh73DXpqu+4tKubm+1hWBwwi4+Mb
	k26rDhR4iQH6thefH/rjWWNxJUoCPo4bh2Q5MhZ9sJoh8C6U+3wjHeNNPavPcrE4S7lzpgdwb46
	++iDv3lrih7a4KnZDDaN807XV8S3IBagF/7rqTfelYl8a1zsZBK4f637HigHD9sPPN60ClFVgWX
	zpUytRijK056VCIjqk6yudkl1K/tnnozi9z2WstfxAQrrLtd6Zp6NcBVCeTeaSqm5sDj8aWFMj9
	6jRjWoR+KWRKfKtnBc6vbCbby5GQhmpkqYLJu5cUgKN60Idy4o2hBrHo2sjzq+whS+10u9XZ32z
	3Ar+zZDfiuMM5Luzn52ttaM0ljZZUdNpuBMbpiWxawo15Awe2HtDMe0EIwsW9Odb6oHsvp9cnXh
	YWODZUSs2GXX7/XA7rIz5HscLtxRzTbPfvo+qWl4mZ1vAbFmMrBI6Qoauy67KLOg9w==
X-Received: by 2002:a05:6a20:a11f:b0:3e9:f2d:d556 with SMTP id adf61e73a8af0-4014ca44d17mr16159174637.55.1795546934090;
        Tue, 24 Nov 2026 11:02:14 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde9bb05981sm2247135a12.26.2026.11.24.11.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 11:02:13 -0800 (PST)
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
Date: Tue, 24 Nov 2026 11:02:12 -0800
Message-Id: <DN3O9LHR4XNH.1EYLA6D1F0J2P@google.com>
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
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
From: "David Matlack" <dmatlack@google.com>
To: "Pratyush Yadav" <pratyush@kernel.org>, "David Matlack"
 <dmatlack@google.com>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
 <2vxzse0rzjdn.fsf@kernel.org> <DN2RQ7LGX224.3W3PSQ2PBHTJZ@google.com>
 <2vxz33sqz1xj.fsf@kernel.org>
In-Reply-To: <2vxz33sqz1xj.fsf@kernel.org>

On Tue Nov 24, 2026 at 7:25 AM PST, Pratyush Yadav wrote:
> I don't think it buys us any functionality. It just hides the problem in
> some lucky cases.

Following up on our offline discussion: I think it's worth keeping
support for optional features, both before and after the spec changes
land.

Before the spec lands, optional features are the only way to enable new
features at all. For example, the PCI follow-up series [1] preserves
BARs and bridge windows using an optional flag. It's purely additive: a
kernel that doesn't understand it keeps behaving the way it does today.
With optional features it can be enabled as soon as it lands, and Live
Update keeps working in both directions, including rollback. If every
feature is required, there is no way to enable it until the outgoing
kernel can learn what its target supports.

After the spec lands, optional features are still useful, and at worst
harmless:

 - Kernels that predate the spec mechanism can't provide a spec. As long
   as one of them is a possible target (e.g. for rollback), optional
   features are still the only features the outgoing kernel can use.

 - The outgoing kernel doesn't need to consult the spec for optional
   features at all (less complexity), since by definition the target can
   ignore them. It can always produce the same payload, and only
   required features need to be gated on what the target supports.

 - Nothing prevents an outgoing kernel that has a spec from choosing not
   to set optional bits its target doesn't understand, if we ever want
   that.

The cost of keeping them is negligible in the current design: the same
number of bits in the header, and one range check on the incoming side.

The one rule we need is that optional really means safe to ignore, e.g.
optional data must not reference preserved memory or carry restrictions
that the next kernel has to act on. Anything like that must be a
required feature.

[1] https://lore.kernel.org/linux-pci/20261019213054.3157159-5-dmatlack@goo=
gle.com/

