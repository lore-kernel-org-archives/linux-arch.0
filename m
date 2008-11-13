From: Hitoshi Mitake <h.mitake@gmail.com>
Subject: Re: [PATCH 1/1] edac x38: new MC driver module
Date: Fri, 14 Nov 2008 00:15:14 +0900
Message-ID: <20081114001514.ea469b4f.h.mitake@gmail.com>
References: <20081105222911.d76e7e1c.mitake@clustcom.com>
	<413709.12821.qm@web50106.mail.re2.yahoo.com>
	<20081106164641.ed369060.akpm@linux-foundation.org>
	<20081107152830.a42766f3.mitake@clustcom.com>
	<20081106223122.8a255211.akpm@linux-foundation.org>
	<20081107153824.0ec934e6.mitake@clustcom.com>
	<20081106231102.aab83cd4.akpm@linux-foundation.org>
	<a6b9f31a0811090710y17e956bawf20675d6678b145e@mail.gmail.com>
	<20081109112646.97c594b5.akpm@linux-foundation.org>
	<20081111061140.GB32733@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:44532 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbYKMPPV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 13 Nov 2008 10:15:21 -0500
Received: by an-out-0708.google.com with SMTP id d40so425431and.1
        for <linux-arch@vger.kernel.org>; Thu, 13 Nov 2008 07:15:20 -0800 (PST)
In-Reply-To: <20081111061140.GB32733@linux-sh.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mundt <lethal@linux-sh.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hitoshi Mitake <mitake@clustcom.com>, Doug Thompson <norsk5@yahoo.com>, dougthompson@xmission.com, linux-kernel@vger.kernel.org, ktaka@clustcom.com, linux-arch@vger.kernel.org

On Tue, 11 Nov 2008 15:11:40 +0900
Paul Mundt <lethal@linux-sh.org> wrote:

> On Sun, Nov 09, 2008 at 11:26:46AM -0800, Andrew Morton wrote:
> > (cc linux-arch)
> > 
> > > It seems that architectures that provide readq/writeq are
> > > mips, parisc and x86 (and x86_64).
> > > 
> There are more than that, grep arch/*/include also.
> 
> In addition to mips, parisc, and x86, there is ia64, alpha, sh, and
> sparc.

I didn't noticed these functions, thanks.

> 
> > #ifdef readq
> > 
> > Is a suitable way of determining whether the architecture implements
> > readq and writeq.  It isn't pretty, but it will suffice.
> > 
> > A problem with it is that drivers will then do
> > 
> > #ifndef readq
> > <provide a local implementation here>
> > #endif
> > 
> > which rather sucks - we don't want lots of little private readq/writeq
> > implementations all over the tree.
> > 
> > Perhaps it would be better to have a CONFIG_ARCH_HAS_READQ and to then
> > disable these drivers on the architectures which don't provide
> > readq/writeq support.
> > 
> However this is handled, we don't want a rehash of the read/writes{b,w,l} fiasco.
> 
> Allowing drivers to do their own local implementations of these things
> has always been a complete disaster. A Kconfig option will at least take
> care of having these craptastic ifdef lists for architectures in every
> driver that rolls its own implementation.
> 
> Even a sub-optimal asm-generic version would be preferable, if the
> semantics are well enough defined and consistently adhered to.

I found nice source file, lib/iomap.c.
There are architecture independent read/write{b,w,l} (named like ioread8).

I want to implement architecture independent readq/writeq in lib/iomap.c .
Andrew told,

> Perhaps it would be better to have a CONFIG_ARCH_HAS_READQ and to then
> disable these drivers on the architectures which don't provide
> readq/writeq support.

But I want to use x38_edac.c on x86_32 environment,
and I think similar desire may occur in the future.

Is this way good enough? Request for comment.
