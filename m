From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2.5/13] memblock: Use __meminit[data] instead of __init[data]
Date: Thu, 14 Jul 2011 14:24:38 -0700
Message-ID: <4E1F5E96.2060709@zytor.com>
References: <1310462166-31469-1-git-send-email-tj@kernel.org>	<20110714094203.GE3455@htj.dyndns.org> <CAE9FiQU92k-GAy3DVB4HYpn6D6_u=4T7t9_8FOGh8BLDEAKD=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:57008 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932232Ab1GNVYy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Jul 2011 17:24:54 -0400
In-Reply-To: <CAE9FiQU92k-GAy3DVB4HYpn6D6_u=4T7t9_8FOGh8BLDEAKD=Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, tglx@linutronix.de, benh@kernel.crashing.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org

On 07/14/2011 02:00 PM, Yinghai Lu wrote:
>>
>> diff --git a/include/linux/memblock.h b/include/linux/memblock.h
>> index aa5df9e..434b958 100644
>> --- a/include/linux/memblock.h
>> +++ b/include/linux/memblock.h
>> @@ -152,8 +152,8 @@ static inline unsigned long memblock_region_reserved_end_pfn(const struct memblo
>>
>>
>>  #ifdef ARCH_DISCARD_MEMBLOCK
>> -#define __init_memblock __init
>> -#define __initdata_memblock __initdata
>> +#define __init_memblock __meminit
>> +#define __initdata_memblock __meminitdata
>>  #else
>>  #define __init_memblock
>>  #define __initdata_memblock
> 
> that is not good. It will keep memblock.reserved related data and
> functions after boot.
> and those data/func are not used after slab is ready.
> 

From the look of it this ranges from about 7-19K, so I'm going to take
this and we can optimize this later.

	-hpa
