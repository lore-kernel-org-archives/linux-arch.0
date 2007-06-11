Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from users.ccur.com ([66.10.65.2]:46212 "EHLO gamx.iccur.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754572AbXFKWjg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 11 Jun 2007 18:39:36 -0400
Date: Mon, 11 Jun 2007 17:47:15 -0400
From: Joe Korty <joe.korty@ccur.com>
Subject: Re: [PATCH 1/2] PTRACE_PEEKDATA consolidation
Message-ID: <20070611214715.GA20833@tsunami.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
References: <20070611204006.GC5715@martell.zuzino.mipt.ru> <20070611203517.GA22252@infradead.org> <20070611205225.GE5715@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070611205225.GE5715@martell.zuzino.mipt.ru>
Sender: linux-arch-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jun 12, 2007 at 12:52:25AM +0400, Alexey Dobriyan wrote:
> On Mon, Jun 11, 2007 at 09:35:17PM +0100, Christoph Hellwig wrote:
> > On Tue, Jun 12, 2007 at 12:40:06AM +0400, Alexey Dobriyan wrote:
> > > Identical implementations of PTRACE_PEEKDATA go into
> > > simple_ptrace_peekdata() function.
> > >
> > > compile-tested on ~half of archs, playing with gdb on x86_64.
> >
> > Looks good.  Why don't you call it generic_ptrace_peekdata instead of
> > simple_ptrace_peekdata, though?
> 
> Because they're simple :) I was probably spoiled by libfs.c .

The problem with names like 'simple_*' is that, as the years go by,
simple code grows to become complex code, and then the prefix 'simple'
doesn't apply anymore.

Regards,
Joe
