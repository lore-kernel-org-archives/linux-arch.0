Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793049253;
	b=ThjUBszwsvGcPNK/p6iUMKga40dICiifbMNkyPuJhvQs2l5VqWHbor69ceurHHb3s5FQ
	 ReWv3MVWTL7q4M05WB2fyEVto3hktKNOesTr4TBKS3fpC5A3Ov2+VP2iGtT3Vtn/4b+Yn
	 Etk9m1NwResmUOQqYWS6enKjhYlsrJZlmoRNVEkt9ALXRrW20muSDSMkPwCjwTccfR006
	 Nwmp4vkN8ei0/qpXY839se6CuCEsAjEb3lA3qC2+zWH0O/joTzKI+w3O9ON9RE6XXvfc5
	 ihpbxEm17mSq8U+nOcKVYo+WdqdOpLVaY4U7n7uHaUo9/TcfzgKpdq/A4uM9d3VbpzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793049253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=gKF3hAWDK1ltcE+SHB5ZbEu9q5rcNDasVCUAn/AhQHg=;
	b=qayWE93S8hbmIZ7tiUaJJG7BQ7IJy9/DvMVzOMRcj4gm41s2Ua89wKnlsya1Eu+UFlgk
	 qtAB0pOUt/0UcVSzQeRfOk1CSo4WjgmOLKsI7lRgHY4NIFElSdppulBm7MG5QI5iNvObk
	 tv5do2RjDLNYDWju9MOpaTmupgV/2t2OTBcLboRtR96Jf4DT8eMLgRHEiqgGF3nsXxI+P
	 nx5GR4Ri73Y+k3ycjcjo1OrcmpliWvl4lxSsgy5iTI1P8YO+MoCK4LM5uF+SDrAPa6hnk
	 4tpJ/XklNfgAPLjAhocLINEYAhd7VpbMl4acqss6Skts+B3PWn0KeoBHXVnhf2cMUSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K67nv9XJ;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1510606A31E
	for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2026 21:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1510606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=K67nv9XJ
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so1223517a12.1
        for <linux-arch@vger.kernel.org>; Mon, 26 Oct 2026 14:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793049252; x=1793654052; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gKF3hAWDK1ltcE+SHB5ZbEu9q5rcNDasVCUAn/AhQHg=;
        b=K67nv9XJ4TeaL34vMeEZnzHwkkjAJXvovbKt25dK0ARJPImK8eAJxasjllvcrO3Mvz
         0GnHKSvbs2j+fu1L93vtVfYaEU7xBX2oBxVR4XSp19D8BxbS5MYCpBV1+ZjPWQ/Qou0G
         zCzOQQs71hCXYgkSqfxoI+w4i5o+oRk28rX4pfVUgSmX2Ghz150YtewTvUM95BqcWP5W
         +em5Y44xGXwMDj3h+mYQvTQ5PR6vT1Y1kvTbUxQmieHlgsnHuGeGqx3rs6CbGzAdcSyS
         aIIPuVbSixMCtl5PfpYxO7dwRL+PhVrWizeSZ5Cq07AOWp7dCw6lGuB6PhYEUCIwAA9v
         LA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793049252; x=1793654052;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gKF3hAWDK1ltcE+SHB5ZbEu9q5rcNDasVCUAn/AhQHg=;
        b=QCi+8qwbzFdht8FDG743FTuWInKT/sMsD557Ixauzjc3mDEjouvEFZn0/cSis61SDn
         MME57Xa4NvTyVg8VIYg2aajXD/LxtZD9rFaMn71oRsxFz/ojeBLTcPefW/td93noYSxm
         MeGAlZvh1//SEDMCUikkD9XcUiwMkgu0zNRk/yFrIlLWD6U+EZiMxLlyv1i8DodwK2sg
         UVpQoZx+8keVlbrht9HZrkGA4rHNl3DdqdNxgNnXOegrBZkzsnHPT7hKyMXW/qvG819W
         5BCA252s8GXbpO6kofEzHpi71tmeIyJ6vg2XiUD8ulyA7Iqcboa9pnKJ73dgWLJkqWsP
         3guA==
X-Forwarded-Encrypted: i=1; AKwUvBz65xUxl7jHgPZgjAn5Eo8qMJcyRtxkiTZSs3GdUMAYUNT6+/whCNa1/LcnaC8ICRyKW9Op0zRcUtb7@vger.kernel.org
X-Gm-Message-State: AFq9FYJhZ+BqTLZGYcxscdw22nJWCg/r0KxpunQB6s0Po0LVjukan+WY
	IgvdwaGcTV3JuUnGgR5wdpiTXh4g5EsLavzBhn+ehDR1IqHnYqiUKq3/DeKzbMeJJA==
X-Gm-Gg: AYBFou2m5v/PLT+G3aZSqNyF35b2jk6sso2Zqh+t7s0Nb4WPttjaf5OVSCdPNHLC9B+
	KDXxivF0qYz5inbpMi8M5q5yw+CECFL56fDto13k1oNzc62Q17soNyGW9cd8X/2ue0c43RuF2GI
	kEcwCO6yspOaI9Et8dSICXhBPVKsVX/Okq+NMaYiuMOZ+KV5HrFFY+wzsJhxuYeF+jZXg/FwJ7h
	mjshwA+d5ylsnQiEi4fadMb94yYDR15r5RA7InMsZlArYHHK14CcMuNSSRgn1rwCgEVc4xDddSR
	IkxnPZZFFQ3BLPYvo0i3MX00tvkuuNtDYmsd5F8/QpmC0hmcKT47HjCnINJbBdCeAUsf4mCjBug
	Ji7OI9ee8joVgcqXSTkGJkbVKZW5gM1EwEqcScCVW96UtZdn0nN57AGcuD/WscKS1kNQ9fECImj
	/a2W9QIuf7soe0U22LPdG0UnKqd7X3KO6y/0L62n8HG5R21JCLkFAyEuuPlYxEHU4lwoBd4R90U
	znwDlQaDortwO+PPVl6Cw5EhscHdY3r01rOnR13TNH4/nNP7yfNgsKwIHZoHTGV6bbrh4f1ykxr
	TI93XXOzEl32SKFwjxCODeDpXWjrU3ZkXsLizz5ScFQ=
X-Received: by 2002:a05:6300:6bc9:b0:3e2:3392:53e7 with SMTP id adf61e73a8af0-3e7a1b97750mr5308652637.0.1793049251805;
        Mon, 26 Oct 2026 14:14:11 -0700 (PDT)
Received: from google.com (192.150.203.35.bc.googleusercontent.com. [35.203.150.192])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36b372888sm1666157b3a.30.2026.10.26.14.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 14:14:09 -0700 (PDT)
Date: Mon, 26 Oct 2026 21:14:05 +0000
From: David Matlack <dmatlack@google.com>
To: tarunsahu@google.com
Cc: Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Pasha Tatashin <pasha.tatashin@soleen.com>,
	Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <at_CncIPYCxOVkLo@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com>
 <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com>
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
In-Reply-To: <9huzzew0el59.fsf@tarunix.c.googlers.com>

On 2026-10-26 11:50 AM, tarunsahu@google.com wrote:
> Right, Required bit should be source kernel payload property to tell
> target kernel that the payload must be handled to correctly deserialize
> the data. It should be source kernel (userspace) responsiblity to make
> sure it understand the target kernel before doing liveupdate.
> 
> Saying this, During deserialization, target kernel's required bit is not
> necessary. So I propose the following truth table.
> 
> Source hdr  Target supported[i]  Action
> ----------  -------------------  ----------------------------------
> 00          0 or 1               Accept: feature absent in payload
> 01          0                    Accept: ignore the feature data
> 01          1                    Accept: use the feature data
> 11          0                    Reject: -EOPNOTSUPP
> 11          1                    Accept: use the feature data
> 10          0 or 1               Reject: -EINVAL (invalid encoding)

Yes, this matches what I had in mind for the semantics.

To be explicit: the source kernel should set the bits for each Live
Update based on what is actually preserved, rather than generating the
header from a static per-kernel array. E.g. memfd would only mark a
feature present for memfds that actually use it. That's what allows
rollback to an older kernel as long as nothing being preserved depends
on the new feature.

But looking at this again, I think the required bit is redundant. Whether
a feature can be safely ignored is a property of the feature itself, not
of any particular file. Every file that has a feature present will have
the same required bit for it. The only thing that actually varies per
file is whether the feature is present.

The required bit still has to be conveyed to the target somehow, since
the kernel that needs it is the one that doesn't know about the feature.
But it can be conveyed by the feature's number rather than an extra bit:
split the flag space into required features and optional features, and
assign each feature to one of them when it is defined. This is similar
to the required_flags and optional_flags approach in struct pci_ser [1].

Keeping the same header shape as discussed with Pasha:

struct kho_ser_hdr {
    __u32 size;           /* Size of header + payload in bytes */
    __u16 nr_required;    /* Number of required feature bits */
    __u16 nr_optional;    /* Number of optional feature bits */
    __u64 flags[];        /* Required bits, followed by optional bits */
};

Required feature N is bit N of flags[], and optional feature N is bit
nr_required + N (using nr_required from the incoming header). The length
of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
are numbered contiguously, so there are no gaps, and up to 64 features
still fit in a 16-byte header.

Each bit just means the feature is present, so the truth table becomes:

Source bit       Target supports  Action
---------------  ---------------  ------------------------------
Not set          -                Accept: feature absent
Optional set     No               Accept: ignore the feature data
Optional set     Yes              Accept: use the feature data
Required set     No               Reject: -EOPNOTSUPP
Required set     Yes              Accept: use the feature data

There is no invalid encoding left to check.

[1] https://lore.kernel.org/linux-pci/20261013162529.1928093-1-dmatlack@google.com/
