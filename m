Return-Path: <SRS0=ZbOS=4O=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [PATCH V2 3/4] mm/vma: Replace all remaining open encodings with
 is_vm_hugetlb_page()
References: <1582520593-30704-1-git-send-email-anshuman.khandual@arm.com>
 <1582520593-30704-4-git-send-email-anshuman.khandual@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
Message-ID: <79d454cb-9b7e-4fc2-6381-3da93f17ddc1@suse.cz>
Date: Wed, 26 Feb 2020 18:40:41 +0100
MIME-Version: 1.0
In-Reply-To: <1582520593-30704-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Alexander Viro <viro@zeniv.linux.org.uk>, Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200226174041.yoHWuIpNG_I1VWG-mGZbjENcJF-CYhkxkucSnCAivOo@z>

On 2/24/20 6:03 AM, Anshuman Khandual wrote:
> This replaces all remaining open encodings with is_vm_hugetlb_page().
> 
> Cc: Paul Mackerras <paulus@ozlabs.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: Will Deacon <will@kernel.org>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Nick Piggin <npiggin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: kvm-ppc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Meh, why is there _page in the function's name... but too many users to bother
changing it now, I guess.

Acked-by: Vlastimil Babka <vbabka@suse.cz
