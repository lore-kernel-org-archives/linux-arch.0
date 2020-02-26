Return-Path: <linux-riscv-bounces+rppt=linux.ibm.com@lists.infradead.org>
Subject: Re: [PATCH V14] mm/debug: Add tests validating architecture page
 table helpers
References: <1581909460-19148-1-git-send-email-anshuman.khandual@arm.com>
 <1582726182.7365.123.camel@lca.pw> <1582726340.7365.124.camel@lca.pw>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <eb154054-68ab-a659-065b-f4f7dcbb8671@c-s.fr>
Date: Wed, 26 Feb 2020 15:44:23 +0100
MIME-Version: 1.0
In-Reply-To: <1582726340.7365.124.camel@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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
To: Qian Cai <cai@lca.pw>, Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-snps-arc@lists.infradead.org, Vasily Gorbik <gor@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Paul Walmsley <paul.walmsley@sifive.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>, linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200226144423.d9OMA7h1SDh12s9IJ1C7y1QjB5EbBtpL-mkXpk5MxT0@z>



Le 26/02/2020 à 15:12, Qian Cai a écrit :
> On Wed, 2020-02-26 at 09:09 -0500, Qian Cai wrote:
>> On Mon, 2020-02-17 at 08:47 +0530, Anshuman Khandual wrote:
>>
>> How useful is this that straightly crash the powerpc?
> 
> And then generate warnings on arm64,
> 
> [  146.634626][    T1] debug_vm_pgtable: debug_vm_pgtable: Validating
> architecture page table helpers
> [  146.643995][    T1] ------------[ cut here ]------------
> [  146.649350][    T1] virt_to_phys used for non-linear address:
> (____ptrval____) (start_kernel+0x0/0x580)

Must be something wrong with the following in debug_vm_pgtable()

	paddr = __pa(&start_kernel);

Is there any explaination why start_kernel() is not in linear memory on 
ARM64 ?

Christophe
