Return-Path: <jhubbard@nvidia.com>
Subject: Re: [PATCH v6 02/11] mm/gup: Use functions to track lockless pgtbl
 walks on gup_pgd_range
References: <20200206030900.147032-1-leonardo@linux.ibm.com>
 <20200206030900.147032-3-leonardo@linux.ibm.com>
 <760c238043196e0628c8c0eff48a8e938ef539ba.camel@linux.ibm.com>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <0c2f5a89-4890-fd84-6a6d-e470ba110399@nvidia.com>
Date: Fri, 7 Feb 2020 14:54:29 -0800
MIME-Version: 1.0
In-Reply-To: <760c238043196e0628c8c0eff48a8e938ef539ba.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Leonardo Bras <leonardo@linux.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Steven Price <steven.price@arm.com>, Robin Murphy <robin.murphy@arm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Balbir Singh <bsingharora@gmail.com>, Reza Arbab <arbab@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200207225429.5aCrW_SZh8JFKYhfpWhnTm1PPU_tdcr6-BrdEE9trfo@z>

On 2/5/20 7:25 PM, Leonardo Bras wrote:
> On Thu, 2020-02-06 at 00:08 -0300, Leonardo Bras wrote:
>>                 gup_pgd_range(addr, end, gup_flags, pages, &nr);
>> -               local_irq_enable();
>> +               end_lockless_pgtbl_walk(IRQS_ENABLED);
>>                 ret = nr;
>>         }
>>  
> 
> Just noticed IRQS_ENABLED is not available on other archs than ppc64.
> I will fix this for v7.
> 

What's the fix going to look like, approximately?


thanks,
-- 
John Hubbard
NVIDIA
