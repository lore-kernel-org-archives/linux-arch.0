From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Make exported headers use strict posix types
Date: Wed, 25 Feb 2009 14:07:20 -0800
Message-ID: <49A5C118.3070605@zytor.com>
References: <20090225032553.GD6690@bombadil.infradead.org> <200902251917.49017.arnd@arndb.de> <20090225201131.GA26110@uranus.ravnborg.org> <200902252258.30489.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:44813 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219AbZBYWLG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 17:11:06 -0500
In-Reply-To: <200902252258.30489.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, Kyle McMartin <kyle@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Arnd Bergmann wrote:
> 
> Actually, this change does belong in here: This is the only user of u_short
> in exported headers, and nothing uses u_char, u_int or u_long, so it gets
> rid of a whole class of types. The only questionable types left after this
> are the standard stdint.h types, many of which are probably legitimate:
> 

Not legitimate in *exported* headers.

	-hpa
