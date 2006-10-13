Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from x35.xmailserver.org ([69.30.125.51]:62687 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id S1751357AbWJMAG6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Oct 2006 20:06:58 -0400
Received: from alien.or.mcafeemobile.com
	by xmailserver.org with [XMail 1.23 ESMTP Server]
	id <S1F3B12> for <linux-arch@vger.kernel.org> from <davidel@xmailserver.org>;
	Thu, 12 Oct 2006 17:06:55 -0700
Date: Thu, 12 Oct 2006 17:03:22 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
Subject: Re: epoll_pwait
In-Reply-To: <1159864949.3438.55.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.64.0610121658000.10088@alien.or.mcafeemobile.com>
References: <20061003002728.01133537.akpm@osdl.org>
 <1159862233.3438.45.camel@pmac.infradead.org> <1159864949.3438.55.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org, Michael Kerrisk <mtk-manpages@gmx.net>, Ulrich Drepper <drepper@redhat.com>, Roland McGrath <roland@redhat.com>, paulus@samba.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 12 Oct 2006, David Woodhouse wrote:

> On Tue, 2006-10-03 at 08:57 +0100, David Woodhouse wrote:
> > On Tue, 2006-10-03 at 00:27 -0700, Andrew Morton wrote:
> > > 
> > > I'm about to send this Linuswards.  Architectures which implement
> > > TIF_RESTORE_SIGMASK can wire it up.
> > 
> > It needs compat_sys_epoll_wait() for the signal stuff though.
> 
> Something like the patch below ought to suffice, although it's not
> tested further than just building it.

I was thinking about adding epoll compat functions to compat.c, but at the 
end the only user would have been IA64. Also, epoll_pwait has two 
structures that needs to be filtered, sigset_t (for every 64 bits archs) 
and epoll_event (only for IA64 ATM). And this would require two 
compat_epoll_pwait. At the end, I'm ok with David's patch.


Acked-by: Davide Libenzi <davidel@xmailserver.org>



- Davide


