Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:47623 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754304AbeCRU0B (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sun, 18 Mar 2018 16:26:01 -0400
Message-ID: <1521404757.27411.46.camel@perches.com>
Subject: Re: [PATCH 00/19] C-SKY(csky) Linux Kernel Port
From: Joe Perches <joe@perches.com>
Date: Sun, 18 Mar 2018 13:25:57 -0700
In-Reply-To: <cover.1521399976.git.ren_guo@c-sky.com>
References: <cover.1521399976.git.ren_guo@c-sky.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Message-ID: <20180318202557.7BxD0MCJffN8wOo2-fRB01PNpx1Ld2nRJZnOUGbdCnc@z>

On Mon, 2018-03-19 at 03:51 +0800, Guo Ren wrote:
> This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> CPU cores and the patches are based on linux-4.16-rc5.
> 
> There are two ABI versions with several CPU cores in this patchset:
>   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
>   ABIv2: ck807 ck810 (16/32-bit variable length instruction, PIPT Cache ...)

[]

> It's my first patchset to linux and any feedback is welcome :)

Hello.  You might try to do a git am <series>
on a new branch and correct the various
git whitespace messages that are produced.

It's also possible to run checkpatch and correct
some of the linux-kernel code style conformance
nits it lists.

Perhaps something like:

$ git ls-files arch/csky/ | \
  while read file ; do \
    ./scripts/checkpatch.pl --strict --terse --no-summary $file ; \
  done

add --fix-inplace to the checkpatch line if desired.
