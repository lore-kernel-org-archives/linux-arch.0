Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:40624 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756416Ab2CSGqQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 19 Mar 2012 02:46:16 -0400
Received: by wibhj6 with SMTP id hj6so3369998wib.1
        for <linux-arch@vger.kernel.org>; Sun, 18 Mar 2012 23:46:14 -0700 (PDT)
Message-ID: <4F66D632.5070107@monstr.eu>
Date: Mon, 19 Mar 2012 07:46:10 +0100
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
Subject: Re: [PATCH] Kbuild: centralize MKIMAGE and cmd_uimage definitions
References: <1331931835-12346-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1331931835-12346-1-git-send-email-swarren@wwwdotorg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Michal Marek <mmarek@suse.cz>, Russell King <linux@arm.linux.org.uk>, nico@fluxnic.net, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, microblaze-uclinux@itee.uq.edu.au, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20120319064610.RFGiIebG1SjikZb0xCpupum5fSmvHPu4lE-Pe7jKWQI@z>

Stephen Warren wrote:
> All ARCHs have the same definition of MKIMAGE. Move it to Makefile.lib
> to avoid duplication.
> 
> All ARCHs have similar definitions of cmd_uimage. Place a sufficiently
> parameterized version in Makefile.lib to avoid duplication.
> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> v2:
> * Fix blackfin's UIMAGE_LOADADDR in the ROMKERNEL case.
> * Fix missing ) on a variable reference in avr32 and sparc.
> * Only set those UIMAGE_* variables that the arch-specific Makefile hasn't
>   already set.
> * The patch series is now just this single patch which removes duplication;
>   I've dropped the Kconfig feature to allow use of -T kernel_noload for
>   now, since it looks like U-Boot is gaining direct zImage support.
> 
>  arch/arm/boot/Makefile          |   23 +++++++++--------------
>  arch/avr32/boot/images/Makefile |    9 +++------
>  arch/blackfin/boot/Makefile     |   19 ++++++++-----------
>  arch/microblaze/boot/Makefile   |   10 +++-------
>  arch/sh/boot/Makefile           |    8 ++------
>  arch/sparc/boot/Makefile        |    9 +++------
>  arch/unicore32/boot/Makefile    |   12 ++----------
>  scripts/Makefile.lib            |   24 ++++++++++++++++++++++++
>  8 files changed, 54 insertions(+), 60 deletions(-)

No problem for Microblaze.

Tested-by: Michal Simek <monstr@monstr.eu>

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
