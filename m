Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:52381 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1759460AbWLBQCz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 2 Dec 2006 11:02:55 -0500
Date: Sat, 2 Dec 2006 09:02:52 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061202160252.GQ14076@parisc-linux.org>
References: <20061201172149.GC3078@ftp.linux.org.uk> <1165064370.24604.36.camel@localhost.localdomain> <20061202140521.GJ3078@ftp.linux.org.uk> <1165070713.24604.50.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165070713.24604.50.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Dec 02, 2006 at 03:45:12PM +0100, Thomas Gleixner wrote:
> What's the cruft ? 
> 
> struct bla = container_of(timer, struct bla, timer); ???

That's it, right there.  Any idea how much we've bloated the kernel with
sysfs, just by insisting that the struct device not be the first item in
the struct?  There's any number of 2- and 3- line functions calling each
other, each adding and subtracting constants from the pointers passed to
them.  This was a huge mistake, IMO.
