From: Gustavo Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH 10/30] compat: Use COMPAT_USE_64BIT_TIME in the Bluetooth
 subsystem
Date: Wed, 22 Feb 2012 12:45:58 -0200
Message-ID: <20120222144557.GA21443@joana>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com>
 <1329696488-16970-11-git-send-email-hpa@zytor.com>
 <20120221190419.GA2914@joana>
 <alpine.LRH.2.00.1202221447000.22368@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:36355 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab2BVOqP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2012 09:46:15 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1202221447000.22368@twin.jikos.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Kosina <jkosina@suse.cz>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>

Hi Jiri,

* Jiri Kosina <jkosina@suse.cz> [2012-02-22 14:47:29 +0100]:

> On Tue, 21 Feb 2012, Gustavo Padovan wrote:
> 
> > > From: "H. J. Lu" <hjl.tools@gmail.com>
> > > 
> > > Enable the Bluetooth subsystem to be used with a compat ABI with
> > > 64-bit time.
> > > 
> > > Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> > > Cc: Marcel Holtmann <marcel@holtmann.org>
> > > Cc: Gustavo F. Padovan <padovan@profusion.mobi>
> > > Cc: David S. Miller <davem@davemloft.net>
> > > ---
> > >  net/bluetooth/hci_sock.c |    3 ++-
> > >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > Applied, thanks.
> 
> How much sense does it make to apply this single patch without the 
> previous x32 infrastructure changes?

No sense, I already stepped back with this changes. That's what happens when
you try to apply patches in the middle of the Brazilian Carnival. :)

	Gustavo
