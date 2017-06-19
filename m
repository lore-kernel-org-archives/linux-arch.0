From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 4/5] x86/um: thin archives build fix
Date: Mon, 19 Jun 2017 15:21:00 +0900
Message-ID: <CAK7LNAT4v3h=eaG5nyCCZCP1o9yPkJWAXny9zvSa+Z0Q89=9Zw@mail.gmail.com>
References: <20170609052417.561-1-npiggin@gmail.com> <20170609052417.561-5-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20170609052417.561-5-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-Id: linux-arch.vger.kernel.org

2017-06-09 14:24 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> The linker does not like vdso-syms.lds in input archive files.
> Make it an extra-y instead.
>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: user-mode-linux-devel@lists.sourceforge.net
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>
> Arch maintainers please give an ack if we can take this through
> the kbuild tree.
>
> Thanks,
> Nick
>
>  arch/x86/um/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
> index d72dec406ccb..329406224330 100644
> --- a/arch/x86/um/vdso/Makefile
> +++ b/arch/x86/um/vdso/Makefile
> @@ -53,7 +53,7 @@ CFLAGS_REMOVE_vdso-note.o = -pg -fprofile-arcs -ftest-coverage
>  CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
>
>  targets += vdso-syms.lds
> -obj-$(VDSO64-y)                        += vdso-syms.lds
> +extra-$(VDSO64-y)                      += vdso-syms.lds


I agree this line is weird, but where is vdso-syms.lds used?


I removed the following, but it still built successfully.


targets += vdso-syms.lds
obj-$(VDSO64-y)                        += vdso-syms.lds

$(obj)/%-syms.lds: $(obj)/%.so.dbg FORCE
       $(call if_changed,vdsosym)





-- 
Best Regards
Masahiro Yamada
