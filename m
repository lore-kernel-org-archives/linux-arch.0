From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 0/7] Use strict kernel types to fix the world
Date: Thu, 26 Feb 2009 01:52:22 +0100
Message-ID: <200902260152.23410.arnd@arndb.de>
References: <20090225235138.062045835@arndb.de> <200902260124.13641.arnd@arndb.de> <49A5E28F.5050209@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:53463 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbZBZAxf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 19:53:35 -0500
In-Reply-To: <49A5E28F.5050209@zytor.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Kyle McMartin <kyle@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 26 February 2009, H. Peter Anvin wrote:
> I'm really of two minds regarding the patches that replace pure data=20
> types (2/7-5/7). =A0Part of me thinks it would be better to do this v=
ia a=20
> script in make headers_install, but another part of me thinks that th=
at=20
> is a recipe for missing includes.
>=20
> However, if subsystem maintainers are sharing headers with other=20
> platforms, it's probably the only sane road to go.

The only file I found that is obviously shared across operating systems
is linux/coda.h, and I completely left that one alone on the basis
that the hacks in there should still work with the new linux/types.h.

Doing an automated conversion on coda.h would guarantee trouble, which
I see as an argument for doing the manual approach in general.

The changes outside of mtd, netfilter, drm and pfkeyv2.h are actually
pretty minimal. For reference, all other patches touching those files
since 2.6.28 have a combined diffstat of=20

 include/drm/drm.h                      |   26 +++-
 include/drm/drm_mode.h                 |  271 ++++++++++++++++++++++++=
++++++++
 include/drm/i915_drm.h                 |   43 +++++-
 include/linux/agpgart.h                |    1 -
 include/linux/cyclades.h               |    2 -
 include/linux/dvb/audio.h              |    5 -
 include/linux/dvb/video.h              |    7 +-
 include/linux/if_pppol2tp.h            |    2 +-
 include/linux/matroxfb.h               |    2 +-
 include/linux/mroute6.h                |   26 +++-
 include/linux/netfilter/x_tables.h     |    2 +-
 include/linux/netfilter/xt_conntrack.h |    1 +
 include/linux/pkt_sched.h              |   18 ++
 include/linux/ppp_defs.h               |    2 +
 include/linux/time.h                   |    1 +
 include/linux/types.h                  |   24 ++--
 include/linux/xfrm.h                   |   14 ++
 include/mtd/inftl-user.h               |    2 +
 include/mtd/ubi-user.h                 |  134 +++++++++++++---
 include/sound/asound.h                 |    1 +
 20 files changed, 530 insertions(+), 54 deletions(-)

As long as the netfilter, mtd and drm maintainers agree, I don't see
anything holding up the convert-everything-now approach.

	Arnd <><
