From: James Morse <james.morse@arm.com>
Subject: Re: [PATCH v8 01/26] arm64: Fix HCR.TGE status for NMI contexts
Date: Mon, 14 Jan 2019 17:25:00 +0000
Message-ID: <41c6dc69-3bdc-2ea1-4862-5f4df9b843dd@arm.com>
References: <1546956464-48825-1-git-send-email-julien.thierry@arm.com>
 <1546956464-48825-2-git-send-email-julien.thierry@arm.com>
 <20190114155634.GB84430@arrakis.emea.arm.com>
 <229aade3-5bb3-aad4-bd9a-d6220db836c0@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <229aade3-5bb3-aad4-bd9a-d6220db836c0@arm.com>
Content-Language: en-GB
Sender: stable-owner@vger.kernel.org
To: Julien Thierry <julien.thierry@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, linux-arch@vger.kernel.org, daniel.thompson@linaro.org, Arnd Bergmann <arnd@arndb.de>, marc.zyngier@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, christoffer.dall@arm.com, joel@joelfernandes.org
List-Id: linux-arch.vger.kernel.org

Hi guys,

On 14/01/2019 16:12, Julien Thierry wrote:
> On 14/01/2019 15:56, Catalin Marinas wrote:
>> On Tue, Jan 08, 2019 at 02:07:19PM +0000, Julien Thierry wrote:
>>> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
>>> to interract with guest TLBs, switching from EL2&0 translation regime
>>> to EL1&0.
>>>
>>> However, some non-maskable asynchronous event could happen while TGE is
>>> cleared like SDEI. Because of this address translation operations
>>> relying on EL2&0 translation regime could fail (tlb invalidation,
>>> userspace access, ...).
>>
>> Why would an NMI context need to access user space? (just curious what
>> breaks exactly without this patch; otherwise it looks fine)
> 
> If I remember correctly, the SDEI interrupt might perform cache
> maintenance with EL2&0 translation regime, but James can probably give
> more detail (or correct me if I'm wrong).

Yup, spot on.
The APEI driver has to map/unmap memory using the fixmap. If it interrupts a
guest, the TLB maintenance would affect EL1&0 instead.


> Otherwise, if we decide to use the pseudo NMI for profiling with perf, I
> believe the perf interrupt can access user space (although I'm not
> completely sure whether that might be to record profiling data in
> buffers shared with user space or something else).

It does a stack walk, I think its the PERF_SAMPLE_CALLCHAIN feature, and the
code is:
arch/arm64/kernel/perf_callchain.c::user_backtrace()


Thanks,

James
