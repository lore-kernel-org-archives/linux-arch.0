From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: mn10300: Any plans to introduce arch/mn10300/include?
Date: Mon, 1 Dec 2008 14:13:22 +0100
Message-ID: <20081201131322.GA32500@uranus.ravnborg.org>
References: <20081125200644.GA7128@uranus.ravnborg.org> <19366.1228136477@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:34664 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752340AbYLANMB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Dec 2008 08:12:01 -0500
Content-Disposition: inline
In-Reply-To: <19366.1228136477@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Koichi Yasutake <yasutake.koichi@jp.panasonic.com>, linux-am33-list@redhat.com, linux arch <linux-arch@vger.kernel.org>

On Mon, Dec 01, 2008 at 01:01:17PM +0000, David Howells wrote:
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > Almost all other architectures has moved over to arch/$ARCH/include
> > 
> > Are you planning to do so for mn10300 for next merge window?
> > 
> > Remaining ones: frv, h8300, m32r, m68k and mn10300
> > The other are done or have patches queued for next merge window to do so.
> > 
> > Can I be of any help?
> 
> I thought I'd do it after the next merge window.  There are a bunch of patches
> that munge header files around waiting to go in from Harvey Harrison, I
> believe.

Great!

I will drop you a patch later that may help a little.
A fix for kbuild scheduled for next merge window will also help
and you will need that I think.

	Sam
