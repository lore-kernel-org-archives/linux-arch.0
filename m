Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:9920 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030234AbWIETMb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 5 Sep 2006 15:12:31 -0400
Subject: Re: [PATCH 3/9] actual generic PAGE_SIZE infrastructure
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1157478771.3186.30.camel@localhost.localdomain>
References: <20060901190805.C906A21A@localhost.localdomain>
	 <20060901190807.522EDD97@localhost.localdomain>
	 <1157434085.2413.22.camel@shinybook.infradead.org>
	 <1157434669.2413.30.camel@shinybook.infradead.org>
	 <1157478771.3186.30.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 11:39:01 -0700
Message-Id: <1157481541.2477.21.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-09-05 at 10:52 -0700, Dave Hansen wrote:
> On Mon, 2006-09-04 at 22:37 -0700, David Woodhouse wrote:
> > The above can be summarised: In general, please remember to run 
> > 'make headers_install' and check the sanity of the result if you're
> > making changes which are going to affect user-visible headers.
> 
> Did you spot anything that looked like a problem?

I pointed out a few things that looked like a problem in the previous
mail, which I was quoting when I said "the above can be summarised".

I objected to the inclusion of <linux/compiler.h> from outside the
protection of #ifdef __KERNEL__ -- but in fact I was wrong. That one is
automatically stripped out by the export script, which also strips out
all instances of __user etc.

But you are including <asm-generic/page.h> from some places (like
asm-parisc/page.h) without it being in #ifdef __KERNEL__ -- and since
you haven't exported <asm-generic/page.h>, that _isn't_ OK. Admittedly,
we do want <asm/page.h> to stop being exported some time soon -- but we
haven't got there _yet_ so we should refrain from breaking them.

You've got #ifdef __KERNEL__ in your new <asm-generic/page.h> despite
the fact that it isn't exported so can never be compiled without
__KERNEL__ being defined, which seems strange. If you _did_ intend it to
be exported, then you need to add it to the Kbuild file -- and then
it'll be a problem that you're including <linux/align.h> from it -- and
_that_ isn't exported either.

> How do I check the sanity?  Just that none of my headers showed up in
> the new include directory.  Or, if they did, that all of their meat is
> inside of an #ifdef __KERNEL__?

Running e.g. 'make headers_check' should at least do a simple test which
should catch the inclusion of missing files, although I don't think
we've finished making it pass yet for some architectures. In general,
cross-exporting with 'make ARCH=parisc header_check' ought to work
because it shouldn't even require that you actually have a toolchain
installed. 

-- 
dwmw2

