From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/6] serial: add amba-pl011-pci
Date: Sat, 26 May 2012 08:29:19 +0000
Message-ID: <201205260829.19232.arnd@arndb.de>
References: <201205260739.31653.arnd@arndb.de> <b166cb0fce2a67b24da5808604553b4196258f45.1337959750.git.rubini@gnudd.com> <20120526075855.GA1702@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120526075855.GA1702@mail.gnudd.com>
Sender: linux-serial-owner@vger.kernel.org
To: Alessandro Rubini <rubini@gnudd.com>
Cc: linux-kernel@vger.kernel.org, giancarlo.asnaghi@st.com, alan@linux.intel.com, linux@arm.linux.org.uk, x86@kernel.org, gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Saturday 26 May 2012, Alessandro Rubini wrote:
> > Aside from the dma mask, this looks almost entirely generic. Would it
> > be possible to make this a generic pci-amba driver that lives under
> > drivers/amba/ and does not care about the type of device behind it?
> 
> Yes, it's possible. Actually, this was my longer-time plan: propose a
> factorization when more of those were ready.  So I'll remove the
> special name in the device and offer an implementation as generic
> as possible.
> 
> BTW, are the prerequisite patches of with you?
> 

Yes, they all look good to me, although patch 5 would have to change
if you do patch 6 the way we discussed here.

	Arnd
