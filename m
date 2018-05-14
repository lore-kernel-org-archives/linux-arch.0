From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 0/4] LD_DEAD_CODE_DATA_ELIMINATION fixes and enabling
 for powerpc
Date: Mon, 14 May 2018 09:08:52 +0900
Message-ID: <CAK7LNARVkvM1deFGbdnaTt41hDqV9pCZ1+OCB0dCqPgspLMVPw@mail.gmail.com>
References: <20180509130001.24276-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20180509130001.24276-1-npiggin@gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

2018-05-09 21:59 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> v2 changes only patch 4, updates the changelog with ppc32 numbers and
> Tested-by tags, and also use TEXT_MAIN in the linker script as
> Christophe suggested.


Replaced with v2.
Thanks!


> Thanks,
> Nick
>
> Nicholas Piggin (4):
>   kbuild: Fix asm-generic/vmlinux.lds.h for
>     LD_DEAD_CODE_DATA_ELIMINATION
>   kbuild: LD_DEAD_CODE_DATA_ELIMINATION no
>     -ffunction-sections/-fdata-sections for module build
>   kbuild: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selectable if
>     enabled
>   powerpc: Allow LD_DEAD_CODE_DATA_ELIMINATION to be selected
>
>  Makefile                          |  4 +--
>  arch/Kconfig                      | 15 ----------
>  arch/powerpc/Kconfig              |  1 +
>  arch/powerpc/kernel/vmlinux.lds.S | 22 +++++++-------
>  include/asm-generic/vmlinux.lds.h | 49 ++++++++++++++++++-------------
>  init/Kconfig                      | 27 +++++++++++++++++
>  6 files changed, 70 insertions(+), 48 deletions(-)
>
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
