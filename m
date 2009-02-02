Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:60919 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361AbZBBVwk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 2 Feb 2009 16:52:40 -0500
Message-ID: <49876A91.4000705@zytor.com>
Date: Mon, 02 Feb 2009 13:50:09 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: + preadv-pwritev-add-preadv-and-pwritev-system-calls.patch added
 to -mm tree
References: <200902022135.n12LZa1a010673@imap1.linux-foundation.org>
In-Reply-To: <200902022135.n12LZa1a010673@imap1.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, kraxel@redhat.com, arnd@arndb.de, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, ralf@linux-mips.org, tglx@linutronix.de, viro@zeniv.linux.org.uk
Message-ID: <20090202215009.5AYZmoF94yqzhgFBq8_ZpIc4D7SxJYL7QNCoFWEFkYc@z>

akpm@linux-foundation.org wrote:
> 
> This prototype has one problem though: On 32bit archs is the (64bit)
> offset argument unaligned, which the syscall ABI of several archs doesn't
> allow to do.  At least s390 needs a wrapper in glibc to handle this.  As
> we'll need a wrappers in glibc anyway I've decided to push problem to
> glibc entriely and use a syscall prototype which works without
> arch-specific wrappers inside the kernel: The offset argument is
> explicitly splitted into two 32bit values.
> 

That rather sucks.  It'd be cleaner to just shuffle the argument order.

	-hpa
