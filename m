Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:12877 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965092AbWJBUnk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Oct 2006 16:43:40 -0400
Received: by ug-out-1314.google.com with SMTP id o38so555595ugd
        for <linux-arch@vger.kernel.org>; Mon, 02 Oct 2006 13:43:38 -0700 (PDT)
Message-ID: <d120d5000610021343h45bf1414ica2246f3b10ff46d@mail.gmail.com>
Date: Mon, 2 Oct 2006 16:43:38 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers
In-Reply-To: <20061002132116.2663d7a3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
	 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
	 <20061002132116.2663d7a3.akpm@osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, torvalds@osdl.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Alan Stern <stern@rowland.harvard.edu>
List-ID: <linux-arch.vger.kernel.org>

On 10/2/06, Andrew Morton <akpm@osdl.org> wrote:
> On Mon, 02 Oct 2006 17:21:09 +0100
> David Howells <dhowells@redhat.com> wrote:
>
> > Maintain a per-CPU global "struct pt_regs *" variable which can be used instead
> > of passing regs around manually through all ~1800 interrupt handlers in the
> > Linux kernel.
> >

Nice! I was wanting to do that for a long time...

>
> I think the change is good.  But I don't want to maintain this whopper
> out-of-tree for two months!  If we want to do this, we should just smash it
> in and grit our teeth.

Yes, lets drop it in while we still not reached rc1.

>
> > Some notes on the interrupt handling in the drivers:
> >
> >  (*) input_dev() is now gone entirely.  The regs pointer is no longer stored in
> >      the input_dev struct.

Good riddance... Athough I would not remove input_regs() just yet but
just redefine it to an empty inline and mark it as depreciated so we
won't break all out-of-tree input drivers right away. Removal of
input_regs() from in-tree drivers could be done by separate patch as
well, once main changes are in.

-- 
Dmitry
