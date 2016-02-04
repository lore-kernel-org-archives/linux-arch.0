From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH v2 01/13] [kbuild] handle exports in lib-y objects
 reliably
Date: Thu, 4 Feb 2016 23:33:27 +0100
Message-ID: <56B3D1B7.4080305@suse.cz>
References: <20160203211953.GT17997@ZenIV.linux.org.uk>
 <1454534445-16759-1-git-send-email-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1454534445-16759-1-git-send-email-viro@ZenIV.linux.org.uk>
Sender: linux-kbuild-owner@vger.kernel.org
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Dne 3.2.2016 v 22:20 Al Viro napsal(a):
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> Collect the symbols exported by anything that goes into lib.a and
> add an empty object (lib-exports.o) with explicit undefs for each
> of those to obj-y.
> 
> That allows to relax the rules regarding the use of exports in
> lib-* objects - right now an object with export can be in lib-*
> only if we are guaranteed that there always will be users in
> built-in parts of the tree, otherwise it needs to be in obj-*.
> As the result, we have an unholy mix of lib- and obj- in lib/Makefile
> and (especially) in arch/*/lib/Makefile.  Moreover, a change in
> generic part of the kernel can lead to mysteriously missing exports
> on some configs.  With this change we don't have to worry about
> that anymore.
> 
> One side effect is that built-in.o now pulls everything with exports
> from the corresponding lib.a (if such exists).  That's exactly what
> we want for linking vmlinux and fortunately it's almost the only thing
> built-in.o is used in.  arch/ia64/hp/sim/boot/bootloader is the only
> exception and it's easy to get rid of now - just turn everything in
> arch/ia64/lib into lib-* and don't bother with arch/ia64/lib/built-in.o
> anymore.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/ia64/hp/sim/boot/Makefile |  2 +-
>  arch/ia64/lib/Makefile         |  8 +++-----
>  scripts/Makefile.build         | 20 ++++++++++++++++++++
>  3 files changed, 24 insertions(+), 6 deletions(-)

Acked-by: Michal Marek <mmarek@suse.cz>

Sorry for the delay.


> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -81,6 +81,7 @@ endif
>  
>  ifneq ($(strip $(lib-y) $(lib-m) $(lib-)),)
>  lib-target := $(obj)/lib.a
> +obj-y += $(obj)/lib-ksyms.o
>  endif
>  
>  ifneq ($(strip $(obj-y) $(obj-m) $(obj-) $(subdir-m) $(lib-target)),)
> @@ -363,6 +364,25 @@ $(lib-target): $(lib-y) FORCE
>  	$(call if_changed,link_l_target)
>  
>  targets += $(lib-target)
> +
> +dummy-object = $(obj)/__lib_exports.o
> +ksyms-lds = $(obj)/lib-ksyms.lds

Just a really minor nitpick (no need to resend just because of it): We
typically use dotfiles for temporary stuff, e.g.

dummy-object = $(obj)/.lib_exports.o
ksyms-lds = $(dot-target).lds

Michal
