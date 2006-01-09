Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:50073 "EHLO
	palinux.hppa") by vger.kernel.org with ESMTP id S964770AbWAIMTe
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 9 Jan 2006 07:19:34 -0500
Date: Mon, 9 Jan 2006 05:19:34 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Adding compat_ptrace_request
Message-ID: <20060109121934.GM19769@parisc-linux.org>
References: <20060109065914.GS26499@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109065914.GS26499@krispykreme>
Sender: linux-arch-owner@vger.kernel.org
To: Anton Blanchard <anton@samba.org>
Cc: linux-arch@vger.kernel.org, sfr@canb.auug.org.au
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jan 09, 2006 at 05:59:14PM +1100, Anton Blanchard wrote:
> 
> Hi,
> 
> We noticed 32/64bit compat issues with GETSIGINFO and SETSIGINFO. It
> looks like s390 are already fixing this up in architecture specific
> code, but here is a patch from Stephen Rothwell to add some generic
> compat ptrace helpers.

I think this patch:

http://www.ussg.iu.edu/hypermail/linux/kernel/0601.1/0166.html

makes your patch obsolete ...

although it only handles setsiginfo; should be a one-liner to add
getsiginfo too.
