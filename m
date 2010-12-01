From: Greg KH <greg@kroah.com>
Subject: Re: [RFC] persistent store (version 2) (part 1 of 2)
Date: Wed, 1 Dec 2010 14:10:19 -0800
Message-ID: <20101201221019.GA21980@kroah.com>
References: <20101201005851.GA31571@kroah.com>
 <4cf68d6f178373258a@agluck-desktop.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:46952 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844Ab0LAWTn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 1 Dec 2010 17:19:43 -0500
Content-Disposition: inline
In-Reply-To: <4cf68d6f178373258a@agluck-desktop.sc.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu, akpm@linux-foundation.org, ying.huang@intel.com, Borislav Petkov <bp@alien8.de>, David Miller <davem@davemloft.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Jim Keniston <jkenisto@linux.vnet.ibm.com>, Kyungmin Park <kmpark@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Wed, Dec 01, 2010 at 10:01:19AM -0800, Luck, Tony wrote:
> > As you are adding new sysfs files, you are required to document them in
> > Documentation/ABI/ as well.
> 
> Is this what you need?

Yes, looks good, thanks.

greg k-h
