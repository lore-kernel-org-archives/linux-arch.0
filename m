Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:41000 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757121AbZBYXMh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 18:12:37 -0500
Message-ID: <49A5CF2E.6050306@zytor.com>
Date: Wed, 25 Feb 2009 15:07:26 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH] Make exported headers use strict posix types
References: <20090225032553.GD6690@bombadil.infradead.org> <49A4F051.3000706@zytor.com> <20090225072202.GI6690@bombadil.infradead.org> <200902251917.49017.arnd@arndb.de> <20090225201131.GA26110@uranus.ravnborg.org>
In-Reply-To: <20090225201131.GA26110@uranus.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Kyle McMartin <kyle@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20090225230726.nbFuFFzfI-xfM-VJvlNF2qz4rfmx-OdfarBby6JqH4c@z>

Sam Ravnborg wrote:
>>
>> This is my previous patch, ported to today's git. It's my last day
>> before my vacation, so I can't do the usual testing etc. on it.
>> Hopefully somebody else can take care of this.
> 
> I hesitate to put it in kbuild.git... Any better place?
> 

I'll put it in tip:core/headers-fixes.

	-hpa
