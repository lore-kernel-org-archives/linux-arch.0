Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55545 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757320AbXKOK1I (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2007 05:27:08 -0500
Date: Thu, 15 Nov 2007 10:26:38 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: HAVE or ARCH_HAS or ARCH_SUPPORTS and use of select
Message-ID: <20071115102638.GB748@flint.arm.linux.org.uk>
References: <20071115090215.GA20612@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071115090215.GA20612@uranus.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux arch <linux-arch@vger.kernel.org>, Mathieu Desnoyers <compudj@krystal.dyndns.org>, Randy Dunlap <rdunlap@xenotime.net>
List-ID: <linux-arch.vger.kernel.org>

On Thu, Nov 15, 2007 at 10:02:15AM +0100, Sam Ravnborg wrote:
> automake and friends uses HAVE_ and I dunno about other tools.

For the sake of conciseness, HAVE_ is the obvious winner.  Though
I'm not sure that we particularly go for conciseness:

config ARCH_MAY_HAVE_PC_FDC

I've no particular preference for any particular prefix above
conciseness.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
