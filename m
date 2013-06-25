From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [Suggestion] arch: avr32: compiler: compiling tools issue
Date: Tue, 25 Jun 2013 08:48:00 +0200
Message-ID: <20130625064800.GB23182@samfundet.no>
References: <51C90B06.5070802@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:57330 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab3FYGsF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2013 02:48:05 -0400
Content-Disposition: inline
In-Reply-To: <51C90B06.5070802@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: =?iso-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Around Tue 25 Jun 2013 11:14:14 +0800 or thereabout, Chen Gang wrote:
> Hello Maintainers:
>=20
> With allmodconfig, and set "avr32-linux-gnu-" as cross compiler prefi=
x.
>=20
> It will report error:
>   avr32-linux-gnu-gcc: error: unrecognized command line option =E2=80=
=98-mno-pic=E2=80=99
>   avr32-linux-gnu-gcc: error: unrecognized command line option =E2=80=
=98-march=3Dap=E2=80=99
>=20
> The related gcc version:
>   [root@dhcp122 linux-next]# rpm -qf /usr/bin/avr32-linux-gnu-gcc
>   gcc-avr32-linux-gnu-4.7.1-0.1.20120606.fc17.x86_64

Interesting version, 4.7.1.

> Can we say: it is compiler's issue, and I need try to compile the cro=
ss
> compiler to test it again ?

I would assume so, I didn't know Atmel finally pushed all the source co=
de to
support avr32-linux from upstream.

I still use a jay old 4.2 based GCC port, which was the last one I used=
 when
working for Atmel.

--=20
mvh
Hans-Christian Egtvedt
