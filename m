From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/4] mm/hugetlb: Simplify hugetlb unmap
Date: Thu, 02 Jun 2016 13:51:41 +0530
Message-ID: <87twhcvw4q.fsf@skywalker.in.ibm.com>
References: <1464587062-17745-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com> <20160601153442.229f0747c97d1bbf21f1a935@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160601153442.229f0747c97d1bbf21f1a935@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Andrew Morton <akpm@linux-foundation.org> writes:

> On Mon, 30 May 2016 11:14:19 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> For hugetlb like THP (and unlike regular page), we do tlb flush after
>> dropping ptl. Because of the above, we don't need to track force_flush
>> like we do now. Instead we can simply call tlb_remove_page() which
>> will do the flush if needed.
>> 
>> No functionality change in this patch.
>
> This all looks fairly non-horrifying.  Will a non-RFC version be
> forthcoming?

Yes. I will send an updated version of the series. Patch 4 may need to go through
powerpc tree because of other dependent patches. I will continue to include
that in the series to show the arch related changes.
 
-aneesh
