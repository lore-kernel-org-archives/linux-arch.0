From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Early crash
Date: Tue, 8 Feb 2011 13:42:48 +1030
Message-ID: <201102081342.49243.rusty@rustcorp.com.au>
References: <20110207081933.GA11855@dtor-ws.eng.vmware.com> <20110207165829.GA13101@dtor-ws.eng.vmware.com> <20110207.112708.193718501.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:47089 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752762Ab1BHDMw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 7 Feb 2011 22:12:52 -0500
In-Reply-To: <20110207.112708.193718501.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: dtor@vmware.com, schwab@linux-m68k.org, geert@linux-m68k.org, linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, 8 Feb 2011 05:57:08 am David Miller wrote:
> From: Dmitry Torokhov <dtor@vmware.com>
> Date: Mon, 7 Feb 2011 08:58:29 -0800
> 
> > But, theoretically speaking, nothing stops GCC to align pointers with
> > "gaps" as well? Let's say having everything (or some) aligned on
> > quadword boundary even though arch is 32 bit?
> 
> The alignment business only applies to aggregates (ie. structs and
> unions).
> 
> This has been confirmed via several weeks of expermentation with
> different GCC versions on different platforms as well.

But OTOH, this is an old problem which was faced by module params since
pre-git.  And we use the-align-to-void*-size method there; I vaguely recall
inserting it.

You've now got me wondering whether these platforms have broken builtin
module parameters, but I think it would crash iterating if you had any
boot parameters at all if that were the case.

So do we fix that now too, or wait for it to break?
Rusty.
