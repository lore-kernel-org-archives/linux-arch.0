Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:36450 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755085AbZBCRI3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Feb 2009 12:08:29 -0500
Message-ID: <498879B3.8030002@zytor.com>
Date: Tue, 03 Feb 2009 09:06:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: + preadv-pwritev-add-preadv-and-pwritev-system-calls.patch added
 to -mm tree
References: <200902022135.n12LZa1a010673@imap1.linux-foundation.org> <49876A91.4000705@zytor.com> <49881904.30705@redhat.com>
In-Reply-To: <49881904.30705@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, arnd@arndb.de, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, ralf@linux-mips.org, tglx@linutronix.de, viro@zeniv.linux.org.uk
Message-ID: <20090203170659.hkdujcoGdi1zZnJ6id2ggmdOnMkjjIkTGr_uuURAJ_w@z>

Gerd Hoffmann wrote:
> H. Peter Anvin wrote:
>> akpm@linux-foundation.org wrote:
>>> This prototype has one problem though: On 32bit archs is the (64bit)
>>> offset argument unaligned, which the syscall ABI of several archs doesn't
>>> allow to do.  At least s390 needs a wrapper in glibc to handle this.  As
>>> we'll need a wrappers in glibc anyway I've decided to push problem to
>>> glibc entriely and use a syscall prototype which works without
>>> arch-specific wrappers inside the kernel: The offset argument is
>>> explicitly splitted into two 32bit values.
>> That rather sucks.  It'd be cleaner to just shuffle the argument order.
> 
> That was discussed too.  Doesn't solve the problem that you need some
> wrap-o-magic in glibc (this time to swap arguments instead of splitting
> the offset).  And is has the drawback that it is confusing to have
> different argument ordering at application and syscall level (think
> strace).  Check the archives for the details.
> 

A pointer would help.

I would say that different argument order in strace is a lot better than
having an argument completely mangled, which is what one gets with this
as proposed.

All in all, I think it is WRONG to make sane architectures suffer for
what broken architectures have to do, and we should implement this the
sane way without any shuffling, splitting, or other braindamage.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.

