From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 20/40] mn10300: Use set_current_blocked() and block_sigmask()
Date: Tue, 14 Feb 2012 15:56:16 +0000
Message-ID: <17603.1329234976@redhat.com>
References: <1329219673-28711-21-git-send-email-matt@console-pimps.org> <1329219673-28711-1-git-send-email-matt@console-pimps.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37557 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750887Ab2BNP4h (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Feb 2012 10:56:37 -0500
In-Reply-To: <1329219673-28711-21-git-send-email-matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-am33-list@redhat.com

Matt Fleming <matt@console-pimps.org> wrote:

>  asmlinkage long sys_sigsuspend(int history0, int history1, old_sigset_t mask)
>  {
> -	mask &= _BLOCKABLE;
> -	spin_lock_irq(&current->sighand->siglock);
> +	sigset_t blocked;
> +
>  	current->saved_sigmask = current->blocked;

Can this line create a race, now that it's not protected by a lock?  It is
possible for current->blocked to get altered by another thread.

David
