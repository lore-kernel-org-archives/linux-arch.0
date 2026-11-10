Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316236;
	b=Nyml8V15bNW75YkrtiaYmq27+TjCBpPcwhYDP5Gro9Xxsd7k6iUaFaAKX+BIW9ZO7hOZ
	 2bBSpQ5Cq9Kic7fWEGHzL4UhRqii7aSfmFaCXGtXFTp+OXjG1C7WmytB+zQHTVaD1fGf9
	 1jOcnC4HuFeGTwCNbm7ozPvnCyD3mBzKkDGAdAdbvboW+WjqasroxcQcqcQu1Kf9/PKUJ
	 LukwIZM8XSC1qYFXxFNl211CDTsuezlBrAALFPJSbia3hbwLm7uxH/lpAHieei/Iz+SUN
	 XDzqlLWSMweEmcFWEyHXiNUPnluzmQg4357ZqeuSZDH87d4gKPcR7LjDNrGr7WbaKyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 To:Cc:Subject:From:X-Mailer:References:In-Reply-To;
	bh=XQDfTOBLyQYKItk/7IbkqTdv3CPMUC9LzGhAb3DHHto=;
	b=s1bLsQ/2oEoL6Hkd3Cr0n3zIqmIc3CNRXo8yDPiU8w6v2jx7wXCkxZZrB79sd/BQRiM3
	 o85KroAmSvyb+6Ol+ZSw30nkJDcyTPweFjNlEzSqx7rwBQXMy5S/qWI5qzq0z6VIw2Edu
	 62lKsIF8B+V8GhLJiZ4ZKVou2wjF+Uzjdup86/0SBcHaMNHLHc3EUthgRQmH/j8r3g+bw
	 T3SIpLMxhlo794UgRvMDyqfkXct9TBAdXfV3lOs+/mT1IxwLz34pU/qWaCRmwES92ZGFL
	 LjJwnewvL4ODdb4hx6+V29IfYy2l05j/qJKGNf8J0gnVhI9E15OFkoVp5Jaa2TyMexg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soleen.com;
	spf=pass smtp.mailfrom=soleen.com;
	dkim=pass header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=giz8XH7k;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEEB860A261E
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 13:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEEB860A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.a=rsa-sha256 header.s=google header.b=giz8XH7k
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eadef147ffso616218e0c.3
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 05:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1794316235; x=1794921035; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XQDfTOBLyQYKItk/7IbkqTdv3CPMUC9LzGhAb3DHHto=;
        b=giz8XH7kLVNdvxOASwgI4RprGKiyUEsoiMXkvupuqdbq9I7LXpuFZqF9NAaqie1qMr
         HNJZv2mOnI1c14z3zIJwnN7vIs8ky6CILsvv2CM0qmoOH9g3iRbx1bbXTS7NHMeYMWDc
         T1E3X751NjsqCQfFyFJFZ/1wwBrMlG9vrd5wNzsn7G8Ze3LfFR7gBEFXW/avDW9IJBDC
         tg48AzOGXWZzS3cj3uRy9HUOHAvypw2biHfmU5mc8WkPHCq5oCLx7A1KH9y3W7p0DbVV
         Z8ZPRJ/mvn6eRb0cH+TTlVE5RtTkT5jIfBviqNGhmYhHP7IR91Dl8nmTHPnqTd/K3rGg
         w4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316235; x=1794921035;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XQDfTOBLyQYKItk/7IbkqTdv3CPMUC9LzGhAb3DHHto=;
        b=s7l5gpwaK28qqdi89ZZ82Yc3h2lgFsba3wtUz0Pfj2y9Vsj1kLIruaf93tG0heHhmg
         3zHJLVF0uGa+GPVccHoef5qvAFPrgTgOwzFKZ6MHbvK1mrVgsHpmx8D25ON+QW/1yaqG
         A2Tvz7mR8DiIjMwxERK6xpGz38YkZUEDhJ3T6+u8/ypftVIJY8sIWp4J77gJvfFigbww
         TP4ArNyk3Sz7eMeBKBl3UW6LHzTHDBO4GYcEtt/EECDEsO5ePFWEOa1ZntnD1MePXGf3
         gW4Hh5W9+cTLvS+jHqiaDLqMXEZMFmmRbIfVqQfarogBZeQzFPNhoD6gMcJmUc1Max+K
         ahJw==
X-Forwarded-Encrypted: i=1; AL+hErGwPUTQL0C82oRZG+kQif4Axz0pDyjhbCwP9gfQmFr9VvbkPP+fzgCLeXQB618eTo0bBiXkWgdRV3mb@vger.kernel.org
X-Gm-Message-State: APuU4Z9bqj9Y6IDz4rcK1fUevtre61ebjTAFhR+iZVQ2dRt0erA1nn3M
	YROejSdszRjRc0glSX94rluCUrTfceCq7WodTbMhpgHZb1q1Q1PxgatLcysIlWSB9yc=
X-Gm-Gg: AYBFou1Gc3OUu5b9ZQOsrFFUdebhge4xQjhoZtkcGroUab/7LVngHADJ+84qvbVGtYi
	vAH7puwAvMRv0ezLn4TmGV2zKwI/6bPGS23B5fdfssSQUCIJxHREtn3GjvbGgp+GFTAOW/dkUvN
	b3m2LQfdY1SQ3q4jbj4/R39aaBHK2GbMdQgbe/oEyG+QeLhUdUJsDlTTx2f7D0GJl4wzpMoTDN4
	3fIAHsjyfgm6lHTYfS+t4VEo3qz+pKa8VXg2l+Uli+ZymqGwb/rAxP5bmx6u41l6Bzc1fjrDgnN
	sbjuzsp9BlZquI6Qp1RBuSRYWN/MMIBAdWFgJwJY5n6JndfTlv2aPVbIYqHpxuoF3aTUbiSX3b6
	XCAyZArf5Ihq/bZBN4Bv92mT0ivuGTLuyVpbEnrk8NbQMALyQ2G6qYrKzLIoRvMM49+O55O7mmd
	tksob4+c3qmI2QbRYOGoU7OArtTVS69Yy8x4VUZME+XKLStDIP0NOp63jD/KLpR11Xb9OI3IPA9
	UMDqUi1hc4X6EsMQw8Qx0ZcgQnt7w7QUd9JB+fuSekL1BpfzPa2q0n0efmStR3p4QSrYXUIVTIQ
	vi8cA+V5nHyuasv07lVYfXihTvBGLNKVYBWVkr5MdxYUZe+HgLmXD3T6hJH7bQcL9G2Ms/KAPzc
	Zk+C/Wzizolm6U1nGKNKFRwl4KF6U8n8=
X-Received: by 2002:a05:6122:222a:b0:5c7:fbb5:6ea0 with SMTP id 71dfb90a1353d-5ee0d068066mr932090e0c.4.1794316234604;
        Tue, 10 Nov 2026 05:10:34 -0800 (PST)
Received: from localhost (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c20081409sm1695863241.8.2026.11.10.05.10.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 05:10:33 -0800 (PST)
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
Date: Tue, 10 Nov 2026 08:10:32 -0500
Message-Id: <DMRK0PU0VCN3.15F59WLOQ05P4@soleen.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/19] kho: block: Record the entry size in the block
 header
From: "Pasha Tatashin" <pasha.tatashin@soleen.com>
X-Mailer: aerc 0.22.0-39-g5d7784875be2
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-3-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-3-tarunsahu@google.com>

On Tue Nov 10, 2026 at 12:01 AM EST, Tarun Sahu wrote:
> Subsystems using the KHO Serialization Blocks framework currently do
> not record the serialized entry size in the block header. The entry size
> is only known to individual callers, which must track and store it in an
> owning serialized data structure. If a newer source kernel adds fields
> to an entry, the changed entry size breaks the stride when an older
> target kernel iterates over blocks.
>
> Add an entry_size field to struct kho_block_header_ser. On the outgoing
> side, record bs->entry_size into every block header during allocation.
> During restoration, derive the entry stride directly from the block
> header instead of relying on caller-supplied dimensions. The
> kho_block_set_init() interface remains unchanged. A zero entry size,
> or one that differs between blocks of a set, is rejected during
> restoration.
>
> This change modifies the serialized layout of struct kho_block_header_ser
> and shifts the offset of serialized entries within preserved blocks.
> Bump KHO_FDT_COMPATIBLE from kho-v4 to kho-v5 so that pre-v5 and post-v5
> kernels cleanly reject mismatched handover state during boot. Also
> update the stale compatible string example in the documentation.
>
> Suggested-by: Pratyush Yadav <pratyush@kernel.org>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>
> ---
>  include/linux/kho/abi/block.h          | 10 ++++----
>  include/linux/kho/abi/kexec_handover.h |  6 ++---
>  kernel/liveupdate/kho_block.c          | 32 +++++++++++++++++++++++---
>  3 files changed, 38 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/kho/abi/block.h b/include/linux/kho/abi/block.=
h
> index 36bdbaf9b3b8..a40b0906c821 100644
> --- a/include/linux/kho/abi/block.h
> +++ b/include/linux/kho/abi/block.h
> @@ -40,9 +40,10 @@
> =20
>  /**
>   * struct kho_block_header_ser - Header for the serialized data block.
> - * @next:  Physical address of the next struct kho_block_header_ser.
> - * @count: The number of entries that immediately follow this header in =
the
> - *         memory block.
> + * @next:       Physical address of the next struct kho_block_header_ser=
.
> + * @count:      The number of entries that immediately follow this heade=
r in the
> + *              memory block.
> + * @entry_size: The size in bytes of each serialized entry in the block.
>   *
>   * This structure is located at the beginning of a block of physical mem=
ory
>   * preserved across a kexec. It provides the necessary metadata to inter=
pret
> @@ -51,9 +52,10 @@
>  struct kho_block_header_ser {
>  	u64 next;
>  	u64 count;
> +	u64 entry_size;
>  };
> =20
> -static_assert(sizeof(struct kho_block_header_ser) =3D=3D 16);
> +static_assert(sizeof(struct kho_block_header_ser) =3D=3D 24);
>  static_assert(!IS_ENABLED(CONFIG_64BIT) ||
>  	      __alignof__(struct kho_block_header_ser) =3D=3D 8);

The above change goes away once my comment on the previous patch=20
is addressed.

> =20
> diff --git a/include/linux/kho/abi/kexec_handover.h b/include/linux/kho/a=
bi/kexec_handover.h
> index 2f4fb9c63942..6f12f5037ea5 100644
> --- a/include/linux/kho/abi/kexec_handover.h
> +++ b/include/linux/kho/abi/kexec_handover.h
> @@ -41,7 +41,7 @@
>   *   restore the preserved data.::
>   *
>   *     / {
> - *         compatible =3D "kho-v3";
> + *         compatible =3D "kho-v5";
>   *
>   *         preserved-memory-map =3D <0x...>;
>   *
> @@ -62,7 +62,7 @@
>   *     };
>   *
>   *   Root KHO Node (/):
> - *     - compatible: "kho-v3"
> + *     - compatible: "kho-v5"

These are just examples, don't update them.

>   *
>   *       Identifies the overall KHO ABI version.
>   *
> @@ -90,7 +90,7 @@
>   */
> =20
>  /* The compatible string for the KHO FDT root node. */
> -#define KHO_FDT_COMPATIBLE "kho-v4"
> +#define KHO_FDT_COMPATIBLE "kho-v5"
> =20
>  /* The FDT property for the preserved memory map. */
>  #define KHO_FDT_MEMORY_MAP_PROP_NAME "preserved-memory-map"
> diff --git a/kernel/liveupdate/kho_block.c b/kernel/liveupdate/kho_block.=
c
> index 0d2a342ef422..9b148009085e 100644
> --- a/kernel/liveupdate/kho_block.c
> +++ b/kernel/liveupdate/kho_block.c
> @@ -16,6 +16,12 @@
>   * array of serialized entries. Multiple blocks are linked together via =
a
>   * physical pointer in the header, forming a linked list that can be eas=
ily
>   * traversed in both the current and the next kernel.
> + *
> + * Each block header also records the size of its entries. A newer kerne=
l may

"newer kernel" does not make sense in the documentation comment, as any=20
kernel can do that. I would suggest "outgoing kernel." By the way, in=20
this series you use the terms "source" and "destination" kernel, whereas=20
traditionally we have used "outgoing" and "incoming." While both=20
conventions work, it would be preferable to maintain consistency.

> + * append fields to an entry, so the kernel that writes a block and the =
kernel
> + * that reads it can use different entry sizes. The reader steps through=
 the
> + * entries with the recorded size, so every entry is found, and it does =
not read
> + * beyond the recorded size of an entry.
>   */
> =20
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -110,6 +116,8 @@ static int kho_block_set_grow_one(struct kho_block_se=
t *bs)
>  	if (IS_ERR(ser))
>  		return PTR_ERR(ser);
> =20
> +	ser->entry_size =3D bs->entry_size;
> +
>  	err =3D kho_block_add(bs, ser);
>  	if (err) {
>  		kho_block_free_ser(bs, ser);
> @@ -242,7 +250,8 @@ static bool kho_block_set_is_cyclic(struct kho_block_=
set *bs)
>   *
>   * Restores a serialized block set from a given physical address. The ca=
ller is
>   * responsible for ensuring that the block set @bs has been allocated an=
d
> - * initialized prior to calling this function.
> + * initialized prior to calling this function. The entry size and the nu=
mber
> + * of entries per block are taken from the restored block headers.
>   *
>   * Return: 0 on success, or a negative errno on failure.
>   */
> @@ -250,6 +259,7 @@ int kho_block_set_restore(struct kho_block_set *bs, u=
64 head_pa)
>  {
>  	struct kho_block_header_ser *ser;
>  	u64 next_pa =3D head_pa;
> +	u64 entry_size =3D 0;
>  	int err;
> =20
>  	/* Restored block sets use size from the previous kernel */
> @@ -264,8 +274,21 @@ int kho_block_set_restore(struct kho_block_set *bs, =
u64 head_pa)
>  	}
> =20
>  	while (next_pa) {
> +		u64 capacity;
> +
>  		ser =3D phys_to_virt(next_pa);
> -		if (!ser->count || ser->count > bs->count_per_block) {
> +		if (!ser->entry_size || (entry_size && ser->entry_size !=3D entry_size=
)) {
> +			pr_warn("Block contains invalid entry size: %llu\n",
> +				ser->entry_size);
> +			err =3D -EINVAL;
> +			goto err_destroy;
> +		}
> +		entry_size =3D ser->entry_size;
> +		bs->entry_size =3D entry_size;
> +		capacity =3D (KHO_BLOCK_SIZE - sizeof(*ser)) / bs->entry_size;
> +		bs->count_per_block =3D capacity;
> +
> +		if (!ser->count || ser->count > capacity) {
>  			pr_warn("Block contains invalid entry count: %llu\n",
>  				ser->count);
>  			err =3D -EINVAL;
> @@ -370,7 +393,10 @@ void *kho_block_set_it_reserve_entry(struct kho_bloc=
k_set_it *it)
>   * @it: The block iterator.
>   *
>   * Iterates through previously written entries during state deserializat=
ion,
> - * respecting the actual count stored in each block's header.
> + * respecting the actual count stored in each block's header. Entries ar=
e
> + * spaced by the entry size recorded by the kernel that wrote them, whic=
h can
> + * be smaller or larger than the caller's structure. Fields beyond that =
size
> + * are not present in the entry.
>   *
>   * Return: A pointer to the next serialized entry, or NULL if all serial=
ized
>   * entries have been read.





--=20
Pasha

