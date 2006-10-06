Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:40091 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932610AbWJFUjU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 6 Oct 2006 16:39:20 -0400
Date: Fri, 6 Oct 2006 14:39:19 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 1/4] LOG2: Implement a general integer log2 facility in the kernel [try #4]
Message-ID: <20061006203919.GS2563@parisc-linux.org>
References: <20061006133414.9972.79007.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0610062232210.30417@yvahk01.tjqt.qr>
Sender: linux-arch-owner@vger.kernel.org
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Oct 06, 2006 at 10:33:19PM +0200, Jan Engelhardt wrote:
> 
> >+ *   the massive ternary operator construction
> >+	(sizeof(n) <= 4) ?			\
> >+	__ilog2_u32(n) :			\
> >+	__ilog2_u64(n)				\
> 
> Should not this be: sizeof(n) <= sizeof(u32)

Were you planning on porting Linux to a machine with non-8-bit-bytes any
time soon?  Because there's a lot more to fix than this.
