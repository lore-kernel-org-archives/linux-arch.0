From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/27] asm-generic: add minimal cache description
Date: Fri, 1 May 2009 14:27:04 +0200
Message-ID: <200905011427.05099.arnd@arndb.de>
References: <cover.1241105648.git.arnd@arndb.de> <2d8ccc76119d2379859480dbb8f7562743a1de58.1241105648.git.arnd@arndb.de> <c1a198be0904302303h73c5168fi73f8dc24dc677965@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51946 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbZEAM1J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 May 2009 08:27:09 -0400
In-Reply-To: <c1a198be0904302303h73c5168fi73f8dc24dc677965@mail.gmail.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Simek <monstr@monstr.eu>
Cc: linux-arch@vger.kernel.org, Remis Lima Baima <remis.developer@googlemail.com>, linux-kernel@vger.kernel.org

On Friday 01 May 2009, Michal Simek wrote:
> > +#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
> > + =A0 =A0 =A0 memcpy(dst, src, len)
> > +#define copy_from_user_page(vma, page, vaddr, dst, src, len) \
> > + =A0 =A0 =A0 memcpy(dst, src, len)
>=20
>=20
> IMHO these two macros will generate cast errors.

I did not see errors here, can you clarify? Note that despite the name,
they don't take a __user pointer. Maybe they should be inline functions
to make that more obvious.

	Arnd <><
