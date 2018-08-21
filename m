Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp17.cstnet.cn ([159.226.251.17]:58407 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbeHUOYb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 21 Aug 2018 10:24:31 -0400
From: Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v4 15/16] driver/edac: enable Hygon support to AMD64 EDAC
 driver
References: <cover.1534599097.git.puwen@hygon.cn>
 <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
 <20180821081331.GC24940@nazgul.tnic>
Message-ID: <ccbc6572-c16f-7a9b-ab27-54fffac1ba0d@hygon.cn>
Date: Tue, 21 Aug 2018 19:04:23 +0800
MIME-Version: 1.0
In-Reply-To: <20180821081331.GC24940@nazgul.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com, pbonzini@redhat.com, mchehab@kernel.org, mikhail.jin@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-edac@vger.kernel.org
Message-ID: <20180821110423.xdInCBP7rgMFqMw4O7yNveXQdo0_PKptbmlYWXNWLQA@z>

On 2018-08-21 16:13, Borislav Petkov wrote:
>On Mon, Aug 20, 2018 at 12:14:58AM +0800, Pu Wen wrote:
...
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 18aeabb..3cefb25 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -211,7 +211,8 @@ static int __set_scrub_rate(struct amd64_pvt 
*pvt, u32 new_bw, u32 min_rate)
>>
>>  scrubval = scrubrates[i].scrubval;
>>
>> -	if (pvt->fam == 0x17) {
>> +	if (pvt->fam == 0x17 ||
>> +	   (pvt->vendor == X86_VENDOR_HYGON && pvt->fam == 0x18)) {
>
>Didn't we say that AMD won't do family 0x18 so you don't need the 
vendor check?

Hi Boris:

Based on the feedback from Paolo Bonzini:
"if the x86 maintainers prefer to have a new X86_VENDOR_*
constant, I'd just ignore the fact that AMD will skip family 18h, and
introduce vendor checks along the lines below. This has the advantage
that it's not an issue if AMD ends up _not_ skipping family 18h."
http://lkml.iu.edu/hypermail/linux/kernel/1807.3/06042.html

and the suggestions from Michael Jin:
"The condition case for family 18h and vendor Hygon looks better
because it is more clear."
http://lkml.iu.edu/hypermail/linux/kernel/1808.1/03232.html

we reworked the patch.

Sure, JV will negotiate with AMD and make sure only JV use family 18h and
AMD won't use family 0x18h, which will make the patch tight and clear.

What's the best way to adapt for EDAC driver?
* To simplify the code based on AMD won't do family 0x18 and remove
   vendor checking.
* Or add vendor checking in codes?

Thanks,
Pu Wen
