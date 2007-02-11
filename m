Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:57752 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647AbXBKD0d (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 10 Feb 2007 22:26:33 -0500
Date: Sun, 11 Feb 2007 03:26:22 +0000
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 192/241] Common compat_sys_sysinfo
Message-ID: <20070211032622.GA8341@infradead.org>
References: <200702100946.l1A9k0VR009254@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200702100946.l1A9k0VR009254@shell0.pdx.osdl.net>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, kyle@parisc-linux.org, hch@infradead.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Feb 10, 2007 at 01:46:00AM -0800, akpm@linux-foundation.org wrote:
> From: Kyle McMartin <kyle@parisc-linux.org>
> 
> I noticed that almost all architectures implemented exactly the same
> sys32_sysinfo...  except parisc, where a bug was to be found in handling of
> the uptime.  So let's remove a whole whack of code for fun and profit. 
> Cribbed compat_sys_sysinfo from x86_64's implementation, since I figured it
> would be the best tested.
> 
> This patch incorporates Arnd's suggestion of not using set_fs/get_fs, but
> instead extracting out the common code from sys_sysinfo.

Looks good to me.

