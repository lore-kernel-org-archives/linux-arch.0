From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v2] Add preadv and pwritev system calls.
Date: Fri, 12 Dec 2008 18:21:42 +0000
Message-ID: <20081212182142.46dcf220@lxorguk.ukuu.org.uk>
References: <1229090440-32120-1-git-send-email-kraxel@redhat.com>
	<20081212152929.GM26095@parisc-linux.org>
	<494287D4.2070909@redhat.com>
	<20081212155113.GO26095@parisc-linux.org>
	<49428AFD.5090009@redhat.com>
	<20081212170347.GR26095@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:38016 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758376AbYLLSWJ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Dec 2008 13:22:09 -0500
In-Reply-To: <20081212170347.GR26095@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Gerd Hoffmann <kraxel@redhat.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>

On Fri, 12 Dec 2008 10:03:47 -0700
Matthew Wilcox <matthew@wil.cx> wrote:

> On Fri, Dec 12, 2008 at 05:02:05PM +0100, Gerd Hoffmann wrote:
> > I'd *really* hate it to have the same system call with different
> > argument ordering on different systems though.  Especially when swapping
> > two integer values, so gcc wouldn't error out on wrong usage.
> 
> We can always permute it further:
> 
> int fd, int vlen, loff_t pos, const struct *

Or you could add cobol calling syntax or pass the arguments in XML
format ?

Any particular reason you want to make things hell for programmers and
the standard people. Follow the BSD one at least to user space. Anything
else will just lead to pain and suffering later on the standardisation
front.

Alan
