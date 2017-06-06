From: Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH 0/4][V3] Improve watchdog config for arch watchdogs
Date: Tue, 6 Jun 2017 12:08:47 -0400
Message-ID: <20170606160847.izishwer3m5jirkb@redhat.com>
References: <20170530012659.16791-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45574 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751388AbdFFQIt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jun 2017 12:08:49 -0400
Content-Disposition: inline
In-Reply-To: <20170530012659.16791-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, babu.moger@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

(adding Babu)

On Tue, May 30, 2017 at 11:26:55AM +1000, Nicholas Piggin wrote:
> Since last time:
> 
> - Have the perf based hardlockup detector use arch_touch_nmi_watchdog()
>   rather than hld_touch_nmi_watchdog(). This changes direction slightly
>   to make the perf-based hard lockup detector an alternative that an
>   arch may select, rather than standalone. This better reflects how the
>   code works in practice).
> 
> - Hopefully fixed the Kconfig options. There's still a bit of ugliness
>   that will require another pass or two over interfaces and config
>   scheme, but the idea is to make a minimal change to get the powerpc
>   HLD in, which gives a reasonable starting point to improve things
>   further.

Hi Babu,

Does this patchset break sparc?  Specifically patch3 with all the config
option changes?

Cheers,
Don

> 
> Nicholas Piggin (4):
>   watchdog: remove unused declaration
>   watchdog: Introduce arch_touch_nmi_watchdog()
>   watchdog: Split up config options
>   watchdog: Provide watchdog_reconfigure() for arch watchdogs
> 
>  arch/blackfin/include/asm/nmi.h            |   2 +
>  arch/blackfin/kernel/nmi.c                 |   2 +-
>  arch/mn10300/include/asm/nmi.h             |   2 +
>  arch/mn10300/kernel/mn10300-watchdog-low.S |   8 +-
>  arch/mn10300/kernel/mn10300-watchdog.c     |   2 +-
>  arch/powerpc/kernel/setup_64.c             |   2 +-
>  arch/sparc/include/asm/nmi.h               |   1 +
>  arch/sparc/kernel/nmi.c                    |   6 +-
>  arch/x86/kernel/apic/hw_nmi.c              |   2 +-
>  include/linux/nmi.h                        |  57 ++++---
>  kernel/Makefile                            |   2 +-
>  kernel/sysctl.c                            |  18 +-
>  kernel/watchdog.c                          | 263 +++++++++++++++++++----------
>  kernel/watchdog_hld.c                      |  37 +---
>  lib/Kconfig.debug                          |  29 +++-
>  15 files changed, 263 insertions(+), 170 deletions(-)
> 
> -- 
> 2.11.0
> 
