From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] mm/debug: Add tests validating arch page table helpers
 for core features
Date: Thu, 27 Feb 2020 11:42:33 +0100
Message-ID: <51421bb3-9075-d7e9-1750-0553a1ebe64a@c-s.fr>
References: <1582799637-11786-1-git-send-email-anshuman.khandual@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pegase1.c-s.fr ([93.17.236.30]:49496 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728844AbgB0Kmx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 27 Feb 2020 05:42:53 -0500
In-Reply-To: <1582799637-11786-1-git-send-email-anshuman.khandual@arm.com>
Content-Language: fr
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-riscv@lists.infradead.org, Will Deacon <will@kernel.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org, Mike Rapoport <rppt@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-snps-arc@lists.infradead.org, Vasily Gorbik <gor@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Paul Walmsley <paul.walmsley@sifive.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Vineet Gupta <vgupta@synopsys.com>, linux-kernel@vger.kernel.org, Palmer Dabbelt <pal>



Le 27/02/2020 à 11:33, Anshuman Khandual a écrit :
> This adds new tests validating arch page table helpers for these following
> core memory features. These tests create and test specific mapping types at
> various page table levels.
> 
> * SPECIAL mapping
> * PROTNONE mapping
> * DEVMAP mapping
> * SOFTDIRTY mapping
> * SWAP mapping
> * MIGRATION mapping
> * HUGETLB mapping

For testing HUGETLB mappings, you also have to include tests of hugepd 
functions/helpers. Not all archictures have hugepage size which matches 
with page tables levels (e.g. powerpc). Those architectures use hugepd_t.

Christophe
