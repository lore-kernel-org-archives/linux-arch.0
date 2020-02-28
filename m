Return-Path: <linux-riscv-bounces+rppt=linux.ibm.com@lists.infradead.org>
Subject: Re: [PATCH] mm/debug: Add tests validating arch page table helpers
 for core features
References: <1582799637-11786-1-git-send-email-anshuman.khandual@arm.com>
 <51421bb3-9075-d7e9-1750-0553a1ebe64a@c-s.fr>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f99692be-5d38-fdb7-46f1-205c7cc7481c@arm.com>
Date: Fri, 28 Feb 2020 14:50:09 +0530
MIME-Version: 1.0
In-Reply-To: <51421bb3-9075-d7e9-1750-0553a1ebe64a@c-s.fr>
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
To: Christophe Leroy <christophe.leroy@c-s.fr>, linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, linux-snps-arc@lists.infradead.org, Vasily Gorbik <gor@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Paul Walmsley <paul.walmsley@sifive.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200228092009.JgBwVW1pIpCDxBYT894wKcFPurmQm77FUQy9kiXnxsk@z>



On 02/27/2020 04:12 PM, Christophe Leroy wrote:
> 
> 
> Le 27/02/2020 à 11:33, Anshuman Khandual a écrit :
>> This adds new tests validating arch page table helpers for these following
>> core memory features. These tests create and test specific mapping types at
>> various page table levels.
>>
>> * SPECIAL mapping
>> * PROTNONE mapping
>> * DEVMAP mapping
>> * SOFTDIRTY mapping
>> * SWAP mapping
>> * MIGRATION mapping
>> * HUGETLB mapping
> 
> For testing HUGETLB mappings, you also have to include tests of hugepd functions/helpers. Not all archictures have hugepage size which matches with page tables levels (e.g. powerpc). Those architectures use hugepd_t.

Dont see much hugepd_t in generic HugeTLB. Just wondering which generic
hugepd helpers can be tested here. Could you please be bit more specific.
As we have not yet started looking for arch specific page table helpers
test requirements, all the test scenarios here need to be generic.

> 
> Christophe
> 
