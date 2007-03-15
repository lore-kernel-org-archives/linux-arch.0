Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:52753 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933543AbXCONX6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Mar 2007 09:23:58 -0400
From: Andi Kleen <ak@suse.de>
Subject: Re: PCI DAC DMA APIs
Date: Thu, 15 Mar 2007 14:23:54 +0100
References: <45F94C45.76E4.0078.0@novell.com>
In-Reply-To: <45F94C45.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703151423.54266.ak@suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Jan Beulich <jbeulich@novell.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thursday 15 March 2007 13:38, Jan Beulich wrote:
> While the kernel headers provide for this, there don't appear to be any
> in-tree users (which seems contrary to general Linux policies). Would there
> be objections to remove all of these?

Would be fine for me.

I think the original idea was to optimize for some SPARC systems, but they
were never really used for that.

x86 never needed them.

-Andi
