Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.210]:37938 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031467AbXD3JWL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 30 Apr 2007 05:22:11 -0400
Date: Mon, 30 Apr 2007 11:22:00 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: utrace comments
Message-ID: <20070430092200.GA15773@lst.de>
References: <20061127165138.GA2991@lst.de> <20070430040213.BF9901801A4@magilla.sf.frob.com> <20070430090840.GB31397@infradead.org> <20070430091808.GA11345@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070430091808.GA11345@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Roland McGrath <roland@redhat.com>, Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, Apr 30, 2007 at 10:18:09AM +0100, Russell King wrote:
> Roland's idea of single-stepping is that it *must* be supported by
> hardware for utrace to use it.  There are a number of architectures
> which can only do single-stepping by modifying the text of the
> program being single stepped.  ARM is one such example.
> 
> As such, even when utrace is complete, some architectures will never
> support in-kernel single step with utrace.  I believe Roland's idea
> is to have single step supported on these via some vapourware userspace
> library.

Does the current arm ptrace code support single stepping in kernelspace?
If yes we absolutely need to continue to support it.

> I'd also like to see utrace become *optional*
> for architectures to support, rather than as it currently stands as
> a *mandatory* requirement when merged.

No way we'd keep both the old ptrace mess and utrace in the same tree.

