From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3] asm-generic: add a generic uaccess.h
Date: Mon, 4 May 2009 12:32:22 +0200
Message-ID: <200905041232.22732.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de> <200905011513.25344.arnd@arndb.de> <49FE861D.5050808@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:63258 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbZEDKcb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2009 06:32:31 -0400
In-Reply-To: <49FE861D.5050808@monstr.eu>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: monstr@monstr.eu
Cc: linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>

On Monday 04 May 2009, Michal Simek wrote:
> #define MAKE_MM_SEG(s)=A0=A0((mm_segment_t) { (s) })
>=20
> #ifndef KERNEL_DS
> #define KERNEL_DS=A0=A0=A0=A0=A0=A0=A0MAKE_MM_SEG(~0UL)
> #endif
>=20
> #ifndef USER_DS
> #define USER_DS=A0=A0=A0=A0=A0=A0=A0=A0=A0MAKE_MM_SEG(TASK_SIZE - 1)
> #endif
>=20
>=20
> #ifndef get_fs
> #define get_ds() (KERNEL_DS)
> #define get_fs() (current_thread_info()->addr_limit)
>=20
> static inline void set_fs(mm_segment_t fs)
> {
> =A0=A0=A0=A0=A0=A0=A0=A0current_thread_info()->addr_limit =3D fs;
> }
> #endif
>=20

yes, looks good. Thanks for the suggestion.

	Arnd <><
