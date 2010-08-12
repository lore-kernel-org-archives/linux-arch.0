From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: + drivers-acpi-apei-erst-dbgc-get_useru64-doesnt-work-on-i386.patch
 added to -mm tree
Date: Wed, 11 Aug 2010 22:06:08 -0700
Message-ID: <4C638140.1080202@zytor.com>
References: <201008112336.o7BNaNEj020805@imap1.linux-foundation.org>	<20100811164310.a4790773.randy.dunlap@oracle.com>	<20100811173327.3ae325ff.akpm@linux-foundation.org>	<4C63771B.6030005@zytor.com> <20100811213013.ab501c6e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:48829 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085Ab0HLFGs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 12 Aug 2010 01:06:48 -0400
In-Reply-To: <20100811213013.ab501c6e.akpm@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org, gcosta@redhat.com, lenb@kernel.org, mingo@elte.hu, tglx@linutronix.de, ying.huang@intel.com, Linux Arch Mailing List <linux-arch@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

On 08/11/2010 09:30 PM, Andrew Morton wrote:
> 
> It occurs so rarely that it's probably not worth bothering about, IMO.
> 

I think the real question is if we want people to convert:

	if (copy_from_user(foo, bar, sizeof *foo))
		return -EFAULT;

... into ...

	if (get_user(*foo, bar))
		return -EFAULT;

... or ...

	rv = get_user(*foo, bar);
	if (rv)
		return rv;

... where *foo is a structure type.  It does have the advantage that a
single API does everything, simple or not, but has the disadvantage that
the partial-access semantics are now less explicit.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
