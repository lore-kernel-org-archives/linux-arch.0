From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 00/18] uaccess: fix sparse warning on get_user for bitwise types
Date: Tue, 16 Dec 2014 14:06:50 +0800
Message-ID: <CAFiDJ5_BSMXBsv0gmzogyJi1x9-4vAhPpZBwn-_CHYDs0pOfvA@mail.gmail.com>
References: <1418575877-21488-1-git-send-email-mst@redhat.com>
	<CAFiDJ5_fGWx2E1jvU+k0Tv_esRpWmC-p+kq7Y_VOr5bx2ZUFzg@mail.gmail.com>
	<20141215101703.GA26156@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:63758 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbaLPGGw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Dec 2014 01:06:52 -0500
In-Reply-To: <20141215101703.GA26156@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>

On Mon, Dec 15, 2014 at 6:17 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Thanks for the heads up.
> No - it will probably need a similar fix for __get_user and get_user.
> It's just a parse warning so it's not a blocker.
> Can you fix it yourself or prefer me to?
Do you have newer revision of this series?
If yes, then it is great if you can include it. Otherwise, I can fix it.

Regards

Ley Foon
