From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 14/28] nios2: DMA mapping API
Date: Fri, 25 Apr 2014 12:33:56 +0200
Message-ID: <5211486.kMbLRJnNBP@wuerfel>
References: <1397824031-4892-1-git-send-email-lftan@altera.com> <201404221552.00501.arnd@arndb.de> <CAFiDJ58__vjDk93crSxGe1us0K7a3kSUwScgk=VaJYy+VqXsWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:50780 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbaDYKd7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 Apr 2014 06:33:59 -0400
In-Reply-To: <CAFiDJ58__vjDk93crSxGe1us0K7a3kSUwScgk=VaJYy+VqXsWQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com

On Friday 25 April 2014 18:13:31 Ley Foon Tan wrote:
> Actually, nios2 doesn't have DMA master with 0x00ffffff mask. I will
> change it to return 1, same as some other architectures
> implementation.
> And the ZONE_DMA stuff will remove as well, it shouldn't have ZONE_DMA
> limitation.

Ok, excellent!

	Arnd
