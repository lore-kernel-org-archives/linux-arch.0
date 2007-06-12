Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45015 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752806AbXFLTwx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 12 Jun 2007 15:52:53 -0400
Date: Tue, 12 Jun 2007 12:51:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/2] PTRACE_PEEKDATA consolidation
Message-Id: <20070612125107.39ebe266.akpm@linux-foundation.org>
In-Reply-To: <20070611205225.GE5715@martell.zuzino.mipt.ru>
References: <20070611204006.GC5715@martell.zuzino.mipt.ru>
	<20070611203517.GA22252@infradead.org>
	<20070611205225.GE5715@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de
List-ID: <linux-arch.vger.kernel.org>

On Tue, 12 Jun 2007 00:52:25 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

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

Yeah, generic_* would be more typical.  I edited the diffs...

Thanks.
