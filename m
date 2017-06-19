From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH 2/5] kbuild: thin archives use P option to ar
Date: Mon, 19 Jun 2017 15:17:39 +0900
Message-ID: <CAK7LNATkm0hKB+yBKHFBEpV2nycp5DyJMvUe7vATLOwN2fLb1g@mail.gmail.com>
References: <20170609052417.561-1-npiggin@gmail.com> <20170609052417.561-3-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20170609052417.561-3-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

Hi Nicholas,


2017-06-09 14:24 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> The P option makes ar do full path name matching and can prevent ar
> from discarding files with duplicate names in some cases of creating
> thin archives from thin archives. The sh architecture in particular
> loses some object files from its kernel/cpu/sh*/ directories without
> this option.

After playing around with thin archives, I agree this is the right
thing to do.

Currently, sh is the only architecture that has this kind of issue
(arch/sh/kernel/cpu/fpu.c  vs  arch/sh/kernel/cpu/sh*/fpu.c),
but this could happen in any architecture, I think.


BTW, I see one more instance in archive_builtin() in scripts/link-vmlinux.sh.

We have no source file at the top directory, so it will work
with/without "P" for the top-level built-in.o

Either way seems OK to me.


> This could be a bug in binutils ar, but the P option should not cause
> any negative effects so it is safe to use to work around tihs with.


Is "tihs" a typo?



> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  scripts/Makefile.build | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 733e044fff8b..4a9a2cec0a1b 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -437,8 +437,8 @@ $(sort $(subdir-obj-y)): $(subdir-ym) ;
>  ifdef builtin-target
>
>  ifdef CONFIG_THIN_ARCHIVES
> -  cmd_make_builtin = rm -f $@; $(AR) rcST$(KBUILD_ARFLAGS)
> -  cmd_make_empty_builtin = rm -f $@; $(AR) rcST$(KBUILD_ARFLAGS)
> +  cmd_make_builtin = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS)
> +  cmd_make_empty_builtin = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS)
>    quiet_cmd_link_o_target = AR      $@
>  else
>    cmd_make_builtin = $(LD) $(ld_flags) -r -o
> @@ -478,7 +478,7 @@ ifdef lib-target
>  quiet_cmd_link_l_target = AR      $@
>
>  ifdef CONFIG_THIN_ARCHIVES
> -  cmd_link_l_target = rm -f $@; $(AR) rcsT$(KBUILD_ARFLAGS) $@ $(lib-y)
> +  cmd_link_l_target = rm -f $@; $(AR) rcsTP$(KBUILD_ARFLAGS) $@ $(lib-y)
>  else
>    cmd_link_l_target = rm -f $@; $(AR) rcs$(KBUILD_ARFLAGS) $@ $(lib-y)
>  endif
> @@ -531,7 +531,7 @@ cmd_link_multi-link = $(LD) $(ld_flags) -r -o $@ $(link_multi_deps) $(cmd_secana
>
>  ifdef CONFIG_THIN_ARCHIVES
>    quiet_cmd_link_multi-y = AR      $@
> -  cmd_link_multi-y = rm -f $@; $(AR) rcST$(KBUILD_ARFLAGS) $@ $(link_multi_deps)
> +  cmd_link_multi-y = rm -f $@; $(AR) rcSTP$(KBUILD_ARFLAGS) $@ $(link_multi_deps)
>  else
>    quiet_cmd_link_multi-y = LD      $@
>    cmd_link_multi-y = $(cmd_link_multi-link)
> --
> 2.11.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
