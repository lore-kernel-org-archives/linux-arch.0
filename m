Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38881 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752087AbaFJXbN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 10 Jun 2014 19:31:13 -0400
Message-ID: <5397952E.9040008@zytor.com>
Date: Tue, 10 Jun 2014 16:30:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH RFC 03/10] tools: Add le_direct/be_direct methods for
 unaligned access
References: <1402441994-16780-1-git-send-email-hpa@zytor.com> <1402441994-16780-4-git-send-email-hpa@zytor.com> <CALCETrUrdvvTc+qt61nQ1iRW4qpyDfMSzqnLKFMUsx7P=XvAfA@mail.gmail.com>
In-Reply-To: <CALCETrUrdvvTc+qt61nQ1iRW4qpyDfMSzqnLKFMUsx7P=XvAfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20140610233054.VggVRQfRpyLZB-UOkCSgDjVY2sRrmC44NKGytjhD--w@z>

On 06/10/2014 04:25 PM, Andy Lutomirski wrote:
> On Tue, Jun 10, 2014 at 4:13 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> For architectures which handle unaligned references transparently.
> 
> Shouldn't these depend on host endianness?
> 

See further down the series for how these end up being invoked.

	-hpa


