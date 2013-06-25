From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [Suggestion] arch: avr32: compiler: compiling tools issue
Date: Tue, 25 Jun 2013 15:43:07 +0800
Message-ID: <51C94A0B.7070002@asianux.com>
References: <51C90B06.5070802@asianux.com> <20130625064800.GB23182@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:59709 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751211Ab3FYHn7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2013 03:43:59 -0400
In-Reply-To: <20130625064800.GB23182@samfundet.no>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: =?UTF-8?B?SMOldmFyZCBTa2lubmVtb2Vu?= <hskinnemoen@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 06/25/2013 02:48 PM, Hans-Christian Egtvedt wrote:
> Around Tue 25 Jun 2013 11:14:14 +0800 or thereabout, Chen Gang wrote:
>> > Hello Maintainers:
>> >=20
>> > With allmodconfig, and set "avr32-linux-gnu-" as cross compiler pr=
efix.
>> >=20
>> > It will report error:
>> >   avr32-linux-gnu-gcc: error: unrecognized command line option =E2=
=80=98-mno-pic=E2=80=99
>> >   avr32-linux-gnu-gcc: error: unrecognized command line option =E2=
=80=98-march=3Dap=E2=80=99
>> >=20
>> > The related gcc version:
>> >   [root@dhcp122 linux-next]# rpm -qf /usr/bin/avr32-linux-gnu-gcc
>> >   gcc-avr32-linux-gnu-4.7.1-0.1.20120606.fc17.x86_64
> Interesting version, 4.7.1.
>=20
>> > Can we say: it is compiler's issue, and I need try to compile the =
cross
>> > compiler to test it again ?
> I would assume so, I didn't know Atmel finally pushed all the source =
code to
> support avr32-linux from upstream.
>=20
> I still use a jay old 4.2 based GCC port, which was the last one I us=
ed when
> working for Atmel.

Is it possible to use the compiler tools (may from source code and
compile the compiler tools firstly), to compile the latest upstream
kernel (e.g next-20130624) for avr32 ?

Thanks.
--=20
Chen Gang

Asianux Corporation
