From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 58/60] microblaze_v4: sys_microblaze.c
Date: Thu, 26 Jun 2008 18:04:24 +0200
Message-ID: <200806261804.25344.arnd@arndb.de>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz> <1214483429-32360-58-git-send-email-monstr@seznam.cz> <1214483429-32360-59-git-send-email-monstr@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55868 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbYFZQFL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jun 2008 12:05:11 -0400
In-Reply-To: <1214483429-32360-59-git-send-email-monstr@seznam.cz>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@seznam.cz
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, stephen.neuendorffer@xilinx.com, John.Linn@xilinx.com, john.williams@petalogix.com, matthew@wil.cx, will.newton@gmail.com, drepper@redhat.com, microblaze-uclinux@itee.uq.edu.au, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, vapier.adi@gmail.com, alan@lxorguk.ukuu.org.uk, hpa@zytor.com, Michal Simek <monstr@monstr.eu>

On Thursday 26 June 2008, monstr@seznam.cz wrote:
> +
> +int sys_uname(struct old_utsname *name)
> +{
> +=A0=A0=A0=A0=A0=A0=A0int err =3D -EFAULT;
> +
> +=A0=A0=A0=A0=A0=A0=A0down_read(&uts_sem);
> +=A0=A0=A0=A0=A0=A0=A0if (name && !copy_to_user(name, utsname(), size=
of(*name)))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0err =3D 0;
> +=A0=A0=A0=A0=A0=A0=A0up_read(&uts_sem);
> +=A0=A0=A0=A0=A0=A0=A0return err;
> +}

This actually seems to be dead code, as your sys_call_table only contai=
ns
sys_newuname but not sys_uname.

	Arnd <><
