From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
Date: Thu, 17 May 2012 17:31:20 -0700
Message-ID: <4FB59858.5030800@zytor.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <1337292816-10839-9-git-send-email-hjl.tools@gmail.com> <4FB58EFD.7010302@zytor.com> <CA+55aFy+XOc350sVuLKDHAaKtz9GdLcVmjxs98N8XLTK4zmMYg@mail.gmail.com> <4FB59474.2020505@zytor.com> <4FB597F3.3060909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38866 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759067Ab2ERAch (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 17 May 2012 20:32:37 -0400
In-Reply-To: <4FB597F3.3060909@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ralf Baechle <ralf@linux-mips.org>, "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de

On 05/17/2012 05:29 PM, David Daney wrote:
> 
> I don't know if that answers your question though.
> 

Not in the slightest.  The question is how on Earth struct msqid64_ds
isn't botched on MIPS.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
