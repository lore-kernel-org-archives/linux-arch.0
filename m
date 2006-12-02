Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from scrub.xs4all.nl ([194.109.195.176]:2449 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1162500AbWLBVck (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 2 Dec 2006 16:32:40 -0500
From: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [RFC] timers, pointers to functions and type safety
Date: Sat, 2 Dec 2006 22:32:01 +0100
References: <20061201172149.GC3078@ftp.linux.org.uk> <1165070713.24604.50.camel@localhost.localdomain> <20061202160252.GQ14076@parisc-linux.org>
In-Reply-To: <20061202160252.GQ14076@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612022232.03345.zippel@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Thomas Gleixner <tglx@linutronix.de>, Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hi,

On Saturday 02 December 2006 17:02, Matthew Wilcox wrote:

> On Sat, Dec 02, 2006 at 03:45:12PM +0100, Thomas Gleixner wrote:
> > What's the cruft ?
> >
> > struct bla = container_of(timer, struct bla, timer); ???
>
> That's it, right there.  Any idea how much we've bloated the kernel with
> sysfs, just by insisting that the struct device not be the first item in
> the struct?

sysfs is a major bloat indeed, but that's not it.
If at all this generates smaller code, as only one pointer is needed instead 
of two.

bye, Roman
