From: Scott Lurndal <scott.lurndal@3leafsystems.com>
Subject: Re: [PATCH v2] Add preadv and pwritev system calls.
Date: Fri, 12 Dec 2008 10:29:29 -0800
Message-ID: <20081212182929.GA9631@pendragon.3leafnetworks.com>
References: <1229090440-32120-1-git-send-email-kraxel@redhat.com> <20081212152929.GM26095@parisc-linux.org> <494287D4.2070909@redhat.com> <20081212155113.GO26095@parisc-linux.org> <49428AFD.5090009@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 65-115-68-195.dia.static.qwest.net ([65.115.68.195]:30393 "EHLO
	chronus.3leafnetworks.corp" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757884AbYLLSok (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 12 Dec 2008 13:44:40 -0500
Content-Disposition: inline
In-Reply-To: <49428AFD.5090009@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>

On Fri, Dec 12, 2008 at 05:02:05PM +0100, Gerd Hoffmann wrote:
> Matthew Wilcox wrote:
> > On the other hand, NetBSD have approximately 0% market share.
> > We shouldn't let them lock us into making a bad decision.  Is there
> > anyone other than NetBSD who has added these syscalls?
> 
> Free- and OpenBSD have it too.  For Solaris I've found a feature request
> only.  Dunno about MacOS/Darwin.  Other un*xes which are important these
> days?
> 
> I'd *really* hate it to have the same system call with different
> argument ordering on different systems though.  Especially when swapping
> two integer values, so gcc wouldn't error out on wrong usage.

I would suggest that from the end-users perspective, the user-mode API
should be similar to pread/pwrite, e.g:

    int preadv(fd, iovec, iovec_size, offset)

scott
