Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793122706;
	b=wSCc1yYFlHtPhezUTjsHwt/CWGwTEOFcpevIyUaoWmY7Fy1PbxbMvMzf73hVq1DBtWAv
	 0S8uKXN962BfAKVkLDJrAeZZWxYD9sUa98MmGifLfd9sKIjUmUpykApbqkps4OQ1obP4Z
	 Fw2jHZ9Z15naiYya3CbAH9AZZwIiGNIQcAzcOb0yWSnh6ZlteP/4HsuKkD0fRRpoKoAzc
	 BgGl4CyPbNo6+djlnJ1oxpl8dMyrVJJgfhlUUwNm1hipFl/PUENxbXFrgpQPHlaLaGruz
	 Wu94nHVRIXg9WjOWrIxiWlKrn45HKjhcfTJcIsyssK/vUEOSQj+KvfVvPaIjLPdOb+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
	b=PFpyKylIXPDjD8B8sLteUAdbym3Peq/undF9Tx7Fh+aaEPF/tMc/NCW8QuwUo1uss/1/
	 hckX+ameankeL2YaWbiyPF5XRU8EaVLA42kkTBj60mJqyIyNVlvtNbt9JMvC0/jDqNO/U
	 N6MZ3hcAeQTVA7PfVUoRnzgRhm8MSktxEo27pvzpvhoJ7/knHlycPz6uvKO5pARs+DFjK
	 urLuw67oV/FLVMgMVBq2NXyb2llyGobbphuR44r6JWnor9Y6UKPAlgNGA2m9SVb4iQzO5
	 nlshw5hCv9lt5AfUpkFl5J1HmXRWP6485GQiGROTdh6L3QqY9ghzM6JTaY22/aBVo9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BpaGH1Tx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0852606A321
	for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 17:38:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0852606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BpaGH1Tx
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c34bff61551so10287066b.2
        for <linux-arch@vger.kernel.org>; Tue, 27 Oct 2026 10:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793122704; cv=none;
        d=google.com; s=arc-20260327;
        b=g9WXJkvvla8LjGarXz7y5vRB1irU/QbSKbmi1UkBf6+GpAJQNe+oPDf9XBuGv3Veh9
         RnPyLHnRQgY2y90Ev9XLS6K4aBaxiHFUAo6T30JbgpLwlU3SHvVdSGW2P/Lwyy7CKZLA
         hex5CVUsQNKjrLYTv+GutRRh7/+D99ZcQpFQpbGvnqfYTW1Th5jnCf0uKRhEW75obVM6
         wVNLpdmsy3T7BJd36uMVEt2hD5PX4cu5nY53DutIzcOwbZuFMCrgwr5k/gDgvDLlaFI/
         W4To+59yYJL3cEbo3u2+6/NSCPK3SH0HOK8tgdnAMEV5UcdJVvmtg3yKhnFIZB4MMjEh
         mZaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
        fh=nMlDHbvm6VMkvL5t7o5AM9UFpMO5cNQOoej/JgkXjo4=;
        b=f859+0sUb7f1kcljsfmkMW1iDclEw2pgl9c1o3EIRqM0op14GPzDOqBNfZtB0CbNo6
         XEq2PqWSILyaC9OlTuK4GIx4kcHhTzVdEw4rqW18UHG4Xhv/gkoI9x/vmECMMOuxbdTa
         2p3NIHYO+db57lGRB3PyQYAsjgcXG5+ZTO8sOLiP+RfoRFKcnot7GLktuS1yd6ougz/S
         vIXFJJiZj8bmyfSqOPfunxtWRg+dQRxH2wwVFzQNfNpn1VGYg9eoKnZOxdF6VjxXm6km
         06psRgSnOUnY4QtNtMt+WQPbdxanCfAlD8Y2oMU3uBfULOoewaaAd+eGqEHa3sK4bEUu
         MwrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122704; x=1793727504; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
        b=BpaGH1Txd/+w5/V9hrGM2M4C4HXHif8xNS790Y75yM+gjPsyf9RDVpi3ythXOIyyxB
         LHbA39OrkFv6VPnuEf7YxyrFUeKLqjhKTuodkRzxStOKPPqtkjvXRm8JON1kZARoOGZw
         G+WE5WGXAh0gXHbGB/5AAOkcpk6oAAotpa8S4NsTzjTX151h94ky5bJl/0uFFt8oqWBD
         dSi8tn6WRA1fzl/53FwPJp809JfuxeD+VFM72MMcHhy/yO2MVvMG4SAVojeP94ItGytF
         rFXKgKpRIjqswwKzrkuh1/hhW61PeuNmG2g6oTy0jNK4pMKDJifndJWntEqZ/Dne6xve
         QRnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122704; x=1793727504;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=75xnGPQfUpxl4aF5uqa7AQlJeR6+8S5bvRDT/N741Fo=;
        b=o0YoH3yukJr9wRU73Buq7CbFIAxclGA3+xjFQXiU2SRmZ3IkLOjE9g2sqK0UQUbpuf
         tDzWdlkqALfIiAKrWqn5Ad1a2Ed6mg5jTOozGrSd4K3HaqrUG7GwenwWVy2mlgfCjIQM
         56hud9enMf22iUecstP248gjfTu9Dkz6uEWCAPJofkOJmoTqCLegWC7LW9Y/Pvt4B6uq
         7ai7c7UgEiaTO6ROk3/1YoZRRR+sshMcULVm/5wBBccqKqQDAvJSKtSDp3PUMZBP+e/E
         i9I8hKg0hBM1mM6Q1VFbyNI6Z4fe5++KKmI9f0MQtcMX2afBB12U/wjR3zG+wRn8Aca9
         7qgA==
X-Forwarded-Encrypted: i=1; AKwUvBze+eB1ICA6+hZCTDSBdGgPTpMJD5c0/E9291uzM5bp0YgVfflE+Gh5P6XPCBn/gSVufVGGcjFoPzx+@vger.kernel.org
X-Gm-Message-State: AFq9FYIsxair7PP0niWIP5WuAZzIMRrSHbe0TkPurr04Td1fJzVH32ZH
	gH0oKECn+GW/Kq+YuaThzp56CWdZ20eZfmUgspAO3vqGyj1rOZ6CppnTVLqRT90HpGfGflMsL2d
	lWt5mKFh2ktLdo4u2+0BuKdL1uNdW4EZJc6JoNIqu
X-Gm-Gg: AYBFou1x4wVUKnA0qc2RWnzKURBjW3/JvNT7IE2SCQDdzOVXaNUX8YBO7wv/bXkcaXO
	TtTIZJI3gtzTo+iuXlxj3bnCJ5GkQtch5ozxUROdjgA1tPkZlThqH15cyO3AUncuVQX2b1dPz55
	Hjxc1ph7RSQfB3SJ4r6UBcjLC4N7l7M9fYO4fon+pK3eNLQ5FxIOpuBnsu2R4oPPX/G3k8Rz4JN
	0e+P4wCyk1XtxJ7cWD4XSVoq1JjjkZCf/gU/0nPkRAgrKTwKsn8ft4SnacpIqqyVsNftgAkzlED
	44cdx2UAVjOOiOLgE7I8UFKFP2h4JORmNFyqF958poPHENfwTVUjxN3Oq3LJLwdt/UDORigSMYJ
	Ho2rDIu4nBP5xSHUqCzwdpoauhaiV/bdcoQQ3Tg==
X-Received: by 2002:a17:907:d308:b0:c2e:378c:8ce3 with SMTP id
 a640c23a62f3a-c46bde8c44fmr1091193766b.32.1793122703439; Tue, 27 Oct 2026
 10:38:23 -0700 (PDT)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021152527.375070-1-tarunsahu@google.com> <20261021152527.375070-4-tarunsahu@google.com>
 <atlQ_Er0Ig7CCSxv@google.com> <CALzav=f00C4yOAseNunW8GgQTDUGWT927Qy=TLm-3-J0TEDH8Q@mail.gmail.com>
 <9huzzew0el59.fsf@tarunix.c.googlers.com> <at_CncIPYCxOVkLo@google.com> <auDT5MjXYq3lcQjE@google.com>
In-Reply-To: <auDT5MjXYq3lcQjE@google.com>
From: David Matlack <dmatlack@google.com>
Date: Tue, 27 Oct 2026 10:37:56 -0700
X-Gm-Features: AclHuK9nhZy1yfbGSOSB3h6FsOr-7RUqfg5DsC4iepC4uLqRp9MK3EAsOEkjOYw
Message-ID: <CALzav=dYKAP7pKfoPtz32X1cT_tH4LN0X47_jTO8_HOCT4Pi=w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>, joro@8bytes.org, 
	Mike Rapoport <rppt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, 
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, 
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, 
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, 
	Alexander Graf <graf@amazon.com>, Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, 
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org, kexec@lists.infradead.org, 
	skhawaja@google.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:40=E2=80=AFAM Pasha Tatashin
<pasha.tatashin@soleen.com> wrote:
>
> On 10-26 21:14, David Matlack wrote:
> > On 2026-10-26 11:50 AM, tarunsahu@google.com wrote:
> > > Right, Required bit should be source kernel payload property to tell
> > > target kernel that the payload must be handled to correctly deseriali=
ze
> > > the data. It should be source kernel (userspace) responsiblity to mak=
e
> > > sure it understand the target kernel before doing liveupdate.
> > >
> > > Saying this, During deserialization, target kernel's required bit is =
not
> > > necessary. So I propose the following truth table.
> > >
> > > Source hdr  Target supported[i]  Action
> > > ----------  -------------------  ----------------------------------
> > > 00          0 or 1               Accept: feature absent in payload
> > > 01          0                    Accept: ignore the feature data
> > > 01          1                    Accept: use the feature data
> > > 11          0                    Reject: -EOPNOTSUPP
> > > 11          1                    Accept: use the feature data
> > > 10          0 or 1               Reject: -EINVAL (invalid encoding)
> >
> > Yes, this matches what I had in mind for the semantics.
> >
> > To be explicit: the source kernel should set the bits for each Live
> > Update based on what is actually preserved, rather than generating the
> > header from a static per-kernel array. E.g. memfd would only mark a
> > feature present for memfds that actually use it. That's what allows
> > rollback to an older kernel as long as nothing being preserved depends
> > on the new feature.
> >
> > But looking at this again, I think the required bit is redundant. Wheth=
er
> > a feature can be safely ignored is a property of the feature itself, no=
t
> > of any particular file. Every file that has a feature present will have
> > the same required bit for it. The only thing that actually varies per
> > file is whether the feature is present.
> >
> > The required bit still has to be conveyed to the target somehow, since
> > the kernel that needs it is the one that doesn't know about the feature=
.
> > But it can be conveyed by the feature's number rather than an extra bit=
:
> > split the flag space into required features and optional features, and
> > assign each feature to one of them when it is defined. This is similar
> > to the required_flags and optional_flags approach in struct pci_ser [1]=
.
> >
> > Keeping the same header shape as discussed with Pasha:
> >
> > struct kho_ser_hdr {
> >     __u32 size;           /* Size of header + payload in bytes */
> >     __u16 nr_required;    /* Number of required feature bits */
> >     __u16 nr_optional;    /* Number of optional feature bits */
> >     __u64 flags[];        /* Required bits, followed by optional bits *=
/
> > };
> >
> > Required feature N is bit N of flags[], and optional feature N is bit
> > nr_required + N (using nr_required from the incoming header). The lengt=
h
> > of flags[] is DIV_ROUND_UP(nr_required + nr_optional, 64). Both spaces
> > are numbered contiguously, so there are no gaps, and up to 64 features
> > still fit in a 16-byte header.
> >
> > Each bit just means the feature is present, so the truth table becomes:
> >
> > Source bit       Target supports  Action
> > ---------------  ---------------  ------------------------------
> > Not set          -                Accept: feature absent
> > Optional set     No               Accept: ignore the feature data
> > Optional set     Yes              Accept: use the feature data
> > Required set     No               Reject: -EOPNOTSUPP
> > Required set     Yes              Accept: use the feature data
> >
>
> I like this proposal. I bet most features are going to be either
> optional or required, and even if we ever have a magical
> sometimes-optional feature, it can have its own required flag. So, no
> need to pay double the cost on every flag.
>
> Just need to make sure that optional features always start from 0, in
> their own enum, so the offset can be computed correctly in the incoming
> kernel.

Right. Instead of having a single 32-bit feature space where every
feature can either be optional or required, we have 2 16-bit feature
spaces, one for required features and one for optional features. Both
feature spaces span from 0 to 2^16-1, and then are packed into
flags[].
