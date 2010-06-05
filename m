From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 0/8] revised patch for arch/tile/ support
Date: Sat, 5 Jun 2010 22:56:05 +1000
Message-ID: <20100605225605.4e44d4e4.sfr@canb.auug.org.au>
References: <201005200543.o4K5hFRF006079@farm-0002.internal.tilera.com>
	<201005290333.o4T3Xjse029917@farm-0002.internal.tilera.com>
	<201005291329.10941.arnd@arndb.de>
	<201006032240.31963.arnd@arndb.de>
	<4C097104.3080406@tilera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__5_Jun_2010_22_56_05_+1000_X7A65JfOHuU./vR5"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from chilli.pcug.org.au ([203.10.76.44]:51771 "EHLO smtps.tip.net.au"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933259Ab0FEM4N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 5 Jun 2010 08:56:13 -0400
In-Reply-To: <4C097104.3080406@tilera.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org

--Signature=_Sat__5_Jun_2010_22_56_05_+1000_X7A65JfOHuU./vR5
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Fri, 04 Jun 2010 17:32:52 -0400 Chris Metcalf <cmetcalf@tilera.com> wrot=
e:
>
> On 6/3/2010 4:40 PM, Arnd Bergmann wrote:
> > You evidently didn't make it into -rc1, probably because Linus consider=
ed
> > your submission to be too late, or possibly because some of the bigger
> > patches got lost in an email filter.
> >
> > To go forward with your architecture, I suggest that you start adding it
> > to the linux-next tree. Until you have a git tree, the easiest way
> > to do that is to put a tarball in quilt format at a http url under
> > your control, and ask Stephen to include that.
>=20
> I've set up a GIT tree for the Tilera architecture support here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/cmetcalf/linux-tile.git
>=20
> I kept the commit to fix up the "generic" unistd.h ABI and added Arnd's
> Acked-by to the commit message, and I combined the v2 Tilera-specific
> series of patches along with responses to the v2 patches into a single
> commit, with appropriate Acked-by and Reviewed-by based on what folks
> had said.
>=20
> Stephen, in an ideal world you could add this repository to your set of
> things you pull from into linux-next, and going forward I would then be
> the gatekeeper for "arch/tile/" changes.  I'll plan to continue mailing
> the diffs to LKML for public review, and push them up to git.kernel.org
> after feedback has died down and they are ready to go to linux-next.=20
> Does that sound good to you?

That sounds pretty good.  I have added the master branch from that tree
and it will appear in linux-next from Monday.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgment of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window.=20

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
	Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

Legal Stuff:
By participating in linux-next, your subsystem tree contributions are
public and will be included in the linux-next trees.  You may be sent
e-mail messages indicating errors or other issues when the
patches/commits from your subsystem tree are merged and tested in
linux-next.  These messages may also be cross-posted to the linux-next
mailing list, the linux-kernel mailing list, etc.  The linux-next tree
project and IBM (my employer) make no warranties regarding the linux-next
project, the testing procedures, the results, the e-mails, etc.  If you
don't agree to these ground rules, let me know and I'll remove your tree
from participation in linux-next.

--Signature=_Sat__5_Jun_2010_22_56_05_+1000_X7A65JfOHuU./vR5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkwKSWUACgkQjjKRsyhoI8zjTACeOOcqzqJK/uiQvSrY3Dho0lLU
uAcAnA2RC/YwPkZauloAJGZWGmohoQ/I
=+dGk
-----END PGP SIGNATURE-----

--Signature=_Sat__5_Jun_2010_22_56_05_+1000_X7A65JfOHuU./vR5--
