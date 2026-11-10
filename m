Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323545;
	b=QALJ37sNbzEhgLLh3bdBKMagKpTIGPmz9aEOamqioDA8OrjRMi/Jya3XpLZDdIMpaM1c
	 DidAgK4+YHUG6wI1OipQwQrP9BbJfEsBsaUG9LvUXy/2uho88lpTmRXdTN0oL1gMymeZm
	 Qh0tuI9zrv7PZlYpf/XthbXykk+Gv9LBgnFKFBB1Rv4yoUIN8+YGfBirOE4tfoKT0FW4q
	 f3dFwfvwJx5sjK5oJwjOImMzbdLPBaTkaNu/M6NVr9M2u/4oewN4R3zTOWqOs/g4EO19V
	 XJ5BQ6eQ4R2uqyKcpIzzzXPnon91ObmQXm/6gK0/eHxgS0aScOQmHz1SjiQ2pd2KeEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323545;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=;
	b=pWBD+4tSe2D3DEoND8MwLB4LypTyhXb7/n5oBRGPn1XRqLM8JYfQe1cBOn4TKvCAL7Qn
	 X4mB12H8Rg0sHZsQZWNYHYvIOTTv5Bk6WGwQKd90phafJA7qf+KxAqJlpp3XTE9FN0TKw
	 rrDjn4G5rGySBA0L1IpYWMObZM89ZwuYyjzsVGqGqA8cZJdvMheUlGn/h2KBvldP7b+8p
	 7OUfhtfgfwhLonkx+aSf7y3+iRY5ctBLYas7dM2HFdatBZ5BJynl0IkJmuupsBOD2hOlO
	 yUgHei4XmPn5L1K/ZRzoZ0dkJIMxZkaaHGbITcuiHg4/k9rE0rj71R/mFzqTJVDjGWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b="YOUBG/UJ";
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78559606A33D
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 15:12:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78559606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=YOUBG/UJ
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ea969fafeeso744065e0c.0
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 07:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794323544; x=1794928344; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=;
        b=YOUBG/UJDUN4UyxvkhIoLhefkcKvcqtCc43YY9icyFLipWGwJr4yRhoF61ai04yb3G
         /3oA/YdYUik8WvsHFnI3gFCqTxtjsY0R+rgJT3k6h2A7QoXojCu8iohoASLyE0xrRsG6
         r77coPHPIo9sHj3xb1YOG5IhOJKV9qF8R6gyeeM54RzrM2UnL6uNga7Md3t05uiI9v6o
         5KldDRCzbIk9P4MYLEtb+lU5m6ZqVMMuwQ4336EDEh3PepvHzOcgNGzJe9mzOCIKRb4w
         P2iFaU19sefu/7GQ+UIx4MnWmqodZKnGvXovtykItH/b2HiCw11TEk6EiCg3vu0DA4qv
         p42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794323544; x=1794928344;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KpEwWty65XIKqwE7JeJ6p16oyvStp8N2eZzOQMIZadI=;
        b=JB/qG8QXhwB+zGO7SUwIcWZVB6RmnII+fERnqYSwXS92FKhMnw/COb0J0MI7UOVLZ9
         WFmoDEi2vehoCtncLR3TkuLovBz+cCVi5V+Wkt/D+WKgraB6z+p3pekCM33xYY1y+A+s
         jhuT140bcmhKrCG5rdfhtqTWJJ/9DdSIwY6LbSkidUEOpm9In+jIOj/fHEaPoCAWYSf3
         QWZt48nBhh+sIj0oeZiWFxA1qpj5xkH6kmmC7BUuSQk75NheE/NCj44pEk1UolFw2O2P
         CSaYGesV6fg0vhhPnRURasV9AQB5aT8dw2nrDvCvZ4frVa6sbZkI2fjGmsG4Pxgwctpd
         iqmQ==
X-Forwarded-Encrypted: i=1; AL+hErGRyxWrkoaTE/VSvFwO8fWCkeIUfdYKhXwbUhj7cloQCwZPxUVqhvVbldXHD2vjfs3oXW533Pks2nF1@vger.kernel.org
X-Gm-Message-State: APuU4Z+bMdhwUUSZViO9nFww4ybMfILRizqSxqYauR5RQKm72NKeSMme
	QzPUkXKxYMw+BEIxsxHwbdWs9U0oVXKDDhV7ufLkVLcIo/fnNr/VWpljhQ4qLCJzKDU=
X-Gm-Gg: AYBFou0HLPAGgNgVuslGr4Tqe2vjtvFsRMC1zfOgm29Yji1OMwVLS7H1pq4hsLXnXJV
	I96DU8ywhD1ZEDOjN88AcOjfgNN9Bf64HSaS6ZPSAQeGajzE/R1QgP1Tj0puz08KQbQ21DYFoxF
	23UjYue6HARvfJjvQelwEWGPJklo+2B5FbhtQlwUuNIU0kozN3hLVQZxT+E1RiHTnzy3A95EGXv
	OVPGCG8bN2HlzMbWLMUWzH5ItCv6BXvZiH62jHAHAgxMswJ+DI3+2WpVhSUd68N2KMtZZ8zusnO
	S7W9NN6QUTzzeDyJ9oi2FViStl8FBwmYQI5oPCus53dcnVruv+zNerC2kMwv6D5zcnvRP1VczIp
	ho0IAZYO8ykp/1DpBqLjMn2uRmshvimbQVZuiBm62hG6TqPX+bW4hT7PabDDZYVdOj5J7m81KHC
	QZIC03Vx7mYqOVZ+HOn7nBuyBQG0/NtCrMWoTtG6c0ujHq9bZZdkt5lqQF44dAcF/+LoRXp4P5I
	sPtDbmh6LAo3lgI9Mbh3Db6XWNJZAVg/t2sO0MKgUYRa6fQwxf8V/fmb4oZvz9GmprnZ94m5nfI
	yBpn2Ty2oU2taLcicpO4rPQKcPatITu0a/pRMe2nL94vJHOjt0RDDR/lno5OX3WThDGLb8xKSRv
	8A26mz6vpMF79+mgMB4IQCcr2OTP0
X-Received: by 2002:a05:6122:5313:b0:5ea:a0f0:192f with SMTP id 71dfb90a1353d-5ee0d0cd07bmr947867e0c.10.1794323544266;
        Tue, 10 Nov 2026 07:12:24 -0800 (PST)
Received: from localhost (16.49.199.35.bc.googleusercontent.com. [35.199.49.16])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c45a110sm2039560e0c.2.2026.11.10.07.12.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 07:12:23 -0800 (PST)
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
Date: Tue, 10 Nov 2026 10:12:22 -0500
Message-Id: <DMRMLZSZ0LAZ.D4P70QWX0IHB@soleen.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/19] kho: Add feature header for fine-grained ABI
 compatibility
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-6-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-6-tarunsahu@google.com>

On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:

> +/**
> + * DECLARE_KHO_SER - Register a serialized payload structure with KHO.
> + * @name:         Structure tag name (e.g. luo_ser).
> + * @payload_size: Compile-time expected size of struct @name in bytes.
> + * @nr_required:  Total number of defined required features.
> + * @nr_optional:  Total number of defined optional features.
> + *
> + * Size and 8-byte alignment are asserted under CONFIG_64BIT: KHO and LU=
O are
> + * 64-bit only, while !CONFIG_KEXEC_HANDOVER stubs pull ABI headers into
> + * 32-bit builds where u64 has 4-byte or 2-byte alignment.
> + */
> +#define DECLARE_KHO_SER(name, payload_size, nr_required, nr_optional)	\
> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
> +		      sizeof(struct name) =3D=3D (payload_size),		\
> +		      "struct " #name " size mismatch");		\
> +	static_assert(!IS_ENABLED(CONFIG_64BIT) ||			\
> +		      __alignof__(struct name) =3D=3D 8,			\
> +		      "struct " #name " must be 8-byte aligned");	\
> +	extern struct kho_ser_hdr __kho_ser_hdr_##name;			\

Remove this extern.

> +	enum {								\
> +		__KHO_SER_SIZE_##name =3D (payload_size),			\
> +		__KHO_SER_NR_REQUIRED_##name =3D (nr_required),		\
> +		__KHO_SER_NR_OPTIONAL_##name =3D (nr_optional),		\
> +	}
> +
> +/**
> + * DECLARE_KHO_SER_HDR - Declare a feature header variable, field, or pa=
rameter.
> + * @name: Structure tag name registered with DECLARE_KHO_SER().
> + * @decl: Declarator (e.g. *fhdr, **out_fhdr, or * inside DECLARE_KHOSER=
_PTR).
> + *
> + * Declares @decl with type struct kho_ser_hdr while checking at compile=
 time
> + * that @name was registered with DECLARE_KHO_SER(), documenting which
> + * serialized payload structure a feature header pointer belongs to.
> + */
> +#define DECLARE_KHO_SER_HDR(name, decl)	typeof(__kho_ser_hdr_##name) dec=
l

Remove DECLARE_KHO_SER_HDR, use kho_ser_hdr directly.

--=20
Pasha

