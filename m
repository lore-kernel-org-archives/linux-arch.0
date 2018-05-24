From: Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v9 3/4] arm64: Implement page table free interfaces
Date: Thu, 24 May 2018 12:33:13 +0530
Message-ID: <5a0481d4-4ac0-e65a-e00e-4ac63c4306c9@codeaurora.org>
References: <1525074094-25839-1-git-send-email-cpandya@codeaurora.org>
 <1525074094-25839-4-git-send-email-cpandya@codeaurora.org>
 <20180523140157.GG26965@arm.com> <1527085967.14039.10.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527085967.14039.10.camel@hpe.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshi" <toshi.kani@hpe.com>, "will.deacon@arm.com" <will.deacon@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>, "vkuznets@redhat.com" <vkuznets@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "james.morse@arm.com" <james.morse@arm.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>, "kristina.martsenko@arm.com" <kristina.martsenko@arm.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "marc.zyngier@arm.com" <marc.zyngier@arm.com>
List-Id: linux-arch.vger.kernel.org



On 5/23/2018 8:04 PM, Kani, Toshi wrote:
> On Wed, 2018-05-23 at 15:01 +0100, Will Deacon wrote:
>> Hi Chintan,
>>
>> [as a side note: I'm confused on the status of this patch series, as part
>>   of it was reposted separately by Toshi. Please can you work together?]
> 
> I do not know the status of my patch series, either... That being said,
> I made my x86 patches based off from Chintan's 1/4 patch (which changes
> both x86 and arm) so that my series won't conflict with his.
> 
> Chintan,
Hi Toshi,

> If you need to update your series before mine's accepted, please make
> sure to use the updated 1/4 below. I've updated the descriptions per
> review comment.
> https://patchwork.kernel.org/patch/10407065/
For the sake of completeness, I will re-push my previous 1/4 but will
take your version of change log. I've seen this and your change log
describes the change better.

> 
> Thanks,
> -Toshi
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
