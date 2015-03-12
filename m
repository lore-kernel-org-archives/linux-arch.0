From: Tobias Klauser <tklauser@distanz.ch>
Subject: Re: nios2: is the ptrace ABI correct?
Date: Thu, 12 Mar 2015 12:07:22 +0100
Message-ID: <20150312110722.GB894@distanz.ch>
References: <CAAEAJfDjDYY-Z6cPyrddCXiFJzrjNx8jkSAJZuokeEM9NU6WWg@mail.gmail.com>
 <10088870.tldQegtTla@wuerfel>
 <54EDB2FC.4050901@vanguardiasur.com.ar>
 <10841724.NbdcAaCe1a@wuerfel>
 <54F03184.7080600@codesourcery.com>
 <54F052B1.4070300@vanguardiasur.com.ar>
 <54FDD041.3080500@codesourcery.com>
 <54FDD219.1060707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sym2.noone.org ([178.63.92.236]:59377 "EHLO sym2.noone.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132AbbCLLMd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Mar 2015 07:12:33 -0400
Content-Disposition: inline
In-Reply-To: <54FDD219.1060707@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chung-Lin Tang <chunglin.tang@gmail.com>
Cc: Chung-Lin Tang <cltang@codesourcery.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <lftan@altera.com>, Walter Goossens <waltergoossens@home.nl>, linux-arch@vger.kernel.org, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 2015-03-09 at 18:02:17 +0100, Chung-Lin Tang <chunglin.tang@gmail.com> wrote:
> On 2015/3/10 12:54 AM, Chung-Lin Tang wrote:
> > It appears that some of the ways nios2 has organized the
> > ucontext/pt_regs/etc. are remnants of the pre-generic code, some
> > basically because the port was based off m68k.
> > 
> > I've re-organized the headers a bit: nios2/include/asm/ucontext.h is
> > deleted, and re-definition of struct sigcontext now allows use of
> > uapi/asm-generic/ucontext.h directly.  Note that the reorg, despite
> > effectively renaming some fields, is still binary compatible. I'll
> > probably update the corresponding glibc definitions later.
> > 
> > struct pt_regs is now not exported, and all exported register sets are
> > now supposed to follow the 49 register set defined as in GDB now.
> > 
> > Tobias, Ley Foon, how do you think this looks?
> 
> Sorry, accidentally attached unrelated GCC patch instead, this one's the
> correct one.

Sorry for jumping into the discussion so late. The patch looks fine to
me as well. Only one minor nit below. Since Ley Foon already applied it
as is, I'll just send a followup patch.

Thanks Ezequiel, Chung-Lin and Ley Foon for pushing this! Looking
forward to have strace support on nios2.

[...]
> diff --git a/arch/nios2/include/uapi/asm/Kbuild b/arch/nios2/include/uapi/asm/Kbuild
> index 4f07ca3f8..37613119 100644
> --- a/arch/nios2/include/uapi/asm/Kbuild
> +++ b/arch/nios2/include/uapi/asm/Kbuild
> @@ -2,3 +2,5 @@ include include/uapi/asm-generic/Kbuild.asm
>  
>  header-y += elf.h
>  header-y += ucontext.h

This should no longer be needed now that the non-generic ucontext.h is
gone.
