From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH/RFC 01/16] compat: let architectures define
 __ARCH_WANT_COMPAT_SYS_GETDENTS64
Date: Thu, 20 Mar 2014 12:33:33 +0100
Message-ID: <20140320113333.GD4403@osiris>
References: <1394121083-2507-1-git-send-email-heiko.carstens@de.ibm.com>
 <1394121083-2507-2-git-send-email-heiko.carstens@de.ibm.com>
 <CAMuHMdUqjhcmaRo-2=qr_DgbXoj9bAGfvzuRPDZ+tOMx6Hvr-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:44810 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610AbaCTLdk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Mar 2014 07:33:40 -0400
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
	Thu, 20 Mar 2014 11:33:38 -0000
Content-Disposition: inline
In-Reply-To: <CAMuHMdUqjhcmaRo-2=qr_DgbXoj9bAGfvzuRPDZ+tOMx6Hvr-Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Linux-Arch <linux-arch@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Linux-Next <linux-next@vger.kernel.org>, Chris Metcalf <cmetcalf@tilera.com>

On Thu, Mar 20, 2014 at 11:03:14AM +0100, Geert Uytterhoeven wrote:
> On Thu, Mar 6, 2014 at 4:51 PM, Heiko Carstens
> <heiko.carstens@de.ibm.com> wrote:
> > For architecture dependent compat syscalls in common code an architecture
> > must define something like __ARCH_WANT_<WHATEVER> if it wants to use the
> > code.
> > This however is not true for compat_sys_getdents64 for which architectures
> > must define __ARCH_OMIT_COMPAT_SYS_GETDENTS64 if they do not want the code.
> >
> > This leads to the situation where all architectures, except mips, get the
> > compat code but only x86_64, arm64 and the generic syscall architectures
> > actually use it.
> >
> > So invert the logic, so that architectures actively must do something to
> > get the compat code.
> >
> > This way a couple of architectures get rid of otherwise dead code.
> >
> > Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Is this the cause of the tilegx_defconfig failures in -next?
> 
> include/uapi/asm-generic/unistd.h:195:1: error:
> 'compat_sys_getdents64' undeclared here (not in a function)
> make[3]: *** [arch/tile/kernel/compat.o] Error 1
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/10808012/

Yes. That's unexpected header include order from my side...
Looking into it. Thanks!
