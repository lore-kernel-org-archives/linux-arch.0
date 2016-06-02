Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:49964 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152AbcFBIVs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jun 2016 04:21:48 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <aneesh.kumar@linux.vnet.ibm.com>;
	Thu, 2 Jun 2016 02:21:47 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 1/4] mm/hugetlb: Simplify hugetlb unmap
In-Reply-To: <20160601153442.229f0747c97d1bbf21f1a935@linux-foundation.org>
References: <1464587062-17745-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com> <20160601153442.229f0747c97d1bbf21f1a935@linux-foundation.org>
Date: Thu, 02 Jun 2016 13:51:41 +0530
Message-ID: <87twhcvw4q.fsf@skywalker.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Message-ID: <20160602082141.RT3pQISSNf4qQpU9lKjXwBJ4ShGDTHTZOiwm7H8yxQA@z>

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

