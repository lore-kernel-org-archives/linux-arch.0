From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Behavior of BUG() [Was: Re: [PATCH 2/5] of/fdt: add kernel
 command line option for dtb_compat string]
Date: Tue, 16 Nov 2010 21:13:17 -0700
Message-ID: <AANLkTimQtXeCE1Gu4YuPBBZ_J3ieW6Z5JtvzF=hF7pWX@mail.gmail.com>
References: <AANLkTinop4_JT4JLtdmWkydPgDDU=TyZNbtiBbgeh1dj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <AANLkTinop4_JT4JLtdmWkydPgDDU=TyZNbtiBbgeh1dj@mail.gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Arnaud Lacombe <lacombar@gmail.com>
Cc: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org, dirk.brandewie@gmail.com, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Nov 16, 2010 at 8:45 PM, Arnaud Lacombe <lacombar@gmail.com> wr=
ote:
> Hi,
>
> [CC: list reduced as starting a new thread, most on the context
> removed as this concern a different issue.]
>
> On Tue, Nov 16, 2010 at 7:16 PM, Grant Likely <grant.likely@secretlab=
=2Eca> wrote:
>> On Tue, Nov 16, 2010 at 3:41 PM, =A0<dirk.brandewie@gmail.com> wrote=
:
>>> From: Dirk Brandewie <dirk.brandewie@gmail.com>
>>> [...]
>> The kernel needs to complain *loudly* if this occurs because it
>> represents a bug. =A0I'm tempted to say use BUG, but that would halt=
 the
>> kernel and prevent any possibility of kernel log output.
>> [...]
> does it ? if CONFIG_BUG is not enabled and the arch has no define for
> it, the default does _nothing_:
>
> from `include/asm-generic/bug.h':
>
> #else /* !CONFIG_BUG */
> #ifndef HAVE_ARCH_BUG
> #define BUG() do {} while(0)
> #endif
>
> #ifndef HAVE_ARCH_BUG_ON
> #define BUG_ON(condition) do { if (condition) ; } while(0)
> #endif
> [...]
>
> gcc is triggering about ~30 warnings (like [0]) on code path using
> BUG(). Most of these path assume BUG() will never return, which is no=
t
> true.

As far as I know, BUG() is not supposed to return.  Period.  The patch
below is part of the linux-tiny work, and should only ever be used on
embedded systems where small size is more important than debugability.

g.

>
> The commit message introducing this behavior state:
>
> commit c8538a7aa5527d02c7191ac5da124efadf6a2827
> Author: Matt Mackall <mpm@selenic.com>
> Date: =A0 Sun May 1 08:59:01 2005 -0700
>
> =A0 =A0[PATCH] remove all kernel BUGs
>
> =A0 =A0This patch eliminates all kernel BUGs, trims about 35k off the=
 typical
> =A0 =A0kernel, and makes the system slightly faster.
>
> =A0 =A0Signed-off-by: Matt Mackall <mpm@selenic.com>
> =A0 =A0Signed-off-by: Andrew Morton <akpm@osdl.org>
> =A0 =A0Signed-off-by: Linus Torvalds <torvalds@osdl.org>
>
> [...]
>
> +config BUG
> + =A0 =A0 =A0 bool "BUG() support" if EMBEDDED
> + =A0 =A0 =A0 default y
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 =A0Disabling this option eliminates support for BUG=
 and WARN, reducing
> + =A0 =A0 =A0 =A0 =A0the size of your kernel image and potentially qu=
ietly ignoring
> + =A0 =A0 =A0 =A0 =A0numerous fatal conditions. You should only consi=
der disabling this
> + =A0 =A0 =A0 =A0 =A0option for embedded systems with no facilities f=
or reporting errors.
>
> So how should BUG() been used ?
> =A01) assuming it will never _ever_ return ?
> =A02) assuming it may return ?
>
> if (1), its definition has to be changed, if (2) a lot of path have t=
o be fixed.

The answer is 1).

g.
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
