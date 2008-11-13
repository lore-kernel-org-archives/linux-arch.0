Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.235]:8974 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbYKMWC3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Nov 2008 17:02:29 -0500
Received: by rv-out-0506.google.com with SMTP id k40so1084838rvb.1
        for <linux-arch@vger.kernel.org>; Thu, 13 Nov 2008 14:02:28 -0800 (PST)
Message-ID: <cfd18e0f0811131402j7ec6a60cq462916cc9715b9aa@mail.gmail.com>
Date: Thu, 13 Nov 2008 17:02:28 -0500
From: "Michael Kerrisk" <mtk.manpages@googlemail.com>
Reply-To: mtk.manpages@gmail.com
Subject: Re: [PATCH] reintroduce accept4
In-Reply-To: <517f3f820811131351l1305b2d2u43ab4e0601d97f93@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200810261641.m9QGfotr024285@hs20-bc2-1.build.redhat.com>
	 <517f3f820811131351l1305b2d2u43ab4e0601d97f93@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Subrata Modak <subrata@linux.vnet.ibm.com>, linux-arch@vger.kernel.org, Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, linux-api@vger.kernel.org, linux-man@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>, netdev <netdev@vger.kernel.org>, Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@tv-sign.ru>, Christoph Hellwig <hch@lst.de>, David Miller <davem@davemloft.net>, Alan Cox <alan@redhat.com>, Jakub Jelinek <jakub@redhat.com>
Message-ID: <20081113220228.UhiU6uYlrpmUhpzJ-eIa_pAHcbe8Kgt20Y3gSBu1zY8@z>

Hit the send button a little early on my last mail.  Just to complete one piece:

> My only argument is with the name of the new sysytem call.

... Each of these new system calls (accept4(), dup3(), evenfd2(),
signalfd4(), inotify_init1(), epoll_create1(), pipe2()) has a name
that's based on the number of arguments it has.  This follows a
convention that was used in a few traditional Unix system calls, e.g.,
wait3(), wait4(), dup2().  However, it's probably a mistake since:

a) The glibc interfaces can have different numbers of arguments from
the system call

b) In the future, we might use the new bits in the flags argument to
signal the presence of additional arguments for the call, in which
case the number in the name no longer matches the number of arguments
in the call signature.

In the end, names like acceptx(), dupx(), ... or acceptfl(), duplf(),
... or somesuch would probably have been better.  But given that we
already added the other system calls, it doesn't seem worth bothering
to change things for accept4().

Cheers,

Michael
