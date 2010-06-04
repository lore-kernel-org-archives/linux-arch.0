From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH] arch/tile: respond to reviews of the second code
 submission.
Date: Fri, 4 Jun 2010 10:31:17 +0900
Message-ID: <20100604103049M.fujita.tomonori@lab.ntt.co.jp>
References: <201005290334.o4T3Y1FX029944@farm-0002.internal.tilera.com>
	<201006032141.o53LfZC9019335@lab-15.internal.tilera.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:50536 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932126Ab0FDBb5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 3 Jun 2010 21:31:57 -0400
In-Reply-To: <201006032141.o53LfZC9019335@lab-15.internal.tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: cmetcalf@tilera.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, fujita.tomonori@lab.ntt.co.jp, lethal@linux-sh.org

On Thu, 3 Jun 2010 17:32:17 -0400
Chris Metcalf <cmetcalf@tilera.com> wrote:

> This change addresses DMA-related comments by FUJITA Tomonori

What about the comment on dma_alloc_coherent()?

The rest changes look fine.
