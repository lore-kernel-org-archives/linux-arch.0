From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH]arch/csky:Enable the gcov function in csky achitecture
Date: Fri, 13 Mar 2020 00:03:36 +0800
Message-ID: <CAJF2gTRFj=aQYHgM6KV7GYM22Nti8D2q_QNi+5WhOHS9-86Wew@mail.gmail.com>
References: <1583854376-15598-1-git-send-email-majun258@linux.alibaba.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1583854376-15598-1-git-send-email-majun258@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ma Jun <majun258@linux.alibaba.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-csky@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
