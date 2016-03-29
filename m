From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 01/31] bitops: add parity functions
Date: Mon, 28 Mar 2016 19:56:04 -0700
Message-ID: <1459220164.25110.41.camel@perches.com>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
	 <56F3A77D.6060802@redhat.com> <56F75490.9010608@gmail.com>
	 <20160328065106.GA12154@ravnborg.org> <56F9E818.1050508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56F9E818.1050508@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Martin Kepplinger <martink@posteo.de>, Sasha Levin <sasha.levin@oracle.com>, Ingo Molnar <mingo@kernel.org>, Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

On Tue, 2016-03-29 at 10:27 +0800, Zeng Zhaoxiu wrote:
> =E5=9C=A8 2016=E5=B9=B403=E6=9C=8828=E6=97=A5 14:51, Sam Ravnborg =E5=
=86=99=E9=81=93:
[]
> > Defining these as static inlines in asm-generic prevent an
> > architecture
> > from selecting between a more optimal asm version or the generic ve=
rsion
> > at run-time.
> > sparc would benefit from this as only some sparc chips supports pop=
c.
> > See how this is done for hweight*
> >=20
> > 	Sam
> Thanks. I will try.

You might also try to describe in any commit message
and perhaps the internal documentation why using gcc's
__builtin_parity isn't appropriate.
