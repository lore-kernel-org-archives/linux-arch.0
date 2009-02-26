From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Make exported headers use strict posix types
Date: Thu, 26 Feb 2009 01:01:30 +0100
Message-ID: <200902260101.31580.arnd@arndb.de>
References: <20090225032553.GD6690@bombadil.infradead.org> <20090225201131.GA26110@uranus.ravnborg.org> <49A5CF2E.6050306@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:64934 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763780AbZBZADG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 19:03:06 -0500
In-Reply-To: <49A5CF2E.6050306@zytor.com>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Kyle McMartin <kyle@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Thursday 26 February 2009, H. Peter Anvin wrote:
> Sam Ravnborg wrote:
> >>
> >> This is my previous patch, ported to today's git. It's my last day
> >> before my vacation, so I can't do the usual testing etc. on it.
> >> Hopefully somebody else can take care of this.
> > 
> > I hesitate to put it in kbuild.git... Any better place?
> > 
> 
> I'll put it in tip:core/headers-fixes.

Just in the minute I notice a bug :(

Unfortunately, I mistakenly replaced uid_t with __kernel_uid_t when
it had to be __kernel_uid32_t. New series follows, including the
changes for all integer types.

	Arnd <><
