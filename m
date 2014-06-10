From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC 03/10] tools: Add le_direct/be_direct methods for
 unaligned access
Date: Tue, 10 Jun 2014 16:41:10 -0700
Message-ID: <53979796.40205@zytor.com>
References: <1402441994-16780-1-git-send-email-hpa@zytor.com> <1402441994-16780-4-git-send-email-hpa@zytor.com> <CALCETrUrdvvTc+qt61nQ1iRW4qpyDfMSzqnLKFMUsx7P=XvAfA@mail.gmail.com> <5397952E.9040008@zytor.com> <CALCETrUvN1kYB=Z+wmPfbJawWSHb-r5NhmYLV1ZTxOWmHkanHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38971 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290AbaFJXlf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Jun 2014 19:41:35 -0400
In-Reply-To: <CALCETrUvN1kYB=Z+wmPfbJawWSHb-r5NhmYLV1ZTxOWmHkanHw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>

On 06/10/2014 04:33 PM, Andy Lutomirski wrote:
> 
> Ah, sneaky.
> 
> Would it make sense to put a comment in this file (and similar files)
> indicating that they must only be included on architectures of the
> appropriate endianness?
> 

That might make sense, yes, although I don't think we do that for the
kernel variants.

	-hpa
