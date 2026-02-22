Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF5535FF6E
	for <linux-arch@vger.kernel.org>; Sun, 22 Feb 2026 23:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771804267; cv=none; b=SKaVFPln+bULJfOV/ug4qkSlhemLefqbn6slH/l8WU28UQNkBr7B7jEHDGQCsr1yGYibpDltfJsIn4CExpt18Jfec/hNgOJgRElD1Bt3X9jcu7y7G6yt50l4WMsQ4IFXv/1t7TKXzbI8iCmC5EnY5weaun92Ww83Xtiz6ygKDdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771804267; c=relaxed/simple;
	bh=yoNlxJY0XAmABPdtJI93ljCjOK0bXGtkNbiu+bg8Mvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPuOs1RvWHK9he23ctykQI99jx3/P3h9FP2JyqM6Tpy00QVZJedwyS1xQdBlEZRTvl64B6E97qv2wepKQLUnIH/E13o5tqb39kKE+4txc/+9HZ3izPft7zpUanid98h2/At22+528dN9L8TtUGgZahUtzb8srZajrYcrA24sxnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lEAmGaoh; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lEAmGaoh"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b8f8f2106f1so515509166b.2
        for <linux-arch@vger.kernel.org>; Sun, 22 Feb 2026 15:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771804264; x=1772409064; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a3DenEUfvzZ4Gn6BP0nDuZ8nQgEdkOBl43ceISWkWLE=;
        b=lEAmGaoh3oh6X+hwTOBbw8e/UJBBEnDMO1KTFfEk7+BXNQyZsq1l3Hr3l2w3AG9YUk
         rg78KILVK0VW66D5N+xp7kZq5eOrMrE85lQW1/BPY9GPN9I4Qs5XXCBMK7Z+tByLEiNP
         unGSc2yybWceX8dHbwgMMD3QNo0w7gUDcnvcP3pBxVBETza4nZTmHxbH20lLqio8zh+q
         gsJTBOEtX3fZ2KEH0ZKmjny/hXOxVP2Rub4kmEtBjntSIr5nFMM3OIMGJDI6FuSePVJ0
         cDIh8lPgk4BUkVkxGFYZUiK2uaSjom78s3moEhv9xKYzkJ1glz6uPn66v45KyrDnu6PM
         hhnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771804264; x=1772409064;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3DenEUfvzZ4Gn6BP0nDuZ8nQgEdkOBl43ceISWkWLE=;
        b=O3uKW/rUekmZEQpFX/f7hI1Hsj95x0trhqYEQHKr40Nd7P8AFr3G2AWeE9hxS4lc77
         c1pxY2CFigyHSlvhVAxNczAMZH+1PWZQmwz6sv6FTHL4cNlmEIFxNrs0RnL1nuOpw+6T
         C+5sU3wjOA1LEmat4sQf7YDkPL+Z/rq/WhgxfoDK/eo4TnuIk6XG39AEeVUGuFyoVifH
         dANEaCCLHBOIwYsYjNI41fHq/qTWpqb8wHQSycvE7WdfDiptFnq4y8ofJo2akEbBArDY
         o0kydMPwWQvWKxgDD8VO7c7r0nfJFH0XRgrA/sOCxMGixn5s3/8RA7sr2ITIkqv4Mo31
         YJsg==
X-Forwarded-Encrypted: i=1; AJvYcCXc96HUs90H+NSMADPhfWRkE4nqcqCXmatib9/NwKsMg5reCafTwVJn+VLhZd/wG/tCNJCZgDrXT5qG@vger.kernel.org
X-Gm-Message-State: AOJu0YzoIcN0BLUTv002NW6hcoUmHggmqskerwz58L87I2ZUDhxbfOwG
	dHs34+hvV3qzF5m7St1G9E593lN8UBWIPI84Kxa/zadXIx8ObTKad5p8wqzPmQ==
X-Gm-Gg: AZuq6aKQAWJhZFOyUVjeatJlsVShcoqaJkD8ZjZ9MGq6jCJf7uK/wha2DfjVQVWlGp1
	tqXGilmOL1g5TmeTw06sO0DRb74CnDQ0S4FvgPh0VV2uttBfmH6ZCrGMhD58zY97YQ15ZdO6b8d
	h0S9/v3wTJk9zcEY+SO4q/9EPGQjcPlV1/oHDycocgCKzcLsbLn7DNbf4vU5doXKJ960kyTTJFW
	J6+/ja2KkxsGnXNW9ykk83Gioc6E04p5YcyaADjWXM7Mw3fCgXNOPW6zSD3yymr89cXE1VlpAgr
	JnDLsQZYkS1PmV0c25CPfXmXEFbH5pNEGAhMrBI/hg8q+meTUv+aYxtsGQic2xobrOSkpzPlzy/
	fCDyn1COShgWKjT6a7PtxoyEtYq1Bc54LqnlnpJpaYBvatjyHukudYkBvMjozaFOosOzgUEM9QD
	qbR/mKIvZ25wzt7syhmzJR0g==
X-Received: by 2002:a17:907:1ca5:b0:b8f:a32d:b90e with SMTP id a640c23a62f3a-b9096709ef4mr238666166b.34.1771804264073;
        Sun, 22 Feb 2026 15:51:04 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9084c824a3sm263031566b.21.2026.02.22.15.51.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Feb 2026 15:51:03 -0800 (PST)
Date: Sun, 22 Feb 2026 23:51:03 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, will@kernel.org,
	aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org,
	Qi Zheng <qi.zheng@linux.dev>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Subject: Re: [PATCH] mm/mmu_gather: define RCU version tlb_remove_table_one()
 in CONFIG_MMU_GATHER_RCU_TABLE_FREE
Message-ID: <20260222235103.firb34hgaddqsc2i@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20260222004512.839-1-richard.weiyang@gmail.com>
 <20260222114201.095379dd766b68dcecbab1c5@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222114201.095379dd766b68dcecbab1c5@linux-foundation.org>
User-Agent: NeoMutt/20170113 (1.7.2)

On Sun, Feb 22, 2026 at 11:42:01AM -0800, Andrew Morton wrote:
>On Sun, 22 Feb 2026 00:45:12 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>
>> Before commit 718b13861d22 ("x86: mm: free page table pages by RCU
>> instead of semi RCU"), the page table pages will be freed by semi RCU,
>> that is:
>> 
>>   - batch table freeing: asynchronous free by RCU
>>   - single table freeing: IPI + synchronous free
>> 
>> This commit introduce a RCU version for single table freeing to support
>> PT_RECLAIM. While it is not necessary to limit the RCU version only in
>> CONFIG_PT_RECLAIM. It is reasonable to asynchronous free single table by
>> RCU if CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>> 
>> This patch moves the definition of single table freeing in
>> CONFIG_MMU_GATHER_RCU_TABLE_FREE, so we have both RCU version
>> batch/single table freeing if CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>
>What are the expected (and measured!) benefits of this?
>

No, this is just a cleanup.

Last time checked with Qi and thought it worth a formal patch. [1]

[1]: http://lkml.kernel.org/r/fd90c84b-9829-4699-b7df-c43020519ec9@linux.dev

-- 
Wei Yang
Help you, Help me
