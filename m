Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from jurassic.park.msu.ru ([195.208.223.243]:56685 "EHLO
	jurassic.park.msu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934091AbYBMVsP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 13 Feb 2008 16:48:15 -0500
Date: Thu, 14 Feb 2008 00:18:54 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: [RFC][PATCH 2/2] xtime_lock vs update_process_times
Message-ID: <20080213211854.GA2853@jurassic.park.msu.ru>
References: <20080128103953.326762000@chello.nl> <20080128104056.184943000@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080128104056.184943000@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: rth@twiddle.net, rmk@arm.linux.org.uk, bryan.wu@analog.com, dhowells@redhat.com, gerg@uclinux.org, lethal@linux-sh.org, wli@holomorphy.com, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu, torvalds@linux-foundation.org

On Mon, Jan 28, 2008 at 11:39:55AM +0100, Peter Zijlstra wrote:
> move update_process_times() out from under xtime_lock.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> ---
>  arch/alpha/kernel/time.c              |   15 ++++++++-------

This indeed fixes deadlock on alpha, so this part

Acked-by: Ivan Kokshaysky <ink@jurassic.park.msu.ru>

Ivan.
