From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: c6x: kernel: include "linux/console.h" when 'VT'
 and 'DUMMY_CONSOLE' enabled.
Date: Tue, 25 Jun 2013 15:34:21 +0800
Message-ID: <51C947FD.4000205@asianux.com>
References: <51C8F948.2040204@asianux.com> <CAMuHMdXngNACn+Qfw1ytJkWWLm_BC+g_PTDpHHbUQyeeyVu8Fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:24007 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab3FYHfN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Jun 2013 03:35:13 -0400
In-Reply-To: <CAMuHMdXngNACn+Qfw1ytJkWWLm_BC+g_PTDpHHbUQyeeyVu8Fg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tony Breeds <tony@bakeyournoodle.com>, Mark Salter <msalter@redhat.com>, "a-jacquiot@ti.com" <a-jacquiot@ti.com>, jkc@redhat.com, linux-c6x-dev@linux-c6x.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 06/25/2013 03:06 PM, Geert Uytterhoeven wrote:
> On Tue, Jun 25, 2013 at 3:58 AM, Chen Gang <gang.chen@asianux.com> wr=
ote:
>> > Need include "linux/console.h" when 'VT' and 'DUMMY_CONSOLE' enabl=
ed
>> > (e.g allmodconfig).
>> >
>> > The related error:
>> >   arch/c6x/kernel/setup.c: In function =E2=80=98setup_arch=E2=80=99=
:
>> >   arch/c6x/kernel/setup.c:442:2: error: =E2=80=98conswitchp=E2=80=99=
 undeclared (first use in this function)
>> >   arch/c6x/kernel/setup.c:442:2: note: each undeclared identifier =
is reported only once for each function it appears in
>> >   arch/c6x/kernel/setup.c:442:16: error: =E2=80=98dummy_con=E2=80=99=
 undeclared (first use in this function)
> Ah, so you managed to obtain a c6x toolchain. There's none at
> https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/ yet :-(

Hmm..., I use:
  [root@dhcp122 linux-next]# rpm -qf /usr/bin/c6x-linux-gnu-gcc
  gcc-c6x-linux-gnu-4.7.1-0.1.20120606.fc17.x86_64

When fix the 3 compiling issues, it almost can pass compiling: during
compiled to fs subsystem, I stopped compilation manually.


Thanks.
--=20
Chen Gang

Asianux Corporation
