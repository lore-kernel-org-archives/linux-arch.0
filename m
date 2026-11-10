Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315405;
	b=sMWtTCzE4G8YldPkN5w3+12gjWwEWmvgrILrfTsnjyVXdKNZtzyK1Q3uBYo9TLbbS7ti
	 ZPcQHecUzp6BJFfXt72v++yZr7PQ+s4/EolUE5rI12U9R5PqnJvoPZLsTghLlEqtponoC
	 5Tp3wh0B2go1ST+hjS6RbZQuHEa/gMALYLenEY9u7BC9/LzKlJjprjsXHOpcUoEBRldf8
	 Wh2Qd30jvqqnrtpTBzqZl3urSKi/vAVED/0ubpE/6gkqDTJuE66ze6w6Brtspcv3+jCLn
	 F1hT1CaS+tlIQlNXjliPrIEfcQWRyOBVz71dWsv2VIdH4HlBekhEoFnabL7H1YZZ/vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=K4NCnFvaGrDIOTRc5HujFwwUmTQ2N/bdVeWHbEi7j9U=;
	b=mp9IH0GqfnE+CHbx9mWYX46Y+FZVFrWE6el19k+nzk1wD+Mz3c46FKwatEA4OFGTjbhX
	 TqkrcpWdRqWh78YTAy/tqSDULqXijDZ1faiLS0CTNocDCtH3ejFmxOnuDyC0KOVjG/wR8
	 r7j+2bfSp3YW6U2g3jyuUHcO6n2qwpuRXJcqlXfs08IiXWuvgjbLnBjV3xidGmcx1gaJb
	 cHWg3ZwcIPBLSRGKYe2DK3OOiDhqUNuA6hS1bcpxIhQKo8mwCsoroZ/MNM83Y23NDMUAn
	 uLKnLlG92ntJgDQBQwwIPSopaJOONv8IRUIquF4NmwEJz8sMqU/SUcpl4qu92LMCvpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=B3iJeP0V;
	arc=none smtp.remote-ip=209.85.221.171
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF1A606D5DB
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 12:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AF1A606D5DB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=B3iJeP0V
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5ecde8e8e5bso547396e0c.2
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 04:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794315404; x=1794920204; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=K4NCnFvaGrDIOTRc5HujFwwUmTQ2N/bdVeWHbEi7j9U=;
        b=B3iJeP0VqOibLx/oHU379JhvLuL5xoHtXPOSUDz1sWhQq3L6oFf2bvSFc1MOgJFpsk
         RH7eI3twEeghXtQ/Gk0Jj8E/OIuyPJtOVIv5QU+CMQrlde3D4Zc/qL0Xz1umU76GfSvN
         3W3Ys46pB5DBi7ADjnu72bDFF65QV+tmu7+yIYy48KqnK2nc00twgRldIQCpHQdU+c1T
         ca3u4c3qGNmz9c/L+fD1jlkf/u+FY+feBQqAAdd+4GQC/efExzpnavMzwuladM5T9A1O
         ChELZT7mPSGcLB7aLK/BGp2p0aZ/4WFMNh9MLPSeMdy5DOg6pitTxINH6bCR12ZxmaZ6
         khCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794315404; x=1794920204;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K4NCnFvaGrDIOTRc5HujFwwUmTQ2N/bdVeWHbEi7j9U=;
        b=PQUErmCQrYCEzBQPKGBjkg/BJH8cLOJ9cWi3YU/EjeYpT+KaMuBg7bBJsEPhVyo51h
         IzMGlgvtyA7qbqswrFG4myxQJudLYh9vAV8gPw7b7McKPBx/lRLI3+U7t49kjGmZW17f
         5rr5wlqYCZ79SHqtTVvYeNJoUi9qbFIt3jOLXeBi3ih2teAai5jtFMeEKxAd4374n4Li
         yrAMLNQHW6qHdj6TS2doP0AgFs2jEg/pPEU9+Hkso1WIqfDJoKOX5Z9LPkLdMMFq64Y0
         488NxeSeY3+VpfG4HLgZiyuDb+/M/9l+cVZaCS2z2pgdSsfOsznq3gImCvW1KfDkppXK
         Y4Eg==
X-Forwarded-Encrypted: i=1; AL+hErEKec85lxqh1xJhFAPY7sZdnCj/1g67KOSBT3hJb7+Xc2FZ0V62VBDvb13WEcxaYO/yc5NwWUIjN3oM@vger.kernel.org
X-Gm-Message-State: APuU4Z9TBsu6PuL1rcpjOR223OfU+FN/Thaa0TCAscynNWPfrNTuhBvQ
	eTUoq1BjuWGqUv3PdUvv/5oHNWuEHzJxmYDsP+MXAiUL1EvBsTqOLw8DKQ0caj2+8t4=
X-Gm-Gg: AYBFou1fSdA8IRZbRpxU8QO6CAQhJIJVUe2M15PmTreHpoEOuZDN/FK6+osYp4LQm7/
	AGlYvq65NkdNbTbUum9ScFqxz4ghoUI4diiq7y13z/flizEP3ydZejy6CGc0zA1AyAmOzlukzrV
	nuVqmHs6QVaqh0R5Grpcsuk1iSaWtiwbyhAHo9subt+FB1tyxBPPUmF1X+CQx0NnAPeUcmxGYZK
	r0PVkGAADOjfwlvIVhdewEPxJg1OId/OlorvG1FpRCGHhw8WHl2KBxvaRJxNmY7fLVD7dl1G0xV
	+5kbX4LZQTikshBLB/VpeYuR4NSNzBxEd/yrG1LLjV3GZIzhnpRf2V70EJTITEh1CFyGiJUniq1
	9+x8iTPn3Ssnw/iZWNjl1gs6QKUqoOJDp9HBonw30czUCXFSiLbf4+oWzCn7e8qlHixqhfB1ZNN
	Vlbg+YpzYJ7qyPrC7aqzeyU1qMF1sQkamTZBpyKwBRzhBhAQR5ga7H20CiPtzhwj7svIKALThd0
	fYTwTF1WxlcuSomo3x/7gI0JOd53gcof7Afq4l9oGRSZRO0lb93Zc1vLquNRbJ576ukJ98PrOaW
	DvT+fuXkH7bS3rSfXzkjqqJXulhGRltyYVyW+2ZYN0Uxeb3z8hzukCorucCMI/RHLLdU8QCzCm5
	4EV39oYzAwojGJKB/oIex/biYvZldWAHSHuJsMjp03D1fb/UU/nE4
X-Received: by 2002:a05:6122:3407:b0:5ec:3e18:a8da with SMTP id 71dfb90a1353d-5ee0d14a2e5mr823009e0c.17.1794315403552;
        Tue, 10 Nov 2026 04:56:43 -0800 (PST)
Received: from localhost (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c5b2233sm1547234e0c.10.2026.11.10.04.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 04:56:42 -0800 (PST)
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
Date: Tue, 10 Nov 2026 07:56:41 -0500
Message-Id: <DMRJQ42LR1D3.1GZKU9EX48KZU@soleen.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/19] liveupdate, kho: Remove __packed from KHO, LUO
 and memfd ABI structures
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
 <20261110050202.529473-2-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-2-tarunsahu@google.com>

On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:
> All structures in include/linux/kho/abi/block.h (struct
> kho_block_header_ser), include/linux/kho/abi/luo.h (struct luo_ser,
> struct luo_file_ser, struct luo_file_set_ser, struct luo_session_ser,
> struct luo_flb_header_ser, struct luo_flb_ser) and
> include/linux/kho/abi/memfd.h (struct memfd_luo_folio_ser, struct
> memfd_luo_ser) have naturally aligned fields on 64-bit architectures,
> with no padding holes between fields or tail padding. Assert both the
> structure size and 8-byte alignment under CONFIG_64BIT at compile time.
> Any future unaligned field addition should come with reserved field to
> keep the structure aligned.

Just state:

Remove __packed, as it may break natural alignment. Instead, ensure that=20
all padding holes are explicitly covered by reserved or similar fields,=20
as is already done for KHO/LUO serialized data, so no functional changes=20
are intended by this change.

>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  include/linux/kho/abi/block.h | 10 +++++++--
>  include/linux/kho/abi/luo.h   | 38 +++++++++++++++++++++++++++++------
>  include/linux/kho/abi/memfd.h | 16 ++++++++++++---
>  3 files changed, 53 insertions(+), 11 deletions(-)
>
> diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.=
h
> index d06d64b963be..36bdbaf9b3b8 100644
> --- a/include/linux/kho/abi/block.h
> +++ b/include/linux/kho/abi/block.h
> @@ -12,7 +12,7 @@
>   * pre-update kernel to a post-update kernel.
>   *
>   * This interface is a contract. Any modification to the structure field=
s,
> - * compatible strings, or the layout of the `__packed` serialization
> + * compatible strings, or the layout of the serialization
>   * structures defined here constitutes a breaking change. Such changes r=
equire
>   * incrementing the version number in the `KHO_FDT_COMPATIBLE` string to
>   * prevent a new kernel from misinterpreting data from an old kernel.
> @@ -26,6 +26,8 @@
>  #define _LINUX_KHO_ABI_BLOCK_H
> =20
>  #include <asm/page.h>
> +#include <linux/build_bug.h>
> +#include <linux/kconfig.h>
>  #include <linux/types.h>
> =20
>  /**
> @@ -49,6 +51,10 @@
>  struct kho_block_header_ser {
>  	u64 next;
>  	u64 count;
> -} __packed;
> +};
> +
> +static_assert(sizeof(struct kho_block_header_ser) =3D=3D 16);
> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
> +	      __alignof__(struct kho_block_header_ser) =3D=3D 8);
> =20
>  #endif /* _LINUX_KHO_ABI_BLOCK_H */
> diff --git a/include/linux/kho/abi/luo.h b/include/linux/kho/abi/luo.h
> index 288076de6d4a..721949374fa1 100644
> --- a/include/linux/kho/abi/luo.h
> +++ b/include/linux/kho/abi/luo.h
> @@ -58,6 +58,8 @@
>  #define _LINUX_KHO_ABI_LUO_H
> =20
>  #include <linux/align.h>
> +#include <linux/build_bug.h>
> +#include <linux/kconfig.h>
>  #include <linux/kho/abi/block.h>
>  #include <uapi/linux/liveupdate.h>
> =20
> @@ -82,7 +84,11 @@ struct luo_ser {
>  	u64 liveupdate_num;
>  	u64 sessions_pa;
>  	u64 flbs_pa;
> -} __packed;
> +};
> +
> +static_assert(sizeof(struct luo_ser) =3D=3D 32);
> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
> +	      __alignof__(struct luo_ser) =3D=3D 8);

Please remove the two assertions above throughout this patch, as they=20
are replaced later in the series. In general, introducing add -> remove=20
-> add churn across a patch series is discouraged, as it indicates a=20
lack of planning.

> =20
>  #define LIVEUPDATE_HNDL_COMPAT_LENGTH	48
> =20
> @@ -98,7 +104,11 @@ struct luo_file_ser {
>  	char compatible[LIVEUPDATE_HNDL_COMPAT_LENGTH];
>  	u64 data;
>  	u64 token;
> -} __packed;
> +};
> +
> +static_assert(sizeof(struct luo_file_ser) =3D=3D 64);
> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
> +	      __alignof__(struct luo_file_ser) =3D=3D 8);
> =20
>  /**
>   * struct luo_file_set_ser - Represents the serialized metadata for file=
 set
> @@ -113,7 +123,11 @@ struct luo_file_ser {
>  struct luo_file_set_ser {
>  	u64 files;
>  	u64 count;
> -} __packed;
> +};
> +
> +static_assert(sizeof(struct luo_file_set_ser) =3D=3D 16);
> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
> +	      __alignof__(struct luo_file_set_ser) =3D=3D 8);
> =20
>  /**
>   * struct luo_session_ser - Represents the serialized metadata for a LUO=
 session.
> @@ -131,7 +145,11 @@ struct luo_file_set_ser {
>  struct luo_session_ser {
>  	char name[LIVEUPDATE_SESSION_NAME_LENGTH];
>  	struct luo_file_set_ser file_set_ser;
> -} __packed;
> +};
> +
> +static_assert(sizeof(struct luo_session_ser) =3D=3D 80);
> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
> +	      __alignof__(struct luo_session_ser) =3D=3D 8);
> =20
>  /* The max size is set so it can be reliably used during in serializatio=
n */
>  #define LIVEUPDATE_FLB_COMPAT_LENGTH	48
> @@ -152,7 +170,11 @@ struct luo_session_ser {
>  struct luo_flb_header_ser {
>  	u64 pgcnt;
>  	u64 count;
> -} __packed;
> +};
> +
> +static_assert(sizeof(struct luo_flb_header_ser) =3D=3D 16);
> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
> +	      __alignof__(struct luo_flb_header_ser) =3D=3D 8);
> =20
>  /**
>   * struct luo_flb_ser - Represents the serialized state of a single FLB =
object.
> @@ -175,7 +197,11 @@ struct luo_flb_ser {
>  	char name[LIVEUPDATE_FLB_COMPAT_LENGTH];
>  	u64 data;
>  	u64 count;
> -} __packed;
> +};
> +
> +static_assert(sizeof(struct luo_flb_ser) =3D=3D 64);
> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
> +	      __alignof__(struct luo_flb_ser) =3D=3D 8);
> =20
>  /* Kernel Live Update Test ABI */
>  #ifdef CONFIG_LIVEUPDATE_TEST
> diff --git a/include/linux/kho/abi/memfd.h b/include/linux/kho/abi/memfd.=
h
> index 08b10fea2afc..376a724a1d8c 100644
> --- a/include/linux/kho/abi/memfd.h
> +++ b/include/linux/kho/abi/memfd.h
> @@ -11,6 +11,8 @@
>  #ifndef _LINUX_KHO_ABI_MEMFD_H
>  #define _LINUX_KHO_ABI_MEMFD_H
> =20
> +#include <linux/build_bug.h>
> +#include <linux/kconfig.h>
>  #include <linux/types.h>
>  #include <linux/kho/abi/kexec_handover.h>
> =20
> @@ -20,7 +22,7 @@
>   * memfd uses the ABI defined below for preserving its state across a ke=
xec
>   * reboot using the LUO.
>   *
> - * The state is serialized into a packed structure `struct memfd_luo_ser=
`
> + * The state is serialized into `struct memfd_luo_ser`
>   * which is handed over to the next kernel via the KHO mechanism.
>   *
>   * This interface is a contract. Any modification to the structure layou=
t
> @@ -54,7 +56,11 @@ struct memfd_luo_folio_ser {
>  	u64 pfn:52;
>  	u64 flags:12;
>  	u64 index;
> -} __packed;
> +};
> +
> +static_assert(sizeof(struct memfd_luo_folio_ser) =3D=3D 16);
> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
> +	      __alignof__(struct memfd_luo_folio_ser) =3D=3D 8);
> =20
>  /*
>   * The set of seals this version supports preserving. If support for any=
 new
> @@ -85,7 +91,11 @@ struct memfd_luo_ser {
>  	u32 flags;
>  	u64 nr_folios;
>  	struct kho_vmalloc folios;
> -} __packed;
> +};
> +
> +static_assert(sizeof(struct memfd_luo_ser) =3D=3D 48);
> +static_assert(!IS_ENABLED(CONFIG_64BIT) ||
> +	      __alignof__(struct memfd_luo_ser) =3D=3D 8);
> =20
>  /* The compatibility string for memfd file handler */
>  #define MEMFD_LUO_FH_COMPATIBLE	"memfd-v2"

--=20
Pasha

