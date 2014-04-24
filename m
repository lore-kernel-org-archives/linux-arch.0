From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Subject: Re: [PATCH 19/28] nios2: Device tree support
Date: Thu, 24 Apr 2014 13:05:45 -0300
Message-ID: <20140424160545.GE1735@arch.cereza>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
 <1397824031-4892-16-git-send-email-lftan@altera.com>
 <201404221542.16481.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201404221542.16481.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Apr 22, Arnd Bergmann wrote:
> On Friday 18 April 2014, Ley Foon Tan wrote:
>=20
> Are these all synthesized devices, or is there also some hardwired
> logic? It often makes sense to split out the reusable parts into
> a separate .dtsi file that gets included by every implementation.
>=20

In case you are not aware of this, devicetree files for Nios-II
SoCs are produced through an automated tool calle sopc2dts:

http://www.alterawiki.com/wiki/Sopc2dts
http://git.rocketboards.org/sopc-tools.git/

You feed it with a sopcinfo file (AFAIK, Altera's specific format) and
you obtain a full-fledged devicetree source file. Usually it works
out-of-the-box, although I like to go over it and fix ranges, whitespac=
es,
and do some cleaning.

So I'm wondering -given we have such superb tool- why would we want to
include the devicetree source's in the kernel?=20

=46irst, we'll be only supporting a *specific* configuration. Second, t=
he
dts is trivially easy to obtain.

The binding documentation should be enough specification, and there's n=
o
need for further reference or examples.
--=20
Ezequiel Garc=EDa, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
