Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:46261 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750917AbZBCKP0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 3 Feb 2009 05:15:26 -0500
Message-ID: <49881904.30705@redhat.com>
Date: Tue, 03 Feb 2009 11:14:28 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
MIME-Version: 1.0
Subject: Re: + preadv-pwritev-add-preadv-and-pwritev-system-calls.patch added
 to -mm tree
References: <200902022135.n12LZa1a010673@imap1.linux-foundation.org> <49876A91.4000705@zytor.com>
In-Reply-To: <49876A91.4000705@zytor.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, arnd@arndb.de, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, ralf@linux-mips.org, tglx@linutronix.de, viro@zeniv.linux.org.uk
Message-ID: <20090203101428.OCG4EIynGmrQjNKdzWjsHhTQVCR1RqMVFtYbQJSSXTU@z>

H. Peter Anvin wrote:
> akpm@linux-foundation.org wrote:
>>
>> This prototype has one problem though: On 32bit archs is the (64bit)
>> offset argument unaligned, which the syscall ABI of several archs doesn't
>> allow to do.  At least s390 needs a wrapper in glibc to handle this.  As
>> we'll need a wrappers in glibc anyway I've decided to push problem to
>> glibc entriely and use a syscall prototype which works without
>> arch-specific wrappers inside the kernel: The offset argument is
>> explicitly splitted into two 32bit values.
> 
> That rather sucks.  It'd be cleaner to just shuffle the argument order.

That was discussed too.  Doesn't solve the problem that you need some
wrap-o-magic in glibc (this time to swap arguments instead of splitting
the offset).  And is has the drawback that it is confusing to have
different argument ordering at application and syscall level (think
strace).  Check the archives for the details.

cheers,
  Gerd

