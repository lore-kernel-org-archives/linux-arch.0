From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH v3 0/6] mips: system call table generation support
Date: Thu, 6 Dec 2018 12:15:41 +0000 (GMT)
Message-ID: <alpine.LFD.2.21.1812061209220.7193@eddie.linux-mips.org>
References: <1543481016-18500-1-git-send-email-firoz.khan@linaro.org> <CALxhOnjSEp++W5T3Sf0eX+8hPt08ER22M817M-Vhd24_96a_EQ@mail.gmail.com> <20181205063436.kzxgnvgexcgq572k@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23990828AbeLFMPludY8u (ORCPT
        <rfc822;linux-arch@vger.kernel.org> + 1 other);
        Thu, 6 Dec 2018 13:15:41 +0100
In-Reply-To: <20181205063436.kzxgnvgexcgq572k@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Burton <paul.burton@mips.com>
Cc: Firoz Khan <firoz.khan@linaro.org>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, libc-alpha@sourceware.org
List-Id: linux-arch.vger.kernel.org

On Wed, 5 Dec 2018, Paul Burton wrote:

> > Could you review this patch series. I would appreciate if you can
> > perform the boot test on the actual platform.
> 
> This is looking pretty good to me, so I look forward to v4 with Arnd's
> comments addressed.
> 
> I've verified that the sys call tables are identical for both
> 32r2el_defconfig & 64r6el_defconfig before & after this series, and that
> both still boot fine.

 I believe this file is used by the glibc build process to retrieve 
syscall numbers for glibc's own use as well for <sys/syscall.h>.  Has the 
change been verified not to break this process?

 Cc-ing <libc-alpha@sourceware.org> for information and possible further 
input.

  Maciej
