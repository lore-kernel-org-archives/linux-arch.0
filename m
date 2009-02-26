Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50927 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751451AbZBZAY7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 19:24:59 -0500
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 0/7] Use strict kernel types to fix the world
Date: Thu, 26 Feb 2009 01:24:12 +0100
References: <20090225235138.062045835@arndb.de> <49A5DC30.4080803@zytor.com>
In-Reply-To: <49A5DC30.4080803@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-ID: <200902260124.13641.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Kyle McMartin <kyle@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20090226002412.zx_BKIRNjsiPllylj-tvg7MsAlgmpUi1rDA5FFZ5NYA@z>

On Thursday 26 February 2009, H. Peter Anvin wrote:
> 
> > I split out netfilter, DRM and MTD, because of both
> > size and potentially controversial changes.
> 
> I take it this supercedes your previous monolithic patch?

Patch 1/7 supercedes my previous patch and is still as monolithic,
except for the separate 6/7 hunk. I only split the integer type
patches by subsystem, but I did these from scratch now.

Patch 7/7 is a new one, based on your input from the last time
we discussed it.

	Arnd <><
