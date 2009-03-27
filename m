From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/13] score - New architecure port to SunplusCT S+CORE processor
Date: Fri, 27 Mar 2009 20:19:53 +0100
Message-ID: <200903272019.53689.arnd@arndb.de>
References: <OFE9A5E3A2.37B73BA8-ON48257586.0008CFAC-48257586.00091B05@sunplusct.com> <20090327184013.GB21149@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54684 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753272AbZC0TVN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 27 Mar 2009 15:21:13 -0400
In-Reply-To: <20090327184013.GB21149@uranus.ravnborg.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: liqin.chen@sunplusct.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org

On Friday 27 March 2009, Sam Ravnborg wrote:
> > +struct shmid64_ds {
> > + =A0 =A0 =A0 struct ipc64_perm =A0 =A0 =A0 shm_perm; =A0 =A0 =A0 /=
* operation perms */
> > + =A0 =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0shm_segsz; =
=A0 =A0 =A0/* size of segment (bytes)=20
> > */
> > + =A0 =A0 =A0 __kernel_time_t =A0 =A0 =A0 =A0 shm_atime; =A0 =A0 =A0=
/* last attach time */
> > + =A0 =A0 =A0 __kernel_time_t =A0 =A0 =A0 =A0 shm_dtime; =A0 =A0 =A0=
/* last detach time */
> > + =A0 =A0 =A0 __kernel_time_t =A0 =A0 =A0 =A0 shm_ctime; =A0 =A0 =A0=
/* last change time */
> > + =A0 =A0 =A0 __kernel_pid_t =A0 =A0 =A0 =A0 =A0shm_cpid; =A0 =A0 =A0=
 /* pid of creator */
> > + =A0 =A0 =A0 __kernel_pid_t =A0 =A0 =A0 =A0 =A0shm_lpid; =A0 =A0 =A0=
 /* pid of last operator */
> > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 shm_nattch; =A0 =A0=
 /* no. of current attaches=20
> > */
> > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 __unused1;
> > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 __unused2;
> > +};
>=20
> This is an exported header and you mix wide specific and generic type=
s.
> The recommended way is to stick to the __[u]{32,64}int versions + the=
 kernel
> specific types as __kernel_pid_t.
> In other words avoid use of int, long etc in your exported headers.
>=20

This is correct in general, but in this particular case (SysV IPC) it i=
s
exactly what most of the other architectures do. It's basically impossi=
ble
to get this right, so simply doing the same as x86 is the best option
I found (unlike most of the other headers).

	Arnd <><
