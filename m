From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 05/28] nios2: Traps exception handling
Date: Tue, 22 Apr 2014 11:28:31 -0300
Message-ID: <20140422142831.GC15745@arch.cereza>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
 <1397845149-3141-1-git-send-email-lftan@altera.com>
 <1397845149-3141-2-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397845149-3141-2-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

Hello Ley Foon,

On Apr 19, Ley Foon Tan wrote:
> +
> +#ifndef CONFIG_ALIGNMENT_TRAP
> +/* Alignment exception handler */
> +asmlinkage void handle_unaligned_c(struct pt_regs *fp, int cause)
> +{
> +	unsigned long addr =3D RDCTL(CTL_BADADDR);
> +
> +	cause >>=3D 2;
> +	fp->ea -=3D 4;
> +
> +	if (fixup_exception(fp))
> +		return;

This will throw an undeclared error if you build with CONFIG_ALIGNMENT_=
TRAP=3Dn.

You need to add the uaccess.h header, or implement some similar fix.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
