Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:12760 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751013AbWGCJUl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 Jul 2006 05:20:41 -0400
Date: Mon, 3 Jul 2006 02:20:26 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] s390 kconfig cleanup, 2nd version.
Message-Id: <20060703022026.495cdb2c.akpm@osdl.org>
In-Reply-To: <1151917853.5334.6.camel@localhost>
References: <1151670404.11575.5.camel@localhost>
	<20060630104103.0b394b20.akpm@osdl.org>
	<1151917853.5334.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: schwidefsky@de.ibm.com
Cc: linux-arch@vger.kernel.org, ak@suse.de, geert@linux-m68k.org, Keir.Fraser@cl.cam.ac.uk, chrisw@sous-sol.org, matthew@wil.cx
List-ID: <linux-arch.vger.kernel.org>

On Mon, 03 Jul 2006 11:10:53 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> On Fri, 2006-06-30 at 10:41 -0700, Andrew Morton wrote:
> > Even better would be to teach the Kconfig sytem about this, so in
> > arch/s390/Kconfig we do
> > 
> > disable	VT
> > 
> > and the Kconfig system knows not to offer VT, so there's no need to go
> > adding `depends on !DISABLE_foo' all over the place.  The above DISABLE_foo
> > convention just simulates that missing feature.
> 
> That would be a very useful feature to have. There are some border cases
> where no real positive dependency exist. For that a "disable xxx" would
> be perfect. But we still should use positive dependencies where possible
> to keep the disable lists short.
> 

I don't understand that.

	depends on !DISABLE_FOO

is short?
