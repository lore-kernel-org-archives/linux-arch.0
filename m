From: David Howells <dhowells@redhat.com>
Subject: Re: mn10300: Any plans to introduce arch/mn10300/include?
Date: Mon, 01 Dec 2008 13:01:17 +0000
Message-ID: <19366.1228136477@redhat.com>
References: <20081125200644.GA7128@uranus.ravnborg.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:60255 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbYLANB2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 1 Dec 2008 08:01:28 -0500
In-Reply-To: <20081125200644.GA7128@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: dhowells@redhat.com, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com, linux arch <linux-arch@vger.kernel.org>

Sam Ravnborg <sam@ravnborg.org> wrote:

> Almost all other architectures has moved over to arch/$ARCH/include
> 
> Are you planning to do so for mn10300 for next merge window?
> 
> Remaining ones: frv, h8300, m32r, m68k and mn10300
> The other are done or have patches queued for next merge window to do so.
> 
> Can I be of any help?

I thought I'd do it after the next merge window.  There are a bunch of patches
that munge header files around waiting to go in from Harvey Harrison, I
believe.

David
