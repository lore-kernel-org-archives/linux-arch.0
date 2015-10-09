From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 10/12] mm,thp: introduce flush_pmd_tlb_range
Date: Fri, 9 Oct 2015 13:08:16 +0300
Message-ID: <20151009100816.GC7873@node>
References: <1442918096-17454-1-git-send-email-vgupta@synopsys.com>
 <1442918096-17454-11-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <1442918096-17454-11-git-send-email-vgupta@synopsys.com>
Sender: owner-linux-mm@kvack.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Matthew Wilcox <matthew.r.wilcox@intel.com>, Minchan Kim <minchan@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 22, 2015 at 04:04:54PM +0530, Vineet Gupta wrote:

Commit message: -ENOENT.

Otherwise, looks good:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
