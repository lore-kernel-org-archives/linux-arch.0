From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 0/7] Use strict kernel types to fix the world
Date: Thu, 26 Feb 2009 01:56:22 +0100
Message-ID: <20090226005622.GA30255@elte.hu>
References: <20090225235138.062045835@arndb.de> <200902260124.13641.arnd@arndb.de> <49A5E28F.5050209@zytor.com> <200902260152.23410.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:59866 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512AbZBZA4r (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 25 Feb 2009 19:56:47 -0500
Content-Disposition: inline
In-Reply-To: <200902260152.23410.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Kyle McMartin <kyle@infradead.org>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org


* Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 26 February 2009, H. Peter Anvin wrote:
> > I'm really of two minds regarding the patches that replace pure dat=
a=20
> > types (2/7-5/7). =A0Part of me thinks it would be better to do this=
 via a=20
> > script in make headers_install, but another part of me thinks that =
that=20
> > is a recipe for missing includes.
> >=20
> > However, if subsystem maintainers are sharing headers with other=20
> > platforms, it's probably the only sane road to go.
>=20
> The only file I found that is obviously shared across=20
> operating systems is linux/coda.h, and I completely left that=20
> one alone on the basis that the hacks in there should still=20
> work with the new linux/types.h.
>=20
> Doing an automated conversion on coda.h would guarantee=20
> trouble, which I see as an argument for doing the manual=20
> approach in general.
>=20
> The changes outside of mtd, netfilter, drm and pfkeyv2.h are=20
> actually pretty minimal. For reference, all other patches=20
> touching those files since 2.6.28 have a combined diffstat of
>=20
>  include/drm/drm.h                      |   26 +++-
>  include/drm/drm_mode.h                 |  271 ++++++++++++++++++++++=
++++++++++
>  include/drm/i915_drm.h                 |   43 +++++-
>  include/linux/agpgart.h                |    1 -
>  include/linux/cyclades.h               |    2 -
>  include/linux/dvb/audio.h              |    5 -
>  include/linux/dvb/video.h              |    7 +-
>  include/linux/if_pppol2tp.h            |    2 +-
>  include/linux/matroxfb.h               |    2 +-
>  include/linux/mroute6.h                |   26 +++-
>  include/linux/netfilter/x_tables.h     |    2 +-
>  include/linux/netfilter/xt_conntrack.h |    1 +
>  include/linux/pkt_sched.h              |   18 ++
>  include/linux/ppp_defs.h               |    2 +
>  include/linux/time.h                   |    1 +
>  include/linux/types.h                  |   24 ++--
>  include/linux/xfrm.h                   |   14 ++
>  include/mtd/inftl-user.h               |    2 +
>  include/mtd/ubi-user.h                 |  134 +++++++++++++---
>  include/sound/asound.h                 |    1 +
>  20 files changed, 530 insertions(+), 54 deletions(-)
>=20
> As long as the netfilter, mtd and drm maintainers agree, I=20
> don't see anything holding up the convert-everything-now=20
> approach.

In addition to that we could also keep tip:core/header-fixes=20
feature-free and pullable. So should any maintainer run into=20
conflicts in that area the branch could be pulled into that=20
tree. (the branch is focused on fixing the situation so=20
generally pullable.)

	Ingo
