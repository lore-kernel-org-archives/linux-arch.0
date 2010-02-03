From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/14] move user_enable_single_step & co prototypes to
	linux/ptrace.h
Date: Wed, 3 Feb 2010 03:42:05 -0500
Message-ID: <8bd0f97a1002030042t5cdc1a88oe9e273e7d6ec4269@mail.gmail.com>
References: <20100202185755.GA3630@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f189.google.com ([209.85.210.189]:64530 "EHLO
	mail-yx0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753102Ab0BCIm0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2010 03:42:26 -0500
In-Reply-To: <20100202185755.GA3630@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: roland@redhat.com, oleg@redhat.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mattst88@gmail.com, ink@jurassic.park.msu.ru, rth@twiddle.net, linux@arm.linux.org.uk, hskinnemoen@atmel.com, vapier@gentoo.org, starvik@axis.com, jesper.nilsson@axis.com, ysato@users.sourceforge.jp, takata@linux-m32r.org, gerg@uclinux.org, monstr@monstr.eu, ralf@linux-mips.org, jdike@addtoit.com, chris@zankel.net

On Tue, Feb 2, 2010 at 13:57, Christoph Hellwig wrote:
> While in theory user_enable_single_step/user_disable_single_step/
> user_enable_blockstep could also be provided as an inline or macro th=
ere's no
> good reason to do so, and having the prototype in one places keeps co=
de size
> and confusion down.

the only annoying thing here is that we currently have to enable both
user_disable_single_step() and ptrace_disable() that do exactly the
same thing.  i avoided this somewhat on Blackfin by cheating:
#define user_disable_single_step(child) ptrace_disable(child)

so now there's no code bloat.  perhaps this could be moved into common
linux/ptrace.h too ?

> --- linux-2.6/include/linux/ptrace.h
> +++ linux-2.6/include/linux/ptrace.h
> @@ -238,6 +238,9 @@
> =C2=A0static inline void user_disable_single_step(struct task_struct =
*task)
> =C2=A0{
> =C2=A0}
> +#else
> +extern void user_enable_single_step(struct task_struct *);
> +extern void user_disable_single_step(struct task_struct *);
> =C2=A0#endif /* arch_has_single_step */

+#define ptrace_disable(child) user_disable_single_step(child)
-mike
