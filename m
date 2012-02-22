From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 10/30] compat: Use COMPAT_USE_64BIT_TIME in the Bluetooth
 subsystem
Date: Wed, 22 Feb 2012 14:47:29 +0100 (CET)
Message-ID: <alpine.LRH.2.00.1202221447000.22368@twin.jikos.cz>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com> <1329696488-16970-11-git-send-email-hpa@zytor.com> <20120221190419.GA2914@joana>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120221190419.GA2914@joana>
Sender: linux-kernel-owner@vger.kernel.org
To: Gustavo Padovan <padovan@profusion.mobi>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com, Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

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
