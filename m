From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v3 01/29] asm-generic: add generic futex for !CONFIG_SMP
Date: Fri, 26 Sep 2014 16:30:17 +0800
Message-ID: <CAFiDJ5-GGitbYY29=zu=nxTMZFaS1x4-5Mt4W2828vFgQf59qA@mail.gmail.com>
References: <1410168160-3624-1-git-send-email-lftan@altera.com>
	<3608975.MxU44B73lk@wuerfel>
	<CAFiDJ58h4VKrr-wHe6iD+aPB8QU=xLo03kW5k6QDpLW5Et0DGw@mail.gmail.com>
	<11277081.DWgcnnZv54@wuerfel>
	<CAFiDJ58Y1iQhkkS-OVwMBdowJnXKKbYfHttQibmBh_qa5vgOmQ@mail.gmail.com>
	<CAMuHMdX8MD9vynbehHjgVKryfUVAMJduhXjd2XBt58U=djO11Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35458 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753321AbaIZIaU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Sep 2014 04:30:20 -0400
In-Reply-To: <CAMuHMdX8MD9vynbehHjgVKryfUVAMJduhXjd2XBt58U=djO11Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>, Thomas Gleixner <tglx@linutronix.de>

On Fri, Sep 26, 2014 at 2:41 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Sep 26, 2014 at 4:22 AM, Ley Foon Tan <lftan@altera.com> wrote:
>>> Randy Dunlap <rdunlap@infradead.org> is the maintainer listed for
>>> Documentation, and I see you already have linux-doc@vger.kernel.org
>>> on Cc here. Please make sure that Randy is on Cc for the documentation
>>> patches as well. A lot of documentation patches go in without his
>>> Ack, which I think is fine as long as someone else (i.e. you) is
>>> responsible for maintaining that documentation later.
>> Okay, will add Randy to CC list for Documentation patch.
>
> Please change that to Jiri Kosina:
>
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d671e42457e1fef70ad0df07084207078633a9e8
>
Oh, okay. Will CC new maintainer.
Thanks.

Regards
Ley Foon
