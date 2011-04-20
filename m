From: Christoph Lameter <cl@linux.com>
Subject: Re: slub: fix panic with DISCONTIGMEM
Date: Wed, 20 Apr 2011 08:54:23 -0500 (CDT)
Message-ID: <alpine.DEB.2.00.1104200853150.8634@router.home>
References: <1303248576.11237.23.camel@mulgrave.site> <BANLkTinyvO78OnKZGW3jB_N6uao0tppnAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811839-557332752-1303307665=:8634"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp103.prem.mail.ac4.yahoo.com ([76.13.13.42]:22644 "HELO
	smtp103.prem.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753649Ab1DTNy3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 20 Apr 2011 09:54:29 -0400
In-Reply-To: <BANLkTinyvO78OnKZGW3jB_N6uao0tppnAw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, linux-arch@vger.kernel.org, linux-mm@vger.kernel.org, Parisc List <linux-parisc@vger.kernel.org>, Thorsten Glaser <tg@mirbsd.de>, Michael Schmitz <schmitzmic@googlemail.com>, Linux/m68k <linux-m68k@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811839-557332752-1303307665=:8634
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 20 Apr 2011, Geert Uytterhoeven wrote:

> On Tue, Apr 19, 2011 at 23:29, James Bottomley
> <James.Bottomley@hansenpartnership.com> wrote:
> > Slub makes assumptions about page_to_nid() which are violated by
> > DISCONTIGMEM and !NUMA. =C2=A0This violation results in a panic because
> > page_to_nid() can be non-zero for pages in the discontiguous ranges and
> > this leads to a null return by get_node(). =C2=A0The assertion by the
> > maintainer is that DISCONTIGMEM should only be allowed when NUMA is als=
o
> > defined. =C2=A0However, at least six architectures: alpha, ia64, m32r, =
m68k,
> > mips, parisc violate this. =C2=A0The panic is a regression against slab=
, so
> > just mark slub broken in the problem configuration to prevent users
> > reporting these panics.
>
> How does the problem manifest itself? We're having a problem on m68k, whi=
ch
> seems to go away when switching from SLUB to SLAB, or when reverting a co=
mmit
> in [2] (probably this was never reported upstream).

The NULL pointer dereference is typical. If SLUB breaks in this way then
other things are also not functioning in the core.

Guess you are also using DISCONTIG in !NUMA?
---1463811839-557332752-1303307665=:8634--
