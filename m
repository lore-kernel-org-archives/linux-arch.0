From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH 15/21] mm: memmap_init: iterate over memblock regions
 rather that check each PFN
Date: Fri, 24 Apr 2020 09:22:32 +0200
Message-ID: <9143538a-4aaa-ca1d-9c8f-72ac949cf593@redhat.com>
References: <20200412194859.12663-1-rppt@kernel.org>
 <20200412194859.12663-16-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200412194859.12663-16-rppt@kernel.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org
To: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Mike Rapoport <rppt@linux.ibm.com>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, linux-sh@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@in>
List-Id: linux-arch.vger.kernel.org

On 12.04.20 21:48, Mike Rapoport wrote:
> From: Baoquan He <bhe@redhat.com>
> 
> When called during boot the memmap_init_zone() function checks if each PFN
> is valid and actually belongs to the node being initialized using
> early_pfn_valid() and early_pfn_in_nid().
> 
> Each such check may cost up to O(log(n)) where n is the number of memory
> banks, so for large amount of memory overall time spent in early_pfn*()
> becomes substantial.
> 
> Since the information is anyway present in memblock, we can iterate over
> memblock memory regions in memmap_init() and only call memmap_init_zone()
> for PFN ranges that are know to be valid and in the appropriate node.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  mm/page_alloc.c | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7f6a3081edb8..c43ce8709457 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5995,14 +5995,6 @@ void __meminit memmap_init_zone(unsigned long size, int nid, unsigned long zone,
>  		 * function.  They do not exist on hotplugged memory.
>  		 */

After this change, the comment above is stale. the "holes in boot-time
mem_map" are handled by the caller now AFAIKs.

>  		if (context == MEMMAP_EARLY) {
> -			if (!early_pfn_valid(pfn)) {
> -				pfn = next_pfn(pfn);
> -				continue;
> -			}
> -			if (!early_pfn_in_nid(pfn, nid)) {
> -				pfn++;
> -				continue;
> -			}
>  			if (overlap_memmap_init(zone, &pfn))
>  				continue;
>  			if (defer_init(nid, pfn, end_pfn))


-- 
Thanks,

David / dhildenb
