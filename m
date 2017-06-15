From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [HELP-NEEDED, PATCH 0/3] Do not loose dirty bit on THP pages
Date: Thu, 15 Jun 2017 08:20:32 +0530
Message-ID: <95a2756a-dd56-e042-95ed-90f4078e0380@linux.vnet.ibm.com>
References: <20170614135143.25068-1-kirill.shutemov@linux.intel.com>
 <eed279c6-bf61-f2f3-c9f2-d9a94568e2e3@linux.vnet.ibm.com>
 <20170614165513.GD17632@arm.com>
 <548e33cb-e737-bb39-91a3-f66ee9211262@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <548e33cb-e737-bb39-91a3-f66ee9211262@linux.vnet.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Ralf Baechle <ralf@linux-mips.org>, "David S. Miller" <davem@davemloft.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com
List-Id: linux-arch.vger.kernel.org



On Thursday 15 June 2017 06:35 AM, Aneesh Kumar K.V wrote:
> 

> W.r.t pmdp_invalidate() usage, I was wondering whether we can do that 
> early in __split_huge_pmd_locked().
> 


BTW by moving  pmdp_invalidate early, we can then get rid of

	pmdp_huge_split_prepare(vma, haddr, pmd);


-aneesh
