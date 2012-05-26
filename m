From: Alessandro Rubini <rubini@gnudd.com>
Subject: Re: [PATCH 6/6] serial: add amba-pl011-pci
Date: Sat, 26 May 2012 09:58:55 +0200
Message-ID: <20120526075855.GA1702@mail.gnudd.com>
References: <201205260739.31653.arnd@arndb.de>
  <cover.1337959750.git.rubini@gnudd.com>
 <b166cb0fce2a67b24da5808604553b4196258f45.1337959750.git.rubini@gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201205260739.31653.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, giancarlo.asnaghi@st.com, alan@linux.intel.com, linux@arm.linux.org.uk, x86@kernel.org, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
