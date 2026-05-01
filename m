Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA0C282F25;
	Fri,  1 May 2026 05:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777611741; cv=none; b=DSNF6i4IXGAicwcm1V3Xw3nhuUfA4UnpWZwVgeEwvia8CsIasW4K8NOI1GPHDIS9OTdxbfYLZpSBZGxItKeRQbJ15g0m18i5TAfX+lPoCrGtvRBSd0apn+nuM9Nfv4f6qrg5LmwiprcO1t55ZDaJRB55iXltAp4Vt7fFWFQ8apI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777611741; c=relaxed/simple;
	bh=FV7al0NPrDZHBMtp5wA2Vo7CH8pb40DdHuc0z+Q5QSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PKzclMXRbSPNU4AB94607IKBduo3R3174dZaNxhSwNS1/BjpgZp93XNGLBnKaOMeTCSiNF8DmWa9oEyJEtmhKmJDubcgH0jb4XFF1VkTjuc6i43DADa/QQbra58cjmhzZzqs79knBQnGiohN4zQn6VzXGnj9bd+R2/j5wYcHPog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s/XyEXP/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s/XyEXP/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=LWA1g5oFCwVWUPa0xognVFXJxi+MRLqSNTq6zqH5uA0=; b=s/XyEXP/N+p/3PM8Bcpp4itzj3
	nJkn4/KLruwboJq5ylu0uw0N6ktZQ8fVhYeATeXHZe+II/XlVhlaKdSN+0Vy9xpQs8yQOLzZX9sfx
	/38v+oEYCWajprMRtYvvQU64jB80WzIdstlS/3BLzKsQZdbUVfSyPzQVrDenM9Pt3PgDP6KdoX+by
	j/K3O578lOThv43e0mu5dFYmrWc/A5VMm4MVKkFfWjLEX2vn2Ud7mUBjIh5FgMCbeLAIqVEJ5MxPl
	+byLGyx131re6sVQVmrG0Q+GdS27iRdqQH38OTy2pfkyBhpjNFy99c6rcJqPLcsZ576bwt72FkLC6
	ahoCfyHg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wIg14-00000006Mec-1TQ4;
	Fri, 01 May 2026 05:02:18 +0000
Message-ID: <9f0378c1-b56b-4f8b-b151-cda91633c5a0@infradead.org>
Date: Thu, 30 Apr 2026 22:02:17 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bitops: use correct parameter names in kernel-doc
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 linux-arch@vger.kernel.org
References: <20260430233934.2620065-1-rdunlap@infradead.org>
 <afPvrowTHUHGdtle@yury>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <afPvrowTHUHGdtle@yury>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/30/26 5:11 PM, Yury Norov wrote:
> On Thu, Apr 30, 2026 at 04:39:34PM -0700, Randy Dunlap wrote:
>> Fix the kernel-doc comments to use the correct parameter names to
>> avoid kernel-doc warnings:
>>
>> Warning: include/asm-generic/bitops/lock.h:19 function parameter 'p'
>>  not described in 'arch_test_and_set_bit_lock'
>> Warning: include/asm-generic/bitops/lock.h:41 function parameter 'p'
>>  not described in 'arch_clear_bit_unlock'
>> Warning: include/asm-generic/bitops/lock.h:59 function parameter 'p'
>>  not described in 'arch___clear_bit_unlock'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Hi Randy,
> 
> Thanks for the patch!
> 
> The arches implementing those functions use 'addr', not 'p'. In
> generic version originally it was 'addr, but then the functions
> were re-implemented in 84c6591103dbe, thus this 'p' appeared. 
> 
> Maybe just restore this 'addr' instead of fixing comments?

OK, did that:
https://lore.kernel.org/all/20260501045923.2884548-1-rdunlap@infradead.org/

-- 
~Randy

