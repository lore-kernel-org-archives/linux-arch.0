From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/6] serial: add amba-pl011-pci
Date: Sat, 26 May 2012 07:39:31 +0000
Message-ID: <201205260739.31653.arnd@arndb.de>
References: <cover.1337959750.git.rubini@gnudd.com> <b166cb0fce2a67b24da5808604553b4196258f45.1337959750.git.rubini@gnudd.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b166cb0fce2a67b24da5808604553b4196258f45.1337959750.git.rubini@gnudd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alessandro Rubini <rubini@gnudd.com>
Cc: linux-kernel@vger.kernel.org, Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Alan Cox <alan@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Friday 25 May 2012, Alessandro Rubini wrote:
> 
> This is a simple PCI driver that registers an amba device
> in its probe function. It successfully drives the 4 serial
> ports of the sta2x11 I/O Hub.
> 
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

Aside from the dma mask, this looks almost entirely generic. Would it
be possible to make this a generic pci-amba driver that lives under
drivers/amba/ and does not care about the type of device behind it?

	Arnd
