From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 07/13] powerpc: add support for folded p4d page tables
Date: Wed, 26 Feb 2020 12:20:49 +0100
Message-ID: <7a008227-433c-73d7-b01a-1c6c7c66f04e@c-s.fr>
References: <20200216081843.28670-1-rppt@kernel.org>
 <20200216081843.28670-8-rppt@kernel.org>
 <c79b363c-a111-389a-5752-51cf85fa8c44@c-s.fr> <20200218105440.GA1698@hump>
 <20200226091315.GA11803@hump> <f881f732-729b-a098-f520-b30e44dc10c8@c-s.fr>
 <20200226105615.GB11803@hump>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <20200226105615.GB11803@hump>
Content-Language: fr
Sender: linux-ia64-owner@vger.kernel.org
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Guan Xuetao <gxt@pku.edu.cn>, James Morse <james.morse@arm.com>, Jonas Bonn <jonas@southpole.se>, Julien Thierry <julien.thierry.kdev@gmail.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <stefan.kristian>
List-Id: linux-arch.vger.kernel.org



Le 26/02/2020 à 11:56, Mike Rapoport a écrit :
> On Wed, Feb 26, 2020 at 10:46:13AM +0100, Christophe Leroy wrote:
>>
>>
>> Le 26/02/2020 à 10:13, Mike Rapoport a écrit :
>>> On Tue, Feb 18, 2020 at 12:54:40PM +0200, Mike Rapoport wrote:
>>>> On Sun, Feb 16, 2020 at 11:41:07AM +0100, Christophe Leroy wrote:
>>>>>
>>>>>
>>>>> Le 16/02/2020 à 09:18, Mike Rapoport a écrit :
>>>>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>>>>
>>>>>> Implement primitives necessary for the 4th level folding, add walks of p4d
>>>>>> level where appropriate and replace 5level-fixup.h with pgtable-nop4d.h.
>>>>>
>>>>> I don't think it is worth adding all this additionnals walks of p4d, this
>>>>> patch could be limited to changes like:
>>>>>
>>>>> -		pud = pud_offset(pgd, gpa);
>>>>> +		pud = pud_offset(p4d_offset(pgd, gpa), gpa);
>>>>>
>>>>> The additionnal walks should be added through another patch the day powerpc
>>>>> need them.
>>>>
>>>> Ok, I'll update the patch to reduce walking the p4d.
>>>
>>> Here's what I have with more direct acceses from pgd to pud.
>>
>> I went quickly through. This looks promising.
>>
>> Do we need the walk_p4d() in arch/powerpc/mm/ptdump/hashpagetable.c ?
>> Can't we just do
>>
>> @@ -445,7 +459,7 @@ static void walk_pagetables(struct pg_state *st)
>>   		addr = KERN_VIRT_START + i * PGDIR_SIZE;
>>   		if (!pgd_none(*pgd))
>>   			/* pgd exists */
>> -			walk_pud(st, pgd, addr);
>> +			walk_pud(st, p4d_offset(pgd, addr), addr);
> 
> We can do
> 
> 	addr = KERN_VIRT_START + i * PGDIR_SIZE;
> 	p4d = p4d_offset(pgd, addr);
> 	if (!p4d_none(*pgd))
> 		walk_pud()
> 
> But I don't think this is really essential. Again, we are trading off code
> consistency vs line count. I don't think line count is that important.

Ok.

Christophe
