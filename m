Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([69.30.125.51]:54448 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1030348AbWJCRbx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Oct 2006 13:31:53 -0400
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1EF6EB> for <linux-arch@vger.kernel.org> from <davidel@xmailserver.org>;
	Tue, 3 Oct 2006 10:31:51 -0700
Date: Tue, 3 Oct 2006 10:31:47 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: epoll_pwait
In-Reply-To: <20061003002728.01133537.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610031031080.5702@alien.or.mcafeemobile.com>
References: <20061003002728.01133537.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Michael Kerrisk <mtk-manpages@gmx.net>, Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 3 Oct 2006, Andrew Morton wrote:

> 
> 
> I'm about to send this Linuswards.  Architectures which implement
> TIF_RESTORE_SIGMASK can wire it up.
> 
> David, do you have a test app which people can use?

The good&old one :)

http://www.xmailserver.org/epoll_pwait_test.c



- Davide


