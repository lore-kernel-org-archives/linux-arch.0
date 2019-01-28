From: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v9 01/26] arm64: Fix HCR.TGE status for NMI contexts
Date: Mon, 28 Jan 2019 15:42:42 +0000
Message-ID: <847c54ef-ea41-eea5-8aff-72e0cea465f8@arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-2-git-send-email-julien.thierry@arm.com>
 <8e8c4f5b-5b83-7bbc-1b84-36d68e210968@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <8e8c4f5b-5b83-7bbc-1b84-36d68e210968@arm.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, daniel.thompson@linaro.org, joel@joelfernandes.org, marc.zyngier@arm.com, christoffer.dall@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Hi James,

On 28/01/2019 11:48, James Morse wrote:
> Hi Julien,
> 
> On 21/01/2019 15:33, Julien Thierry wrote:
>> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
>> to interract with guest TLBs, switching from EL2&0 translation regime
> 
> (interact)
> 
> 
>> to EL1&0.
>>
>> However, some non-maskable asynchronous event could happen while TGE is
>> cleared like SDEI. Because of this address translation operations
>> relying on EL2&0 translation regime could fail (tlb invalidation,
>> userspace access, ...).
>>
>> Fix this by properly setting HCR_EL2.TGE when entering NMI context and
>> clear it if necessary when returning to the interrupted context.
> 
> Yes please. This would not have been fun to debug!
> 
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> 

Thanks.

> 
> I was looking for why we need core code to do this, instead of updating the
> arch's call sites. Your 'irqdesc: Add domain handlers for NMIs' patch (pointed
> to from the cover letter) is the reason: core-code calls nmi_enter()/nmi_exit()
> itself.
> 

Yes, that's the main reason.

> 
>> diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
>> index 1473fc2..94b7481 100644
>> --- a/arch/arm64/include/asm/hardirq.h
>> +++ b/arch/arm64/include/asm/hardirq.h
>> @@ -19,6 +19,7 @@
>>  #include <linux/cache.h>
>>  #include <linux/threads.h>
>>  #include <asm/irq.h>
>> +#include <asm/kvm_arm.h>
> 
> percpu.h?
> sysreg.h?
> barrier.h?
> 

Good point, I'll add those.

Thanks,

-- 
Julien Thierry
