Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45426 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751293AbdEQFRr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 May 2017 01:17:47 -0400
Subject: Re: [PATCH] iommu: of: Fix check for returning EPROBE_DEFER
References: <1494912253-25957-1-git-send-email-sricharan@codeaurora.org>
 <20170516140943.ps2yufiukz6iurpl@latitude>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <f5f8de4a-73a1-a32f-2736-2a7e64bfaa1a@codeaurora.org>
Date: Wed, 17 May 2017 10:47:30 +0530
MIME-Version: 1.0
In-Reply-To: <20170516140943.ps2yufiukz6iurpl@latitude>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>
Cc: robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org, robh+dt@kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, gregkh@linuxfoundation.org
Message-ID: <20170517051730.hcw5NClntVwkwVOXi6gu7Ptnb1i6yPPwbtesO9qK3Ts@z>

Hi,

On 5/16/2017 7:39 PM, Jonathan Neuschäfer wrote:
> Hi, I have a few suggestions on how to make this commit message more
> readable:
> 
> On Tue, May 16, 2017 at 10:54:13AM +0530, Sricharan R wrote:
>> While returning EPROBE_DEFER for iommu masters
> 
> Add a comma at the end of this line
> 
>> take in to account of iommu nodes that could be
> 
> s/in to/into/
> s/of iommu/of_iommu/
> 

ok, will correct the above.

Regards,
 Sricharan

>> marked in DT as 'status=disabled', in which case
>> simply return NULL and let the master's probe
>> continue rather than deferring.
>>
>> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
>> Tested-by: Will Deacon <will.deacon@arm.com>
>> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> 
> Thanks,
> Jonathan Neuschäfer
> 

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
