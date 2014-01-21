From: Geoff Levand <geoff@infradead.org>
Subject: Re: [PATCH 10/73] powerpc: use device_initcall for registering rtc
 devices
Date: Tue, 21 Jan 2014 15:48:05 -0800
Message-ID: <1390348085.5027.18.camel@smoke>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
	 <1390339396-3479-11-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:41422 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753140AbaAUXsO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jan 2014 18:48:14 -0500
In-Reply-To: <1390339396-3479-11-git-send-email-paul.gortmaker@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org

Hi Paul,

On Tue, 2014-01-21 at 16:22 -0500, Paul Gortmaker wrote:
> Currently these two RTC devices are in core platform code
> where it is not possible for them to be modular.  It will
> never be modular, so using module_init as an alias for
> __initcall can be somewhat misleading.
> 
>  arch/powerpc/kernel/time.c        | 2 +-
>  arch/powerpc/platforms/ps3/time.c | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)

I tested the PS3 part of this patch and it seems to work OK.

Acked-by: Geoff Levand <geoff@infradead.org>
