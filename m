Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:31483 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbXFKUpn (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jun 2007 16:45:43 -0400
Received: by ug-out-1314.google.com with SMTP id j3so4548ugf
        for <linux-arch@vger.kernel.org>; Mon, 11 Jun 2007 13:45:41 -0700 (PDT)
Date: Tue, 12 Jun 2007 00:52:25 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 1/2] PTRACE_PEEKDATA consolidation
Message-ID: <20070611205225.GE5715@martell.zuzino.mipt.ru>
References: <20070611204006.GC5715@martell.zuzino.mipt.ru> <20070611203517.GA22252@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070611203517.GA22252@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jun 11, 2007 at 09:35:17PM +0100, Christoph Hellwig wrote:
> On Tue, Jun 12, 2007 at 12:40:06AM +0400, Alexey Dobriyan wrote:
> > Identical implementations of PTRACE_PEEKDATA go into
> > simple_ptrace_peekdata() function.
> >
> > compile-tested on ~half of archs, playing with gdb on x86_64.
>
> Looks good.  Why don't you call it generic_ptrace_peekdata instead of
> simple_ptrace_peekdata, though?

Because they're simple :) I was probably spoiled by libfs.c .

