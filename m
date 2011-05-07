From: richard -rw- weinberger <richard.weinberger@gmail.com>
Subject: Re: [PATCH] lib: Consolidate DEBUG_STACK_USAGE option
Date: Sat, 7 May 2011 11:34:13 +0200
Message-ID: <BANLkTi=h-151_cMPpii6O+kowvc=0WxKjQ@mail.gmail.com>
References: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
Sender: sparclinux-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, linux-m32r@ml.linux-m32r.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>, user-mode-linux-devel@lists.sourceforge.net, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Sat, May 7, 2011 at 7:57 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Most arches define CONFIG_DEBUG_STACK_USAGE exactly the same way.
> Move it to lib/Kconfig.debug so each arch doesn't have to define
> it. This obviously makes the option generic, but that's fine
> because the config is already used in generic code.
>
> It's not obvious to me that sysrq-P actually does anything
> different with this option enabled, but I erred on the side of
> caution by keeping the most inclusive wording.
>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: uclinux-dist-devel@blackfin.uclinux.org
> Cc: linux-m32r@ml.linux-m32r.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: user-mode-linux-devel@lists.sourceforge.net
> Cc: x86@kernel.org
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Acked-by: Richard Weinberger <richard@nod.at>

-- 
Thanks,
//richard
