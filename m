Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49784 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506Ab2BVNsT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Feb 2012 08:48:19 -0500
Date: Wed, 22 Feb 2012 14:47:29 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 10/30] compat: Use COMPAT_USE_64BIT_TIME in the Bluetooth
 subsystem
In-Reply-To: <20120221190419.GA2914@joana>
Message-ID: <alpine.LRH.2.00.1202221447000.22368@twin.jikos.cz>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com> <1329696488-16970-11-git-send-email-hpa@zytor.com> <20120221190419.GA2914@joana>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gustavo Padovan <padovan@profusion.mobi>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>
Message-ID: <20120222134729.3r9F0PQG5bbeA7LTHez34f1MPuCTSk9DL1bUWWS_emc@z>

On Tue, 21 Feb 2012, Gustavo Padovan wrote:

> > From: "H. J. Lu" <hjl.tools@gmail.com>
> > 
> > Enable the Bluetooth subsystem to be used with a compat ABI with
> > 64-bit time.
> > 
> > Signed-off-by: H. Peter Anvin <hpa@zytor.com>
> > Cc: Marcel Holtmann <marcel@holtmann.org>
> > Cc: Gustavo F. Padovan <padovan@profusion.mobi>
> > Cc: David S. Miller <davem@davemloft.net>
> > ---
> >  net/bluetooth/hci_sock.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> Applied, thanks.

How much sense does it make to apply this single patch without the 
previous x32 infrastructure changes?

-- 
Jiri Kosina
SUSE Labs

