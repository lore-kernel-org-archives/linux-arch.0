Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:43435 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846AbXFKUfV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 Jun 2007 16:35:21 -0400
Date: Mon, 11 Jun 2007 21:35:17 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] PTRACE_PEEKDATA consolidation
Message-ID: <20070611203517.GA22252@infradead.org>
References: <20070611204006.GC5715@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070611204006.GC5715@martell.zuzino.mipt.ru>
Sender: linux-arch-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de
List-ID: <linux-arch.vger.kernel.org>

On Tue, Jun 12, 2007 at 12:40:06AM +0400, Alexey Dobriyan wrote:
> Identical implementations of PTRACE_PEEKDATA go into
> simple_ptrace_peekdata() function.
> 
> compile-tested on ~half of archs, playing with gdb on x86_64.

Looks good.  Why don't you call it generic_ptrace_peekdata instead of
simple_ptrace_peekdata, though?

