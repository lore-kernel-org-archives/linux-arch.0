Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:56821 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161103AbXBTX6G (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 20 Feb 2007 18:58:06 -0500
Date: Tue, 20 Feb 2007 15:57:12 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 18/50] add epoll compat code to kernel/compat.c
Message-Id: <20070220155712.7b355161.akpm@linux-foundation.org>
In-Reply-To: <20070221102027.52bf703a.sfr@canb.auug.org.au>
References: <200702202159.l1KLxMcC021074@shell0.pdx.osdl.net>
	<20070221102027.52bf703a.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: torvalds@linux-foundation.org, davidel@xmailserver.org, dwmw2@infradead.org, linux-arch@vger.kernel.org, rmk@arm.linux.org.uk, tony.luck@intel.com
List-ID: <linux-arch.vger.kernel.org>

On Wed, 21 Feb 2007 10:20:27 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> On Tue, 20 Feb 2007 13:57:58 -0800 akpm@linux-foundation.org wrote:
> >
> > From: Davide Libenzi <davidel@xmailserver.org>
> >
> > Add epoll compat_ code to kernel/compat.c.  IA64 and ARM-OABI are currently
> > using their own version of epoll compat_ code and they could probably wire to
> > the new common code.
> 
> So did you just ignore the discussion that went on about this patch and
> the suggestions made (by me) and accepted by the author?

That was a week ago and it's all gone quiet, so I guess I assumed we're good to go.

> Nacked-by: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Whatever that means.

OK, I'll drop it.
