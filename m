Return-Path: <SRS0=UTne=45=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgCLQDu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Mar 2020 12:03:50 -0400
MIME-Version: 1.0
References: <1583854376-15598-1-git-send-email-majun258@linux.alibaba.com>
In-Reply-To: <1583854376-15598-1-git-send-email-majun258@linux.alibaba.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 13 Mar 2020 00:03:36 +0800
Message-ID: <CAJF2gTRFj=aQYHgM6KV7GYM22Nti8D2q_QNi+5WhOHS9-86Wew@mail.gmail.com>
Subject: Re: [PATCH]arch/csky:Enable the gcov function in csky achitecture
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ma Jun <majun258@linux.alibaba.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org
Message-ID: <20200312160336.nhH4ZOxOhvVvyG7A3CRG1UU55OEhLO4BSPW70Is55rw@z>

Acked-by: Guo Ren <guoren@kernel.org>

On Thu, Mar 12, 2020 at 4:59 PM Ma Jun <majun258@linux.alibaba.com> wrote:
>
> Support the gcov function in csky architecture
>
> Signed-off-by: Ma Jun <majun258@linux.alibaba.com>
> ---
>  arch/csky/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
> index 047427f..9c4749d 100644
> --- a/arch/csky/Kconfig
> +++ b/arch/csky/Kconfig
> @@ -64,6 +64,7 @@ config CSKY
>         select PCI_DOMAINS_GENERIC if PCI
>         select PCI_SYSCALL if PCI
>         select PCI_MSI if PCI
> +       select ARCH_HAS_GCOV_PROFILE_ALL
>
>  config CPU_HAS_CACHEV2
>         bool
> --
> 1.8.3.1
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
