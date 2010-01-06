From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] generic sys_old_select
Date: Wed, 06 Jan 2010 09:47:34 -0800
Message-ID: <4B44CCB6.5020408@zytor.com>
References: <20100106172112.GA17163@lst.de> <20100106173258.GJ9882@parisc-linux.org> <20100106173438.GA17660@lst.de> <20100106174109.GA30528@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38097 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006Ab0AFRyR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Jan 2010 12:54:17 -0500
In-Reply-To: <20100106174109.GA30528@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christoph Hellwig <hch@lst.de>, Matthew Wilcox <matthew@wil.cx>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, dhowells@redhat.com, ysato@users.sourceforge.jp, tony.luck@intel.com, geert@linux-m68k.org, zippel@linux-m68k.org, gerg@uclinux.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, jdike@addtoit.com, tglx@linutronix.de, mingo@redhat.com

On 01/06/2010 09:41 AM, Al Viro wrote:
> On Wed, Jan 06, 2010 at 06:34:38PM +0100, Christoph Hellwig wrote:
>> On Wed, Jan 06, 2010 at 10:32:59AM -0700, Matthew Wilcox wrote:
>>> On Wed, Jan 06, 2010 at 06:21:12PM +0100, Christoph Hellwig wrote:
>>>> Add a generic implementation of the old select syscall, which expects it's
>>>> argument in a memory block and switch all architectures over to use it.
>>>
>>> Don't we want an ifdef around compat_sys_old_select() like the one
>>> around sys_old_select()?
>>
>> Because nothing in compat.c does it.  If we want to bother saving those
>> few bites we should do it for more functions, and in a consistant way.
> 
> Actually, I'd be a lot happier if we had lib/syscall/old_select.c, instead
> of cluttering fs/select.c with that.  Objections?

I'd prefer a toplevel directory, syscall/ or libsyscall/, instead of
hiding it under lib/ -- I really wouldn't expect to find full syscall
implementations under lib/ -- but otherwise the idea makes sense.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
