Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:30922 "EHLO smtp.ocgnet.org")
	by vger.kernel.org with ESMTP id S932420AbWIQMvO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 17 Sep 2006 08:51:14 -0400
Date: Sun, 17 Sep 2006 21:51:10 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: All arch maintainers: 'make headers_check' fails on most architectures.
Message-ID: <20060917125110.GA21192@localhost.usen.ad.jp>
References: <1158079495.9189.125.camel@hades.cambridge.redhat.com> <1158478779.24527.209.camel@pmac.infradead.org> <20060917115137.GA19084@localhost.usen.ad.jp> <1158495004.24527.236.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158495004.24527.236.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-arch@vger.kernel.org, drepper@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Sun, Sep 17, 2006 at 01:10:04PM +0100, David Woodhouse wrote:
> A bunch of architectures define it as PAGE_SIZE anyway, which is broken
> when PAGE_SIZE gets killed off -- which we're doing either because it's
> dynamic on the arch in question or just because we're killing it on a
> bunch of architectures so we should kill it on all for consistency.
> Userspace needs to learn to use getpagesize() or sysconf(_SC_PAGE_SIZE).
> 
The other thing I forgot to mention is that PAGE_SIZE is really the
wrong thing here anyways. On the systems with an aliasing dcache, it's
the 4k pages that are generally the problem. On those platforms you can
still switch to larger page sizes and then not have to worry about it.

So something like:

> Hm, is there a sysconf(_SC_SHMLBA) ?

would be much more useful. This would stop userspace libc's from doing
things like #define SHMLBA (getpagesize() * 4)..

In the 4k PAGE_SIZE case you still need the dcache specifics to figure
out whether to bump up SHMLBA or not. So you either go with the safe
route of using a "big enough" size that covers the worst-case aliasing
scenario, or find a way to do it at run-time (ie, via the auxvt or
_SC_SHMLBA).
