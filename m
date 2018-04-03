Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58198 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755415AbeDCLzm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 3 Apr 2018 07:55:42 -0400
Subject: Re: [PATCH v8 0/4] Fix issues with huge mapping in ioremap for ARM64
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
 <a613f834-f356-a826-526f-aef532f62951@arm.com>
From: Chintan Pandya <cpandya@codeaurora.org>
Message-ID: <0229cecc-18fc-c3ef-a5cb-be3f9829cad4@codeaurora.org>
Date: Tue, 3 Apr 2018 17:25:29 +0530
MIME-Version: 1.0
In-Reply-To: <a613f834-f356-a826-526f-aef532f62951@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>, catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com
Cc: arnd@arndb.de, ard.biesheuvel@linaro.org, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Message-ID: <20180403115529.oDO3UvZaWXK2EDW-YEMwubpkW5MqYH2p4Lan8MaJwjw@z>



On 4/3/2018 2:13 PM, Marc Zyngier wrote:
> Hi Chintan,
Hi Marc,
> 
> On 03/04/18 09:00, Chintan Pandya wrote:
>> This series of patches are follow up work (and depends on)
>> Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
>> panic in ioremap huge pages".
>>
>> This series of patches are tested on 4.9 kernel with Cortex-A75
>> based SoC.
> 
> Given that this is targeting mainline, can you please test with 4.16?
> Basing your patches on something that is over 15 months old is not
> exactly reassuring.

We have 4.14 ported with the devices (remotely) accessible to me. If
that's sufficient, I will post test report by tomorrow.

If we really require these patches to be tested with 4.16, I would need
some help here.

Thanks,

> 
> Thanks,
> 
> 	M.
> 

Chintan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation
Collaborative Project
