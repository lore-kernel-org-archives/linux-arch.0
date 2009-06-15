From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [GIT PULL] new files for score architecture
Date: Mon, 15 Jun 2009 13:46:01 +0200
Message-ID: <200906151346.02022.arnd@arndb.de>
References: <OF28F09400.68D4B737-ON482575D6.003FA1F3-482575D6.00403088@sunplusct.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56149 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbZFOLqD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2009 07:46:03 -0400
In-Reply-To: <OF28F09400.68D4B737-ON482575D6.003FA1F3-482575D6.00403088@sunplusct.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: liqin.chen@sunplusct.com
Cc: Christoph Hellwig <hch@infradead.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Remis Lima Baima <remis.developer@googlemail.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Monday 15 June 2009, liqin.chen@sunplusct.com wrote:
> Hi Christoph Hellwig,
>=20
> Christoph Hellwig <hch@infradead.org> =D0=B4=D3=DA 2009-06-15 19:26:2=
8:
>=20
> > On Mon, Jun 15, 2009 at 11:21:01AM +0800, liqin.chen@sunplusct.com=20
> wrote:
> > > Hi Linus,
> > >=20
> > > This pack contains initial pack for S+core CPU.
> > > The patches are reviewed by Arnd and many people.
> > > Because I have not get the git repository now,=20
> > > So Arnd kindly commit score patch into=20
> > > git/arnd/asm-generic.git.
> >=20
> > As mentioned before the ptrace implementation is badly wrong as it'=
s
> > been copy and pasted from a years old stage of some other architect=
ure
> > and just munged enough to compile.
> >=20
>=20
> Thanks your comment, I had removed unused code from ptrace.

Ok. Please just send a diff relative to the git tree in my directory,
I'll integrate that.

	Arnd <><
