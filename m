From: Peter Wu <peter@lekensteyn.nl>
Subject: Re: 'kbuild' merge before 4.9-rc1 breaks build and boot
Date: Sun, 20 Nov 2016 19:26:23 +0100
Message-ID: <20161120182623.GA1988@al>
References: <4c04b846-3da8-dc42-4fa6-30f72a5c2437@hartkopp.net>
 <20161027154202.GE27017@al>
 <alpine.DEB.2.20.1611071408040.24418@macbook-air>
 <20161107213907.GB18092@al>
 <20161108123334.3df2dcc9@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161108123334.3df2dcc9@roar.ozlabs.ibm.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Vince Weaver <vincent.weaver@maine.edu>, Michal Marek <mmarek@suse.com>, Al Viro <viro@zeniv.linux.org.uk>, Oliver Hartkopp <socketcan@hartkopp.net>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, regressions@leemhuis.info
List-Id: linux-arch.vger.kernel.org

Hi Nicholas,

Current git master (v4.9-rc5-364-g77079b1) with the latest kbuild fixes
is still failing to load modules when built with CONFIG_MODVERSIONS=y on
x86_64 using GCC 6.2.1.

It can still be reproduced with make defconfig, then enabling
CONFIG_MODVERSIONS=y. The build output contains:

    WARNING: "memcpy" [net/netfilter/nf_nat.ko] has no CRC!
    WARNING: "memmove" [net/netfilter/nf_nat.ko] has no CRC!
    WARNING: "_copy_to_user" [fs/efivarfs/efivarfs.ko] has no CRC!
    WARNING: "memcpy" [fs/efivarfs/efivarfs.ko] has no CRC!
    WARNING: "_copy_from_user" [fs/efivarfs/efivarfs.ko] has no CRC!

    $ grep 000000 Module.symvers
    0x00000000	phys_base	vmlinux	EXPORT_SYMBOL
    0x00000000	memmove	vmlinux	EXPORT_SYMBOL
    0x00000000	__copy_user_nocache	vmlinux	EXPORT_SYMBOL
    0x00000000	__get_user_4	vmlinux	EXPORT_SYMBOL
    0x00000000	__put_user_4	vmlinux	EXPORT_SYMBOL
    0x00000000	__memcpy	vmlinux	EXPORT_SYMBOL
    0x00000000	memset	vmlinux	EXPORT_SYMBOL
    0x00000000	__sw_hweight64	vmlinux	EXPORT_SYMBOL
    0x00000000	__sw_hweight32	vmlinux	EXPORT_SYMBOL
    0x00000000	memcpy_mcsafe_unrolled	vmlinux	EXPORT_SYMBOL_GPL
    0x00000000	memcpy	vmlinux	EXPORT_SYMBOL
    0x00000000	copy_user_enhanced_fast_string	vmlinux	EXPORT_SYMBOL
    0x00000000	clear_page	vmlinux	EXPORT_SYMBOL
    0x00000000	__put_user_2	vmlinux	EXPORT_SYMBOL
    0x00000000	__get_user_2	vmlinux	EXPORT_SYMBOL
    0x00000000	copy_page	vmlinux	EXPORT_SYMBOL
    0x00000000	copy_user_generic_string	vmlinux	EXPORT_SYMBOL
    0x00000000	_copy_to_user	vmlinux	EXPORT_SYMBOL
    0x00000000	__memmove	vmlinux	EXPORT_SYMBOL
    0x00000000	empty_zero_page	vmlinux	EXPORT_SYMBOL
    0x00000000	__get_user_8	vmlinux	EXPORT_SYMBOL
    0x00000000	__put_user_8	vmlinux	EXPORT_SYMBOL
    0x00000000	_copy_from_user	vmlinux	EXPORT_SYMBOL
    0x00000000	native_load_gs_index	vmlinux	EXPORT_SYMBOL
    0x00000000	__memset	vmlinux	EXPORT_SYMBOL
    0x00000000	__put_user_1	vmlinux	EXPORT_SYMBOL
    0x00000000	__get_user_1	vmlinux	EXPORT_SYMBOL
    0x00000000	copy_user_generic_unrolled	vmlinux	EXPORT_SYMBOL

Kind regards,
Peter

On Tue, Nov 08, 2016 at 12:33:34PM +1100, Nicholas Piggin wrote:
> On Mon, 7 Nov 2016 22:39:07 +0100
> Peter Wu <peter@lekensteyn.nl> wrote:
> 
> > On Mon, Nov 07, 2016 at 02:10:12PM -0500, Vince Weaver wrote:
> > > On Thu, 27 Oct 2016, Peter Wu wrote:
> > >   
> > > > I can confirm Olivers issue, the current mainline kernel fails to boot
> > > > on kernels with CONFIG_MODVERSIONS=y. Bisection points to:
> > > > 
> > > >     commit 784d5699eddc55878627da20d3fe0c8542e2f1a2
> > > >     Author: Al Viro <viro@zeniv.linux.org.uk>
> > > >     Date:   Mon Jan 11 11:04:34 2016 -0500  
> > > > > WARNING: "memset" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > > > > WARNING: "__fentry__" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > > > > WARNING: "memcpy" [sound/usb/snd-usbmidi-lib.ko] has no CRC!
> > > > > WARNING: "__sw_hweight32" [sound/usb/snd-usbmidi-lib.ko] has no CRC!  
> > > 
> > > Has any progress been made with this problem?
> > > 
> > > I'm also encountering it on my debian-unstable box on any kernel more 
> > > recent than 4.9-rc1 (up to and including 4.9-rc4).  I am glad someone 
> > > managed to isolate it as I was unable to get a clean bisect.
> > > 
> > > Vince  
> > 
> > The original kbuild issue went in via
> > merge commit 84d69848c97faab0c25aa2667b273404d2e2a64a which notes:
> > 
> >  - EXPORT_SYMBOL for asm source by Al Viro.
> > 
> >    This does bring a regression, because genksyms no longer generates
> >    checksums for these symbols (CONFIG_MODVERSIONS). Nick Piggin is
> >    working on a patch to fix this.
> > 
> >    Plus, we are talking about functions like strcpy(), which rarely
> >    change prototypes.
> > 
> > Adding Nicholas in the cc, hopefully he can give a status update.
> 
> I think Michal has everything needed now for the kbuild bits. The arch
> specific patches can go via arch trees quite easily (there is no hard
> dependency either way). This is the kbuild bit:
> 
> https://git.kernel.org/cgit/linux/kernel/git/mmarek/kbuild.git/commit/?h=rc-fixes&id=4efca4ed05cbdfd13ec3e8cb623fb77d6e4ab187
> 
> And it also needs this incremental bit not in Michal's tree yet:
> 
> ---
>  scripts/Makefile.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 3e223c2..05c6bb4 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -332,7 +332,7 @@ cmd_gensymtypes_S =                                                         \
>      (echo "\#include <linux/kernel.h>" ;                                    \
>       echo "\#include <asm/asm-prototypes.h>" ;                              \
>      $(CPP) $(a_flags) $< |                                                  \
> -     grep ^___EXPORT_SYMBOL |                                               \
> +     grep ___EXPORT_SYMBOL |                                                \
>       sed 's/___EXPORT_SYMBOL \([a-zA-Z0-9_]*\),.*/EXPORT_SYMBOL(\1);/' ) |  \
>      $(CPP) -D__GENKSYMS__ $(c_flags) -xc - |                                \
>      $(GENKSYMS) $(if $(1), -T $(2))                                         \
> -- 
> 2.9.3
> 
