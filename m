Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:27361 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261402AbUCZW55 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Mar 2004 17:57:57 -0500
Date: Fri, 26 Mar 2004 14:57:55 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: [CFT] compat_sys_mount
Message-Id: <20040326145755.02e32de1.davem@redhat.com>
In-Reply-To: <20040326205225.GL25059@parcelfarce.linux.theplanet.co.uk>
References: <20040324154832.GJ25059@parcelfarce.linux.theplanet.co.uk>
	<200403252117.00480.arnd@arndb.de>
	<20040326205225.GL25059@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@debian.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, 26 Mar 2004 20:52:25 +0000
Matthew Wilcox <willy@debian.org> wrote:

> Here's the resulting patch.  Now fully hooked-up and tested on parisc64
> running 32-bit userspace.  I didn't try ncpfs or smbfs.

I just did the same on sparc64, looks fine.
