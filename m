Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:54679 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932578AbeCSLDN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Mar 2018 07:03:13 -0400
Date: Mon, 19 Mar 2018 19:03:02 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 02/19] csky: Exception handling and syscall
Message-ID: <20180319110302.GA15454@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <fe603a94a7755528ff6f5ac288a017e2a20071c4.1521399976.git.ren_guo@c-sky.com>
 <20180319085009.GA32603@isilmar-4.linta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319085009.GA32603@isilmar-4.linta.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Message-ID: <20180319110302.kny8_lD_26vu9D2xDeqtxS7ELQX0SJvFtzzU4lMbuYA@z>

Hi Dominik,

On Mon, Mar 19, 2018 at 09:50:09AM +0100, Dominik Brodowski wrote:
> > +#define __ARCH_WANT_SYSCALL_DEPRECATED
> > +#define __ARCH_WANT_SYSCALL_OFF_T
> > +#define __ARCH_WANT_SYSCALL_NO_AT
> > +#define __ARCH_WANT_SYSCALL_NO_FLAGS
> 
> Does this arch *really* want these deprecated and obsolete syscalls? See the
> commend in include/uapi/asm-generic/unistd.h
> 
>  * All syscalls below here should go away really,
>  * these are provided for both review and as a porting
>  * help for the C library version.
> 
OK, I will cleanup them next and check the unistd.h again.

Best Regards
  Guo Ren
