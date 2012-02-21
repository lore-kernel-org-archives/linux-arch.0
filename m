From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 30/30] x32: Add x32 VDSO support
Date: Tue, 21 Feb 2012 11:03:31 -0800
Message-ID: <4F43EA83.6020203@zytor.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com> <1329696488-16970-31-git-send-email-hpa@zytor.com> <4F42E171.9080005@mit.edu> <4F431665.3010004@zytor.com> <CAObL_7Hy8Y0PWrcZdRSGRcEt+aoma7ax4XU44f-gdHEGoWBzTg@mail.gmail.com> <4F43D98D.1020406@zytor.com> <CAObL_7GqT-CSB6uBoDvKymodEzUi3tY0DJv0U=xzYbaJS7A1nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:44795 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755799Ab2BUTDq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Feb 2012 14:03:46 -0500
In-Reply-To: <CAObL_7GqT-CSB6uBoDvKymodEzUi3tY0DJv0U=xzYbaJS7A1nA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Lutomirski <luto@mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com

On 02/21/2012 10:54 AM, Andrew Lutomirski wrote:
> 
> uclibc hardcodes a call to the vsyscall gettimeofday implementation in
> its locking primitives, which probably gives terrible performance, but
> that's a separate issue.  I think do_emulate_vsyscall should send a
> segfault if called by an x32 task -- there's some security benefit to
> doing so, and there's unlikely to be any downside.
> 

The vsyscall page shouldn't be mapped for x32 tasks...

	-hpa
