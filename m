Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34954 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbdFFK5d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2017 06:57:33 -0400
MIME-Version: 1.0
In-Reply-To: <20170603190102.28866-1-hch@lst.de>
References: <20170603190102.28866-1-hch@lst.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Jun 2017 12:57:11 +0200
Message-ID: <CAK8P3a05TaU_x97+egQHyptPQ5x8iq3=U9PVEwaFfjohJ-pVwg@mail.gmail.com>
Subject: Re: untangle the <asm/siginfo.h> mess
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, "David S. Miller" <davem@davemloft.net>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, linux-arch <linux-arch@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>, linux-ia64@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20170606105711.dIYPZJEIbHfUmTDLgSap38G-bsYjoblZuYU2tbQD5ko@z>

On Sat, Jun 3, 2017 at 9:00 PM, Christoph Hellwig <hch@lst.de> wrote:
> We currently have uapi versions of <asm/siginfo.h> which at least on a few
> architectures define bits of the userspace ABI before including an uapi
> asm-generic version, and also non-uapi versions which do almost nothing
> except for making sure other headers include the right uapi one before
> including an asm-generic that defined two prototypes and a few defines
> that aren't architecture specific in any.
>
> This series completely gets rid of the non-uapi versions and cleans up
> various small bits on the way.
>
> Note that Thomas has some posix-timers work overlapping with this, so
> it might make sense to take these through the tip tree.

Yes, makes sense. For asm-generic:

Acked-by: Arnd Bergmann <arnd@arndb.de>
