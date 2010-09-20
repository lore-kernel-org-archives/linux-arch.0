From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH -mm 4/8] mips: enable ARCH_DMA_ADDR_T_64BIT with (HIGHMEM
 && 64BIT_PHYS_ADDR) || 64BIT
Date: Mon, 20 Sep 2010 14:34:35 +0100
Message-ID: <20100920133434.GB15938@linux-mips.org>
References: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
 <1283474956-14710-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:49290 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab0ITNeh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Sep 2010 09:34:37 -0400
Content-Disposition: inline
In-Reply-To: <1283474956-14710-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org

On Fri, Sep 03, 2010 at 09:49:12AM +0900, FUJITA Tomonori wrote:

> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Cc: linux-mips@linux-mips.org

Looks good:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

As this patch by itself doesn't make any sense in the MIPS tree and would
only cry for a janitor to remove it again I suggest you merge this with
the rest of the series.

Thanks,

  Ralf
