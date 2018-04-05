From: Chintan Pandya <cpandya@codeaurora.org>
Subject: Re: [PATCH v8 0/4] Fix issues with huge mapping in ioremap for ARM64
Date: Thu, 5 Apr 2018 14:39:15 +0530
Message-ID: <fcc152ba-c88e-6330-7608-4bec398d33d8@codeaurora.org>
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
 <a613f834-f356-a826-526f-aef532f62951@arm.com>
 <0229cecc-18fc-c3ef-a5cb-be3f9829cad4@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0229cecc-18fc-c3ef-a5cb-be3f9829cad4@codeaurora.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com
Cc: linux-arch@vger.kernel.org, arnd@arndb.de, ard.biesheuvel@linaro.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, james.morse@arm.com, tglx@linutronix.de, akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org



On 4/3/2018 5:25 PM, Chintan Pandya wrote:
> 
> 
> On 4/3/2018 2:13 PM, Marc Zyngier wrote:
>> Hi Chintan,
> Hi Marc,
>>
>> On 03/04/18 09:00, Chintan Pandya wrote:
>>> This series of patches are follow up work (and depends on)
>>> Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
>>> panic in ioremap huge pages".
>>>
>>> This series of patches are tested on 4.9 kernel with Cortex-A75
>>> based SoC.
>>
>> Given that this is targeting mainline, can you please test with 4.16?
>> Basing your patches on something that is over 15 months old is not
>> exactly reassuring.
> 
> We have 4.14 ported with the devices (remotely) accessible to me. If
> that's sufficient, I will post test report by tomorrow.
> 
> If we really require these patches to be tested with 4.16, I would need
> some help here.
> 
Rajendra Nayak <rnayak@codeaurora.org> helped me with testing these
patches on 4.16 kernel (with all the dependent patches already part of
4.16) on SDM845.

In addition to kernel boot up, he executed my test-code which was
stressing ioremap framework and was able to reproduce the bug without
these patches (and Will Deacon's WA).

That passed 10hrs of run.

[36001.446355] IOREMAP_TEST: my tests ended now

Thanks Rajendra Nayak  for testing these patches.

> Thanks,
> 
>>
>> Thanks,
>>
>>     M.
>>
> 
> Chintan

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
