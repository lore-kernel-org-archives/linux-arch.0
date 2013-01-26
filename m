From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 21/44] metag: Time keeping
Date: Sat, 26 Jan 2013 00:03:43 +0000
Message-ID: <201301260003.43854.arnd@arndb.de>
References: <1357831872-29451-1-git-send-email-james.hogan@imgtec.com> <1357831872-29451-22-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:52865 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab3AZADv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Jan 2013 19:03:51 -0500
In-Reply-To: <1357831872-29451-22-git-send-email-james.hogan@imgtec.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 10 January 2013, James Hogan wrote:
> Add time keeping code for metag. Meta hardware threads have 2 timers.
> The background timer (TXTIMER) is used as a free-running time base, and
> the interrupt timer (TXTIMERI) is used for the timer interrupt. Both
> counters traditionally count at approximately 1MHz.
> 
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> ---
>  arch/metag/include/asm/clock.h     |   51 +++++++++++
>  arch/metag/include/asm/delay.h     |   29 +++++++
>  arch/metag/include/asm/mach/arch.h |    4 +
>  arch/metag/kernel/clock.c          |   53 ++++++++++++
>  arch/metag/kernel/time.c           |  163 ++++++++++++++++++++++++++++++++++++

We are actually moving clocksource drivers to drivers/clocksource
now, maybe you can move this one too.

	Arnd
