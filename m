Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368087;
	b=NykFZP5CbnyUdjX2ClQwE3VMohw/zkE31aZaKPFCfScrF6e5NVlFgsM7jc36iHVowRun
	 fvmuWE7kNV3GnY8jahgaKadiH9GSDMgOOFd+VpI1GrwrlfZw7E8itlvSlfQ8CbVxsWi/u
	 9tqwrEPLEsgco4ZnSzknEzEehNYNWRlZkHyA/dl9NXvnES96qakJHgnEh9H1JAmKtPHOx
	 ovVcd79x0RPZUwZFca2tFiVcUzUn9Yd4w0ECyUUikQxxzZUmVgxCVq9vvcq2R8jlFuCSG
	 MiXIcR9dK4nD5dEYWI1/r8urxwb+ogLROMmBVuJfoXtY8wsqUWZejore3uA/Zy0ba0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368087;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
	b=nDeIxJG1C2Wl7RmpFKn6ePaa62kOQDNmvLZO9KNpG9hdge9Ko4RkvK95lP9htAZdVQh7
	 tdt72/KQ3yOe0o5OqvTV8N57P3ixiY6IFLFysmqzAAO1lwP2pXOkLgnV3OyrgiTT7KBAn
	 CvojL064NGPwncLVtkbKhxgihUMLAthDIFRKo+jFacWZtQIqmArQzkpsW3rFuzKIshxMU
	 MotjxD85QA7dvPa010ZRaFb+ndU9SzkOo3PFx6MVT3eWWNiY+2fiCL6u+gBePOFlAe1Iw
	 +5hNN/Hy6tRGcCJfGJFGDwcuzUrRy2JrullU/qCi1K2FZH3mQHdBy9TVhSnGmTSeWRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0o7zm7K;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3F0606A323
	for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 13:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D3F0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0o7zm7K
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so5783705e9.3
        for <linux-arch@vger.kernel.org>; Fri, 30 Oct 2026 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793368085; x=1793972885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
        b=P0o7zm7KEPIXltx3NlgMQzHQT99NsbdanhX5hUYiA8mqcXpAtEl9r+/7vE4Ggfb6xQ
         AjDmKEsJCN3A9nhHSHYQq86Tx9QzgKkEoL+MNKiu90Y6d/c6qq8wEeWDbGqZ4zOp73t2
         V+jiEVsBNp3JryoT0gq/L7+LKDEBausQ7tqgfI+sigyrm1PvM7UpDQc9g0naBiUQsKsm
         txn6SCcpysT3ZLStg89zxyyBWbPd9BONg/H56ElBDxvktEsTFh0x/DFDQ8EoFwz5gpkM
         +r9npc2iAjvhv6WuZ+vHLzVgZO3yPFE7oA+XMRoLdTuvTODgouxb21kNS1YSNNzhhvRI
         MLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368085; x=1793972885;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rmX4JEwV7qAmy43PkgvX967p02rESGhBBxr09gc4cBg=;
        b=iGGKMtYoCRikFzdCUWo9fzwa4hKL5nqrD9AzXxHUqeWI/D+JAUq5a3dyI60MdYjuRj
         A5MoOs5fh95jXQSHPX3bxREELt1He6t1VLXtBkjNemoOkyS3oEq3+sjYI8q2ubo0AF+H
         6FIDhKxfyo7xdYKHvzJztCNKkLPt9651rz98DbSGyyMeuXGxo3/VndVaqlnDd6MDZEza
         APhdCXAZJEE54dzyox7oXZgJMpHT6Kh2KUwreykzeOoG0Dtml2vQDCmUvb1ZZ4mxxaGa
         cXZ/ipjwphPZQdN0geCEaVQ376r2Dkf54XhhzMj0G39EnTrCk5USqT7OWis5D0Nyizho
         /2kA==
X-Forwarded-Encrypted: i=1; AKwUvBy21gdD/NrmNcYUkuiTgdzjsMwGFT3wrxLhxvoALBD1nyDKhLYYs8+/LZXjQPmMIQk658Ni6DJ87WSp@vger.kernel.org
X-Gm-Message-State: AFq9FYLvX1iSqdjn7zD2v2ozVoI5psZHyjHEk0tFRg+wJO6g5v+JUGg1
	0ulZKShDuE0AM+/v6njjDtRcS6jLi19ja/z2gBdMkMODVXuHJ8ATXOzv
X-Gm-Gg: AYBFou04v1C1++vjpKG0oZ4vtEVLZTMU4lDZvniS2MX0mnbSPrdLvLUKmmGWgyIPTJ/
	K5ncAM24XRL9PW56JXINoz1PcDxWCxfC2zRWGiup2OWSnJycr1aEuvflluX832pzcdhTDlm1Gsu
	3rr5MwgMV4vzIxJbZuuHkpNE84K9myRu+PqCrafZn8Pjt3xIJ8j7KWueYVQaI4B8GmctKRkqE9C
	Ypcz3yeEOmSFY/s7gIuklbcLNMFc0S/a0gglxidXvH5LcKBxPJHMTsgUQ1Ygv4SgKagFzfB1eoT
	yBHRF0KDsVVF0WxgeA6y/2R7oRinaZilPfti9ac/8FIpV1IuO31GHrM3JUaleirv5/3RLl1i6VL
	03CGGavbRNFk45T9o1KO+X4IiFuhxEqW7okhzMBtI11S3OeJ2yFxKDjl19QBsZuNusFQVlIOWjV
	Y1nOBUx1Qt0Nx7AymAR/s4hKrqRWDJbUUwPZxhYnZRKALNvqoHcKQs9Zbot0b4KrVAS9Z6OTshV
	XkchtH6Y1clKY4F+A5l/0WNpr2Kst35Jt1lZ5qBFsam/xfMe1cZoaN6uOZkvUUft40kP6royKQ0
	keEwdYHzjiZL4XDSjl45SjFWTET64G61RgQNgCmypIOWDJwzTkPN5n6G//ErIQjzjKDqLEMnbVx
	YaQd+NnBra+jcWQ==
X-Received: by 2002:a05:600c:34d1:b0:4a2:526b:d3fd with SMTP id 5b1f17b1804b1-4ac1793fb5emr50752935e9.15.1793368085145;
        Fri, 30 Oct 2026 06:48:05 -0700 (PDT)
Received: from C422HJQPQG-Fractile ([130.43.154.100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ab69b54742sm172048905e9.15.2026.10.30.06.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:48:04 -0700 (PDT)
Date: Fri, 30 Oct 2026 13:48:02 +0000
From: "Vishal Moola (Fractile)" <vishal.moola@gmail.com>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Alistair Popple <apopple@nvidia.com>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>
Subject: Re: [PATCH 0/2] mm: Remove pagetable_dtor_free()
Message-ID: <auSgElFWW4n3sJLb@C422HJQPQG-Fractile>
References: <20261030083800.599152-1-songmuchun@bytedance.com>
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
In-Reply-To: <20261030083800.599152-1-songmuchun@bytedance.com>

On Fri, Oct 30, 2026 at 04:37:58PM +0800, Muchun Song wrote:
> This is a follow-up cleanup to the page-table teardown fixes [1].
> 
> pagetable_free() now invokes pagetable_dtor() for constructed page tables.
> This makes pagetable_dtor_free() redundant and leaves explicit destructor
> calls immediately before pagetable_free() duplicating lifecycle handling.
> 
> Remove pagetable_dtor_free() and convert its callers to pagetable_free(),
> then remove the remaining redundant pagetable_dtor() calls. This keeps the
> destructor decision in the common free path. No functional change is
> intended.
> 
> [1] https://lore.kernel.org/r/20261023063428.3658761-1-songmuchun@bytedance.com
> 
> Muchun Song (2):
>   mm: remove pagetable_dtor_free()
>   mm: remove redundant pagetable_dtor() calls

For the series:

Acked-by: Vishal Moola (Fractile) <vishal.moola@gmail.com>
