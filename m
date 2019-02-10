Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:37315 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfBJU1F (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 10 Feb 2019 15:27:05 -0500
Date: Sun, 10 Feb 2019 21:27:01 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [GIT PULL 1/2] arch: System call unification and cleanup
In-Reply-To: <CAK8P3a3pPwnOW7pXjOhU386zCekAda+p8AgzbOM6ybT=dKMGwA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1902102125410.8784@nanos.tec.linutronix.de>
References: <CAK8P3a3pPwnOW7pXjOhU386zCekAda+p8AgzbOM6ybT=dKMGwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190210202701.xRxwybepKShoxtqDJ-CscnXkmnO0OanaKr7MfvOn0YI@z>

On Sat, 9 Feb 2019, Arnd Bergmann wrote:

> The following changes since commit 1c7fc5cbc33980acd13d668f1c8f0313d6ae9fd8:
> 
>   Linux 5.0-rc2 (2019-01-14 10:41:12 +1200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org:/pub/scm/linux/kernel/git/arnd/playground.git
> tags/y2038-syscall-cleanup

Went over the lot with a fine comb. This looks really good. Nice work!

Pulled into tip timers/2038

Thanks,

	tglx
