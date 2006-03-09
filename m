Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from detroit.securenet-server.net ([209.51.153.26]:16618 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S1030211AbWCIA7W (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Mar 2006 19:59:22 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
Date: Wed, 8 Mar 2006 16:59:05 -0800
References: <20060308184500.GA17716@devserv.devel.redhat.com> <20060308194037.GO7301@parisc-linux.org> <17423.30924.278031.151438@cargo.ozlabs.ibm.com>
In-Reply-To: <17423.30924.278031.151438@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603081659.05786.jbarnes@virtuousgeek.org>
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>, David Howells <dhowells@redhat.com>, Alan Cox <alan@redhat.com>, akpm@osdl.org, mingo@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wednesday, March 8, 2006 4:37 pm, Paul Mackerras wrote:
> Matthew Wilcox writes:
> > Looking at the SGI implementation, it's smarter than you think. 
> > Looks like there's a register in the local I/O hub that lets you
> > determine when this write has been queued in the appropriate
> > host->pci bridge.
>
> Given that mmiowb takes no arguments, how does it know which is the
> appropriate PCI host bridge?

It uses a per-node address space to reference the local bridge.  The 
local bridge then waits until the remote bridge has acked the write 
before, then sets the outstanding write register to the appropriate 
value.

Jesse
