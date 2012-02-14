From: Mark Salter <msalter@redhat.com>
Subject: Re: [PATCH 00/40] arch: set_current_blocked() and block_sigmask()
Date: Tue, 14 Feb 2012 08:45:01 -0500
Message-ID: <1329227102.2395.58.camel@deneb.redhat.com>
References: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32219 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755040Ab2BNNpK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Feb 2012 08:45:10 -0500
In-Reply-To: <1329219673-28711-1-git-send-email-matt@console-pimps.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-arch@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt Fleming <matt.fleming@intel.com>

On Tue, 2012-02-14 at 11:40 +0000, Matt Fleming wrote:
> From: Matt Fleming <matt.fleming@intel.com>
> 
> This series simplifies the architecture code for handling signals by
> making use of set_current_blocked() introduced in e6fa16ab ("signal:
> sigprocmask() should do retarget_shared_pending()") and
> block_sigmask() introduced in commit 5e6292c0f28f ("signal: add
> block_sigmask() for adding sigmask to current->blocked").
> 
...
> Matt Fleming (39):
...
>   C6X: Use set_current_blocked() and block_sigmask()
...
>  arch/c6x/kernel/signal.c           |   16 ++----------

The c6x patch seems to be missing from the series.

--Mark
