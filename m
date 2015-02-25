Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:62624 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbbBYOHy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2015 09:07:54 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: nios2: is the ptrace ABI correct?
Date: Wed, 25 Feb 2015 15:07:39 +0100
Message-ID: <10841724.NbdcAaCe1a@wuerfel>
In-Reply-To: <54EDB2FC.4050901@vanguardiasur.com.ar>
References: <CAAEAJfDjDYY-Z6cPyrddCXiFJzrjNx8jkSAJZuokeEM9NU6WWg@mail.gmail.com> <10088870.tldQegtTla@wuerfel> <54EDB2FC.4050901@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Tobias Klauser <tklauser@distanz.ch>, Chung-Ling Tang <cltang@codesourcery.com>, Walter Goossens <waltergoossens@home.nl>, Ley Foon Tan <lftan@altera.com>, linux-arch@vger.kernel.org, "nios2-dev@lists.rocketboards.org" <nios2-dev@lists.rocketboards.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <20150225140739.86vm091dy_ulmi_vrgGjW_Vlmaj4_YyjNdyx1Qnm2Xc@z>

On Wednesday 25 February 2015 08:33:16 Ezequiel Garcia wrote:
> 
> /me is more confused now
> 
> In arch/nios2/include/asm/ucontext.h
> 
> struct ucontext {
>         unsigned long     uc_flags;
>         struct ucontext  *uc_link;
>         stack_t           uc_stack;
>         struct mcontext   uc_mcontext;
>         sigset_t          uc_sigmask;
> };
> 
> And in include/uapi/asm-generic/ucontext.h:
> 
> struct ucontext {
>         unsigned long     uc_flags;
>         struct ucontext  *uc_link;
>         stack_t           uc_stack;
>         struct sigcontext uc_mcontext;
>         sigset_t          uc_sigmask;
> };
> 
> Which one is the one that userspace sees? And why does the kernel has
> two different structures?

Userspace sees the asm-generic header, which I assume is a bug
in this case.

> Given this oddities, I'm wondering how troublesome would be to just
> re-do this and break the ptrace and signal ABI. For instance, just
> pushing pt_regs in PTRACE_GETREGSET would make things much clearer.

Could you change pt_regs to match the layout you have for PTRACE_GETREGSET
instead? It seems much more intuitive.

> I guess Linus would burn me for even suggesting to breaking users... but
> do we have any users at all? This arch has just been mainlined. Altera's
> out-of-tree is already ABI-incompatible with mainline so that's not an
> issue.
> 
> The only one using this ABI is gdb, which is easily fixed.

You can change anything you like as long as nobody complains about
regressions.

	Arnd
