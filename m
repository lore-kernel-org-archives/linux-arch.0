From: "Luck, Tony" <tony.luck@intel.com>
Subject: RE: [RFC] persistent store (version 2) (part 1 of 2)
Date: Wed, 1 Dec 2010 22:00:12 -0800
Message-ID: <987664A83D2D224EAE907B061CE93D530191F27E0E@orsmsx505.amr.corp.intel.com>
References: <4cf594e21679631af0@agluck-desktop.sc.intel.com>
 <20101201165139.a3bb2199.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:43738 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756291Ab0LBGAP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 2 Dec 2010 01:00:15 -0500
In-Reply-To: <20101201165139.a3bb2199.akpm@linux-foundation.org>
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@elte.hu" <mingo@elte.hu>, "greg@kroah.com" <greg@kroah.com>, "Huang, Ying" <ying.huang@intel.com>, Borislav Petkov <bp@alien8.de>, David Miller <davem@davemloft.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Keniston <jkenisto@linux.vnet.ibm.com>, Kyungmin Park <kmpark@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>

> filenames refer to files!  And lo, that's what we have here.  A
> filesystem!  The files are created by the kernel and are read and
> unlinked by userspace.
>
> So why not implement this whole thing as a proper filesystem?
...
> Wait.  It *is* a filesystem.
...
> So why can't I remove these "records" with rm?

Because I tried to use /sys for this and couldn't find a
way to get notified about "unlink".  Alan Cox called this
bit "daft" in v1 (and I agreed with him). Peter Anvin gave
me some pointers on how easy this would be to do as a real
filesystem ... so v3 will be out in a little while with
this insanity removed.

I'll roll in fixes to address your other comments too.

Thanks for the review.

-Tony
