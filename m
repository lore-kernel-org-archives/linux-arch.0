From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH] Break out types from <linux/list.h> to
 <linux/list_types.h>.
Date: Sat, 3 Jul 2010 11:44:14 +0300
Message-ID: <20100703084414.GA14244@x200>
References: <201007021811.04197.arnd@arndb.de>
 <201007021747.o62HlgmV019405@farm-0002.internal.tilera.com>
 <20100702191910.GA5842@parisc-linux.org>
 <4C2E3F1F.3010202@tilera.com>
 <20100702204817.GB5842@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33539 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047Ab0GCIoU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 3 Jul 2010 04:44:20 -0400
Content-Disposition: inline
In-Reply-To: <20100702204817.GB5842@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Chris Metcalf <cmetcalf@tilera.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Fri, Jul 02, 2010 at 02:48:17PM -0600, Matthew Wilcox wrote:
> On Fri, Jul 02, 2010 at 03:33:52PM -0400, Chris Metcalf wrote:
> > On 7/2/2010 3:19 PM, Matthew Wilcox wrote:
> > > Why a new header file instead of linux/types.h?
> > 
> > I was working from analogy to kvm_types.h, mm_types.h, rwlock_types.h,
> > spinlock_types.h.  My impression is that linux/types.h is generally for
> > basic (non-struct) types, with atomic_t/atomic64_t being added as
> > "almost non-struct types", and of course the historical exception of
> > "struct ustat", which has been there since the dawn of time (0.97 anyway).
> 
> I think list_head, hlist_head and hlist_node qualify as "almost non-struct
> types", don't you?  :-)
> 
> I wouldn't mind seeing kvm_types.h, rwlock_types.h

> and spinlock_types.h

*cough*

You may want to run spinlock_types.h through preprocessor and see how
much garbage it will produce.

> merged into types.h, personally.  They're all pretty fundamental kernel
> kind of types.

Also we care about compilation speed.

> It's a matter of taste, and I'm not particularly fussed one way or the other.
> 
> mm_types.h is complex and full of mm-specific information, so keeping
> it separate makes sense to me.
> 
> I just object to the unnecessary creation of tiny files like this.

Me too. Also jumping over one file to understand what's going on is
better than jumping over multiple files.

> Which is how we ended up with atomic_t and atomic64_t in there in the
> first place :-)
