From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 01/17] h8300: Assembly headers.
Date: Mon, 27 Apr 2015 11:33:51 +0200
Message-ID: <2948748.6qO2hTmrkc@wuerfel>
References: <1430112924-1134-1-git-send-email-ysato@users.sourceforge.jp> <4430626.HbYtNkMCT0@wuerfel> <20150427092622.GD11048@distanz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:64486 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932376AbbD0JeG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 Apr 2015 05:34:06 -0400
In-Reply-To: <20150427092622.GD11048@distanz.ch>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tobias Klauser <tklauser@distanz.ch>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Monday 27 April 2015 11:26:22 Tobias Klauser wrote:
> On 2015-04-27 at 09:48:39 +0200, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday 27 April 2015 09:42:41 Tobias Klauser wrote:
> > > > diff --git a/arch/h8300/include/asm/elf.h b/arch/h8300/include/asm/elf.h
> > > > new file mode 100644
> > > > index 0000000..09031d0
> > > > --- /dev/null
> > > > +++ b/arch/h8300/include/asm/elf.h
> > > > @@ -0,0 +1,101 @@
> > > > +#ifndef __ASM_H8300_ELF_H
> > > > +#define __ASM_H8300_ELF_H
> > > > +
> > > > +/*
> > > > + * ELF register definitions..
> > > > + */
> > > > +
> > > > +#include <asm/ptrace.h>
> > > > +#include <asm/user.h>
> > > > +
> > > > +typedef unsigned long elf_greg_t;
> > > > +
> > > > +#define ELF_NGREG (sizeof(struct user_regs_struct) / sizeof(elf_greg_t))
> > > > +typedef elf_greg_t elf_gregset_t[ELF_NGREG];
> > > > +typedef unsigned long elf_fpregset_t;
> > > > +
> > > > +/*
> > > > + * This is used to ensure we don't load something for the wrong architecture.
> > > > + */
> > > > +#define elf_check_arch(x) ((x)->e_machine == EM_H8_300)
> > > 
> > > EM_H8_300 is still used before it is introduced in patch 15/17, please
> > > change the patch order. Otherwise you break bisectability.
> > 
> > While that is true in principle, I really wouldn't care about that
> > when introducing a new architecture: There is no way to use this
> > code unless you introduce all code first.
> 
> Agreed. But should the ELF machine at least be introduced before the
> build infrastructure (patch 10/17) is added? Otherwise we're able to
> compile the new arch port in principle but it will fail due to the
> missing definition.
> 

Yes, moving the the patch that adds the build scripts last in the
series makes sense.

	Arnd
