Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel10.hp.com ([156.153.255.245]:49899 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263640AbUFNRqo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Jun 2004 13:46:44 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16589.58497.175113.616875@napali.hpl.hp.com>
Date: Mon, 14 Jun 2004 10:46:41 -0700
Subject: Re: [RFC][PATCH 3/3] Convert console list to list_head
In-Reply-To: <20040614134623.E14403@flint.arm.linux.org.uk>
References: <20040614134502.C14403@flint.arm.linux.org.uk>
	<20040614134538.D14403@flint.arm.linux.org.uk>
	<20040614134623.E14403@flint.arm.linux.org.uk>
Reply-To: davidm@hpl.hp.com
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Mon, 14 Jun 2004 13:46:23 +0100, Russell King <rmk@arm.linux.org.uk> said:

  Russell> arch/ia64/hp/sim/simserial.c:extern struct console
  Russell> *console_drivers; /* from kernel/printk.c */
  Russell> arch/ia64/hp/sim/simserial.c: console = console_drivers;

  Russell>   This is interesting - it appears to search the console
  Russell> driver list for the first console, hold a reference to it,
  Russell> and call its write method.  If a console were to be
  Russell> unregistered via unregister_console() this would
  Russell> potentially oops.

True, but since the serial console is almost the only supported
device-driver for the simulator, the likelihood of this happening is
pretty much NIL.  Anyhow, we can certainly adjust simserial if and when
your change goes in.

	--david
