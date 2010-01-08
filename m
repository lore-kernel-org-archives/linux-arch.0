From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] generic sys_old_select
Date: Fri, 08 Jan 2010 14:22:41 -0800
Message-ID: <4B47B031.5000406@zytor.com>
References: <20100106172112.GA17163@lst.de> <20100106173258.GJ9882@parisc-linux.org> <20100106173438.GA17660@lst.de> <20100106174109.GA30528@ZenIV.linux.org.uk> <20100108093137.GA28722@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:45652 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752564Ab0AHW2G (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Jan 2010 17:28:06 -0500
In-Reply-To: <20100108093137.GA28722@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, dhowells@redhat.com, ysato@users.sourceforge.jp, tony.luck@intel.com, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com

On 01/08/2010 01:31 AM, Christoph Hellwig wrote:
> On Wed, Jan 06, 2010 at 05:41:09PM +0000, Al Viro wrote:
>> Actually, I'd be a lot happier if we had lib/syscall/old_select.c, instead
>> of cluttering fs/select.c with that.  Objections?
> 
> If we do that let's do it consistantly for various old syscalls, not
> an odd one out.

Yes, and it would be a good idea to do so, rather than hiding all these
compatibility calls in all kind of random places.

There is, however, a reason *not* to do it which should be carefully
considered: by co-locating the compatibility version with the modern
version, it gets access to static functions that are part of the
implementation of the modern version.  If we move the compatibility
versions out, it may entail having to export those statics.

	-hpa
