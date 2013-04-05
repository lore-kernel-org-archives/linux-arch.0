From: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Subject: Re: [PATCH v2 3/4] kprobes: move x86-specific blacklist symbols to
 arch directory
Date: Fri, 05 Apr 2013 11:36:32 +0900
Message-ID: <515E38B0.3000102@hitachi.com>
References: <1365079889-21525-1-git-send-email-oskar.andero@sonymobile.com> <1365079889-21525-4-git-send-email-oskar.andero@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail7.hitachi.co.jp ([133.145.228.42]:47219 "EHLO
	mail7.hitachi.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964821Ab3DECgf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Apr 2013 22:36:35 -0400
In-Reply-To: <1365079889-21525-4-git-send-email-oskar.andero@sonymobile.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oskar Andero <oskar.andero@sonymobile.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, davem@davemloft.net, anil.s.keshavamurthy@intel.com, ananth@in.ibm.com, radovan.lekanovic@sonymobile.com, bjorn.davidsson@sonymobile.com, "yrl.pp-manager.tt@hitachi.com" <yrl.pp-manager.tt@hitachi.com>

(2013/04/04 21:51), Oskar Andero wrote:
> From: Bj=C3=B6rn Davidsson <bjorn.davidsson@sonymobile.com>
>=20
> The common kprobes blacklist contains x86-specific symbols.
> Looking for these in kallsyms takes unnecessary time during startup
> on non-X86 platform. The symbols where moved to
> arch/x86/kernel/kprobes/core.c.

OK, it looks good for me. :)

Acked-by: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>

>=20
> Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: linux-arch@vger.kernel.org
> Reviewed-by: Radovan Lekanovic <radovan.lekanovic@sonymobile.com>
> Signed-off-by: Bj=C3=B6rn Davidsson <bjorn.davidsson@sonymobile.com>
> Signed-off-by: Oskar Andero <oskar.andero@sonymobile.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 6 +++++-
>  kernel/kprobes.c               | 3 ---
>  2 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes=
/core.c
> index 4aa71a5..41ce6c1 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -65,7 +65,11 @@ void jprobe_return_end(void);
>  DEFINE_PER_CPU(struct kprobe *, current_kprobe) =3D NULL;
>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> =20
> -const char * const arch_kprobes_blacksyms[] =3D {};
> +const char * const arch_kprobes_blacksyms[] =3D {
> +	"native_get_debugreg",
> +	"irq_entries_start",
> +	"common_interrupt",
> +};
>  const size_t arch_kprobes_blacksyms_size =3D ARRAY_SIZE(arch_kprobes=
_blacksyms);
> =20
>  #define stack_addr(regs) ((unsigned long *)kernel_stack_pointer(regs=
))
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 7654278..58c9f4e 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -95,9 +95,6 @@ static raw_spinlock_t *kretprobe_table_lock_ptr(uns=
igned long hash)
>   */
>  static const char * const common_kprobes_blacksyms[] =3D {
>  	"preempt_schedule",
> -	"native_get_debugreg",
> -	"irq_entries_start",
> -	"common_interrupt",
>  	"mcount",       /* mcount can be called from everywhere */
>  };
>  static const size_t common_kprobes_blacksyms_size =3D
>=20


--=20
Masami HIRAMATSU
IT Management Research Dept. Linux Technology Center
Hitachi, Ltd., Yokohama Research Laboratory
E-mail: masami.hiramatsu.pt@hitachi.com
