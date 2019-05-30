From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH, RFC] byteorder: sanity check toolchain vs kernel
 endianess
Date: Thu, 30 May 2019 08:41:31 +0200
Message-ID: <20190530064131.GA29291@lst.de>
References: <20190412143538.11780-1-hch@lst.de> <alpine.DEB.2.20.1905300243200.18422@tpp.hgst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1905300243200.18422@tpp.hgst.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Maciej Rozycki <macro@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "mick@ics.forth.gr" <mick@ics.forth.gr>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, May 30, 2019 at 01:46:18AM +0000, Maciej Rozycki wrote:
> > +#if defined(__BYTE_ORDER__) && __BYTE_ORDER__ != __ORDER_BIG_ENDIAN__
> > +#error "Unsupported endianess, check your toolchain"
> 
>  Typo here: s/endianess/endianness/.

The original patch has already been merged, please send a fixup.
