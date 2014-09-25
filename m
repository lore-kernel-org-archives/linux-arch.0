Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:62566 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110AbaIYKzD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Sep 2014 06:55:03 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 01/29] asm-generic: add generic futex for !CONFIG_SMP
Date: Thu, 25 Sep 2014 12:54:49 +0200
Message-ID: <11277081.DWgcnnZv54@wuerfel>
In-Reply-To: <CAFiDJ58h4VKrr-wHe6iD+aPB8QU=xLo03kW5k6QDpLW5Et0DGw@mail.gmail.com>
References: <1410168160-3624-1-git-send-email-lftan@altera.com> <3608975.MxU44B73lk@wuerfel> <CAFiDJ58h4VKrr-wHe6iD+aPB8QU=xLo03kW5k6QDpLW5Et0DGw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20140925105449.3ZyCjcHdrWevDVmdugp_tur7Dc9ZZzpW4fe_aBbo_eM@z>

On Thursday 25 September 2014 16:33:33 Ley Foon Tan wrote:
> There are 4 patches that touching code outside of arch/nios2,
> including this patch.
> Do we have maintainers for common files for patch #15, #27 and #28
> below? Can't find this info from MAINTAINERS file.
> It is good if you can take a look this v3 patchset so I can send pull
> request if no further issue. Thanks!
> 
> [PATCH v3 01/29] asm-generic: add generic futex for !CONFIG_SMP

You already have my Ack, which is sufficient here.

> [PATCH v3 15/29] Add ELF machine define for Nios2

I'm not maintaining this one, but it looks very obvious, please
add my Ack as well. I don't think you need to wait for anybody's
input here.

> [PATCH v3 27/29] MAINTAINERS: Add nios2 maintainer

This one is fine to go in. You basically own the entry though, so if
anybody wants to change the text for nios2 later, they should ask
for your Ack.

> [PATCH v3 28/29] Documentation: Add documentation for Nios2 architecture

Randy Dunlap <rdunlap@infradead.org> is the maintainer listed for
Documentation, and I see you already have linux-doc@vger.kernel.org
on Cc here. Please make sure that Randy is on Cc for the documentation
patches as well. A lot of documentation patches go in without his
Ack, which I think is fine as long as someone else (i.e. you) is
responsible for maintaining that documentation later.

	Arnd
