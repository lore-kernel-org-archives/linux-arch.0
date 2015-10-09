Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34966 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757276AbbJIKIU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2015 06:08:20 -0400
Received: by wicge5 with SMTP id ge5so61371346wic.0
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2015 03:08:18 -0700 (PDT)
Date: Fri, 9 Oct 2015 13:08:16 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 10/12] mm,thp: introduce flush_pmd_tlb_range
Message-ID: <20151009100816.GC7873@node>
References: <1442918096-17454-1-git-send-email-vgupta@synopsys.com>
 <1442918096-17454-11-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1442918096-17454-11-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Matthew Wilcox <matthew.r.wilcox@intel.com>, Minchan Kim <minchan@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20151009100816.Xp9xm3fRllzYyEi8KdySQtHdx5USHyj478Q3h93Czk8@z>

On Tue, Sep 22, 2015 at 04:04:54PM +0530, Vineet Gupta wrote:

Commit message: -ENOENT.

Otherwise, looks good:

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
