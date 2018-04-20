From: Mathieu Malaterre <malat@debian.org>
Subject: Re: [PATCH 0/4] LD_DEAD_CODE_DATA_ELIMINATION fixes and enabling for
 powerpc
Date: Fri, 20 Apr 2018 11:59:56 +0200
Message-ID: <CA+7wUsz37qQCngaMMo2S6SRa6M-F4u_inyborA7zLf+-oSPMpA@mail.gmail.com>
References: <20180420073414.23169-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <20180420073414.23169-1-npiggin@gmail.com>
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
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Nicolas Pitre <nico@fluxnic.net>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 20, 2018 at 9:34 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> A few people have been interested in this again. And I promised
> if it remains dead code it should be removed, so I would like to
> have another try.
>
> I think I got snagged on the modules problem last time and did
> not take the time to work it out, this time I just turned off the
> compile options for modules (the linker option was never set anyway
> so no loss).
>
> This includes some linker script catches and ideas from others, I
> didn't documnt them all, but thanks for looking.

This series works for me. v2 from Christophe was triggering a kernel
panic (call stack mentioned set_pte_at...).

So if needed:

Tested-by: Mathieu Malaterre <malat@debian.org>

Env: Mac Mini G4, with custom config.

> I would be interested to help other archs get this working too, if
> anybody needs some help.
>
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
