Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:35603 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802AbXFRFmR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 18 Jun 2007 01:42:17 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18038.6658.854660.4233@cargo.ozlabs.ibm.com>
Date: Mon, 18 Jun 2007 15:37:06 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Wire up sys_sync_file_range() on powerpc
In-Reply-To: <1182018044.2808.75.camel@pmac.infradead.org>
References: <1181992681.25228.683.camel@pmac.infradead.org>
	<1182018044.2808.75.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, rmk@arm.linux.org.uk, torvalds@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Woodhouse writes:

> Pants.

Ah.  Is that a naughty word in the UK?  If so I'll have to remember
that when I go to kernel summit. :)

> It doesn't work because the 'flags' argument ends up in r9, and
> we can only use r3-r8 for syscall arguments. We'll need to do it the
> same way as ARM does, with the flags as the second argument.

Yes.  We'll need a wrapper for both 32-bit and for 32-on-64.

> Or is it? Can we ditch sys_sync_file_range now and implement a new
> sys_sync_file_range2 with the two 32-bit arguments first?

Would be nice...

Paul.
