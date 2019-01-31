From: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH v9 01/26] arm64: Fix HCR.TGE status for NMI contexts
Date: Thu, 31 Jan 2019 08:56:04 +0000
Message-ID: <32af4a5c-7aeb-0171-1b4a-2cbee5f78bca@arm.com>
References: <1548084825-8803-1-git-send-email-julien.thierry@arm.com>
 <1548084825-8803-2-git-send-email-julien.thierry@arm.com>
 <8e8c4f5b-5b83-7bbc-1b84-36d68e210968@arm.com>
 <847c54ef-ea41-eea5-8aff-72e0cea465f8@arm.com>
 <20190131081900.GM13482@e113682-lin.lund.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190131081900.GM13482@e113682-lin.lund.arm.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Christoffer Dall <christoffer.dall@arm.com>
Cc: James Morse <james.morse@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, daniel.thompson@linaro.org, joel@joelfernandes.org, marc.zyngier@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, mark.rutland@arm.com, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org



On 31/01/2019 08:19, Christoffer Dall wrote:
> On Mon, Jan 28, 2019 at 03:42:42PM +0000, Julien Thierry wrote:
>> Hi James,
>>
>> On 28/01/2019 11:48, James Morse wrote:
>>> Hi Julien,
>>>
>>> On 21/01/2019 15:33, Julien Thierry wrote:
>>>> When using VHE, the host needs to clear HCR_EL2.TGE bit in order
>>>> to interract with guest TLBs, switching from EL2&0 translation regime
>>>
>>> (interact)
>>>
>>>
>>>> to EL1&0.
>>>>
>>>> However, some non-maskable asynchronous event could happen while TGE is
>>>> cleared like SDEI. Because of this address translation operations
>>>> relying on EL2&0 translation regime could fail (tlb invalidation,
>>>> userspace access, ...).
>>>>
>>>> Fix this by properly setting HCR_EL2.TGE when entering NMI context and
>>>> clear it if necessary when returning to the interrupted context.
>>>
>>> Yes please. This would not have been fun to debug!
>>>
>>> Reviewed-by: James Morse <james.morse@arm.com>
>>>
>>>
>>
>> Thanks.
>>
>>>
>>> I was looking for why we need core code to do this, instead of updating the
>>> arch's call sites. Your 'irqdesc: Add domain handlers for NMIs' patch (pointed
>>> to from the cover letter) is the reason: core-code calls nmi_enter()/nmi_exit()
>>> itself.
>>>
>>
>> Yes, that's the main reason.
>>
> I wondered the same thing, but I don't understand the explanation :(
> 
> Why can't we do a local_daif_mask() around the (very small) calls that
> clear TGE instead?
> 

That would protect against the pseudo-NMIs, but you can still get an
SDEI at that point even with all daif bits set. Or did I misunderstand
how SDEI works?

Thanks,

-- 
Julien Thierry
