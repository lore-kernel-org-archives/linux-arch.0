From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH -mm 1/4] sparc: remove dma64_addr_t usage
Date: Mon, 11 Oct 2010 23:28:06 -0700 (PDT)
Message-ID: <20101011.232806.59691034.davem@davemloft.net>
References: <1286853195-32202-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<1286853195-32202-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:49059
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753601Ab0JLG1o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Oct 2010 02:27:44 -0400
In-Reply-To: <1286853195-32202-2-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: fujita.tomonori@lab.ntt.co.jp
Cc: akpm@linux-foundation.org, linux-arch@vger.kernel.org

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Tue, 12 Oct 2010 12:13:12 +0900

> let's use u64 instead.
> 
> Looks like PCI654_REQUIRED_MASK or PCI64_ADR_BASE isn't used. They can
> be removed?
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Acked-by: David S. Miller <davem@davemloft.net>
