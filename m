Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:36044 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964828AbXDAUJs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 1 Apr 2007 16:09:48 -0400
Date: Sun, 1 Apr 2007 14:09:47 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: missing syscalls
Message-ID: <20070401200947.GB826@parisc-linux.org>
References: <20070401160123.GA9178@uranus.ravnborg.org> <20070401191511.GA24987@flint.arm.linux.org.uk> <20070401.122345.123969742.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070401.122345.123969742.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: rmk@arm.linux.org.uk, sam@ravnborg.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sun, Apr 01, 2007 at 12:23:45PM -0700, David Miller wrote:
> You should hook both of these syscalls up even if the config option
> that enables them usually is not, or cannot currently be, enabled.
> 
> The cond_syscall()'s will make sure they always link properly and
> provide a -ENOSYS implementation.
> 
> Hooking them up makes it easier to check future missed cases without
> us having to add a plethora of ifdefs to the missing syscall checks
> for each platform.

I haven't looked at the missing syscall check implementation, but it seems
like it's poorly designed if we have to add ifdefs for each arch.  Why not
allow arches a mechanism to state which syscalls they intentionally
don't implement?
