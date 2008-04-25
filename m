From: Andreas Schwab <schwab-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 00/24] Unify integer type definitions, and add fixed type constructor macros
Date: Fri, 25 Apr 2008 09:49:45 +0200
Message-ID: <jebq3yjrvq.fsf@sykes.suse.de>
References: <1209078352-7593-1-git-send-email-hpa@zytor.com>
	<Pine.LNX.4.64.0804250915030.21224@anakin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0804250915030.21224@anakin> (Geert Uytterhoeven's
	message of "Fri, 25 Apr 2008 09:17:32 +0200 (CEST)")
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Arch Mailing List <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> writes:

> On Thu, 24 Apr 2008, H. Peter Anvin wrote:
>> This patchset unifies the integer definitions across all the
>> <asm-*/types.h> files, replacing them with two asm-generic files, on=
e
>> for the LL64 model (all 32-bit architectures plus x86-64) and one fo=
r
>> the L64 model (all other 64-bit architectures.)
>
> Just a minor nitpick, what about calling them LP32 and LP64, like
> everybody else does?

LP32 wouldn't fit x86-64 (the header has nothing to say about pointer
types, it's all about integer types).

Andreas.

--=20
Andreas Schwab, SuSE Labs, schwab-l3A5Bk7waGM@public.gmane.org
SuSE Linux Products GmbH, Maxfeldstra=DFe 5, 90409 N=FCrnberg, Germany
PGP key fingerprint =3D 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4=
ED5
"And now for something completely different."
