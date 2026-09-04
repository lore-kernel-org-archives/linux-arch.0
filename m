Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD5D43F8DE;
	Fri,  4 Sep 2026 21:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788559127; cv=none; b=i5nwLB9TXqzxm/N+t2BTYfe02hc3o0OyFJL+/08OQbrvtk3+YMD1NgQEsZWAuiM5Qxmo11Ea6tMakp49CXrHdI61Sd9jiZ4NtI5/Civ7ab332c9XmieU0iog/5CN5+Jv81qH1SGodp6MILVfpRDa32DkcZyUMuim5CakNCD9FRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788559127; c=relaxed/simple;
	bh=H35BU7y6k4CoifW/ay2GfOQzq0oEUICP3sw26CQOMT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cMGHYw2kprDF0prWZPJRjGuK/n6cl5vWV614bdIacteKO5rVCFARKFar7tmTj5pURqCQAU26IPASen+gQ79byFUytIrqcSCyHUtAjwZ3VryJ0qcEMuzM4t6G1GjThSav81yQgFj5M01b0mCxW0Bd3K89XVWa2h/RR27ysYGK3mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DEs3y3UK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DEs3y3UK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=XzksWWU1MUewC/BGGGBFcbL92cidcE2lZQDMH810em0=; b=DEs3y3UKSKMtC6+hpG42uJJrxK
	nNwf1sy9HeWqgaQDHiRkVEDSiamQWh5BXeT3EJdFuQGLJI08iYFHKJP3OtvFw26vslDqZLWkTpr5N
	0JbaWi1KUCxAoiMkDEWNXR0rugBYMGV4rlFfK7u2Nwy0lozHNnipNxscf0L0jV434+RGmNGUmZdeF
	P2sMfhObKnxBU7IuHpbz4vbcVWZ2lcRQN5Z3a9b9TQUqW1hNIVca+B+BIiFK+wunioTm8qPTbkqZc
	TelBW/MjVOrpYaMI+VLJbMAsC9zVOz6pXXJmwj0vXIU605lTKycs4rzdCpKcNEMQ2gRXt6wrAkRPD
	3LJjHOgQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x2bvc-00000003MUF-39hx;
	Fri, 04 Sep 2026 21:58:32 +0000
Message-ID: <bf0048cb-afa0-4830-b453-4083680e6534@infradead.org>
Date: Fri, 4 Sep 2026 14:58:32 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] asm-generic: fix typo "explicity" in comment
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Hemanth Selam <hemanth.selam@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, David Hildenbrand
 <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
References: <20260904104854.25272-1-hemanth.selam@gmail.com>
 <20260904104854.25272-2-hemanth.selam@gmail.com> <apqsBpALCmN8S-qw@gremlin>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <apqsBpALCmN8S-qw@gremlin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/4/26 4:33 AM, Lorenzo Stoakes (ARM) wrote:
> On Fri, Sep 04, 2026 at 04:18:46PM +0530, Hemanth Selam wrote:
>> Correct "explicity" to "Explicitly", reported by scripts/checkpatch.pl
>> using the misspelling list in scripts/spelling.txt.  Only touches comments,
>> no code changes.
>>
>> Assisted-by: Cursor:claude-opus-5
> 
> Thanks for acking the LLM usage! Appreciated.

I agree, but I find myself wondering what the LLM did here.
checkpatch reported the misspelling.
Does it take an LLM to use the correct spelling?

>> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> 
> Please make sure to cc everybody on every single patch. It makes it a nightmare
> to deal with your series given the volume of mail I get.
> 
> I may have to write a bot to auto send this :)
> 
> Anyway LGTM so:
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> 
>> ---
>>  include/uapi/asm-generic/mman-common.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
>> index ef1c27fa3c57..cf1418649b3a 100644
>> --- a/include/uapi/asm-generic/mman-common.h
>> +++ b/include/uapi/asm-generic/mman-common.h
>> @@ -62,7 +62,7 @@
>>  #define MADV_HUGEPAGE	14		/* Worth backing with hugepages */
>>  #define MADV_NOHUGEPAGE	15		/* Not worth backing with hugepages */
>>
>> -#define MADV_DONTDUMP   16		/* Explicity exclude from the core dump,
>> +#define MADV_DONTDUMP   16		/* Explicitly exclude from the core dump,
>>  					   overrides the coredump filter bits */
>>  #define MADV_DODUMP	17		/* Clear the MADV_DONTDUMP flag */
>>
>> --
>> 2.48.1
>>
> 
> --
> Cheers, Lorenzo
> 

-- 
~Randy
