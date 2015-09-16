From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 00/11] THP support for ARC
Date: Wed, 16 Sep 2015 15:27:29 -0700
Message-ID: <20150916152729.15b8b5f05c82beeed599c143@linux-foundation.org>
References: <1440666194-21478-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:46464 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbbIPW1a (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Sep 2015 18:27:30 -0400
In-Reply-To: <1440666194-21478-1-git-send-email-vgupta@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Mel Gorman <mgorman@suse.de>, Matthew Wilcox <matthew.r.wilcox@intel.com>, Minchan Kim <minchan@kernel.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, arc-linux-dev@synopsys.com

On Thu, 27 Aug 2015 14:33:03 +0530 Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:

> This series brings THP support to ARC. It also introduces an optional new
> thp hook for arches to possibly optimize the TLB flush in thp regime.

The mm/ changes look OK to me.  Please maintain them in the arc tree,
merge them upstream at the same time.
