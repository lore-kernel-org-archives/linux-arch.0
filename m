Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:42374
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S933109AbWLaJsD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 31 Dec 2006 04:48:03 -0500
Date: Sun, 31 Dec 2006 01:47:56 -0800 (PST)
Message-Id: <20061231.014756.112264804.davem@davemloft.net>
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
From: David Miller <davem@davemloft.net>
In-Reply-To: <1167557242.20929.647.camel@laptopd505.fenrus.org>
References: <20061230.212338.92583434.davem@davemloft.net>
	<20061231092318.GA1702@flint.arm.linux.org.uk>
	<1167557242.20929.647.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: arjan@infradead.org
Cc: rmk+lkml@arm.linux.org.uk, torvalds@osdl.org, miklos@szeredi.hu, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@osdl.org
List-ID: <linux-arch.vger.kernel.org>

From: Arjan van de Ven <arjan@infradead.org>
Date: Sun, 31 Dec 2006 10:27:22 +0100

> 
> > 
> > However, it's not only FUSE which is suffering - direct-IO also doesn't
> > work. 
> 
> for direct-IO the kernel won't touch the data *at all*... (that's the
> point ;) 
> 
> is it still an issue then?

It can be an issue with virtual caches if the "I/O" is done
using cpu loads and stores, but we should be handling that
with explicit flushing anyways.

The core of the problem is that ARM doesn't look for the user
mappings for anonymous pages when flush_dcache_page() is invoked.
I think as a temporary fix it could walk the RMAP list and
use that to find the user virtual mappings.  Would that work
Russel?
