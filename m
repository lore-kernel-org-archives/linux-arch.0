Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:33582 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757099AbbJIJtB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2015 05:49:01 -0400
Received: by wiclk2 with SMTP id lk2so62925417wic.0
        for <linux-arch@vger.kernel.org>; Fri, 09 Oct 2015 02:49:00 -0700 (PDT)
Date: Fri, 9 Oct 2015 12:48:58 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v2 08/12] mm: move some code around
Message-ID: <20151009094858.GB7873@node>
References: <1442918096-17454-1-git-send-email-vgupta@synopsys.com>
 <1442918096-17454-9-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1442918096-17454-9-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Matthew Wilcox <matthew.r.wilcox@intel.com>, Minchan Kim <minchan@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Message-ID: <20151009094858.X_Od5NMreO6bo4A_8XMi2tpJdxmSV2Tbsfij7Q4B89w@z>

On Tue, Sep 22, 2015 at 04:04:52PM +0530, Vineet Gupta wrote:
> This reduces/simplifies the diff for the next patch which moves THP
> specific code.
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>

Okay, so you group pte-related helpers together, right?
It would be nice to mention it in commit message.

Acked-by: Kirill A. Shutemov kirill.shutemov@linux.intel.com

-- 
 Kirill A. Shutemov
