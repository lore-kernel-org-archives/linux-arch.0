From: Ard Biesheuvel <ard.biesheuvel@arm.com>
Subject: Re: [PATCH] module/ksymtab: use 64-bit relative reference for target
 symbol
Date: Thu, 23 May 2019 10:29:39 +0100
Message-ID: <907a9681-cd1d-3326-e3dd-5f6965497720@arm.com>
References: <20190522150239.19314-1-ard.biesheuvel@arm.com>
 <293c9d0f-dc14-1413-e4b4-4299f0acfb9e@arm.com>
 <f2141ee5-d07a-6dd9-47c6-97e8fbdccf34@arm.com>
 <20190523091811.GA26646@fuggles.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190523091811.GA26646@fuggles.cambridge.arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com, james.morse@arm.com, guillaume.gardet@arm.com, mark.rutland@arm.com, mingo@kernel.org, jeyu@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, arnd@arndb.de, x86@kernel.org
List-Id: linux-arch.vger.kernel.org



On 5/23/19 10:18 AM, Will Deacon wrote:
> On Thu, May 23, 2019 at 09:41:40AM +0100, Ard Biesheuvel wrote:
>>
>>
>> On 5/22/19 5:28 PM, Ard Biesheuvel wrote:
>>>
>>>
>>> On 5/22/19 4:02 PM, Ard Biesheuvel wrote:
>>>> The following commit
>>>>
>>>>     7290d5809571 ("module: use relative references for __ksymtab entries")
>>>>
>>>> updated the ksymtab handling of some KASLR capable architectures
>>>> so that ksymtab entries are emitted as pairs of 32-bit relative
>>>> references. This reduces the size of the entries, but more
>>>> importantly, it gets rid of statically assigned absolute
>>>> addresses, which require fixing up at boot time if the kernel
>>>> is self relocating (which takes a 24 byte RELA entry for each
>>>> member of the ksymtab struct).
>>>>
>>>> Since ksymtab entries are always part of the same module as the
>>>> symbol they export (or of the core kernel), it was assumed at the
>>>> time that a 32-bit relative reference is always sufficient to
>>>> capture the offset between a ksymtab entry and its target symbol.
>>>>
>>>> Unfortunately, this is not always true: in the case of per-CPU
>>>> variables, a per-CPU variable's base address (which usually differs
>>>> from the actual address of any of its per-CPU copies) could be at
>>>> an arbitrary offset from the ksymtab entry, and so it may be out
>>>> of range for a 32-bit relative reference.
>>>>
>>
>> (Apologies for the 3-act monologue)
> 
> Exposition, development and recapitulation ;)
> 
>> This turns out to be incorrect. The symbol address of per-CPU variables
>> exported by modules is always in the vicinity of __per_cpu_start, and so it
>> is simply a matter of making sure that the core kernel is in range for
>> module ksymtab entries containing 32-bit relative references.
>>
>> When running the arm64 with kaslr enabled, we currently randomize the module
>> space based on the range of ADRP/ADD instruction pairs, which have a -/+ 4
>> GB range rather than the -/+ 2 GB range of 32-bit place relative data
>> relocations. So we can fix this by simply reducing the randomization window
>> to 2 GB.
> 
> Makes sense. Do you see the need for an option to disable PREL relocs
> altogether in case somebody wants the additional randomization range?
> 

No, not really. To be honest, I don't think 
CONFIG_RANDOMIZE_MODULE_REGION_FULL is that useful to begin with, and 
the only reason we enabled it by default at the time was to ensure that 
the PLT code got some coverage after we introduced it.
