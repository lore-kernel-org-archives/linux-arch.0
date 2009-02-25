From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Make exported headers use strict posix types
Date: Wed, 25 Feb 2009 15:58:39 -0800
Message-ID: <49A5DB2F.6000700@zytor.com>
References: <20090225032553.GD6690@bombadil.infradead.org>	 <200902251917.49017.arnd@arndb.de>	 <20090225201131.GA26110@uranus.ravnborg.org>	 <200902252258.30489.arnd@arndb.de>  <49A5C118.3070605@zytor.com> <1235601586.4913.9.camel@macbook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:45013 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763304AbZBZACj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 19:02:39 -0500
In-Reply-To: <1235601586.4913.9.camel@macbook.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>, Kyle McMartin <kyle@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

David Woodhouse wrote:
>> Not legitimate in *exported* headers.
> 
> Not in the ones which might be included implicitly by glibc, perhaps --
> but other non-POSIX headers are perfectly entitled to require C standard
> types, surely?

It doesn't make any sense, though, when there is a straighforward way to 
deal without.

Now, for source code maintainability reasons I still believe this should 
be done mechanically instead of having to edit the source all over the 
place.

	-hpa
