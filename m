From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [RFC PATCH -v3 1/2] lmb: seperate region array from lmb_region
 struct
Date: Tue, 23 Mar 2010 10:38:38 -0700
Message-ID: <4BA8FC9E.1050806@kernel.org>
References: <1269333587-1866-1-git-send-email-yinghai@kernel.org> <1269333587-1866-5-git-send-email-yinghai@kernel.org> <4BA899C2.8020208@kernel.org> <alpine.LFD.2.00.1003231528100.3147@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:51652 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753429Ab0CWRkQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Mar 2010 13:40:16 -0400
In-Reply-To: <alpine.LFD.2.00.1003231528100.3147@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On 03/23/2010 08:07 AM, Thomas Gleixner wrote:
> On Tue, 23 Mar 2010, Yinghai Lu wrote:
> 
>>
>> lmb_init() connect them back.
>>
>> also add region_array_size in lmb_region to tack the region array size.
>>
>> -v3: seperate lmb core change to seperated patch
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>
>> ---
>>  include/linux/lmb.h |    5 ++++-
>>  lib/lmb.c           |   11 ++++++++++-
>>  2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> Index: linux-2.6/include/linux/lmb.h
>> ===================================================================
>> --- linux-2.6.orig/include/linux/lmb.h
>> +++ linux-2.6/include/linux/lmb.h
>> @@ -26,7 +26,8 @@ struct lmb_property {
>>  struct lmb_region {
>>  	unsigned long cnt;
>>  	u64 size;
>> -	struct lmb_property region[MAX_LMB_REGIONS+1];
>> +	struct lmb_property *region;
>> +	unsigned long region_array_size;
>>  };
>>  
>>  struct lmb {
>> @@ -37,6 +38,8 @@ struct lmb {
>>  };
>>  
>>  extern struct lmb lmb;
>> +extern struct lmb_property lmb_memory_region[MAX_LMB_REGIONS + 1];
>> +extern struct lmb_property lmb_reserved_region[MAX_LMB_REGIONS + 1];
> 
> Is there a reason why this needs to be exported ?
> 
lmb_reserved_region is used in kernel/early_res.c::__check_and_double_early_res/subtract_early_res/early_res_to_bootmem

later if those functions are moved lmb.c, we can make lmb_reserved_region to be static

same thing to lmb_memory_region, that will be used by add_lmb_memory() later.

YH
