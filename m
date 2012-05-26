Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail2.gnudd.com ([213.203.150.91]:52816 "EHLO mail.gnudd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732Ab2EZH7Y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 26 May 2012 03:59:24 -0400
Date: Sat, 26 May 2012 09:58:55 +0200
From: Alessandro Rubini <rubini@gnudd.com>
Subject: Re: [PATCH 6/6] serial: add amba-pl011-pci
Message-ID: <20120526075855.GA1702@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201205260739.31653.arnd@arndb.de>
References: <201205260739.31653.arnd@arndb.de>
  <cover.1337959750.git.rubini@gnudd.com>
 <b166cb0fce2a67b24da5808604553b4196258f45.1337959750.git.rubini@gnudd.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, giancarlo.asnaghi@st.com, alan@linux.intel.com, linux@arm.linux.org.uk, x86@kernel.org, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20120526075855.vW4coe7_M3JVBtlc5PB64s-3AZsrQ52-ZqBgWJdpmUA@z>

> Aside from the dma mask, this looks almost entirely generic. Would it
> be possible to make this a generic pci-amba driver that lives under
> drivers/amba/ and does not care about the type of device behind it?

Yes, it's possible. Actually, this was my longer-time plan: propose a
factorization when more of those were ready.  So I'll remove the
special name in the device and offer an implementation as generic
as possible.

BTW, are the prerequisite patches of with you?

thanks
/alessandro
