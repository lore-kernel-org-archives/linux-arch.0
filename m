Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:33061 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032408AbWLGQv4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 Dec 2006 11:51:56 -0500
Received: from localhost.localdomain ([127.0.0.1]:20203 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037734AbWLGQvz (ORCPT <rfc822;linux-arch@vger.kernel.org>
	+ 1 other); Thu, 7 Dec 2006 16:51:55 +0000
Date: Thu, 7 Dec 2006 16:51:42 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061207165142.GA9006@linux-mips.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4577DF5C.5070701@yahoo.com.au>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, Christoph Lameter <clameter@sgi.com>, David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Dec 07, 2006 at 08:31:08PM +1100, Nick Piggin wrote:

> Wrong. Your ll/sc implementation with cmpxchg is buggy. The cmpxchg
> load_locked is not locked at all, and there can be interleaving writes
> between the load and cmpxchg which do not cause the store_conditional
> to fail.
> 
> It might be reasonable to implement this watered down version, but:
> don't some architectures have restrictions on what instructions can
> be issued between the ll and the sc?

On MIPS the restriction is no loads or stores or sync instructions between
ll/sc.  Also there may be at most 2048 bytes between the address of the
ll and sc instructions.  Which means ll/sc sequences should better be
written in assembler or gcc might do a bit too creative things ...

  Ralf
