Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:36550 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbfANQMn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 14 Jan 2019 11:12:43 -0500
Subject: Re: [PATCH v8 01/26] arm64: Fix HCR.TGE status for NMI contexts
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-2-git-send-email-julien.thierry@arm.com>
 <20190114155634.GB84430@arrakis.emea.arm.com>
From: Julien Thierry <julien.thierry@arm.com>
Message-ID: <229aade3-5bb3-aad4-bd9a-d6220db836c0@arm.com>
Date: Mon, 14 Jan 2019 16:12:39 +0000
MIME-Version: 1.0
In-Reply-To: <20190114155634.GB84430@arrakis.emea.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, daniel.thompson@linaro.org, Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, christoffer.dall@arm.com, james.morse@arm.com, joel@joelfernandes.org
Message-ID: <20190114161239.LklHxEXXVRGU8PwuT7k0OLPX8eCvAKFdXuOFOldw1zk@z>



On 14/01/2019 15:56, Catalin Marinas wrote:
> On Tue, Jan 08, 2019 at 02:07:19PM +0000, Julien Thierry wrote:
>> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
>> to interract with guest TLBs, switching from EL2&0 translation regime
>> to EL1&0.
>>
>> However, some non-maskable asynchronous event could happen while TGE is
>> cleared like SDEI. Because of this address translation operations
>> relying on EL2&0 translation regime could fail (tlb invalidation,
>> userspace access, ...).
> 
> Why would an NMI context need to access user space? (just curious what
> breaks exactly without this patch; otherwise it looks fine)

If I remember correctly, the SDEI interrupt might perform cache
maintenance with EL2&0 translation regime, but James can probably give
more detail (or correct me if I'm wrong).

Otherwise, if we decide to use the pseudo NMI for profiling with perf, I
believe the perf interrupt can access user space (although I'm not
completely sure whether that might be to record profiling data in
buffers shared with user space or something else).

Thanks,

-- 
Julien Thierry
