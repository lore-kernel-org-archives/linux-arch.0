Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from nic.NetDirect.CA ([216.16.235.2]:55651 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754641AbXEGR6b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 May 2007 13:58:31 -0400
Date: Mon, 7 May 2007 13:51:22 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
Subject: Re: [PATCH] Consolidate asm/poll.h
In-Reply-To: <20070507184510.60742ae3.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.64.0705071350480.27625@localhost.localdomain>
References: <20070507184510.60742ae3.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
List-ID: <linux-arch.vger.kernel.org>

On Mon, 7 May 2007, Stephen Rothwell wrote:

> These files are almost all the same.
>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  include/asm-alpha/poll.h   |   26 +-------------------------
>  include/asm-arm/poll.h     |   28 +---------------------------
>  include/asm-arm26/poll.h   |   22 ++--------------------
>  include/asm-avr32/poll.h   |   28 +---------------------------
>  include/asm-cris/poll.h    |   27 +--------------------------
>  include/asm-frv/poll.h     |   18 +++---------------
>  include/asm-generic/Kbuild |    1 +
>  include/asm-generic/poll.h |   37 +++++++++++++++++++++++++++++++++++++
>  include/asm-h8300/poll.h   |   18 +++---------------
>  include/asm-i386/poll.h    |   28 +---------------------------
>  include/asm-ia64/poll.h    |   33 +--------------------------------
>  include/asm-m32r/poll.h    |   33 +--------------------------------
>  include/asm-m68k/poll.h    |   17 +----------------
>  include/asm-mips/poll.h    |   21 +--------------------
>  include/asm-parisc/poll.h  |   28 +---------------------------
>  include/asm-powerpc/poll.h |   25 +------------------------
>  include/asm-s390/poll.h    |   36 +-----------------------------------
>  include/asm-sh/poll.h      |   28 +---------------------------
>  include/asm-sh64/poll.h    |   33 ++-------------------------------
>  include/asm-sparc/poll.h   |   14 +-------------
>  include/asm-sparc64/poll.h |   14 +-------------
>  include/asm-v850/poll.h    |   17 +----------------
>  include/asm-x86_64/poll.h  |   28 +---------------------------
>  include/asm-xtensa/poll.h  |   20 +-------------------
>  24 files changed, 66 insertions(+), 514 deletions(-)
>  create mode 100644 include/asm-generic/poll.h

hey ... if *this* goes in, can i re-try the same thing with ioctl.h?

rday
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
