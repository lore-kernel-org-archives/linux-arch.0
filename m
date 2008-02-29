Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from relay2.sgi.com ([192.48.171.30]:42154 "EHLO relay.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753658AbYB2Tch (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 29 Feb 2008 14:32:37 -0500
Date: Fri, 29 Feb 2008 11:32:35 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
Subject: Re: let __dec_zone_page_state use __dec_zone_state
In-Reply-To: <20080229074527.GA32230@digi.com>
Message-ID: <Pine.LNX.4.64.0802291132170.11084@schroedinger.engr.sgi.com>
References: <20080225132648.GA13791@digi.com> <20080225133846.GA9945@flint.arm.linux.org.uk>
 <20080225153208.GA15734@digi.com> <20080225154503.GA16223@digi.com>
 <Pine.LNX.4.64.0802271108500.32462@schroedinger.engr.sgi.com>
 <20080229074527.GA32230@digi.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1700579579-2002042812-1204313555=:11084"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <Uwe.Kleine-Koenig@digi.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1700579579-2002042812-1204313555=:11084
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 29 Feb 2008, Uwe Kleine-K=F6nig wrote:

> Hello Christoph,
>=20
> Christoph Lameter wrote:
> > On Mon, 25 Feb 2008, Uwe Kleine-K=F6nig wrote:
> >=20
> > > This removes code duplication and makes __dec_zone_page_state look li=
ke
> > > __inc_zone_page_state.
> >=20
> > Acked-by: Christoph Lameter <clameter@sgi.com>
> Unless Linus or Andrew take that patch I think the best path for that
> patch into mainline is going over your tree.

I only do slab stuff via my tree. This has to go through Andrew.

---1700579579-2002042812-1204313555=:11084--
