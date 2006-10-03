Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:1940 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965452AbWJCH5Q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Oct 2006 03:57:16 -0400
Subject: Re: epoll_pwait
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20061003002728.01133537.akpm@osdl.org>
References: <20061003002728.01133537.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 03 Oct 2006 08:57:13 +0100
Message-Id: <1159862233.3438.45.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org, Davide Libenzi <davidel@xmailserver.org>, Michael Kerrisk <mtk-manpages@gmx.net>, Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>
List-ID: <linux-arch.vger.kernel.org>

On Tue, 2006-10-03 at 00:27 -0700, Andrew Morton wrote:
> 
> I'm about to send this Linuswards.  Architectures which implement
> TIF_RESTORE_SIGMASK can wire it up.

It needs compat_sys_epoll_wait() for the signal stuff though.

Given the horridness in the definition of 'struct epoll_event', I'm not
finding it easy to convince myself that we don't need compat versions of
other epoll syscalls, but I have a vague recollection that we looked at
this before and it's OK -- i386 is the only 32-bit architecture which
lets the u64 be non-64-bit-aligned? Could do with a better comment
though.

-- 
dwmw2

