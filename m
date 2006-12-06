Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from omx2-ext.sgi.com ([192.48.171.19]:37911 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937494AbWLFT34 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 6 Dec 2006 14:29:56 -0500
Date: Wed, 6 Dec 2006 11:29:42 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch
 doesn't support it
In-Reply-To: <20061206192647.GW3013@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0612061128340.27363@schroedinger.engr.sgi.com>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org> <20061206192647.GW3013@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>, linux-arm-kernel@lists.arm.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 6 Dec 2006, Matthew Wilcox wrote:

> It's just been pointed out to me that the parisc one isn't safe.
> 
> <dhowells> imagine variable X is set to 3
> <dhowells> CPU A issues cmpxchg(&X, 3, 5)
> <dhowells> you'd expect that to change X to 5
> <dhowells> but what if CPU B assigns 6 to X between cmpxchg reading X
> and it setting X?

The same could happen with a regular cmpxchg. Cmpxchg changes it to 5 and 
then other cpu performs a store before the next instruction.

