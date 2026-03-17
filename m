Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF182BEC27
	for <linux-arch@vger.kernel.org>; Tue, 17 Mar 2026 03:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773716805; cv=none; b=qsYWgOBWhENcem7i5UVf6S4kx0qrR61tUh71/gY6xbRApcdrGQFsFr/t7SqzQtibUXMBjMSUPUKtBUlMUum0czD8oUmKOt5a1mSArKo4ZhoMsKgvZbJhh6avdAJGoeeUxTVhxnwDoZaJ0U2hErgYxcSSf1Q3ApT0GhjqoUWkkDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773716805; c=relaxed/simple;
	bh=f+U+RHB3J3u+dTioS7Vn6ot1T5etXD8kagp74lVKQ2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhvPlefeKKGZCYRRpgSiM6RHEJgjCBdQYZSp8IxdHIfaQR0JIABbaTuYkBG5nD58/EYMagKkYEFnesT7Co/tOvarMramkMYXcTz7h/sxd2XRpdENjW4FxCAof9OsuW/arHx1J3h6h8+KCUQ2oJwnDXFIjOL+TGdAdCFXWYQenzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jJrBdC/a; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jJrBdC/a"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40429b1d8baso2074230fac.0
        for <linux-arch@vger.kernel.org>; Mon, 16 Mar 2026 20:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1773716803; x=1774321603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pIA5bzRUo/kqjvuSbXtkhZ0/jdS0vsz2MPNHxmrgJFE=;
        b=jJrBdC/aKbOHnB+ZkjMM3/rCJvj9a118PImJx9kNMH22uuhxpzk+Cicso8u51n3Z55
         fZjcFKuXD03NyWdaRBTdnN3eutDjoRFW/k1HSpMlIERpFqWzYt3iJTVXrzu2SReyn6uF
         pTXqF0Jco6wT4+3rAtPtOLK74o8PvgPX+g8x/3u0+8isKcopN+eix3GYBYuOmuHEW+gf
         lJQBWuL+DsM+DgtnBhFc6wEo+jttZirs1GWoHr+sROkNEGGro1GVAMBPWMNa0UftuDzd
         bHavUiY339Ld8wpSPfr5kCWKPYCKCoEVboA8EML3I+ISiBbr9ED+REsQMxyrOyOGRHDp
         OWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773716803; x=1774321603;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIA5bzRUo/kqjvuSbXtkhZ0/jdS0vsz2MPNHxmrgJFE=;
        b=lpfZE5rboseQXZj6Xpx6lvJb0Jh044W4PqbW2OlsbF3or2WgOFY240oI0WOWNAW516
         OvgcwPr2Ww4S346b6BlgkPxXASt03YMstyY1FoYwQFVRVwgae86fD95eDb5qn5efORlW
         EECUN+kTNBlxqNct/mVnAYlj2WDv3FlViAbOtwv9Uj6fPI20B44FAplJyUUHFGva3Kxo
         h+8RWhDQtJPGoR4/Fd2DdEXSE6H2xJQsvj+uCEp9SSyuv+9vW7RVnDjND++NsDV2vYrE
         CGtsoWT7E9WTyTvtmAq93NWiV7WiCUyVpSAc+/2n7DLvwe+f9waiylgFCBqRfvkcI54n
         9YdA==
X-Forwarded-Encrypted: i=1; AJvYcCVSXLDAMTFjbDcxpq1msNYbFXTYn1+sbQPB+3IJCOFuXuujd/v29reteoaH28zNB0mURdtD7qPK+TAQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxCTFK3bF8EuD0oC82sZboKkWxq7Zml4TlH1Aa5Xy0b6sa8GTE4
	87t3f48B1TPgnjSjyXstJwG6NkOJXLmbpfDhtdjKyfM2cH/kvyTuWx6NCXNw/u+f8WM=
X-Gm-Gg: ATEYQzxl0MEFIv3bodpwjo7Gbkb9CntZru6f73xxd/0kKmhn5pCiz80oaBniPb5eI8S
	G/jNlXB80cvJqWg1uCZU2bsgSkaIPcgjWM9N9XwS5mvYAxSRMKdsjL/+n6E3I/ItDSh8Z2FSVAf
	/3C7gs24sOcnBZQKNSqypy6hF9JMVRzTfikfdfLA0YlQuX3g3naglA9beAYx9vCGug4WcjDDSZ3
	FzQxZy3GMZBSt23ENsrJQuMHeA2ZDUUlMYqerpsBqoZ18uArT0s9Bff6KWc6utoX/irdDTVpDEC
	62+3v4TqU9QA2rsT4hTupB3ybkuyH1TeoXRTh0DR5hT5bp8sigX5CjHxwwqdEVBzNxaYoNi2zUi
	2cwsslz2D5i8fqBMzATHBOjouUFKFp8ad+b8WBMNCtXVplcE1HnYg/OW1j9CItwp8RvyN7gnSaT
	vzX1wR18X3FXokMfQjuCAkKXTGJdAH71EC76RQ0CSA
X-Received: by 2002:a05:6870:c154:b0:40e:a338:c8a1 with SMTP id 586e51a60fabf-417b9072c62mr8995239fac.11.1773716802857;
        Mon, 16 Mar 2026 20:06:42 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.103.33])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e1f9f86sm18099947fac.2.2026.03.16.20.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2026 20:06:42 -0700 (PDT)
Message-ID: <f25ed5b8-e785-414a-b13e-85c1a787665d@sifive.com>
Date: Mon, 16 Mar 2026 22:06:40 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 7/7] futex: Use runtime constants for
 __futex_hash() hot path
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>,
 "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
 Sean Christopherson <seanjc@google.com>,
 Charlie Jenkins <charlie@rivosinc.com>,
 Charles Mirabile <cmirabil@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jisheng Zhang <jszhang@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
References: <20260316052401.18910-1-kprateek.nayak@amd.com>
 <20260316052401.18910-8-kprateek.nayak@amd.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20260316052401.18910-8-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Prateek,

On 2026-03-16 12:24 AM, K Prateek Nayak wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Runtime constify the read-only after init data  __futex_shift(shift_32),
> __futex_mask(mask_32), and __futex_queues(ptr) used in __futex_hash()
> hot path to avoid referencing global variable.
> 
> This also allows __futex_queues to be allocated dynamically to
> "nr_node_ids" slots instead of reserving config dependent MAX_NUMNODES
> (1 << CONFIG_NODES_SHIFT) worth of slots upfront.
> 
> No functional chages intended.
> 
>   [ prateek: Dynamically allocate __futex_queues, mark the global data
>     __ro_after_init since they are constified after futex_init(). ]
> 
> Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.kicks-ass.net
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de> # MAX_NUMNODES bloat
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  include/asm-generic/vmlinux.lds.h |  5 +++-
>  kernel/futex/core.c               | 42 +++++++++++++++++--------------
>  2 files changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 1e1580febe4b..86f99fa6ae24 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -975,7 +975,10 @@
>  		RUNTIME_CONST(shift, d_hash_shift)			\
>  		RUNTIME_CONST(ptr, dentry_hashtable)			\
>  		RUNTIME_CONST(ptr, __dentry_cache)			\
> -		RUNTIME_CONST(ptr, __names_cache)
> +		RUNTIME_CONST(ptr, __names_cache)			\
> +		RUNTIME_CONST(shift, __futex_shift)			\
> +		RUNTIME_CONST(mask,  __futex_mask)			\
> +		RUNTIME_CONST(ptr,   __futex_queues)
>  
>  /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
>  #define KUNIT_TABLE()							\
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index cf7e610eac42..6b5c5a1596a5 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -45,23 +45,19 @@
>  #include <linux/mempolicy.h>
>  #include <linux/mmap_lock.h>
>  
> +#include <asm/runtime-const.h>
> +
>  #include "futex.h"
>  #include "../locking/rtmutex_common.h"
>  
> -/*
> - * The base of the bucket array and its size are always used together
> - * (after initialization only in futex_hash()), so ensure that they
> - * reside in the same cacheline.
> - */
> -static struct {
> -	unsigned long            hashmask;
> -	unsigned int		 hashshift;
> -	struct futex_hash_bucket *queues[MAX_NUMNODES];
> -} __futex_data __read_mostly __aligned(2*sizeof(long));
> +static u32 __futex_mask __ro_after_init;
> +static u32 __futex_shift __ro_after_init;
> +static struct futex_hash_bucket **__futex_queues __ro_after_init;
>  
> -#define futex_hashmask	(__futex_data.hashmask)
> -#define futex_hashshift	(__futex_data.hashshift)
> -#define futex_queues	(__futex_data.queues)
> +static __always_inline struct futex_hash_bucket **futex_queues(void)
> +{
> +	return runtime_const_ptr(__futex_queues);
> +}
>  
>  struct futex_private_hash {
>  	int		state;
> @@ -439,14 +435,14 @@ __futex_hash(union futex_key *key, struct futex_private_hash *fph)
>  		 * NOTE: this isn't perfectly uniform, but it is fast and
>  		 * handles sparse node masks.
>  		 */
> -		node = (hash >> futex_hashshift) % nr_node_ids;
> +		node = runtime_const_shift_right_32(hash, __futex_shift) % nr_node_ids;
>  		if (!node_possible(node)) {
>  			node = find_next_bit_wrap(node_possible_map.bits,
>  						  nr_node_ids, node);
>  		}
>  	}
>  
> -	return &futex_queues[node][hash & futex_hashmask];
> +	return &futex_queues()[node][runtime_const_mask_32(hash, __futex_mask)];
>  }
>  
>  /**
> @@ -1913,7 +1909,7 @@ int futex_hash_allocate_default(void)
>  	 *   16 <= threads * 4 <= global hash size
>  	 */
>  	buckets = roundup_pow_of_two(4 * threads);
> -	buckets = clamp(buckets, 16, futex_hashmask + 1);
> +	buckets = clamp(buckets, 16, __futex_mask + 1);
>  
>  	if (current_buckets >= buckets)
>  		return 0;
> @@ -1983,10 +1979,19 @@ static int __init futex_init(void)
>  	hashsize = max(4, hashsize);
>  	hashsize = roundup_pow_of_two(hashsize);
>  #endif
> -	futex_hashshift = ilog2(hashsize);
> +	__futex_mask = hashsize - 1;
> +	__futex_shift = ilog2(hashsize);

__futex_mask is always a power of two minus 1, in other words all low bits set.
Would it be worth using an n-bit zero extension operation instead of an
arbitrary 32-bit mask? This would use fewer instructions on some architectures:
for example a single ubfx on arm64 and slli+srli on riscv.

Regards,
Samuel

