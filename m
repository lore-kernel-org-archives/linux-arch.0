From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH 00/10] Use __kernel_[u]long_t for x32 user space compatibility
Date: Thu, 17 May 2012 16:31:54 -0700
Message-ID: <4FB58A6A.6020601@zytor.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <4FB584C0.6080807@gmail.com> <4FB585B8.2010607@zytor.com> <4FB58901.5060604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38498 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965781Ab2EQXcH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 May 2012 19:32:07 -0400
In-Reply-To: <4FB58901.5060604@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de

On 05/17/2012 04:25 PM, David Daney wrote:
>>
>> Do you have any basis whatsoever for that statement?
> 
> You should have asked for a 'solid basis'.
> 
> My basis is that the name '__kernel_ulong_t' implies, in my mind, that
> it would have the width of a kernel unsigned long.

The namespace __kernel_* doesn't mean "as used in the kernel" but rather
"exported by the kernel".  But yes, see also Linus' criticism.

	-hpa


-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
