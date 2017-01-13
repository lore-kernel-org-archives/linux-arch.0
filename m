From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v3 1/8] arm: put types.h in uapi
Date: Fri, 13 Jan 2017 16:35:48 +0000
Message-ID: <27078.1484325348@warthog.procyon.org.uk>
References: <20170113161951.GT14217@n2100.armlinux.org.uk> <1484304406-10820-2-git-send-email-nicolas.dichtel@6wind.com> <3131144.4Ej3KFWRbz@wuerfel> <1484304406-10820-1-git-send-email-nicolas.dichtel@6wind.com> <25063.1484321803@warthog.procyon.org.uk> <4633e475-47f2-5627-81a9-a1747dfddbc0@6wind.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:42360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750953AbdAMQgB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Jan 2017 11:36:01 -0500
In-Reply-To: <20170113161951.GT14217@n2100.armlinux.org.uk>
Content-ID: <27077.1484325348.1@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: dhowells@redhat.com, Nicolas Dichtel <nicolas.dichtel@6wind.com>, arnd@arndb.de, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org

Russell King - ARM Linux <linux@armlinux.org.uk> wrote:
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> > Le 13/01/2017 =C3=A0 16:36, David Howells a =C3=A9crit :
> > > Nicolas Dichtel <nicolas.dichtel@6wind.com> wrote:
> > >=20
> > >> This header file is exported, thus move it to uapi.
> > >=20
> > > Exported how?
> >=20
> > It is listed in include/uapi/asm-generic/Kbuild.asm, which is included =
by
> > arch/arm/include/uapi/asm/Kbuild.
>=20
> We really should not be installing non-uapi header files to userland
> under _any_ circumstance - this to me sounds like a bug in kbuild.

It's not (or was not) a bug exactly - it was something introduced in commit
10b63956fce7f369cc37fd4d994f09bd5203efe4 to ease the transition to using the
UAPI headers as Linus required the commit for each header dir to go through
the submaintainer's tree.

It was supposed to be removed, but that never got posted to Linus because t=
he
next phase of cleanups didn't happen as Linus said he block my email and ne=
ver
take any more patches from me if I sent him any more:-/

David
