Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from conssluserg-01.nifty.com ([210.131.2.80]:18616 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbfC3FHD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 Mar 2019 01:07:03 -0400
MIME-Version: 1.0
References: <1553921453-23777-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1553921453-23777-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sat, 30 Mar 2019 14:06:02 +0900
Message-ID: <CAK7LNARmXqLyJ_gvNo_Yh3eivCbzE4n6fE0PYPaXmDnCJksJgw@mail.gmail.com>
Subject: Re: [PATCH] Remove SPDX "WITH Linux-syscall-note" from kernel-space headers
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Andy Gross <andy.gross@linaro.org>, Vitaly Kuznetsov <vkuznets@redhat.com>, Girish Mahadevan <girishm@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>, linux-arch <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Haiyang Zhang <haiyangz@microsoft.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Sasha Levin <sashal@kernel.org>, Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>, linux-hyperv@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Ingo Molnar <mingo@redhat.com>
Message-ID: <20190330050602.VB-suRTinX8cz-MdZAPqILQiZpgS9v2pChaN2aPHSnY@z>

On Sat, Mar 30, 2019 at 1:54 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> The "WITH Linux-syscall-note" should be added to headers exported to
> the user-space.
>
> Some kernel-space headers have "WITH Linux-syscall-note", which seems
> a mistake.
>
> [1] arch/x86/include/asm/hyperv-tlfs.h
>
> 5a4858032217 ("x86/hyper-v: move hyperv.h out of uapi") moved this file
> out of uapi, but missed to update the SPDX License tag.
>
> [2] include/asm-generic/shmparam.h
>
> 76ce2a80a28e ("Rename include/{uapi => }/asm-generic/shmparam.h really")
> moved this file out of uapi, but missed to update the SPDX License tag.
>
> [3] include/linux/qcom-geni-se.h
>
> eddac5af0654 ("soc: qcom: Add GENI based QUP Wrapper driver") added this
> file, but I do now see a good reason why its license tag must include


This is a fatal typo, which makes the meaning opposite.

"I do now see ..." -> "I do not see ..."





> "WITH Linux-syscall-note".
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/x86/include/asm/hyperv-tlfs.h | 2 +-
>  include/asm-generic/shmparam.h     | 2 +-
>  include/linux/qcom-geni-se.h       | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 2bdbbbc..cdf44aa 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: GPL-2.0 */
>
>  /*
>   * This file contains definitions from Hyper-V Hypervisor Top-Level Functional
> diff --git a/include/asm-generic/shmparam.h b/include/asm-generic/shmparam.h
> index 8b78c0b..b8f9035 100644
> --- a/include/asm-generic/shmparam.h
> +++ b/include/asm-generic/shmparam.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef __ASM_GENERIC_SHMPARAM_H
>  #define __ASM_GENERIC_SHMPARAM_H
>
> diff --git a/include/linux/qcom-geni-se.h b/include/linux/qcom-geni-se.h
> index 3bcd67f..dd46494 100644
> --- a/include/linux/qcom-geni-se.h
> +++ b/include/linux/qcom-geni-se.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/* SPDX-License-Identifier: GPL-2.0 */
>  /*
>   * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
>   */
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
