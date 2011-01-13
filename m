From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PAGE_KERNEL_RO
Date: Thu, 13 Jan 2011 11:11:24 +1100
Message-ID: <1294877484.9586.66.camel@pasglop>
References: <20110112160722.6486a6c2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:54039 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756109Ab1AMAMM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 12 Jan 2011 19:12:12 -0500
In-Reply-To: <20110112160722.6486a6c2.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>

On Wed, 2011-01-12 at 16:07 -0800, Andrew Morton wrote:
> drivers/firewire/ohci.c now needs PAGE_KERNEL_RO, but many
> architectures don't implement it.  Broke my sparc64 build.

Some architectures actually cannot implement it even... at least some
variants of powerpc MMUs don't have a combination of protection bits
that allow a kernel-only RO mapping (yeah odd).

Cheers,
Ben.
