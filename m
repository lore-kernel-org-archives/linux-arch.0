From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] DEBUGFS: Fixing name for debug fs
Date: Sat, 3 May 2008 23:07:03 +0200
Message-ID: <200805032307.04352.arnd@arndb.de>
References: <monstr@seznam.cz> <1209825314-8048-1-git-send-email-monstr@seznam.cz> <c65b09261996cf3500b6faee201e2dd6c152973e.1209825194.git.monstr@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.179]:57202 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752875AbYECVHG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 3 May 2008 17:07:06 -0400
In-Reply-To: <c65b09261996cf3500b6faee201e2dd6c152973e.1209825194.git.monstr@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>

On Saturday 03 May 2008, monstr@seznam.cz wrote:
> From: Michal Simek <monstr@monstr.eu>
>=20
> This change is made because powerpc_debugfs_root is arch
> specific name.
=2E..
> =A0
> =A0static int powerpc_debugfs_init(void)
> =A0{
> -=A0=A0=A0=A0=A0=A0=A0powerpc_debugfs_root =3D debugfs_create_dir("po=
werpc", NULL);
> +=A0=A0=A0=A0=A0=A0=A0debugfs_root =3D debugfs_create_dir("powerpc", =
NULL);
> =A0

You left the name as "powerpc", which sort of defeats the purpose of yo=
ur
patch. Files in debugfs are by definition not part of the ABI, so it's
actually possible to change this as well. How about making this "of"
instead of "powerpc"?

	Arnd <><
