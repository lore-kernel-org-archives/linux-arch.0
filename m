From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH 30/60] microblaze_v4: support for a.out
Date: Thu, 26 Jun 2008 17:37:13 +0300
Message-ID: <20080626143713.GE30954@cs181140183.pp.htv.fi>
References: <1214483429-32360-22-git-send-email-monstr@seznam.cz> <1214483429-32360-23-git-send-email-monstr@seznam.cz> <1214483429-32360-24-git-send-email-monstr@seznam.cz> <1214483429-32360-25-git-send-email-monstr@seznam.cz> <1214483429-32360-26-git-send-email-monstr@seznam.cz> <1214483429-32360-27-git-send-email-monstr@seznam.cz> <1214483429-32360-28-git-send-email-monstr@seznam.cz> <1214483429-32360-29-git-send-email-monstr@seznam.cz> <1214483429-32360-30-git-send-email-monstr@seznam.cz> <1214483429-32360-31-git-send-email-monstr@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp4.pp.htv.fi ([213.243.153.38]:52849 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760264AbYFZOjX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jun 2008 10:39:23 -0400
Content-Disposition: inline
In-Reply-To: <1214483429-32360-31-git-send-email-monstr@seznam.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, Michal Simek <monstr@monstr.eu>

On Thu, Jun 26, 2008 at 02:29:59PM +0200, monstr@seznam.cz wrote:
> From: Michal Simek <monstr@monstr.eu>
> 
> 
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> ---
>  0 files changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 include/asm-microblaze/a.out.h
> 
> diff --git a/include/asm-microblaze/a.out.h b/include/asm-microblaze/a.out.h
> new file mode 100644
> index 0000000..e69de29

As of 2.6.26-rc7 you do no longer need this header.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
