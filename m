Return-Path: <linux-riscv-bounces+rppt=linux.ibm.com@lists.infradead.org>
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
References: <c022e863-0807-fab1-cd41-3c320381f448@c-s.fr>
 <11F41980-97CF-411F-8120-41287DC1A382@lca.pw>
 <57a3bc61-bbd5-e251-9621-7bc28f7901a1@arm.com>
 <bcba7b7f-f351-4ee7-d74e-004a0bfbee47@c-s.fr>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d198fc5a-5337-c346-a21c-1ff133202e68@arm.com>
Date: Thu, 5 Mar 2020 11:53:12 +0530
MIME-Version: 1.0
In-Reply-To: <bcba7b7f-f351-4ee7-d74e-004a0bfbee47@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+rppt=linux.ibm.com@lists.infradead.org
To: Christophe Leroy <christophe.leroy@c-s.fr>, Qian Cai <cai@lca.pw>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Memory Management List <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, the arch/x86 maintainers <x86@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-snps-arc@lists.infradead.org, Vasily Gorbik <gor@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Paul Walmsley <paul.walmsley@sifive.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>, LKML <linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200305062312.ToH9Zw2Fx3QFhB7Qr6j9SM5imutJm_dLDxctLvOeshM@z>



On 03/05/2020 11:13 AM, Christophe Leroy wrote:
> 
> 
> Le 05/03/2020 à 01:54, Anshuman Khandual a écrit :
>>
>>
>> On 03/04/2020 04:59 PM, Qian Cai wrote:
>>>
>>>
>>>> On Mar 4, 2020, at 1:49 AM, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>>>
>>>> AFAIU, you are not taking an interrupt here. You are stuck in the pte_update(), most likely due to nested locks. Try with LOCKDEP ?
>>>
>>> Not exactly sure what did you mean here, but the kernel has all lockdep enabled and did not flag anything here.
>>
>> As the patch has been dropped from Linux next (next-20200304) perhaps in
>> order to fold back the __pa_symbol() fix [1], so I am planning to respin
>> the original patch once more as V15 while adding Qian's signed off by for
>> the powerpc part. For now lets enable radix MMU ppc64 along with existing
>> ppc32. As PPC_RADIX_MMU depends on PPC_BOOK3S_64, the following change
>> should be good enough ?
> 
> I don't think so, even if you have the Radix MMU compiled in, hash MMU is used when Radix is not available or disabled. So until the Hash MMU problem is fixed, you cannot enable it by default.

So this implies, that with DEBUG_VM given kernel compiled with Radix MMU will
get stuck in soft lock up when forced to use hash MMU in cases where Radix MMU
is either not available or is disabled. Hence, we cannot enable that.

I will still fold the changes from Qian without enabling ppc64 Radix MMU and
respin V15. These new changes dont hurt, build every where and works good
on arm64 and x86 platforms. More over we know that they also fix a problem
for ppc64 Radix MMU platforms. Hence unless there are some other concerns we
should fold them in.

> 
> Christophe
> 
