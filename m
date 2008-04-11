Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:55299
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1758260AbYDKKQp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 11 Apr 2008 06:16:45 -0400
Date: Fri, 11 Apr 2008 03:16:42 -0700 (PDT)
Message-ID: <20080411.031642.193716019.davem@davemloft.net>
Subject: Re: [PATCH 2/2] kernel: Move arches to use common unaligned access
From: David Miller <davem@davemloft.net>
In-Reply-To: <15208.1207908688@redhat.com>
References: <1207885132.22001.85.camel@brick>
	<15208.1207908688@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: dhowells@redhat.com
Cc: harvey.harrison@gmail.com, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org
Message-ID: <20080411101642.Vn7fU3EzN_b_mdc2T66XBKSiUIRA-W4HkG_gZj0UYNk@z>

From: David Howells <dhowells@redhat.com>
Date: Fri, 11 Apr 2008 11:11:28 +0100

> Harvey Harrison <harvey.harrison@gmail.com> wrote:
> 
> > - * impractical.  So, now we fall back to using memcpy.
> > + * impractical.  So, now we fall back to using memmov.
> 
> That's memmove, not memmov.  Any why memmove, not memcpy?  Is __tmp likely to
> overlap with *ptr?

No, I think it has something to do with what cases GCC is allowed to
optimize the call inline and what cases it cannot wrt.  alignment of
datums.
