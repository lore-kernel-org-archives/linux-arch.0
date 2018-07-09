Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.60.111]:57904 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754516AbeGIS1m (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 14:27:42 -0400
Subject: Re: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
References: <20180709044444.6397-1-abrodkin@synopsys.com>
 <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
 <c95ac7435736d93843c45628ba4d41a4a4988074.camel@synopsys.com>
 <91c57eeba2134dd99a9f0e11fa883c7c@AcuMS.aculab.com>
 <82d2b36fa913bca6d56c7bf32a653324970817b8.camel@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <e98bd4ab-ea20-0b42-bda9-eae8a6030c8f@synopsys.com>
Date: Mon, 9 Jul 2018 11:27:31 -0700
MIME-Version: 1.0
In-Reply-To: <82d2b36fa913bca6d56c7bf32a653324970817b8.camel@synopsys.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>, "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "greg@kroah.com" <greg@kroah.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>
Message-ID: <20180709182731.-SqIukdb6Hiucjgme_hQKQdKGtvYMQxaQEPF6wf1N2I@z>

On 07/09/2018 03:23 AM, Alexey Brodkin wrote:
> Hi David,
> 
> On Mon, 2018-07-09 at 10:18 +0000, David Laight wrote:
>> From: Alexey Brodkin
>>> Sent: 09 July 2018 11:00
>>
>> ...
>>> That's a good idea indeed but it doesn't solve the problem with
>>> struct devres_node. Consider the following snippet:
>>> -------------------------------->8-------------------------------
>>> 	struct mystruct {
>>> 		atomic64_t myvar;
>>> 	}
>>>
>>> 	struct mystruct *p;
>>> 	p = devm_kzalloc(dev, sizeof(*p), GFP_KERNEL);
>>> -------------------------------->8-------------------------------
>>>
>>> Here myvar address will match address of "data" member of struct devres_node.
>>> So if "data" is has offset of 12 bytes from the beginning of a page then
>>> myvar won't be 64-bit aligned regardless of myvar's attribute, right?
>>
>> ...
>>>>> -	unsigned long long		data[];	/* guarantee ull alignment */
>>
>> Ahh, that line should be:
>> 	u8 data[] __aligned(8); /* Guarantee 64bit alignment */
> 
> And that pretty much what I suggested in my initial patch :)
> 
> For the record x86 has exactly the same atomic64_t as you suggested,
> see https://elixir.bootlin.com/linux/latest/source/arch/x86/include/asm/atomic64_32.h#L13:
> ---------------------->8------------------
> typedef struct {
> 	u64 __aligned(8) counter;
> } atomic64_t;
> ---------------------->8------------------

And so does the ARC version since when the atomic64_t support was added by commit
ce6365270ecd

Also, you should consider using the pre-canned type aligned_u64.

typedef struct {
       aligned_u64 counter;
       ^^^^^^^^^^^
} atomic64_t;
