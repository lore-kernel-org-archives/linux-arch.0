From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 1/5] kbuild: thin archives final link close
 --whole-archives option
Date: Mon, 19 Jun 2017 16:48:37 -0700
Message-ID: <20170619234837.GD30361@cloud>
References: <20170609052417.561-1-npiggin@gmail.com>
 <20170609052417.561-2-npiggin@gmail.com>
 <CAK7LNASxuE-6eMk+Y-vyrMfibtYoD2JkjNS2z8QF85x9NdiiaA@mail.gmail.com>
 <20170619165100.3ce26d00@roar.ozlabs.ibm.com>
 <CAK7LNARuuQzGkYBdzoy3bVpBuNPZEMGerHSEdmrH+PqK0Gbyzg@mail.gmail.com>
 <20170619182714.2cb60e17@roar.ozlabs.ibm.com>
 <CAK7LNATznx=5A1KnhkFHpjencsJj7AGUsHtDUu6M-Qkw=jvpPQ@mail.gmail.com>
 <20170620015205.329519b2@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:47913 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753225AbdFTAAV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Jun 2017 20:00:21 -0400
Content-Disposition: inline
In-Reply-To: <20170620015205.329519b2@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Michal Marek <mmarek@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, kbuild test robot <fengguang.wu@intel.com>

On Tue, Jun 20, 2017 at 01:52:05AM +1000, Nicholas Piggin wrote:
> On Mon, 19 Jun 2017 17:35:32 +0900
> Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> 
> > Hi Nicholas,
> > 
> > 
> > 2017-06-19 17:27 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:
> > > On Mon, 19 Jun 2017 17:14:22 +0900
> > > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> > >  
> > >> Hi Nicholas,
> > >>
> > >>
> > >> 2017-06-19 15:51 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:  
> > >> > On Mon, 19 Jun 2017 15:16:17 +0900
> > >> > Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> > >> >  
> > >> >> Hi Nicholas,
> > >> >>
> > >> >>
> > >> >> 2017-06-09 14:24 GMT+09:00 Nicholas Piggin <npiggin@gmail.com>:  
> > >> >> > Close the --whole-archives option with --no-whole-archive. Some
> > >> >> > architectures end up including additional .o and files multiple
> > >> >> > times after this, and they get duplicate symbols when they are
> > >> >> > brought under the --whole-archives option.  
> > >> >>
> > >> >> Which architectures have additional files after --no-whole-archive ?
> > >> >>
> > >> >> I see this case only for ARCH = "um" in vmlinux_link()
> > >> >> where it adds some -l* options after --no-whole-archive.
> > >> >>
> > >> >> I think it is good to close the --whole-archives everywhere.
> > >> >> So, the code looks OK to me, but I just wondered about the log.  
> > >> >
> > >> > Actually a number of archs seemed to get build errors without this,
> > >> > and they seem to come from libgcc perhaps.
> > >> >
> > >> > binfmt_elf.c:(.text+0x4851): undefined reference to `__kernel_syscall_via_epc'
> > >> > /c/gcc/libgcc/libgcc2.c:1318: multiple definition of `__ucmpdi2'
> > >> > /c/gcc/libgcc/libgcc2.c:405: multiple definition of `__lshrdi3'
> > >> > /c/gcc/libgcc/libgcc2.c:433: multiple definition of `__ashldi3'
> > >> > /c/gcc/libgcc/libgcc2.c:461: multiple definition of `__ashrdi3'
> > >> >
> > >> > /home/tony/buildall/src/gcc/libgcc/config/xtensa/lib2funcs.S:36: multiple definition of `__xtensa_libgcc_window_spill'
> > >> >
> > >> > etc  
> > >>
> > >>
> > >> Oops, I did not test such architectures.
> > >>
> > >>  
> > >> > m32r, parisc, xtensa seemed to be getting such errors. I wonder if
> > >> > the linker implicitly adds some runtime libs at the end that get
> > >> > caught up here. Either way I didn't look too far into it because this
> > >> > fix seems obviously correct and solved the problem.
> > >> >
> > >> > Thanks,  
> > >>
> > >>
> > >> Which toolchains do you use?  
> > >
> > > I just had them run through the kbuild 0day tests. Not sure exactly
> > > what they use.
> > >  
> > >> I downloaded xtensa-linux- from this site:
> > >> https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.9.0/
> > >>
> > >>
> > >> I see a different error for xtensa.
> > >>
> > >>
> > >> I applied all of you 5 patches, but xtensa build still fails.
> > >>
> > >>   LD      vmlinux.o
> > >> xtensa-linux-ld: internal error
> > >> /home/tony/buildall/src/binutils/ld/ldlang.c 6178
> > >>
> > >>
> > >> Could you check it?  
> > >
> > > Ahh, the old ld: internal error... what ld version is that?
> > >  
> > 
> > 
> > seems 2.24 according to the following:
> > 
> > 
> > masahiro@pug:~$ xtensa-linux-ld -v
> > GNU ld (GNU Binutils) 2.24
> 
> Ah, thank you. It must have been that the 0day build (cc'ed) did
> not return any error to be from the ld internal error.
> 
> This has led me to the true cause of the error which is the way
> external archives are handled. After implementing the fix, I think
> the lib.a size regression for thin archives should be solved as
> well.

Thanks for addressing this!  Much appreciated.

> This patch should be added between patches 2 and 3 of this series.
> 
> 
> kbuild: handle libs-y archives separately from built-in.o archives
> 
> The thin archives build currently puts all lib.a and built-in.o
> files together and links them with --whole-archive.
> 
> This works because thin archives can recursively refer to thin
> archives. However some architectures include libgcc.a, which may
> not be a thin archive, or it may not be constructed with the "P"
> option, in which case its contents do not get linked correctly.
> 
> So don't pull .a libs into the root built-in.o archive. These
> libs should already have symbol tables and indexes built, so they
> can be direct linker inputs. Move them out of the --whole-archive
> option, which restore the conditional linking behaviour of lib.a
> to thin archives builds.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  Documentation/kbuild/kbuild.txt |  8 +++++--
>  Makefile                        |  7 +++---
>  scripts/link-vmlinux.sh         | 47 ++++++++++++++++++++++++++++++++---------
>  3 files changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/kbuild/kbuild.txt b/Documentation/kbuild/kbuild.txt
> index 0ff6a466a05b..ac2363ea05c5 100644
> --- a/Documentation/kbuild/kbuild.txt
> +++ b/Documentation/kbuild/kbuild.txt
> @@ -236,5 +236,9 @@ Files specified with KBUILD_VMLINUX_INIT are linked first.
>  KBUILD_VMLINUX_MAIN
>  --------------------------------------------------
>  All object files for the main part of vmlinux.
> -KBUILD_VMLINUX_INIT and KBUILD_VMLINUX_MAIN together specify
> -all the object files used to link vmlinux.
> +
> +KBUILD_VMLINUX_LIBS
> +--------------------------------------------------
> +All .a "lib" files for vmlinux.
> +KBUILD_VMLINUX_INIT, KBUILD_VMLINUX_MAIN, and KBUILD_VMLINUX_LIBS together
> +specify all the object files used to link vmlinux.
> diff --git a/Makefile b/Makefile
> index 470bd4d9513a..a145a537ad42 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -952,19 +952,20 @@ core-y		:= $(patsubst %/, %/built-in.o, $(core-y))
>  drivers-y	:= $(patsubst %/, %/built-in.o, $(drivers-y))
>  net-y		:= $(patsubst %/, %/built-in.o, $(net-y))
>  libs-y1		:= $(patsubst %/, %/lib.a, $(libs-y))
> -libs-y2		:= $(patsubst %/, %/built-in.o, $(libs-y))
> +libs-y2		:= $(filter-out %.a, $(patsubst %/, %/built-in.o, $(libs-y)))
>  libs-y		:= $(libs-y1) $(libs-y2)
>  virt-y		:= $(patsubst %/, %/built-in.o, $(virt-y))
>  
>  # Externally visible symbols (used by link-vmlinux.sh)
>  export KBUILD_VMLINUX_INIT := $(head-y) $(init-y)
> -export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y) $(drivers-y) $(net-y) $(virt-y)
> +export KBUILD_VMLINUX_MAIN := $(core-y) $(libs-y2) $(drivers-y) $(net-y) $(virt-y)
> +export KBUILD_VMLINUX_LIBS := $(libs-y1)
>  export KBUILD_LDS          := arch/$(SRCARCH)/kernel/vmlinux.lds
>  export LDFLAGS_vmlinux
>  # used by scripts/pacmage/Makefile
>  export KBUILD_ALLDIRS := $(sort $(filter-out arch/%,$(vmlinux-alldirs)) arch Documentation include samples scripts tools)
>  
> -vmlinux-deps := $(KBUILD_LDS) $(KBUILD_VMLINUX_INIT) $(KBUILD_VMLINUX_MAIN)
> +vmlinux-deps := $(KBUILD_LDS) $(KBUILD_VMLINUX_INIT) $(KBUILD_VMLINUX_MAIN) $(KBUILD_VMLINUX_LIBS)
>  
>  # Include targets which we want to execute sequentially if the rest of the
>  # kernel build went well. If CONFIG_TRIM_UNUSED_KSYMS is set, this might be
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index 2a062ea130b5..e7b7eee31538 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -3,9 +3,12 @@
>  # link vmlinux
>  #
>  # vmlinux is linked from the objects selected by $(KBUILD_VMLINUX_INIT) and
> -# $(KBUILD_VMLINUX_MAIN). Most are built-in.o files from top-level directories
> -# in the kernel tree, others are specified in arch/$(ARCH)/Makefile.
> -# Ordering when linking is important, and $(KBUILD_VMLINUX_INIT) must be first.
> +# $(KBUILD_VMLINUX_MAIN) and $(KBUILD_VMLINUX_LIBS). Most are built-in.o files
> +# from top-level directories in the kernel tree, others are specified in
> +# arch/$(ARCH)/Makefile. Ordering when linking is important, and
> +# $(KBUILD_VMLINUX_INIT) must be first. $(KBUILD_VMLINUX_LIBS) are archives
> +# which are linked conditionally (not within --whole-archive), and do not
> +# require symbol indexes added.
>  #
>  # vmlinux
>  #   ^
> @@ -16,6 +19,9 @@
>  #   +--< $(KBUILD_VMLINUX_MAIN)
>  #   |    +--< drivers/built-in.o mm/built-in.o + more
>  #   |
> +#   +--< $(KBUILD_VMLINUX_LIBS)
> +#   |    +--< lib/lib.a + more
> +#   |
>  #   +-< ${kallsymso} (see description in KALLSYMS section)
>  #
>  # vmlinux version (uname -v) cannot be updated during normal
> @@ -37,9 +43,10 @@ info()
>  	fi
>  }
>  
> -# Thin archive build here makes a final archive with
> -# symbol table and indexes from vmlinux objects, which can be
> -# used as input to linker.
> +# Thin archive build here makes a final archive with symbol table and indexes
> +# from vmlinux objects INIT and MAIN, which can be used as input to linker.
> +# KBUILD_VMLINUX_LIBS archives should already have symbol table and indexes
> +# added.
>  #
>  # Traditional incremental style of link does not require this step
>  #
> @@ -50,7 +57,7 @@ archive_builtin()
>  	if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
>  		info AR built-in.o
>  		rm -f built-in.o;
> -		${AR} rcsT${KBUILD_ARFLAGS} built-in.o			\
> +		${AR} rcsTP${KBUILD_ARFLAGS} built-in.o			\
>  					${KBUILD_VMLINUX_INIT}		\
>  					${KBUILD_VMLINUX_MAIN}
>  	fi
> @@ -63,11 +70,17 @@ modpost_link()
>  	local objects
>  
>  	if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> -		objects="--whole-archive built-in.o --no-whole-archive"
> +		objects="--whole-archive				\
> +			built-in.o					\
> +			--no-whole-archive				\
> +			--start-group					\
> +			${KBUILD_VMLINUX_LIBS}				\
> +			--end-group"
>  	else
>  		objects="${KBUILD_VMLINUX_INIT}				\
>  			--start-group					\
>  			${KBUILD_VMLINUX_MAIN}				\
> +			${KBUILD_VMLINUX_LIBS}				\
>  			--end-group"
>  	fi
>  	${LD} ${LDFLAGS} -r -o ${1} ${objects}
> @@ -83,11 +96,18 @@ vmlinux_link()
>  
>  	if [ "${SRCARCH}" != "um" ]; then
>  		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> -			objects="--whole-archive built-in.o ${1} --no-whole-archive"
> +			objects="--whole-archive			\
> +				built-in.o				\
> +				--no-whole-archive			\
> +				--start-group				\
> +				${KBUILD_VMLINUX_LIBS}			\
> +				--end-group				\
> +				${1}"
>  		else
>  			objects="${KBUILD_VMLINUX_INIT}			\
>  				--start-group				\
>  				${KBUILD_VMLINUX_MAIN}			\
> +				${KBUILD_VMLINUX_LIBS}			\
>  				--end-group				\
>  				${1}"
>  		fi
> @@ -96,11 +116,18 @@ vmlinux_link()
>  			-T ${lds} ${objects}
>  	else
>  		if [ -n "${CONFIG_THIN_ARCHIVES}" ]; then
> -			objects="-Wl,--whole-archive built-in.o ${1} -Wl,--no-whole-archive"
> +			objects="-Wl,--whole-archive			\
> +				built-in.o				\
> +				-Wl,--no-whole-archive			\
> +				-Wl,--start-group			\
> +				${KBUILD_VMLINUX_LIBS}			\
> +				-Wl,--end-group				\
> +				${1}"
>  		else
>  			objects="${KBUILD_VMLINUX_INIT}			\
>  				-Wl,--start-group			\
>  				${KBUILD_VMLINUX_MAIN}			\
> +				${KBUILD_VMLINUX_LIBS}			\
>  				-Wl,--end-group				\
>  				${1}"
>  		fi
> -- 
> 2.11.0
> 
