From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 45/56] microblaze_v2: headers simple files - empty or redirect to asm-generic
Date: Tue, 6 May 2008 18:21:13 +0200
Message-ID: <200805061821.14391.arnd@arndb.de>
References: <1209901305-6404-1-git-send-email-monstr@seznam.cz> <20080507004702.d516a727.sfr@canb.auug.org.au> <482077FE.7080201@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764760AbYEFQWD@vger.kernel.org>
In-Reply-To: <482077FE.7080201@seznam.cz>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: monstr@seznam.cz
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, John Williams <john.williams@petalogix.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca
List-Id: linux-arch.vger.kernel.org

On Tuesday 06 May 2008, Michal Simek wrote:
>=20
> > Absolutely, but is it really necessary to have 14-16 lines of comme=
nt
> > (including a copyright notice) for a file whose single real line is=
 just
> > to include another file? =A0i.e. reduce all these to 1 line files.
>=20
> Can I do it? I think every file need license.

If you want a good answer on that, ask your lawyer. In general, every f=
ile
comes with a 'license' (GPLv2) and 'copyright' (you or the person you c=
opied
from) even if you don't put either statement in the file. Files smaller=
 than
some 10 lines are usually not considered to be covered by copyright, ev=
en
if you have the statement in there.

Most files nowadays are written by large corporations that have strict =
rules
about what you must put in there to protect their intellectual property=
=2E

It's certainly safe to leave out the file names from the comments, they=
 don't
add any value at all.
Similarly, you should easily be able to leave out the license statement=
,
unless you are under a contract that forces you to leave them present.
Most people here will be happier if you remove the license statements.

The most tricky one part is the copyright statement ("Copyright 2012
Big Corporation of America"), which you strictly speaking should never
remove from a file unless you have permission from the copyright holder=
=2E
Many of your files in your patch set are obviously copies of existing
kernel files, with the original copyright notice replaced with "Atmark
Techno, inc.". You can draw your own conclusions from that ;-)

Obviously, I am not a lawyer, so don't consider this as legal advice.

I really hope this doesn't turn into a flamewar, as discussions on
intellectual property sometimes do.

	Arnd <><
