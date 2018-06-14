From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 3/3] powerpc/64s/radix: optimise TLB flush with
 precise TLB ranges in mmu_gather
Date: Thu, 14 Jun 2018 15:15:47 +0900
Message-ID: <CA+55aFwP-6QZ0u2ZYCjTebP6OmkeTpbUHyLT0ih-57TbvJBPxg@mail.gmail.com>
References: <20180612071621.26775-1-npiggin@gmail.com>
 <20180612071621.26775-4-npiggin@gmail.com>
 <CA+55aFzKBieD0Y3sgFQzt+x5esqb9vT6SEQ28xyCz5UWegfFVg@mail.gmail.com>
 <20180613083131.139a3c34@roar.ozlabs.ibm.com>
 <CA+55aFyk9VBLUk8VYhfEUR55x0TXY9_QX1dE4wE0A_ias9tMNQ@mail.gmail.com>
 <20180613090950.50566245@roar.ozlabs.ibm.com>
 <CA+55aFxd97-29qi-JMxyPPoZMxw=eObQHB5XXGiLj7SNV8B-oQ@mail.gmail.com>
 <CA+55aFzbYBXUDcAGaP_HoCxjTvOgkixc0+7nJqMea0yKjLSnhw@mail.gmail.com>
 <20180613101241.004fd64e@roar.ozlabs.ibm.com>
 <CA+55aFzJRknbQD6Mv3OSOvUVozQ4H8ni8jPP7UEEi9wKXmVhQA@mail.gmail.com>
 <20180614124931.703e5b54@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20180614124931.703e5b54@roar.ozlabs.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Nick Piggin <npiggin@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Nadav Amit <nadav.amit@gmail.com>, Minchan Kim <minchan@kernel.org>, Mel Gorman <mgorman@techsingularity.net>, linux-mm <linux-mm@kvack.org>, "Aneesh Kumar K. V" <aneesh.kumar@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 14, 2018 at 11:49 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> +#ifndef pte_free_tlb
>  #define pte_free_tlb(tlb, ptep, address)                       \
>         do {                                                    \
>                 __tlb_adjust_range(tlb, address, PAGE_SIZE);    \
>                 __pte_free_tlb(tlb, ptep, address);             \
>         } while (0)
> +#endif

Do you really want to / need to take over the whole pte_free_tlb macro?

I was hoping that you'd just replace the __tlv_adjust_range() instead.

Something like

 - replace the

        __tlb_adjust_range(tlb, address, PAGE_SIZE);

   with a "page directory" version:

        __tlb_free_directory(tlb, address, size);

 - have the default implementation for that be the old code:

        #ifndef __tlb_free_directory
          #define __tlb_free_directory(tlb,addr,size)
__tlb_adjust_range(tlb, addr, PAGE_SIZE)
        #endif

and that way architectures can now just hook into that
"__tlb_free_directory()" thing.

Hmm?

             Linus
