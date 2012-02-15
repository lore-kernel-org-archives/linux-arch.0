From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH 08/40] cris: Use set_current_blocked() and
	block_sigmask()
Date: Wed, 15 Feb 2012 09:43:54 +0100
Message-ID: <20120215084354.GD8176@axis.com>
References: <1329219673-28711-1-git-send-email-matt@console-pimps.org> <1329219673-28711-9-git-send-email-matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from anubis.se.axis.com ([195.60.68.12]:47089 "EHLO
	anubis.se.axis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757525Ab2BOIoB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Feb 2012 03:44:01 -0500
Content-Disposition: inline
In-Reply-To: <1329219673-28711-9-git-send-email-matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matt Fleming <matt.fleming@intel.com>, Mikael Starvik <starvik@axis.com>, linux-cris-kernel <linux-cris-kernel@axis.com>

On Tue, Feb 14, 2012 at 12:40:41PM +0100, Matt Fleming wrote:
> From: Matt Fleming <matt.fleming@intel.com>
> 
> As described in e6fa16ab ("signal: sigprocmask() should do
> retarget_shared_pending()") the modification of current->blocked is
> incorrect as we need to check whether the signal we're about to block
> is pending in the shared queue.
> 
> Also, use the new helper function introduced in commit 5e6292c0f28f
> ("signal: add block_sigmask() for adding sigmask to current->blocked")
> which centralises the code for updating current->blocked after
> successfully delivering a signal and reduces the amount of duplicate
> code across architectures. In the past some architectures got this
> code wrong, so using this helper function should stop that from
> happening again.
> 
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Mikael Starvik <starvik@axis.com>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Cc: linux-cris-kernel@axis.com
> Signed-off-by: Matt Fleming <matt.fleming@intel.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
