Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34286 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754531AbeCSHL1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 19 Mar 2018 03:11:27 -0400
Date: Mon, 19 Mar 2018 15:11:08 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 00/19] C-SKY(csky) Linux Kernel Port
Message-ID: <20180319071107.GD21923@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <1521404757.27411.46.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521404757.27411.46.camel@perches.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Message-ID: <20180319071108.kUraJtYTIA97OCHiQ1cdg8HWWTj9H8tSFdDmnq77jEo@z>

Thx Joe,

On Sun, Mar 18, 2018 at 01:25:57PM -0700, Joe Perches wrote:
> On Mon, 2018-03-19 at 03:51 +0800, Guo Ren wrote:
> > This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> > CPU cores and the patches are based on linux-4.16-rc5.
> > 
> > There are two ABI versions with several CPU cores in this patchset:
> >   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
> >   ABIv2: ck807 ck810 (16/32-bit variable length instruction, PIPT Cache ...)
> 
> []
> 
> > It's my first patchset to linux and any feedback is welcome :)
> 
> Hello.  You might try to do a git am <series>
> on a new branch and correct the various
> git whitespace messages that are produced.
> 
> It's also possible to run checkpatch and correct
> some of the linux-kernel code style conformance
> nits it lists.
> 
> Perhaps something like:
> 
> $ git ls-files arch/csky/ | \
>   while read file ; do \
>     ./scripts/checkpatch.pl --strict --terse --no-summary $file ; \
>   done
> 
> add --fix-inplace to the checkpatch line if desired.

OK

Best Regards
 Guo Ren
