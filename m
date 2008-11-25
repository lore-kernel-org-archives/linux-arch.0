From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: mn10300: Any plans to introduce arch/mn10300/include?
Date: Tue, 25 Nov 2008 21:22:12 +0100
Message-ID: <20081125202212.GF7128@uranus.ravnborg.org>
References: <20081125200644.GA7128@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:40688 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751287AbYKYUUt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 25 Nov 2008 15:20:49 -0500
Content-Disposition: inline
In-Reply-To: <20081125200644.GA7128@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com
Cc: linux arch <linux-arch@vger.kernel.org>

On Tue, Nov 25, 2008 at 09:06:44PM +0100, Sam Ravnborg wrote:
> Almost all other architectures has moved over to arch/$ARCH/include
> 
> Are you planning to do so for mn10300 for next merge window?
> 
> Remaining ones: frv, h8300, m32r, m68k and mn10300

h8300 already moved - there was a stale file that fooloed me.
The other got a reminder too but I dropped linux-arch from cc.

	Sam
