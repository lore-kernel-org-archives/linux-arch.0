From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch 0/7] Use strict kernel types to fix the world
Date: Wed, 25 Feb 2009 16:02:56 -0800
Message-ID: <49A5DC30.4080803@zytor.com>
References: <20090225235138.062045835@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:56361 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224AbZBZAGf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 25 Feb 2009 19:06:35 -0500
In-Reply-To: <20090225235138.062045835@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: Sam Ravnborg <sam@ravnborg.org>, Kyle McMartin <kyle@infradead.org>, Ingo Molnar <mingo@elte.hu>, Jaswinder Singh Rajput <jaswinderrajput@gmail.com>, mingo@redhat.com, dwmw2@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

arnd@arndb.de wrote:
> I've gone through the files again and fixed up all
> non-strict types I could find. I did not check all
> architectures for this though.
> 
> I split out netfilter, DRM and MTD, because of both
> size and potentially controversial changes.

I take it this supercedes your previous monolithic patch?

	-hpa
