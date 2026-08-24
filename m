Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C849448380
	for <linux-arch@vger.kernel.org>; Mon, 24 Aug 2026 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586317; cv=none; b=SfeZzgNAZg7QP7Hr4lcyHaOlgAlP3VJSWZ5MKwDHdXJPZfaBF1tMCR7k4ylzCDJJvrpUJDHRRFXUD6kphnmQUF+U3qE1VTUcFJwKLOt+L7omiOn2WyPjs8e6eGbGvNP7x6k7NQidYiJ9zIGD7U71Q/sEqYvBCVLAvwDOx+m7fD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586317; c=relaxed/simple;
	bh=rH5ooTmhOET3vAsIUkA6yaGvEUpGPYpVuc1a+dr0RM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jPUG7/6QTsZsrK3/BsHpQZ/L3eU+GNPX01KPUnzAa38G36gbOhh/5ciSDlAVXPQFb79zh25yorbVq1dpM8SwYSGVMIJANnb0tr85WYXMhyO7CzsK0Vh5cYd5/2xrHI+xwEnQNHHOZTKNSiMlksdILtQi6g1iSDZCu0X6NCaDD/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XiWO3OjI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XiWO3OjI"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso4439104a91.2
        for <linux-arch@vger.kernel.org>; Mon, 24 Aug 2026 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787586312; x=1788191112; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QEtJVtkW7q375yAi3A0GskrIJ2s9H0yJ3yupt0Y509Y=;
        b=XiWO3OjIqdcETuZVZGtwjGh/ridNShPFkWNE3WtqLgW/OCUrW4ceSniPCnuw3SK9w1
         XTU8Ys9ZLukdPh1w7VDEanB/FM0sqiWMGyN4dR5evFWNqo6ePuO07HrlNh2fuCx4GNru
         vGoj5lnIz6IFL6b637DRdsu/jePBVR3paCUUy1VRsZi5Dp/5l5BDabEV2rm4s/++FuVi
         7cSrGkjkmZ9dSZmXjXXxqZfPXtq1iTfhvn/lNVGmVmKesYI+fa9ppS+0qqeikflC0VM+
         JFIvYdhKOwdGtQFELrlmbm4uwP6XS2FYISN62wP3zDXL1mZB+3qq3TjDJETwgSTW2eHm
         A9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586312; x=1788191112;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QEtJVtkW7q375yAi3A0GskrIJ2s9H0yJ3yupt0Y509Y=;
        b=VW2IpLz7RedkcahLfmjltNbVH2k7bJ7nzogGPcuJAgqVs2ekzibDhf9Sy9xHXAv9EZ
         bvumNgSwnl0jowwba4GlX9Ox0JnvL5alAydxcpHlXmW7nG6ZwhD502NCAv0IaXxRIy8W
         7lG7EJuL62z4MwxqXGMMdjXG0YtsDuJG6Q+3qfU8WyProzl4Zb+18XPMMh9fPwfoVh6g
         cYMZkMrYV7jHv7TqFO408P3zRA60PyIakmjqbnhWdyYZC8Oq7WDF1TABJC/kFYD0GSK6
         xECN9YtoKPNJVvRKer7xR2IK+acz+LqaNKf6C6x1fYGCRXF+7u04DByLTC+jVd7n7Hqs
         GOFw==
X-Forwarded-Encrypted: i=1; AHgh+RpDdXhcFGGp58P2q7VhdTTRVEtG3bUnjV4ysQfWAArNhWz0kc8tuBRO7BKEmY1ib0XYEgM0+lSy8Pi9@vger.kernel.org
X-Gm-Message-State: AFuF++lQxX0LENUU6KQp8K2MmUDDy3fYQY1LXkII3Jv9kFTpjMkCuXnt
	Z46MpXECilegRHjubyOB1O9wqdm8gDd2j58RZEmwS4FFmdvGBm81P0sykbHD4Z+QQaE=
X-Gm-Gg: AR+sD121meNvPVMeTP7+Oj4oykUr+yKQub+AIMfnsX/8Hr5ZseYe/dSbEZy06W4gKEV
	1fGhT6wSNkSD9iW8pDULozKABo7SKrHtmnOVg2j0Vvtd489NJvcYK1Mkk3mMCJQwk88rZzHaDIe
	5/DiQRUFtps7VcUC/NtlqQXuyD9Szx33+Ypp+QtIMcgmRP7Z4T/JfnPTVUjbTn6mz81BpnX91jS
	AFSreFse3Ij1aYbNHaU0coFFhYe4p3kEBsSUwR9fXkwIWR202TVTFCTTAwVQ4j1z7KN287ZVVYL
	gJg+hsAH6BERBT5nmoTwtBrWzxcYAAx+zjQm9fXbxE5iR+HbF86493DfQ0+ANJvSRyTqGM+WWC0
	byr4Vcx8s8hBXN6mJKnFhTBpdTgoCGuiK0zc89fxiJ6a89ULjvsCryOn91ZQ3OzMOi3w+92n5vU
	wQZHd6fGpPP20EfdepmIXc/mpSM1UWEIzc7Zi+npFH6eZzR7QLb0Jx54UxsfOUCQF33mK6TKetu
	RhRbiV4/iHQWL0=
X-Received: by 2002:a17:90b:5867:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-395df4dcdbcmr39252435a91.15.1787586312489;
        Mon, 24 Aug 2026 08:45:12 -0700 (PDT)
Received: from [100.64.0.1] ([165.225.242.163])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b7ff6dsm23611a91.10.2026.08.24.08.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 08:45:11 -0700 (PDT)
Message-ID: <029cfde8-74fc-4437-bc18-b1b53d44cab2@sifive.com>
Date: Mon, 24 Aug 2026 10:45:09 -0500
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>,
 linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-2-anshuman.khandual@arm.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20260818040041.1891769-2-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-08-17 11:00 PM, Anshuman Khandual wrote:
> Move ptrval_to_str() inside a header thus making the helper more generally

Typo here and in subject: ptrval -> ptval

> available for new users which are being added later. While here, also move
> another related string size macro PTVAL_STR_MAX inside the header as well.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/mm_types.h | 15 +++++++++++++++
>  mm/memory.c              | 16 ++--------------
>  2 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b18c2b2e7d2c..a5b514e55dd7 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -2001,4 +2001,19 @@ static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
>  	return flags & MMF_INIT_LEGACY_MASK;
>  }
>  
> +void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size);
> +
> +#define ptval_to_str(buf, val)								\
>...
