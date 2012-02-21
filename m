From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 30/30] x32: Add x32 VDSO support
Date: Tue, 21 Feb 2012 09:51:09 -0800
Message-ID: <4F43D98D.1020406@zytor.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com> <1329696488-16970-31-git-send-email-hpa@zytor.com> <4F42E171.9080005@mit.edu> <4F431665.3010004@zytor.com> <CAObL_7Hy8Y0PWrcZdRSGRcEt+aoma7ax4XU44f-gdHEGoWBzTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:44309 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936Ab2BURv3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Feb 2012 12:51:29 -0500
In-Reply-To: <CAObL_7Hy8Y0PWrcZdRSGRcEt+aoma7ax4XU44f-gdHEGoWBzTg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Lutomirski <luto@mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com

On 02/21/2012 08:52 AM, Andrew Lutomirski wrote:
>>
>> What about non-glibc?
>
> IMO non-glibc users should just call __vdso_clock_gettime, etc.
> Currently, code like:
>
> if (clock_gettime(whatever) == -1)
>    handle_the_error();
>
> is correct when linked against glibc but incorrect when linked
> directly against the vdso.
>

The issue is what uclibc, Bionic, etc. actually do.

	-hpa
