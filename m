From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH v2] Add preadv and pwritev system calls.
Date: Fri, 12 Dec 2008 08:51:13 -0700
Message-ID: <20081212155113.GO26095@parisc-linux.org>
References: <1229090440-32120-1-git-send-email-kraxel@redhat.com> <20081212152929.GM26095@parisc-linux.org> <494287D4.2070909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:50280 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323AbYLLPvU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Dec 2008 10:51:20 -0500
Content-Disposition: inline
In-Reply-To: <494287D4.2070909@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>

On Fri, Dec 12, 2008 at 04:48:36PM +0100, Gerd Hoffmann wrote:
> Hmm.  It is the argument ordering used by NetBSD, thats why I used that
> too.  It certainly should be the application-visible ordering.  We'll
> have glibc between apps and kernel though, so I think we can reorder the
> arguments at syscall level if that helps on these archs.  Cc'ing Ulrich
> Drepper for comments on that.

On the other hand, NetBSD have approximately 0% market share.
We shouldn't let them lock us into making a bad decision.  Is there
anyone other than NetBSD who has added these syscalls?

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
