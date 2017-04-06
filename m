Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:48846 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934298AbdDFJfr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2017 05:35:47 -0400
Subject: Re: [PATCH V10 03/12] of: dma: Move range size workaround to
 of_dma_get_range()
References: <1489086061-9356-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-1-git-send-email-sricharan@codeaurora.org>
 <1491301105-5274-4-git-send-email-sricharan@codeaurora.org>
 <58E5DF13.2020700@gmail.com>
From: Sricharan R <sricharan@codeaurora.org>
Message-ID: <4b56ef2a-3ede-6093-69d9-576b6e73ea44@codeaurora.org>
Date: Thu, 6 Apr 2017 15:05:31 +0530
MIME-Version: 1.0
In-Reply-To: <58E5DF13.2020700@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frank Rowand <frowand.list@gmail.com>, robin.murphy@arm.com, will.deacon@arm.com, joro@8bytes.org, lorenzo.pieralisi@arm.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, m.szyprowski@samsung.com, bhelgaas@google.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, tn@semihalf.com, hanjun.guo@linaro.org, okaya@codeaurora.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, catalin.marinas@arm.com, arnd@arndb.de, linux-arch@vger.kernel.org, gregkh@linuxfoundation.org
Message-ID: <20170406093531.nY2muPswnk6x5243TyN7wJREtlVsxYSFUL_wYwAPKUk@z>

Hi Frank,

On 4/6/2017 11:54 AM, Frank Rowand wrote:
> On 04/04/17 03:18, Sricharan R wrote:
>> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>>
>> Invalid dma-ranges values should be worked around when retrieving the
>> DMA range in of_dma_get_range(), not by all callers of the function.
>> This isn't much of a problem now that we have a single caller, but that
>> situation will change when moving DMA configuration to device probe
>> time.
>
> Please drop this patch from the series.  I just now sent Rob an
> alternative that reflects other changes that have occurred since
> this patch series was first created many, many moons ago
> (https://lkml.org/lkml/2017/4/6/53).

ok, would drop this.

Regards,
  Sricharan

-- 
"QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
