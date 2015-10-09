From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 09/12] mm,thp: reduce ifdef'ery for THP in generic code
Date: Fri, 9 Oct 2015 15:58:11 +0530
Message-ID: <561796BB.8040905@synopsys.com>
References: <1442918096-17454-1-git-send-email-vgupta@synopsys.com>
 <1442918096-17454-10-git-send-email-vgupta@synopsys.com>
 <20151009095359.GA7971@node>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20151009095359.GA7971@node>
Sender: owner-linux-mm@kvack.org
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Matthew
 Wilcox <matthew.r.wilcox@intel.com>, Minchan Kim <minchan@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Friday 09 October 2015 03:23 PM, Kirill A. Shutemov wrote:
> On Tue, Sep 22, 2015 at 04:04:53PM +0530, Vineet Gupta wrote:
>> > - pgtable-generic.c: Fold individual #ifdef for each helper into a top
>> >   level #ifdef. Makes code more readable
> Makes sense.
> 
>> > - Per Andrew's suggestion removed the dummy implementations for !THP
>> >   in asm-generic/page-table.h to have build time failures vs. runtime.
> I'm not sure it's a good idea. This can lead to unnecessary #ifdefs where
> otherwise call to helper would be eliminated by compiler as dead code.
> 
> What about dummy helpers with BUILD_BUG()?
> 

You are right after all. It is not so much related to __HAVE_ARCH_PMDP_xyz, but
the fact that generic code can call them under PageTransHuge(). So better to
provide stubs with BUILD_BUG

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
