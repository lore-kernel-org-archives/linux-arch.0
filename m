Return-Path: <SRS0=zDlA=5F=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38350 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgCTCuD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Mar 2020 22:50:03 -0400
Date: Fri, 20 Mar 2020 12:47:54 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/9] scripts/link-vmlinux.sh: Delay orphan handling
 warnings until final link
References: <20200228002244.15240-1-keescook@chromium.org>
        <20200228002244.15240-2-keescook@chromium.org>
In-Reply-To: <20200228002244.15240-2-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <1584672297.mudnpz3ir9.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@suse.de>, Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, clang-built-linux@googlegroups.com, "H.J. Lu" <hjl.tools@gmail.com>, James Morse <james.morse@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Masahiro Yamada <masahiroy@kernel.org>, Peter Collingbourne <pcc@google.com>, Will Deacon <will@kernel.org>, x86@kernel.org
Message-ID: <20200320024754.xP7o5oKpQLhAIQCAutZsTxLUOT9FvcKkVoeKafm-d1M@z>

Kees Cook's on February 28, 2020 10:22 am:
> Right now, powerpc adds "--orphan-handling=3Dwarn" to LD_FLAGS_vmlinux
> to detect when there are unexpected sections getting added to the kernel
> image. There is no need to report these warnings more than once, so it
> can be removed until the final link stage.
>=20
> This helps pave the way for other architectures to enable this, with the
> end goal of enabling this warning by default for vmlinux for all
> architectures.
>=20
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/link-vmlinux.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 1919c311c149..416968fea685 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -255,6 +255,11 @@ info GEN modules.builtin
>  tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.file=
=3D//p' |
>  	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$/.ko/' > modules.buil=
tin
> =20
> +
> +# Do not warn about orphan sections until the final link stage.
> +saved_LDFLAGS_vmlinux=3D"${LDFLAGS_vmlinux}"
> +LDFLAGS_vmlinux=3D"$(echo "${LDFLAGS_vmlinux}" | sed -E 's/ --orphan-han=
dling=3Dwarn( |$)/ /g')"
> +
>  btf_vmlinux_bin_o=3D""
>  if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
>  	if gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
> @@ -306,6 +311,7 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
>  	fi
>  fi
> =20
> +LDFLAGS_vmlinux=3D"${saved_LDFLAGS_vmlinux}"
>  vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
> =20
>  if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then

That's ugly. Why not just enable it for all archs?

Thanks,
Nick
=
