From: Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v1 0/4] Fix issues with huge mapping in ioremap
Date: Thu, 15 Mar 2018 12:47:25 +0530
Message-ID: <9954bd28-0457-b80e-8af7-6259b63533f2@codeaurora.org>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
 <1521038277.2693.131.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521038277.2693.131.camel@hpe.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshi" <toshi.kani@hpe.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will.deacon@arm.com" <will.deacon@arm.com>, "arnd@arndb.de" <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>, "james.morse@arm.com" <james.morse@arm.com>, "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org



On 3/14/2018 8:08 PM, Kani, Toshi wrote:
> On Wed, 2018-03-14 at 14:18 +0530, Chintan Pandya wrote:
>> Note: I was working on these patches for quite sometime
>> and realized that Toshi Kani has shared some patches
>> addressing the same isssue with subject
>> "[PATCH 0/2] fix memory leak / panic in ioremap huge pages".
>> I've taken slightly different approach here, so sending
>> to the list, finally.
> 
> Hi Chintan,
Hi Toshi
> 
> Do you have any issue in my patchset?  If so, can you please comment on
Not functional issues. But I didn't see issues you mentioned in your
commit text being solved for ARM64 in your patches. It is just being
masked which they were already by Will's patch. In my approach, end
goal was to get benefits of huge mapping back for ARM64.

> them?  It complicates the thing when you send a different approach
> without telling why a different approach is needed.  Your approach
See my reply above. I just had my original patches and I sent it.

> purges TLB after updating pmd/pud, which I think is broken.  Can you
Yes, they are broken. I understood the issues after Mark and Marc's
review comments.

> work on top of my patchset and properly implement pXd_free_pte_page()
I have realized that if I address Mark's comments, my new patch will
look similar to what you have done. So, I will work on top of your
patches.

> for arm64?  I will send out my v2 today.
>    
> Thanks,
> -Toshi
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
