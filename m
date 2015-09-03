From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH 00/11] THP support for ARC
Date: Thu, 3 Sep 2015 14:16:26 +0530
Message-ID: <55E808E2.2080102@synopsys.com>
References: <1440666194-21478-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1440666194-21478-1-git-send-email-vgupta@synopsys.com>
Sender: owner-linux-mm@kvack.org
To: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Matthew
 Wilcox <matthew.r.wilcox@intel.com>, Minchan Kim <minchan@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, arc-linux-dev@synopsys.com
List-Id: linux-arch.vger.kernel.org

Hi all,

On Thursday 27 August 2015 02:33 PM, Vineet Gupta wrote:
> Hi,
> 
> This series brings THP support to ARC. It also introduces an optional new
> thp hook for arches to possibly optimize the TLB flush in thp regime.
> 
> Rebased against linux-next of today so includes new hook for Minchan's
> madvise(MADV_FREE).
> 
> Please review !
> 
> Thx,
> -Vineet

I understand that this is busy time for people due to merge window. However is
this series in a a review'able state or do people think more changes are needed
before they can take a look.

I already did the pgtable_t switch to pte_t * as requested by Kirill (as a
separate precursor patch) and that does requires one patch in this series to be
updated. I will spin this in v2 but was wondering if we are on the right track here.

Thx,
-Vineet

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
