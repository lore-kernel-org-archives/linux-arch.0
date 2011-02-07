From: Dmitry Torokhov <dtor@vmware.com>
Subject: Re: Early crash
Date: Mon, 7 Feb 2011 11:28:30 -0800
Message-ID: <20110207192830.GA23476@dtor-ws.eng.vmware.com>
References: <20110207081933.GA11855@dtor-ws.eng.vmware.com>
 <20110207.005010.28814928.davem@davemloft.net>
 <20110207165829.GA13101@dtor-ws.eng.vmware.com>
 <20110207.112708.193718501.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([65.115.85.69]:40234 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753936Ab1BGT2b (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 7 Feb 2011 14:28:31 -0500
Content-Disposition: inline
In-Reply-To: <20110207.112708.193718501.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: "schwab@linux-m68k.org" <schwab@linux-m68k.org>, "geert@linux-m68k.org" <geert@linux-m68k.org>, "rusty@rustcorp.com.au" <rusty@rustcorp.com.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-m68k@vger.kernel.org" <linux-m68k@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

On Mon, Feb 07, 2011 at 11:27:08AM -0800, David Miller wrote:
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

I see. OK, then I'll prepare a patch to switch over to struct + pointer
scheme.


Thanks,

Dmitry
