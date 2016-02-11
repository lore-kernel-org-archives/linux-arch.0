From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v3 1/8] iommu: Add MMIO mapping type
Date: Thu, 11 Feb 2016 15:57:26 +0000
Message-ID: <56BCAF66.8010206@arm.com>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1455065878-11906-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <13740597.5lZXKsEG19@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:55634 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750889AbcBKP5a (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 11 Feb 2016 10:57:30 -0500
In-Reply-To: <13740597.5lZXKsEG19@avalon>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>
Cc: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux-foundation.org, vinod.koul@intel.com, geert+renesas@glider.be, linus.walleij@linaro.org, dan.j.williams@intel.com, arnd@arndb.de, linux-arch@vger.kernel.org

On 11/02/16 00:02, Laurent Pinchart wrote:
> Hi Niklas,
>
> Thank you for the patch.
>
> On Wednesday 10 February 2016 01:57:51 Niklas S=F6derlund wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> On some platforms, MMIO regions might need slightly different treatm=
ent
>> compared to mapping regular memory; add the notion of MMIO mappings =
to
>> the IOMMU API's memory type flags, so that callers can let the IOMMU
>> drivers know to do the right thing.
>>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> Answering the question from the cover letter, yes, it's totally fine =
to pick
> the ack, that's actually expected.
>
>> ---
>>   drivers/iommu/io-pgtable-arm.c | 4 +++-
>>   include/linux/iommu.h          | 1 +
>
> You might be asked to split this patch in two.

Worse than that, you might also be asked to fix it up when the silly=20
author remembers that he did this on a stage-2-only ARM SMMU, and the=20
attributes for the stage 1 tables that the IPMMU uses are in a differen=
t=20
code path:

--->8---
diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
index 5b5c299..7622c6e 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -354,7 +354,10 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct=20
arm_lpae_io_pgtable *data,
                 if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
                         pte |=3D ARM_LPAE_PTE_AP_RDONLY;

-               if (prot & IOMMU_CACHE)
+               if (prot & IOMMU_MMIO)
+                       pte |=3D (ARM_LPAE_MAIR_ATTR_IDX_DEV
+                               << ARM_LPAE_PTE_ATTRINDX_SHIFT);
+               else if (prot & IOMMU_CACHE)
                         pte |=3D (ARM_LPAE_MAIR_ATTR_IDX_CACHE
                                 << ARM_LPAE_PTE_ATTRINDX_SHIFT);
         } else {
--->8---

Sorry for the bother,
Robin.

>>   2 files changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtab=
le-arm.c
>> index 381ca5a..3ff4f87 100644
>> --- a/drivers/iommu/io-pgtable-arm.c
>> +++ b/drivers/iommu/io-pgtable-arm.c
>> @@ -364,7 +364,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struc=
t
>> arm_lpae_io_pgtable *data, pte |=3D ARM_LPAE_PTE_HAP_READ;
>>   		if (prot & IOMMU_WRITE)
>>   			pte |=3D ARM_LPAE_PTE_HAP_WRITE;
>> -		if (prot & IOMMU_CACHE)
>> +		if (prot & IOMMU_MMIO)
>> +			pte |=3D ARM_LPAE_PTE_MEMATTR_DEV;
>> +		else if (prot & IOMMU_CACHE)
>>   			pte |=3D ARM_LPAE_PTE_MEMATTR_OIWB;
>>   		else
>>   			pte |=3D ARM_LPAE_PTE_MEMATTR_NC;
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index a5c539f..34b6432 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -30,6 +30,7 @@
>>   #define IOMMU_WRITE	(1 << 1)
>>   #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
>>   #define IOMMU_NOEXEC	(1 << 3)
>> +#define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
>>
>>   struct iommu_ops;
>>   struct iommu_group;
>
