From: Yinghai <yinghai.lu@oracle.com>
Subject: Re: [PATCH 06/33] lmb: Add lmb_reserve_area/lmb_free_area
Date: Wed, 07 Apr 2010 16:36:58 -0700
Message-ID: <4BBD171A.3020108@oracle.com>
References: <1270001838-15857-1-git-send-email-yinghai@kernel.org>	 <1270001838-15857-7-git-send-email-yinghai@kernel.org> <1270683308.9521.7.camel@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet11.oracle.com ([148.87.113.123]:47958 "EHLO
	rcsinet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208Ab0DGXkn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2010 19:40:43 -0400
In-Reply-To: <1270683308.9521.7.camel@concordia>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: michael@ellerman.id.au
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 04/07/2010 04:35 PM, Michael Ellerman wrote:
> On Tue, 2010-03-30 at 19:16 -0700, Yinghai Lu wrote:
>> They will check if the region array is big enough.
>>
>> __check_and_double_region_array will try to double the region array if that
>> array spare slots is not big enough.  Old array will be copied to new array.
>>
> 
>> diff --git a/include/linux/lmb.h b/include/linux/lmb.h
>> index 4cf2f3b..598662f 100644
>> --- a/include/linux/lmb.h
>> +++ b/include/linux/lmb.h
>> @@ -83,6 +84,9 @@ lmb_end_pfn(struct lmb_region *type, unsigned long region_nr)
>>  	       lmb_size_pages(type, region_nr);
>>  }
>>  
>> +void lmb_reserve_area(u64 start, u64 end, char *name);
>> +void lmb_free_area(u64 start, u64 end);
>> +void lmb_add_memory(u64 start, u64 end);
> 
> vs
> 
> extern long lmb_reserve(u64 base, u64 size);
> extern long lmb_free(u64 base, u64 size);   
> extern long lmb_add(u64 base, u64 size);                                    
>                          
> 
> Can you tell which ones handle dynamically expanding the region array?
> 
> You're _still_ adding a new API, which I still think is stupid.

please consider to merge them later.

Don't want to break current lmb users

YH
