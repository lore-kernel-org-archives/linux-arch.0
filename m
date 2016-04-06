From: Chris Metcalf <cmetcalf@mellanox.com>
Subject: Re: [PATCH 10/10] arch: fix has_transparent_hugepage()
Date: Wed, 6 Apr 2016 08:29:05 -0400
Message-ID: <57050111.3070507@mellanox.com>
References: <alpine.LSU.2.11.1604051329480.5965@eggly.anvils>
 <alpine.LSU.2.11.1604051355280.5965@eggly.anvils>
 <20160406065806.GC3078@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20160406065806.GC3078@gmail.com>
Sender: owner-linux-mm@kvack.org
To: Ingo Molnar <mingo@kernel.org>, Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Andres Lagar-Cavilla <andreslc@google.com>, Yang Shi <yang.shi@linaro.org>, Ning Qu <quning@gmail.com>, Arnd Bergman <arnd@arndb.de>, Ralf Baechle <ralf@linux-mips.org>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On 4/6/2016 2:58 AM, Ingo Molnar wrote:
> * Hugh Dickins <hughd@google.com> wrote:
>
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -181,6 +181,7 @@ static inline int pmd_trans_huge(pmd_t p
>>   	return (pmd_val(pmd) & (_PAGE_PSE|_PAGE_DEVMAP)) == _PAGE_PSE;
>>   }
>>   
>> +#define has_transparent_hugepage has_transparent_hugepage
>>   static inline int has_transparent_hugepage(void)
>>   {
>>   	return cpu_has_pse;
> Small nit, just writing:
>
>    #define has_transparent_hugepage
>
> ought to be enough, right?

No, since then in hugepage_init() the has_transparent_hugepage() call site
would be left with just a stray pair of parentheses instead of a call.

-- 
Chris Metcalf, Mellanox Technologies
http://www.mellanox.com

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
