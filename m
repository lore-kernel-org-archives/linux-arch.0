From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 2/3] mm: mmu_gather track of invalidated TLB ranges
 explicitly for more precise flushing
Date: Tue, 12 Jun 2018 11:14:10 -0700
Message-ID: <CA+55aFxaVyTZmKdywAGVopmWeDirb1Ou49XD_SfqGQL_ox_65Q@mail.gmail.com>
References: <20180612071621.26775-1-npiggin@gmail.com>
 <20180612071621.26775-3-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20180612071621.26775-3-npiggin@gmail.com>
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

On Tue, Jun 12, 2018 at 12:16 AM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> +static inline void __tlb_adjust_page_range(struct mmu_gather *tlb,
> +                                     unsigned long address,
> +                                     unsigned int range_size)
> +{
> +       tlb->page_start = min(tlb->page_start, address);
> +       tlb->page_end = max(tlb->page_end, address + range_size);
> +}

Why add this unnecessary complexity for architectures where it doesn't matter?

This is not "generic". This is some crazy powerpc special case. Why
add it to generic code, and why make everybody else take the cost?

                    Linus
