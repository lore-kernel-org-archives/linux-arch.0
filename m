From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/9] scripts/link-vmlinux.sh: Delay orphan handling
 warnings until final link
Date: Fri, 20 Mar 2020 11:24:22 -0700
Message-ID: <202003201121.8CBD96451B@keescook>
References: <20200228002244.15240-1-keescook@chromium.org>
 <20200228002244.15240-2-keescook@chromium.org>
 <1584672297.mudnpz3ir9.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38087 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgCTSYZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Mar 2020 14:24:25 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so3722813pfn.5
        for <linux-arch@vger.kernel.org>; Fri, 20 Mar 2020 11:24:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1584672297.mudnpz3ir9.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Borislav Petkov <bp@suse.de>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, clang-built-linux@googlegroups.com, "H.J. Lu" <hjl.tools@gmail.com>, James Morse <james.morse@arm.com>, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@armlinux.org.uk>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Masahiro Yamada <masahiroy@kernel.org>, Peter Collingbourne <pcc@google.com>, Will Deacon <will@kernel.org>, x86@kernel.org

On Fri, Mar 20, 2020 at 12:47:54PM +1000, Nicholas Piggin wrote:
> Kees Cook's on February 28, 2020 10:22 am:
> > Right now, powerpc adds "--orphan-handling=warn" to LD_FLAGS_vmlinux
> > to detect when there are unexpected sections getting added to the kernel
> > image. There is no need to report these warnings more than once, so it
> > can be removed until the final link stage.
> > 
> > This helps pave the way for other architectures to enable this, with the
> > end goal of enabling this warning by default for vmlinux for all
> > architectures.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  scripts/link-vmlinux.sh | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > index 1919c311c149..416968fea685 100755
> > --- a/scripts/link-vmlinux.sh
> > +++ b/scripts/link-vmlinux.sh
> > @@ -255,6 +255,11 @@ info GEN modules.builtin
> >  tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.file=//p' |
> >  	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$/.ko/' > modules.builtin
> >  
> > +
> > +# Do not warn about orphan sections until the final link stage.
> > +saved_LDFLAGS_vmlinux="${LDFLAGS_vmlinux}"
> > +LDFLAGS_vmlinux="$(echo "${LDFLAGS_vmlinux}" | sed -E 's/ --orphan-handling=warn( |$)/ /g')"
> > +
> >  btf_vmlinux_bin_o=""
> >  if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
> >  	if gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
> > @@ -306,6 +311,7 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
> >  	fi
> >  fi
> >  
> > +LDFLAGS_vmlinux="${saved_LDFLAGS_vmlinux}"
> >  vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
> >  
> >  if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
> 
> That's ugly. Why not just enable it for all archs?

It is ugly; I agree.

I can try to do this for all architectures, but I worry there are a
bunch I can't test. But I guess it would stand out. ;)

-Kees

-- 
Kees Cook
