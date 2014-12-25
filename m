From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 33/38] sparc: drop pte_file()-related helpers
Date: Thu, 25 Dec 2014 18:34:20 -0500 (EST)
Message-ID: <20141225.183420.2288499637535959481.davem@davemloft.net>
References: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com>
	<1419423766-114457-34-git-send-email-kirill.shutemov@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:58677 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751816AbaLYXeY (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Dec 2014 18:34:24 -0500
In-Reply-To: <1419423766-114457-34-git-send-email-kirill.shutemov@linux.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kirill.shutemov@linux.intel.com
Cc: akpm@linux-foundation.org, peterz@infradead.org, mingo@kernel.org, davej@redhat.com, sasha.levin@oracle.com, hughd@google.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 24 Dec 2014 14:22:41 +0200

> We've replaced remap_file_pages(2) implementation with emulation.
> Nobody creates non-linear mapping anymore.
> 
> This patch also increase number of bits availble for swap offset.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>

Acked-by: David S. Miller <davem@davemloft.net>
