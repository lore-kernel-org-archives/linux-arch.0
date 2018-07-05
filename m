Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:52360 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753950AbeGEUeH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Jul 2018 16:34:07 -0400
Date: Thu, 5 Jul 2018 22:33:55 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 3/6] timex: prepare compat helpers for y2038 changes
In-Reply-To: <CABeXuvoXX2=0XrnpDjxu74QBK3zd6qEk46tzYrMuRD+-FKjbZw@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1807052232310.1771@nanos.tec.linutronix.de>
References: <20180703054422.12089-4-deepa.kernel@gmail.com> <201807051322.sUohKhUO%fengguang.wu@intel.com> <CABeXuvoXX2=0XrnpDjxu74QBK3zd6qEk46tzYrMuRD+-FKjbZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: kbuild test robot <lkp@intel.com>, kbuild-all@01.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, y2038 Mailman List <y2038@lists.linaro.org>, linux-arch <linux-arch@vger.kernel.org>, palmer@sifive.com, linux-riscv@lists.infradead.org
Message-ID: <20180705203355.NEMkhvpyWeGLLBvYhTHEen_pE90iCKxCwhYGgbRlJe4@z>

On Thu, 5 Jul 2018, Deepa Dinamani wrote:

> The error is fixed with the following patch that goes in before patch
> 3/6 above in the series.
> Let me know if I should post a v2 instead.
> 
> Thanks,
> Deepa
> 
> 
> commit bfe4b046ed7f01154aef44fcb77d3f172929ccc2
> Author: Deepa Dinamani <deepa.kernel@gmail.com>
> Date:   Thu Jul 5 11:47:25 2018 -0700
> 
>     riscv: Include asm-generic/compat.h
> 
>     riscv does not enable CONFIG_COMPAT in default configurations:
>     defconfig, allmodconfig and nomodconfig.
>     And hence does not inlude definitions for compat data types.
> 
>     Now that time syscalls are being reused in non CONFIG_COMPAT
>     modes, include asm-generic definitions for riscv.
> 
>     Alternative would be to make compat_time.h to be conditional on
>     CONFIG_COMPAT_32BIT_TIME. But, since riscv is already has an
>     asm/compat.h include the generic version instead.
> 
>     Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
>     Cc: palmer@sifive.com
>     Cc: linux-riscv@lists.infradead.org

Post a real patch please instead of something which I have to cleanup
manually. A V2 of the series is probably the simplest way.

Thanks,

	tglx
