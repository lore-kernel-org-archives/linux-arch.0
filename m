From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/8] Update kernel uabi header files for x32
Date: Mon, 20 Jan 2014 09:46:41 -0800
Message-ID: <52DD6101.4010708@zytor.com>
References: <1388182464-28428-1-git-send-email-hjl.tools@gmail.com> <20131228163308.GA1638@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:48920 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbaATRra (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 20 Jan 2014 12:47:30 -0500
In-Reply-To: <20131228163308.GA1638@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, "H.J. Lu" <hjl.tools@gmail.com>, linux-arch <linux-arch@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>

On 12/28/2013 08:33 AM, Christoph Hellwig wrote:
> On Fri, Dec 27, 2013 at 02:14:16PM -0800, H.J. Lu wrote:
>> X32 uses the same kernel system call interface as x86-64 for many
>> system calls.  However, "long" is 64-bit for x86-64 and is 32-bit for
>> x32.  Where long or unsigned long are used in struct types for such
>> system calls, they are wrong for x32.  __kernel_[u]long_t is [unsigned]
>> long for all ABIs other than x32.  I am submitting 8 patches to replace
>> long or unsigned long with __kernel_[u]long_t so that those struct types
>> can be used with x32 system calls.
> 
> Independent on how this fixes things, how does the kernel_long_t name
> here make any sense?
> 
> On x86-64 "kernel" long always is 64 bits wide.  The userspace ABI long
> might be 32 or 64bits wide.
> 
> Currently kernel_long_t has almost no uses, so it might be a good time
> to fix the name, define the rules for it, and last but not least
> properly document the intent for thse types.
> 

This comment by Christoph was literally the only feedback on this
patchset.  The definition of __kernel_[u]long_t is "the size of 'long'
for the native kernel for the ABI".  H.J.'s patchset only affects x86
(specifically x86-64) since on all other platforms __kernel_[u]long_t is
simply defined as long/unsigned long.

That being said, x32 is not the only ABI of this type.  In particular,
if the MIPS N32 and ARM64 ILP32 maintainers have suggestions which would
make this work more applicable to them, it would be highly useful to
receive any such feedback.

	-hpa
