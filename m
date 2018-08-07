From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 1/2] tty/serial_core: add ISO7816 infrastructure
Date: Tue, 7 Aug 2018 06:32:30 -0700
Message-ID: <20180807133230.GA26577@infradead.org>
References: <20180807130049.5957-1-ludovic.desroches@microchip.com>
 <20180807130049.5957-2-ludovic.desroches@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180807130049.5957-2-ludovic.desroches@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-serial@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, jslaby@suse.com, arnd@arndb.de, richard.genoud@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Aug 07, 2018 at 03:00:48PM +0200, Ludovic Desroches wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Add the ISO7816 ioctl and associated accessors and data structure.
> Drivers can then use this common implementation to handle ISO7816.

It would help a lot of you'd explain what ISO7816 is.  Without that
the changelog is rather meaningless.
