Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:52853 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965026AbXDAUoL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Apr 2007 16:44:11 -0400
Date: Sun, 1 Apr 2007 14:44:10 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: missing syscalls
Message-ID: <20070401204410.GC826@parisc-linux.org>
References: <20070401191511.GA24987@flint.arm.linux.org.uk> <20070401.122345.123969742.davem@davemloft.net> <20070401200947.GB826@parisc-linux.org> <20070401.131619.94554745.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070401.131619.94554745.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: rmk@arm.linux.org.uk, sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Apr 01, 2007 at 01:16:19PM -0700, David Miller wrote:
> From: Matthew Wilcox <matthew@wil.cx>
> Date: Sun, 1 Apr 2007 14:09:47 -0600
> 
> > I haven't looked at the missing syscall check implementation, but it seems
> > like it's poorly designed if we have to add ifdefs for each arch.  Why not
> > allow arches a mechanism to state which syscalls they intentionally
> > don't implement?
> 
> The whole idea is for the arch's to just find out that a new syscall
> exists when someone adds a new one and some tries a build on that
> platform the next time.  If the arch's still have to do work then the
> whole exercise is pointless.

By and large, the missing syscalls are older ones, eg socketcall or
utime, and they tend to be missing for good reason.  I think it's
entirely appropriate that the arch has to do work when a new syscall is
added -- either implement it, or state that it's not supposed to be
implemented.
