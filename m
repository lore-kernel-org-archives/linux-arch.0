Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3E33368B0;
	Wed,  4 Mar 2026 00:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772585224; cv=none; b=UyN8DboB214uutkbpcpxTjMPMI9HTDuRNd9qBIihkADTy2nH9F4+Sl4akOQQ7uwVJy/TgP2w8fTTHWwaHXmC/3Sje7XPInKGhy5APEDlCqQ5O20lbPgLfOHfevAiB6RULLnB33wJ5WCe0WOfMJWtJekZkX2F7kN/rKNjRteL2ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772585224; c=relaxed/simple;
	bh=L0agXSy5k5zg4duP9ch4beS1Gjd4ZXMxY4kusjwDp5M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YEwBYjIqDaysKeSZyekvbJql0K/2I9QfVD3ksUUshNtCM7PN944DEXC8t/HtPadWRddAD+Hh23+gcYN0wGRs6O10b+uImzWZ+U5NFcRiTtxneF/reHawTIASJ2/yWUPXRGTpUgzjQDt1Xo9TYMAVkgq076O5+WmhS4keFGBnxvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZD6Mha8n; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZD6Mha8n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3b5lXtOkMrKzHrdzvjsQSTYv3ohYoaYQ3FD0NAZYl/o=; b=ZD6Mha8npV+KwY+YTVHlRD1fK7
	rpWdHkeWb4kgdw/LAkWp/dNzNWaP8VbeTK87jSVQ/cNUEhywHKn4lXFqW6ZXWgBnZdwUDR97RvcFX
	hEZomWuy9gmLmHYsSgKQc0jM8uzHjkFi1S/vH91jOnIs/yyUltOl56Vn0n8+m9dECdcOCHlFli650
	MeBSqCvwXZBoPHbn3jHDvaGWyL1mfb5C66Vf/p/ORGLd6uSSxogwu51g/oVY3J7HeODo91bzg0QKa
	3EptC5RozBx5lXnIXrOmjRjk9fE0G+Ksvw0s9XUn6zIXLsVbzq0YB35hqMS+a0q+E489AFfgfx16P
	UlMEH7pw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxaOC-0000000GBKm-1gRM;
	Wed, 04 Mar 2026 00:47:00 +0000
Message-ID: <4ed82fa4-193b-46a2-89c8-f3d69a5902c2@infradead.org>
Date: Tue, 3 Mar 2026 16:46:59 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] futex: add missing function parameter comments
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
References: <20260228071759.2663907-1-rdunlap@infradead.org>
 <e619c5fd-2e92-49a4-897f-8497980b417a@igalia.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <e619c5fd-2e92-49a4-897f-8497980b417a@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/3/26 6:23 AM, André Almeida wrote:

>>   include/asm-generic/futex.h |    4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> --- linux-next-20260211.orig/include/asm-generic/futex.h
>> +++ linux-next-20260211/include/asm-generic/futex.h
>> @@ -25,7 +25,9 @@
>>    *              argument and comparison of the previous
>>    *              futex value with another constant.
>>    *
>> - * @encoded_op:    encoded operation to execute
>> + * @op:        encoded operation to execute
> 
> I think we don't need the "encoded" part anymore
> 
>> + * @oparg:    operation code (one of FUTEX_OP_...)
> 
> This is the argument of the operation, e.g when op is FUTEX_OP_ADD, oparg is the value to be added.
> 
>> + * @oval:    previous value at @uaddr on successful return
>>    * @uaddr:    pointer to user space address
>>    *
>>    * Return:
> 

Thanks. I'll send a v2.

-- 
~Randy

