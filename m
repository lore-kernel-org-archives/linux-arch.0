From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/4] mm/hugetlb: Simplify hugetlb unmap
Date: Wed, 1 Jun 2016 15:34:42 -0700
Message-ID: <20160601153442.229f0747c97d1bbf21f1a935@linux-foundation.org>
References: <1464587062-17745-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43322 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbcFAWen (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2016 18:34:43 -0400
In-Reply-To: <1464587062-17745-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org

On Mon, 30 May 2016 11:14:19 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> For hugetlb like THP (and unlike regular page), we do tlb flush after
> dropping ptl. Because of the above, we don't need to track force_flush
> like we do now. Instead we can simply call tlb_remove_page() which
> will do the flush if needed.
> 
> No functionality change in this patch.

This all looks fairly non-horrifying.  Will a non-RFC version be
forthcoming?
