From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
Date: Thu, 5 Mar 2020 06:43:23 +0100
Message-ID: <bcba7b7f-f351-4ee7-d74e-004a0bfbee47@c-s.fr>
References: <c022e863-0807-fab1-cd41-3c320381f448@c-s.fr>
 <11F41980-97CF-411F-8120-41287DC1A382@lca.pw>
 <57a3bc61-bbd5-e251-9621-7bc28f7901a1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:10515 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbgCEFnf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 5 Mar 2020 00:43:35 -0500
In-Reply-To: <57a3bc61-bbd5-e251-9621-7bc28f7901a1@arm.com>
Content-Language: fr
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, Qian Cai <cai@lca.pw>
Cc: Linux Memory Management List <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>



Le 05/03/2020 à 01:54, Anshuman Khandual a écrit :
> 
> 
> On 03/04/2020 04:59 PM, Qian Cai wrote:
>>
>>
>>> On Mar 4, 2020, at 1:49 AM, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>>
>>> AFAIU, you are not taking an interrupt here. You are stuck in the pte_update(), most likely due to nested locks. Try with LOCKDEP ?
>>
>> Not exactly sure what did you mean here, but the kernel has all lockdep enabled and did not flag anything here.
> 
> As the patch has been dropped from Linux next (next-20200304) perhaps in
> order to fold back the __pa_symbol() fix [1], so I am planning to respin
> the original patch once more as V15 while adding Qian's signed off by for
> the powerpc part. For now lets enable radix MMU ppc64 along with existing
> ppc32. As PPC_RADIX_MMU depends on PPC_BOOK3S_64, the following change
> should be good enough ?

I don't think so, even if you have the Radix MMU compiled in, hash MMU 
is used when Radix is not available or disabled. So until the Hash MMU 
problem is fixed, you cannot enable it by default.

Christophe
