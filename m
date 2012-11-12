From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [RFC PATCH v1 00/40] Meta Linux Kernel Port
Date: Mon, 12 Nov 2012 16:59:15 +0000
Message-ID: <50A12AE3.4090404@imgtec.com>
References: <1351700061-7203-1-git-send-email-james.hogan@imgtec.com> <201211091506.14940.arnd@arndb.de> <509D1F8C.4040501@imgtec.com> <201211091558.48022.arnd@arndb.de> <509D2D4F.20304@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56846 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263Ab2KLRAi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 12 Nov 2012 12:00:38 -0500
In-Reply-To: <509D2D4F.20304@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>

On 09/11/12 16:20, James Hogan wrote:
> On 09/11/12 15:58, Arnd Bergmann wrote:
>> On Friday 09 November 2012, James Hogan wrote:
>>> On 09/11/12 15:06, Arnd Bergmann wrote:
>>>> On Wednesday 31 October 2012, James Hogan wrote:
>>
>>>>> + * Despite being a 32bit architecture, Meta can do 64bit memory accesses
>>>>> + * (assuming the bus supports it).
>>>>> + */
>>>>> +
>>>>> +static inline u64 __raw_readq(const volatile void __iomem *addr)
>>>>> +{
>>>>> +	return *(const volatile u64 __force *) addr;
>>>>> +}
>>>>> +#define readq(addr) __raw_readq(addr)
>>>>> +
>>>>> +static inline void __raw_writeq(u64 b, volatile void __iomem *addr)
>>>>> +{
>>>>> +	*(volatile u64 __force *) addr = b;
>>>>> +}
>>>>> +#define writeq(b, addr) __raw_writeq(b, addr)
>>>>
>>>> These should be using an inline assembly to guarantee that it gets
>>>> turned into an atomic access, at least of the architecture has
>>>> an atomic 64-bit load/store from memory operation.
>>>
>>> Is there a particular case you have in mind where the compiler could be
>>> expected not to generate an atomic memory op (I presume you mean e.g. 2
>>> 32bit memory ops)? These are implemented the same as asm-generic/io.h
>>> which only omits these ones because metag is 32bit.
>>>
>>> tbh I don't think the 64 bit accesses are ever actually used, so we
>>> could probably drop these ones.
>>
>> There is nothing forcing a compiler to turn a dereferece of a volatile
>> pointer into a single load or store. We've had issues in the past
>> where a such an access got turned into a series of byte accesses
>> when an mmio data structure gets marked as '__packed', but it could
>> happen in other occasions as well.
> 
> Okay fair enough. We'll use inline asm here instead.

Using inline assembly actually causes us a few problems. There is no way
for inline assembly to allow the compiler to intelligently generate
[Reg+Reg] or [Reg+#imm] memory addressing like it can with volatile (and
even if it could, the constraints would be hard/impossible to express
due to the different encodings of GET and SET that have different
immediate lengths and restrictions on register units). This results in
extra code to do an ADD prior to the memory access, and will also
increase register pressure.

Note that Meta doesn't support unaligned accesses anyway so use of
__packed on MMIO is likely broken from the outset. I'd like to therefore
keep using the <asm-generic/io.h> implementations of the __raw_* functions.

Cheers
James
