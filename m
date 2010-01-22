From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: Re: [PATCH] asm-generic: dma: Add BUG_ON for uninitialized dma_ops
Date: Fri, 22 Jan 2010 10:11:25 +0900
Message-ID: <20100122101039D.fujita.tomonori@lab.ntt.co.jp>
References: <1263982111-24123-1-git-send-email-monstr@monstr.eu>
	<1263982111-24123-2-git-send-email-monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sh.osrg.net ([192.16.179.4]:40542 "EHLO sh.osrg.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898Ab0AVBL7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 21 Jan 2010 20:11:59 -0500
In-Reply-To: <1263982111-24123-2-git-send-email-monstr@monstr.eu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@monstr.eu
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com, arnd@arndb.de, linux-arch@vger.kernel.org, fujita.tomonori@lab.ntt.co.jp, akpm@linux-foundation.org, mingo@elte.hu, joerg.roedel@amd.com

On Wed, 20 Jan 2010 11:08:31 +0100
monstr@monstr.eu wrote:

> From: Michal Simek <monstr@monstr.eu>
> 
> Check that dma_ops are initialized correctly. Without this
> checking you get kernel fault and you don't know where the problem is.

Hmm, dma_ops is initialized in early architecture-specific boot-up
code. We don't change it often. I don't think that we need much time
to find where problems are.

The benefit is insufficient to justify the overhead.
