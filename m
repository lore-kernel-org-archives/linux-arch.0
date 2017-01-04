From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v2 0/4] Write protect DAX PMDs in *sync path
Date: Tue, 3 Jan 2017 17:13:49 -0700
Message-ID: <20170104001349.GA8176@linux.intel.com>
References: <1482441536-14550-1-git-send-email-ross.zwisler@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1482441536-14550-1-git-send-email-ross.zwisler@linux.intel.com>
Sender: owner-linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, Dan Williams <dan.j.williams@intel.com>, Dave Chinner <david@fromorbit.com>, Dave Hansen <dave.hansen@intel.com>, Jan Kara <jack@suse.cz>, Matthew Wilcox <mawilcox@microsoft.com>, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nvdimm@lists.01.org
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 22, 2016 at 02:18:52PM -0700, Ross Zwisler wrote:
> Currently dax_mapping_entry_mkclean() fails to clean and write protect the
> pmd_t of a DAX PMD entry during an *sync operation.  This can result in
> data loss, as detailed in patch 4.
> 
> You can find a working tree here:
> 
> https://git.kernel.org/cgit/linux/kernel/git/zwisler/linux.git/log/?h=dax_pmd_clean_v2
> 
> This series applies cleanly to mmotm-2016-12-19-16-31.
> 
> Changes since v1:
>  - Included Dan's patch to kill DAX support for UML.
>  - Instead of wrapping the DAX PMD code in dax_mapping_entry_mkclean() in
>    an #ifdef, we now create a stub for pmdp_huge_clear_flush() for the case
>    when CONFIG_TRANSPARENT_HUGEPAGE isn't defined. (Dan & Jan)
> 
> Dan Williams (1):
>   dax: kill uml support
> 
> Ross Zwisler (3):
>   dax: add stub for pmdp_huge_clear_flush()
>   mm: add follow_pte_pmd()
>   dax: wrprotect pmd_t in dax_mapping_entry_mkclean
> 
>  fs/Kconfig                    |  2 +-
>  fs/dax.c                      | 49 ++++++++++++++++++++++++++++++-------------
>  include/asm-generic/pgtable.h | 10 +++++++++
>  include/linux/mm.h            |  4 ++--
>  mm/memory.c                   | 41 ++++++++++++++++++++++++++++--------
>  5 files changed, 79 insertions(+), 27 deletions(-)

Well, 0-day found another architecture that doesn't define pmd_pfn() et al.,
so we'll need some more fixes. (Thank you, 0-day, for the coverage!)

I have to apologize, I didn't understand that Dan intended his "dax: kill uml
support" patch to land in v4.11.  I thought he intended it as a cleanup to my
series, which really needs to land in v4.10.  That's why I folded them
together into this v2, along with the wrapper suggested by Jan.

Andrew, does it work for you to just keep v1 of this series, and eventually
send that to Linus for v4.10?

https://lkml.org/lkml/2016/12/20/649

You've already pulled that one into -mm, and it does correctly solve the data
loss issue.

That would let us deal with getting rid of the #ifdef, blacklisting
architectures and introducing the pmdp_huge_clear_flush() strub in a follow-on
series for v4.11.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
