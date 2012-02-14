From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 20/40] mn10300: Use set_current_blocked() and
	block_sigmask()
Date: Tue, 14 Feb 2012 18:23:40 +0100
Message-ID: <20120214172340.GA22645@redhat.com>
References: <1329219673-28711-21-git-send-email-matt@console-pimps.org> <1329219673-28711-1-git-send-email-matt@console-pimps.org> <17603.1329234976@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38333 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754002Ab2BNRa1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Feb 2012 12:30:27 -0500
Content-Disposition: inline
In-Reply-To: <17603.1329234976@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Matt Fleming <matt@console-pimps.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-am33-list@redhat.com

On 02/14, David Howells wrote:
>
> Matt Fleming <matt@console-pimps.org> wrote:
>
> >  asmlinkage long sys_sigsuspend(int history0, int history1, old_sigset_t mask)
> >  {
> > -	mask &= _BLOCKABLE;
> > -	spin_lock_irq(&current->sighand->siglock);
> > +	sigset_t blocked;
> > +
> >  	current->saved_sigmask = current->blocked;
>
> Can this line create a race, now that it's not protected by a lock?  It is
> possible for current->blocked to get altered by another thread.

No, only current can change ->blocked. This is even documented in
sigprocmask(). And more, the only correct way to change ->blocked
is set_current_blocked(). OK, with a couple of "I know what I am
doing" exceptions in kernel/signal.c.

Oleg.
