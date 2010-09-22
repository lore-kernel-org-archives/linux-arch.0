From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH -mm 4/8] mips: enable ARCH_DMA_ADDR_T_64BIT with
 (HIGHMEM && 64BIT_PHYS_ADDR) || 64BIT
Date: Wed, 22 Sep 2010 18:18:26 +0900
Message-ID: <20100922181454N.fujita.tomonori@lab.ntt.co.jp>
References: <20100903094753S.fujita.tomonori@lab.ntt.co.jp>
	<1283474956-14710-4-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<20100920133434.GB15938@linux-mips.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:37916 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752394Ab0IVJTI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Sep 2010 05:19:08 -0400
In-Reply-To: <20100920133434.GB15938@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: ralf@linux-mips.org
Cc: fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org

On Mon, 20 Sep 2010 14:34:35 +0100
Ralf Baechle <ralf@linux-mips.org> wrote:

> On Fri, Sep 03, 2010 at 09:49:12AM +0900, FUJITA Tomonori wrote:
> 
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > Cc: linux-mips@linux-mips.org
> 
> Looks good:
> 
> Acked-by: Ralf Baechle <ralf@linux-mips.org>

Thanks,


> As this patch by itself doesn't make any sense in the MIPS tree and would
> only cry for a janitor to remove it again I suggest you merge this with
> the rest of the series.

I expect akpm to merge all the patches.
