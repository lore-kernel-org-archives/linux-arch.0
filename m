From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH v4 00/24] Introduce little endian bitops
Date: Mon, 17 Jan 2011 09:34:18 +0000
Message-ID: <20110117093418.GA25694@flint.arm.linux.org.uk>
References: <1295183333-13802-1-git-send-email-akinobu.mita@gmail.com> <AANLkTikWZYOqxD_CyJ=zF2Lp2Mnt6Z2E1aPUspwMjrz_@mail.gmail.com> <AANLkTinets0TKJmODLB4u9kH1v_KS3UWfxhvP-UQ=vmP@mail.gmail.com> <AANLkTimvUaGJ1eps5thgBUKjAjXuNN-6O4i-oBXZtQsd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AANLkTimvUaGJ1eps5thgBUKjAjXuNN-6O4i-oBXZtQsd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 16, 2011 at 06:50:39PM -0800, Linus Torvalds wrote:
> On Sun, Jan 16, 2011 at 6:37 PM, Akinobu Mita <akinobu.mita@gmail.com=
> wrote:
> >
> > Changing *_bit_le() to take "void *" instead of "unsigned long *"
> > makes this patch series acceptable?
>=20
> That would seem to at least make all the filesystem code happier, and
> they can continue to do just something like
>=20
>    #define ext2_set_bit __set_bit_le
>=20
> (or whatever the exact sequence ends up being).
>=20
> > Or do we also need to change *_bit_le() to handle unaligned address
> > correctly? =A0(i.e. not only long aligned address but also byte ali=
gned
> > address)
>=20
> No, I don't think that is required. We've never done it before, and
> we've never had the type-safety for the little-endian (aka "minix")
> bitops historically. So I'd just keep the status quo.

The ARM bitops (set_bit/clear_bit/change_bit) have always taken an
unsigned long argument and we have casts in our preprocessor macros
for them.  Only a couple of the find_bit functions have taken a
void pointer.

I really don't want to have to change the function prototypes on ARM,
and I really don't want to hide this fact from non-fs users that ARM
bitops require such pointers, with the exception of what's required
for ext2/minix.  If we do hide it, at some point we'll have someone
believing that ARM's wrong to be requiring stricter alignment.

As ARM bitops now (in my tree) require strict alignment to unsigned lon=
g.
A 32-bit load exclusive assembly instruction must never be misaligned,
there's no way to safely fix that kind thing up.  (No, you can't reliab=
ly
use spinlocks and normal stores - what if another thread does an aligne=
d
load exclusive/store exclusive, which won't trap?)

The reason for this change is to avoid the current situation where peop=
le
are building kernels which support multiple platforms - including SMP -
but because the instructions used for the SMP-safe bitops (byte load
exclusive) are not supported on some of the selected processors, we fal=
l
back to the SMP-unsafe versions.  However, using the word load exclusiv=
e
instructions are supported.

I've also added tests in the assembly to ensure pointer alignment (whic=
h,
as we're talking about filesystem data corruption if for some reason
these misbehave due to misaligned pointers is something I've done anywa=
y).

If the generic bitops are going to be changed to void pointers, maybe t=
he
solution to this is to document that bitops require 'unsigned long *'
alignment on some platforms?
