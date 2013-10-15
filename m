From: Chris Zankel <chris@zankel.net>
Subject: Re: [PATCH 0/2] xtensa queue 2013/10/15 for 3.12
Date: Tue, 15 Oct 2013 10:58:35 -0700
Message-ID: <525D824B.4020106@zankel.net>
References: <1381789363-2411-1-git-send-email-jcmvbkbc@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:34340 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932878Ab3JOR6i (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Oct 2013 13:58:38 -0400
Received: by mail-pb0-f41.google.com with SMTP id rp2so9200594pbb.28
        for <linux-arch@vger.kernel.org>; Tue, 15 Oct 2013 10:58:37 -0700 (PDT)
In-Reply-To: <1381789363-2411-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Marc Gauthier <marc@tensilica.com>, Baruch Siach <baruch@tkos.co.il>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org

Hi Max,

Thanks for the patches. Is my assumption correct that this fixes memory
faults while in double exception? And, instead of panic-ing, it works
now but registers are likely wrong with ptrace?

Also, should that go in for 3.12 (rc6?) or only in 3.13?

Thanks,
-Chris


On 10/14/2013 03:22 PM, Max Filippov wrote:
> Hi Chris,
>
> could you please push these two fixes to the 3.12?
> One fixes the regression introduced by the a3/excsave conversion in 3.12-rc1,
> and the other fixes use of nonexistent alternative signal stack by threads.
>
> You can pull these changes from my git tree,
> the following changes since commit 61e6cfa80de5760bbe406f4e815b7739205754d2:
>
>   Linux 3.12-rc5 (2013-10-13 15:41:28 -0700)
>
> are available in the git repository at:
>   git://github.com/jcmvbkbc/linux-xtensa.git xtensa-fixes-for-upstream
>
> Baruch Siach (1):
>       xtensa: don't use alternate signal stack on threads
>
> Max Filippov (1):
>       xtensa: fix fast_syscall_spill_registers_fixup
>
>  arch/xtensa/kernel/entry.S  |   49 ++++++++++++++++++++++++++----------------
>  arch/xtensa/kernel/signal.c |    2 +-
>  2 files changed, 31 insertions(+), 20 deletions(-)
>
