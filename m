From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC] persistent store (version 2) (part 1 of 2)
Date: Thu, 2 Dec 2010 02:12:16 -0800
Message-ID: <20101202021216.2d7c33f8.akpm@linux-foundation.org>
References: <4cf594e21679631af0@agluck-desktop.sc.intel.com>
	<20101201165139.a3bb2199.akpm@linux-foundation.org>
	<987664A83D2D224EAE907B061CE93D530191F27E0E@orsmsx505.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:60801 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751043Ab0LBKOT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Dec 2010 05:14:19 -0500
In-Reply-To: <987664A83D2D224EAE907B061CE93D530191F27E0E@orsmsx505.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "greg@kroah.com" <greg@kroah.com>, "Huang, Ying" <ying.huang@intel.com>, Borislav Petkov <bp@alien8.de>, David Miller <davem@davemloft.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Keniston <jkenisto@linux.vnet.ibm.com>, Kyungmin Park <kmpark@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Wed, 1 Dec 2010 22:00:12 -0800 "Luck, Tony" <tony.luck@intel.com> wrote:

> > filenames refer to files!  And lo, that's what we have here.  A
> > filesystem!  The files are created by the kernel and are read and
> > unlinked by userspace.
> >
> > So why not implement this whole thing as a proper filesystem?
> ...
> > Wait.  It *is* a filesystem.
> ...
> > So why can't I remove these "records" with rm?
> 
> Because I tried to use /sys for this and couldn't find a
> way to get notified about "unlink".  Alan Cox called this
> bit "daft" in v1 (and I agreed with him). Peter Anvin gave
> me some pointers on how easy this would be to do as a real
> filesystem ... so v3 will be out in a little while with
> this insanity removed.

OK.  Yes, the correct answer is usually "create a new filesystem
driver" ;)

<greps>

gad, there are over 200 register_filesystem() callsites.

One thing which does leap out of the v2 implementation is the hardwired
assumption that there is one store kernel-wide.  I suppose that's OK as
a version-1 implementation detail thing, but we should avoid hardwiring
that assumption into the presentation of v1's userspace interfaces.
