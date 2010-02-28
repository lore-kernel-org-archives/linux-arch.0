From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [GIT PULL] ARM devel (pt 1) updates
Date: Sun, 28 Feb 2010 19:02:41 +0000
Message-ID: <20100228190241.GA9546@flint.arm.linux.org.uk>
References: <20100228180419.GA3480@rmk-PC.arm.linux.org.uk> <10f740e81002281049g3f56ec78v28dfff1a9ab85102@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:50135 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031885Ab0B1TDI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2010 14:03:08 -0500
Content-Disposition: inline
In-Reply-To: <10f740e81002281049g3f56ec78v28dfff1a9ab85102@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Sun, Feb 28, 2010 at 07:49:40PM +0100, Geert Uytterhoeven wrote:
> On Sun, Feb 28, 2010 at 19:04, Russell King <rmk@arm.linux.org.uk> wr=
ote:
> > Linus, Andrew,
> >
> > Please incorporate the latest ARM (for-linus branch) changes, which=
 can be found at:
> >
> > =A0 =A0 =A0 =A0master.kernel.org:/home/rmk/linux-2.6-arm.git for-li=
nus
>=20
> Any specific reason this tree is not stored in
> /pub/scm/linux/kernel/git/rmk/, so
> mere mortals can access it?

I rsync it from various locations with restrictive bandwidths, so the
requirement to pack it is incompatible.  However, it's accessible via:

  http://ftp.arm.linux.org.uk/git/gitweb.cgi?p=3Dlinux-2.6-arm.git;a=3D=
summary
  http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-curr/linux-2.6-a=
rm.git

> > For linux-arch: this contains the patch
> > =A0 =A0 =A0 =A0"MM: Pass a PTE pointer to update_mmu_cache() rather=
 than the PTE itself"
> > which was previously sent to linux-arch for testing.
>=20
> Documentation/cachetlb.txt still lacks documentation for the `pte' pa=
rameter.
> Can you please fix that?

Didn't I reply to your email about that?  No response was forthcoming.

Since I've sent the pull request, it's too late to change the original
commit.

--=20
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
