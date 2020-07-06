Return-Path: <SRS0=B4xR=AR=kvack.org=owner-linux-mm@kernel.org>
Date: Mon, 6 Jul 2020 14:06:34 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH V4 0/4] mm/debug_vm_pgtable: Add some more tests
Message-ID: <20200706120633.GA32473@oc3871087118.ibm.com>
References: <1593996516-7186-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593996516-7186-1-git-send-email-anshuman.khandual@arm.com>
Sender: owner-linux-mm@kvack.org
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Vineet Gupta <vgupta@synopsys.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, x86@kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200706120634.z9KZW_AQfEBTTDtu28suxtjjy-gedeKjMdqGZ1kO6w8@z>

On Mon, Jul 06, 2020 at 06:18:32AM +0530, Anshuman Khandual wrote:

[...]

> Tested on arm64, x86 platforms but only build tested on all other enabled
> platforms through ARCH_HAS_DEBUG_VM_PGTABLE i.e powerpc, arc, s390. The

Sorry for missing to test earlier. Works for me on s390. Also, tried with
few relevant config options to set/unset.

Thanks!
