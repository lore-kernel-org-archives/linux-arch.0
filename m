Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:25317 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751416AbWCGS3L (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2006 13:29:11 -0500
Date: Tue, 7 Mar 2006 10:28:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Memory barriers and spin_unlock safety
In-Reply-To: <1141755496.31814.56.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0603071024550.3573@g5.osdl.org>
References: <5041.1141417027@warthog.cambridge.redhat.com>
 <Pine.LNX.4.64.0603030856260.22647@g5.osdl.org>  <32518.1141401780@warthog.cambridge.redhat.com>
  <1146.1141404346@warthog.cambridge.redhat.com>  <31420.1141753019@warthog.cambridge.redhat.com>
 <1141755496.31814.56.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org, ak@suse.de, mingo@redhat.com, jblunck@suse.de, bcrl@linux.intel.com, matthew@wil.cx, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>



On Tue, 7 Mar 2006, Alan Cox wrote:
> 
> What kind of mb/rmb/wmb goes with ioread/iowrite ? It seems we actually
> need one that can work out what to do for the general io API ?

The ioread/iowrite things only guarantee the laxer MMIO rules, since it 
_might_ be mmio. So you'd use the mmio barriers.

In fact, I would suggest that architectures that can do PIO in a more 
relaxed manner (x86 cannot, since all the serialization is in hardware) 
would do even a PIO in the more relaxed ordering (ie writes can at least 
be posted, but obviously not merged, since that would be against PCI 
specs).

x86 tends to serialize PIO too much (I think at least Intel CPU's will 
actually wait for the PIO write to be acknowledged by _something_ on the 
bus, although it obviously can't wait for the device to have acted on it).

			Linus
