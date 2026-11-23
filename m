Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455141;
	b=NNb+QlrLG5jQBSHOcWh/awxH7u7JNyS5Clif9IQRMNVcXT1o8Sg7kf8b1TIRCnKWdXLJ
	 H9iy771qwU4Md7Xd4Py/a2KGhuNqP7Oc7J4NMfjZS67g9+IGXnYU4KOPs3bIS0WQAx4rK
	 AtTkpBZ6IQ4UH6VJGPryqrZ83gp4y6YFOwSDNPgzJ1EWRMdIh3akuUWca14l8pl/PO0dV
	 NdX2UjIzn+jV/nDXmbCddfJcCeM7akhBSknS1sbZUe14XpSLebDqt5KsSGja0tvEIc60n
	 6NemwmVOSNXiwmk4FWc3AmjgN8HB8rJrRG8RerlBqzOaQIMyF+yrb6bIHT/OkhuLh1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 From:To:Cc:Subject:X-Mailer:References:In-Reply-To;
	bh=P+l/VRR07HqPbgm9tEPK7SVr6Tlf5vY5XKwCiYVXpnE=;
	b=vcUJ6iD9zrP4Zt5xcnLB1WkUydly4mfPTF3SxTsIxCpDqZSFNrWSefZKOKXypXnimZTB
	 EVfq27S99PnDYwYbqjQ7LaN3Vivd6U4awvbxJx+1PsuBv3kJyh1Bx9C/5R5psqEA6QH7c
	 fS63SpE0pVG8Z6VlaOSfbrzaJVApeSO/LJBkv7EqCk5Lvh6P5DMEF7wFcA56WKGFZge7U
	 PH7GGCfdqdaUuBrCy2K1rxMwC13Hm2y+bxVRC402AS4mzDxV1TFTfDHk71DmVOKz8+W5t
	 cNIE1f4YrOmiRFMHEv9l8Eo3CRl42u8ECWkzjNkJiL5t6csaF/pwghENABSzTaytm8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GUqMwfdW;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431D1606A327
	for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 17:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 431D1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GUqMwfdW
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2f03920c477so30915615ad.2
        for <linux-arch@vger.kernel.org>; Mon, 23 Nov 2026 09:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795455140; x=1796059940; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=P+l/VRR07HqPbgm9tEPK7SVr6Tlf5vY5XKwCiYVXpnE=;
        b=GUqMwfdWySOE88STspofkPaLQaaZjEwFfhZBDcvXCKXUdwt0IqoJuHyz6c4xJs/dnO
         RLel3qR6lTtHRWvCqUUH6V5nO10hZZlnSxyrXXoEH6W8FwXVOVGLxiAv30EQ6HvrMt1x
         4gFCm0+JmjZI5aW6RAsyZvO6EbM46xOijpgUC6/Gi8xQTSRJxGbSJwxabd7/tnVmiQXO
         v4nAVDKIubL2xTU2aRRz7NEg9/ux/TdNw2zEhqyeTsdVJAu9Sgw1uALVn6Q6ZcCySPur
         zNiBzRfxUKrP/aEvbxj+n/QxJwBzo3JvMo7sIRnvm9/J8aQiFzLnERdkb664faMxpA5G
         xcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795455140; x=1796059940;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+l/VRR07HqPbgm9tEPK7SVr6Tlf5vY5XKwCiYVXpnE=;
        b=fetemqpwIDEbp3F0dhNS4XjJ8gWTGbiy8hSkGpxpFosfFgYV3rrfucHdCjEP3WMrNh
         FSdOs/DMbJqvDR0r0kjbWNnXaWl7TQgIUKn1WtpN7U1151rAG9f7CHdkneVz4uASeLmB
         QnhKbVF/aPUsFr8VatTZ46nvgKJHp5id9kJsQ1fgZzn/xbqfotnAevEBFiVA/kW+DVTe
         +KwvrbLqoZtdjIGuAj3mOpVytvQYRQmce15XUcZW15BypAlnSInQNlZESnteizrxRbAQ
         UGUvxiIZlGSYHrcvcNLHgVwW4HVZWDEIvBdkyYwVTa7C9LYdZP32GdYeV82uNqkAsIg0
         Svsw==
X-Forwarded-Encrypted: i=1; AL+hErFs/+OJifRRa4PpcczXBET/aI7SzR98WOcBoTbUuE6SfuueXZv8zvCOYpOQkxuCCD76CXt2NQZGAJ7H@vger.kernel.org
X-Gm-Message-State: APuU4Z9XibHPEYKVH2dux4/LPF4jH3OBQKUKVVXc3Vnwjv75K5hOy0Ll
	6nKh6xn06aJA2uSD+iaZIu6UM6GZlUXYUw29SnBUFMyYcSZVj7iQQwz9iQ8z+bZ6Bw==
X-Gm-Gg: AZFdTZc+4S8l5+B6QQ1K/8qhcqLM4605B1cKpadra6HaBUWYZ06lXyQWFzfhgYg+LXu
	Ww6B8eWY564ty4+u0vy6JAcjK+rNgVfuKWLMQzIV2egU1pGUUN7WqIstUjPWUvVKiURvb4U1arL
	9P5lC3swF5fI7M+FgiWe6Ri9PcYoVpaA4bmoyrMolmUkCX0Y33xNkznFHnk38ZX+5VsS+kqLpQA
	2/WkCNif+54k2uyMh24eBVFHNA2h9ThRdnL6/RUfyLHPCGh6BbHP39JTgUevjaxE5hExvCqhQsq
	vEmkX2++uBXHzK3x72H5aIV/rJdu7/Viu7bETkN6TNirhoYnjUsGIROY9Jw6UBgcYplYHrqUMEE
	NqpT8nYvhk4Zw0hQn7hEDTDRZkOBSStHGKAh/0toT46iP/RGXSj3ThE5+s9Bi8NhkhE+OmCLxx+
	K2U5Jinjzibqtj05bmoCORT0bXCXTE1ds9gRSAhH2/5soal+qpTGhhUR+vaPfVvxjZVua6M6eJ/
	LrAN2Ir2u7gxIgrD1ei57Kq/CDEBtzM/iXO0g8FZQRYguLPTxGkqfkBO/d8AXVipEpCUDSULg+W
	vtwaDsv3beDKuzfXLrBdWJCfiGm9JQNk/ejJFHimN2QdnyYLj/swpfVSzK0zhiIm
X-Received: by 2002:a17:902:e807:b0:2ee:1fab:158f with SMTP id d9443c01a7336-2f03f167d4emr115089865ad.43.1795455139780;
        Mon, 23 Nov 2026 09:32:19 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f051a566f7sm45650825ad.41.2026.11.23.09.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 09:32:18 -0800 (PST)
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
Date: Mon, 23 Nov 2026 09:32:17 -0800
Message-Id: <DN2RQ7LGX224.3W3PSQ2PBHTJZ@google.com>
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
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
 <2vxzse0rzjdn.fsf@kernel.org>
In-Reply-To: <2vxzse0rzjdn.fsf@kernel.org>

On Mon Nov 23, 2026 at 6:56 AM PST, Pratyush Yadav wrote:
[...]

> When we have all this available, I don't see the point in
> differentiating between optional and required features at the ABI level.
> At the ABI level, all that matters is what the incoming kernel
> understands. If the incoming kernel does not understand a specific
> field, the outgoing kernel should just not use it. There's no point.
> Best case, it gets ignored.

I pretty strongly disagree.

An optional feature is one that the next kernel does not need to
understand to correctly restore the object. A required feature is one
that the next kernel must understand to correctly restore the object.
Optional features can be enabled without any compatibility concerns.
Required features must be enabled carefully (IMO via uAPI) to avoid
breaking Live Update.

I agree it's a good idea for the outgoing kernel to check that the next
kernel supports all of the required features it is using, so the Live
Update can be stopped before the kexec. But that doesn't remove the
need for the distinction. The next kernel still has to decide what to
do when it sees a feature bit it doesn't understand, e.g. because no
spec was provided, the spec was wrong, or we kexec'd into a different
kernel than planned. Without the distinction it can only:

 A. Treat all features as optional, which risks misinterpreting state
    and corrupting memory if the previous kernel did not properly
    validate the next kernel's capabilities.

 B. Treat all features as required, which means no new feature can be
    enabled until every kernel it might Live Update to (including
    rollback targets) understands it, even when those kernels could
    safely ignore it.

Neither of those is a good outcome.

> The semantics of required or optional then become "can I describe this
> object with the capabilities I can use?". If the answer is yes,
> serialization succeeds, if the answer is no, serialization fails. So
> with this, KHO_MAP_F_MULTI_INDEX or KHO_MAP_F_DYN_DEPTH are indeed
> optional. All memfds can be described without these, they just will be
> less efficient.

I think this is a different meaning of "optional". Whether the outgoing
kernel can choose not to use a feature is a decision for the serializer.
Whether the next kernel can safely ignore a feature's data is a property
of the ABI. KHO_MAP_F_MULTI_INDEX is optional in the first sense, but
required in the second: a kernel that doesn't understand it will
misinterpret the map. The header needs to convey the second.

So I see the spec and required bits as complementary: the spec lets the
outgoing kernel avoid features the next kernel doesn't support and fail
before kexec, and required bits let the next kernel fail safely if that
check was skipped or wrong.
