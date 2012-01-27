From: Greg KH <gregkh@suse.de>
Subject: Re: [uml-devel] /sys/class/tty/tty0/active?
Date: Thu, 26 Jan 2012 17:08:38 -0800
Message-ID: <20120127010838.GA27899@suse.de>
References: <CAFLxGvw85fWdsAodBn1Z0vFYZx0U+vYg6hgsBYbmfuyaFTgznA@mail.gmail.com>
 <58311.79.160.186.248.1327615864.squirrel@www.nlc.no>
 <CAFLxGvzsg71gtyPEtOAVnS-DtozYzqgoGNK-ZJRvBfq1mf3Oug@mail.gmail.com>
 <CAFLxGvzffs=uSjxogdWtk_gqoJHPnmgQSLw9WaZRr_be=J5cgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33358 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800Ab2A0BKg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 26 Jan 2012 20:10:36 -0500
Content-Disposition: inline
In-Reply-To: <CAFLxGvzffs=uSjxogdWtk_gqoJHPnmgQSLw9WaZRr_be=J5cgw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kay Sievers <kay.sievers@vrfy.org>, richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: stian@nixia.no, LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net

On Thu, Jan 26, 2012 at 11:56:50PM +0100, richard -rw- weinberger wrote=
:
> On Thu, Jan 26, 2012 at 11:12 PM, richard -rw- weinberger
> <richard.weinberger@gmail.com> wrote:
> > On Thu, Jan 26, 2012 at 11:11 PM, =A0<stian@nixia.no> wrote:
> >>> Hi!
> >>>
> >>> systemd goes nuts on UML.
> >>> While hunting down all issues I found out that systemd wants to r=
ead from
> >>> /sys/class/tty/tty0/active.
> >>
> >> Kernel version?
> >
> > Linus' tree as of today.
>=20
> Hmm, fbc92a34 introduced it.
> But it depends on CONFIG_VT. :-\

Is that a problem for UML somehow?
