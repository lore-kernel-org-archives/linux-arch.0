From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: PAGE_KERNEL_RO
Date: Thu, 13 Jan 2011 07:34:58 +0100
Message-ID: <20110113073458.2179590a@stein>
References: <20110112160722.6486a6c2.akpm@linux-foundation.org>
	<1294877484.9586.66.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:37135 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab1AMGfW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Jan 2011 01:35:22 -0500
In-Reply-To: <1294877484.9586.66.camel@pasglop>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux1394-devel@lists.sourceforge.net, Clemens Ladisch <clemens@ladisch.de>

On Jan 13 Benjamin Herrenschmidt wrote at linux-arch:
> On Wed, 2011-01-12 at 16:07 -0800, Andrew Morton wrote:
> > drivers/firewire/ohci.c now needs PAGE_KERNEL_RO, but many
> > architectures don't implement it.  Broke my sparc64 build.
> 
> Some architectures actually cannot implement it even... at least some
> variants of powerpc MMUs don't have a combination of protection bits
> that allow a kernel-only RO mapping (yeah odd).

The simplest perceivable fix, to disable firewire-ohci on architectures
which don't have PAGE_KERNEL_RO, would be bad since there are actually
sparc64 machines with these controllers.

As far as I can tell, the new RO mapping in firewire-ohci can as well be
an r/w mapping.  We just never need to write at these virtual addresses.
So, should we just change the driver to map it r/w when we can't have
PAGE_KERNEL_RO, or for simplicity on all architectures?
-- 
Stefan Richter
-=====-==-== ---= -==-=
http://arcgraph.de/sr/
