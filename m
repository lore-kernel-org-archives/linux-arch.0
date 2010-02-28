From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [GIT PULL] ARM devel (pt 1) updates
Date: Sun, 28 Feb 2010 19:45:26 +0000
Message-ID: <20100228194526.GD9546@flint.arm.linux.org.uk>
References: <20100228180419.GA3480@rmk-PC.arm.linux.org.uk> <10f740e81002281049g3f56ec78v28dfff1a9ab85102@mail.gmail.com> <20100228190241.GA9546@flint.arm.linux.org.uk> <10f740e81002281141u3a51f368u85830a1da20675dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40613 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936592Ab0B1Tpy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 28 Feb 2010 14:45:54 -0500
Content-Disposition: inline
In-Reply-To: <10f740e81002281141u3a51f368u85830a1da20675dd@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Sun, Feb 28, 2010 at 08:41:22PM +0100, Geert Uytterhoeven wrote:
> On Sun, Feb 28, 2010 at 20:02, Russell King <rmk@arm.linux.org.uk> wr=
ote:
> > On Sun, Feb 28, 2010 at 07:49:40PM +0100, Geert Uytterhoeven wrote:
> >> On Sun, Feb 28, 2010 at 19:04, Russell King <rmk@arm.linux.org.uk>=
 wrote:
> >> > For linux-arch: this contains the patch
> >> > =A0 =A0 =A0 =A0"MM: Pass a PTE pointer to update_mmu_cache() rat=
her than the PTE itself"
> >> > which was previously sent to linux-arch for testing.
> >>
> >> Documentation/cachetlb.txt still lacks documentation for the `pte'=
 parameter.
> >> Can you please fix that?
> >
> > Didn't I reply to your email about that? =A0No response was forthco=
ming.
>=20
> Yes you did; you said "I'm open to suggestions for a suitable
> description for it.".
> Sorry, I forgot to reply that I find that a very uncommon attitude...

Well, what do you want there?  "a pointer to the pte" - that's blatentl=
y
obvious from the fact that it's C declaration is "pte_t *".

--=20
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
