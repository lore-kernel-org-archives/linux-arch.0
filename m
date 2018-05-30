Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51631 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753651AbeE3TzD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 30 May 2018 15:55:03 -0400
Date: Wed, 30 May 2018 21:55:00 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH v3 0/2] mm: PAGE_KERNEL_* fallbacks
Message-ID: <20180530195500.GU4511@wotan.suse.de>
References: <20180510185507.2439-1-mcgrof@kernel.org>
 <20180516164403.GI27853@wotan.suse.de>
 <20180523213551.GF4511@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523213551.GF4511@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: gregkh@linuxfoundation.org, arnd@arndb.de
Cc: willy@infradead.org, geert@linux-m68k.org, linux-m68k@lists.linux-m68k.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, mcgrof@kernel.org
Message-ID: <20180530195500.KSQ0BfBzqsT5-z1pRgXmRCnyedodCMVjYyiRxTZuJ0Y@z>

On Wed, May 23, 2018 at 11:35:51PM +0200, Luis R. Rodriguez wrote:
> On Wed, May 16, 2018 at 06:44:03PM +0200, Luis R. Rodriguez wrote:
> > On Thu, May 10, 2018 at 11:55:05AM -0700, Luis R. Rodriguez wrote:
> > > This is the 3rd iteration for moving PAGE_KERNEL_* fallback
> > > definitions into asm-generic headers. Greg asked for a Changelog
> > > for patch iteration changes, its below.
> > > 
> > > All these patches have been tested by 0-day.
> > > 
> > > Questions, and specially flames are greatly appreciated.
> > 
> > *Poke*
> 
> Greg, since this does touch the firmware loader as well, *poke*.

*Re-re-poke*

  Luis
