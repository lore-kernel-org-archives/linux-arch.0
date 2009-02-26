From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 3/7] make MTD headers use strict integer types
Date: Thu, 26 Feb 2009 01:34:53 +0100
Message-ID: <200902260134.54361.arnd@arndb.de>
References: <20090225235138.062045835@arndb.de> <20090225235515.357247809@arndb.de> <82ecf08e0902251632k550156e5k471fc2cab5e9a0fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:57914 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751880AbZBZAfw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 19:35:52 -0500
In-Reply-To: <82ecf08e0902251632k550156e5k471fc2cab5e9a0fd@mail.gmail.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thiago Galesi <thiagogalesi@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>, Kyle McMartin <kyle@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 26 February 2009, Thiago Galesi wrote:
> I don't know if the idea is to do all at once, but MTD has a lot of
> things like u_char as well

I could not find any of those in the exported parts of the MTD headers,
only inside of #ifdef __KERNEL__, where it doesn't do any harm.

	Arnd <><
