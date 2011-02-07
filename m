From: David Miller <davem@davemloft.net>
Subject: Re: Early crash
Date: Mon, 07 Feb 2011 11:27:08 -0800 (PST)
Message-ID: <20110207.112708.193718501.davem@davemloft.net>
References: <20110207081933.GA11855@dtor-ws.eng.vmware.com>
	<20110207.005010.28814928.davem@davemloft.net>
	<20110207165829.GA13101@dtor-ws.eng.vmware.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20110207165829.GA13101@dtor-ws.eng.vmware.com>
Sender: linux-m68k-owner@vger.kernel.org
To: dtor@vmware.com
Cc: schwab@linux-m68k.org, geert@linux-m68k.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org, linux-m68k@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: Dmitry Torokhov <dtor@vmware.com>
Date: Mon, 7 Feb 2011 08:58:29 -0800

> But, theoretically speaking, nothing stops GCC to align pointers with
> "gaps" as well? Let's say having everything (or some) aligned on
> quadword boundary even though arch is 32 bit?

The alignment business only applies to aggregates (ie. structs and
unions).

This has been confirmed via several weeks of expermentation with
different GCC versions on different platforms as well.
