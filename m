From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Make exported headers use strict posix types
Date: Wed, 25 Feb 2009 22:58:29 +0100
Message-ID: <200902252258.30489.arnd@arndb.de>
References: <20090225032553.GD6690@bombadil.infradead.org> <200902251917.49017.arnd@arndb.de> <20090225201131.GA26110@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:62939 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbZBYV72 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 16:59:28 -0500
In-Reply-To: <20090225201131.GA26110@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Kyle McMartin <kyle@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Wednesday 25 February 2009, Sam Ravnborg wrote:
> > diff --git a/include/linux/mroute6.h b/include/linux/mroute6.h
> > index 5375fac..43dc97e 100644
> > --- a/include/linux/mroute6.h
> > +++ b/include/linux/mroute6.h
> > @@ -65,7 +65,7 @@ struct mif6ctl {
> > =A0=A0=A0=A0=A0=A0mifi_t=A0=A0mif6c_mifi;=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0/* Index of MIF */
> > =A0=A0=A0=A0=A0=A0unsigned char mif6c_flags;=A0=A0=A0=A0=A0=A0/* MI=
=46F_ flags */
> > =A0=A0=A0=A0=A0=A0unsigned char vifc_threshold;=A0=A0=A0/* ttl limi=
t */
> > -=A0=A0=A0=A0=A0u_short=A0 mif6c_pifi;=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0/* the index of the physical IF */
> > +=A0=A0=A0=A0=A0__u16=A0=A0=A0 mif6c_pifi;=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0/* the index of the physical IF */
> > =A0=A0=A0=A0=A0=A0unsigned int vifc_rate_limit;=A0=A0=A0/* Rate lim=
iter values (NI) */
> > =A0};
> > =A0
> This change looks correct - but I assume this is a separate patch.
>=20

Actually, this change does belong in here: This is the only user of u_s=
hort
in exported headers, and nothing uses u_char, u_int or u_long, so it ge=
ts
rid of a whole class of types. The only questionable types left after t=
his
are the standard stdint.h types, many of which are probably legitimate:

grep '\<\(u_\|u\|\)int\(8\|16\|32\|64\)_t\>' obj/usr/include/ -r | \
		 cut -f 1 -d: | uniq -c | grep -v netfilter
      2 obj/usr/include/linux/atmlec.h
     13 obj/usr/include/linux/jffs2.h
      1 obj/usr/include/linux/ivtvfb.h
     12 obj/usr/include/linux/types.h
    121 obj/usr/include/linux/pfkeyv2.h
     13 obj/usr/include/linux/ip_vs.h
     21 obj/usr/include/linux/dm-ioctl.h
      4 obj/usr/include/linux/cm4000_cs.h
      8 obj/usr/include/linux/dlm_netlink.h
      2 obj/usr/include/linux/selinux_netlink.h
     11 obj/usr/include/linux/dvb/video.h
      1 obj/usr/include/linux/dvb/audio.h
     22 obj/usr/include/linux/atmmpc.h
     23 obj/usr/include/linux/coda.h
      1 obj/usr/include/linux/matroxfb.h
     13 obj/usr/include/linux/if_arcnet.h
      8 obj/usr/include/drm/mga_drm.h
      1 obj/usr/include/drm/radeon_drm.h
     20 obj/usr/include/drm/via_drm.h
      9 obj/usr/include/drm/drm.h
     74 obj/usr/include/drm/drm_mode.h
     69 obj/usr/include/drm/i915_drm.h
     15 obj/usr/include/mtd/nftl-user.h
      2 obj/usr/include/mtd/jffs2-user.h
     18 obj/usr/include/mtd/inftl-user.h
     32 obj/usr/include/mtd/mtd-abi.h
     35 obj/usr/include/mtd/ubi-user.h
      4 obj/usr/include/sound/emu10k1.h
      1 obj/usr/include/sound/asound.h

	Arnd <><
