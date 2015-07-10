From: Chris Metcalf <cmetcalf@ezchip.com>
Subject: Re: [RFC][PATCH 23/24] atomic: Collapse all atomic_{set,clear}_mask
 definitions
Date: Fri, 10 Jul 2015 09:34:04 -0400
Message-ID: <559FC9CC.6000400@ezchip.com>
References: <20150709172855.564686637@infradead.org>
 <20150709175310.229218215@infradead.org>
 <CAMuHMdXePQF9BL7OfTz+=FN5Hg9C=E6hAO8MFQ9Eu_tiK_Q8OA@mail.gmail.com>
 <20150710103945.GH19282@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-db3on0069.outbound.protection.outlook.com ([157.55.234.69]:59869
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932355AbbGJNeD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Jul 2015 09:34:03 -0400
In-Reply-To: <20150710103945.GH19282@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, =?UTF-8?Q?H=c3=a5vard_Skinnemoen?= <hskinnemoen@gmail.com>, Miao Steven <realmz6@gmail.com>, David Howells <dhowells@redhat.com>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, James Hogan <james.hogan@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, "James E.J. Bottomley" <jejb@parisc-linux.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@kernel.org>

On 7/10/2015 6:39 AM, Peter Zijlstra wrote:
> On Fri, Jul 10, 2015 at 11:10:33AM +0200, Geert Uytterhoeven wrote:
>> Hi Peter,
>>
>> On Thu, Jul 9, 2015 at 7:29 PM, Peter Zijlstra <peterz@infradead.org> wrote:
>>> --- a/include/linux/atomic.h
>>> +++ b/include/linux/atomic.h
>>> @@ -28,6 +28,23 @@ static inline int atomic_add_unless(atom
>>>   #define atomic_inc_not_zero(v)         atomic_add_unless((v), 1, 0)
>>>   #endif
>>>
>>> +#ifndef atomic_nand
>>> +static inline void atomic_nand(int i, atomic_t *v)
>>> +{
>>> +       atomic_and(~i, v);
>> That sounds like a misnomer...
>>
>> Your NAND is "A & ~B", while my[*] NAND is "~(A & B)"?
>>
>> [*] https://en.wikipedia.org/wiki/NAND_logic
> Right you are.
>
>> What about atomic_clear()? (Is atomic_bic() too ARM-centric?)
> atomic_and_not() ?

I've seen this as ANDN (as opposed to NAND).  That's the name I used in
the tilepro atomics as the thing that implements the bitmask clear operation.
SPARC also has an "andn" instruction with this semantics.

-- 
Chris Metcalf, EZChip Semiconductor
http://www.ezchip.com
