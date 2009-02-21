From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 1/1] edac x38: new MC driver module
Date: Sat, 21 Feb 2009 10:39:42 +0000
Message-ID: <20090221103942.GA26426@flint.arm.linux.org.uk>
References: <20081129180144.GA15533@uranus.ravnborg.org> <20081130171604.dc3c8715.h.mitake@gmail.com> <20081130083700.GA31644@elte.hu> <20081130092407.GA10802@elte.hu> <20081201002056.d9f9204c.h.mitake@gmail.com> <20081130161504.GA25627@elte.hu> <a6b9f31a0812010551h28c0841fxa2a26af4645df64@mail.gmail.com> <20081201135922.GA30068@elte.hu> <a6b9f31a0812011558o373edbd3r9690efe539d43ca0@mail.gmail.com> <20090221191101.62945118.h.mitake@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:48689 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197AbZBUKlr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 21 Feb 2009 05:41:47 -0500
Content-Disposition: inline
In-Reply-To: <20090221191101.62945118.h.mitake@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hitoshi Mitake <h.mitake@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Sam Ravnborg <sam@ravnborg.org>, "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Luck, Tony" <tony.luck@intel.com>, Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, Doug Thompson <norsk5@yahoo.com>, dougthompson@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

On Sat, Feb 21, 2009 at 07:11:01PM +0900, Hitoshi Mitake wrote:
> But there is problem.
> I wrote helps for HAVE_READQ and HAVE_WRITEQ in Kconfig file
> accodring to the advice by Russell King ( http://marc.info/?l=linux-kernel&m=122701161824218&w=2 ),
> but these helps are invisible when I doing menuconfig.
> (when type '/' and search readq string, HAVE_READQ found, but
> help string is not printed...)

Yes, they will be, because users can't change the options.  The point
of providing a help text for them is so that when someone comes across
the options in a few months or years time, they know what the options
are (supposed to be) doing.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
