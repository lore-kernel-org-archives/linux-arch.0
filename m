Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 23 Mar 2005 09:06:44 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] consolidate asm/ipc.h
Message-ID: <20050323080644.GA6760@wotan.suse.de>
References: <20050323150123.1a78e9c4.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050323150123.1a78e9c4.sfr@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

> diff -ruN linus/include/asm-x86_64/ipc.h linus-compat_sys_ipc.1/include/asm-x86_64/ipc.h
> --- linus/include/asm-x86_64/ipc.h	2002-10-17 23:29:20.000000000 +1000
> +++ linus-compat_sys_ipc.1/include/asm-x86_64/ipc.h	1970-01-01 10:00:00.000000000 +1000
> @@ -1,6 +0,0 @@
> -#ifndef __x8664_IPC_H__
> -#define __x8664_IPC_H__
> -
> -/* dummy */
> -
> -#endif

The dummy was originally put in because someone actually included it.
That was in 2.4 days of course.

Can you do a allyesconfig build on x86-64 just to make sure it still builds?

-Andi
