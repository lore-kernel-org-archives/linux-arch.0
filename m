From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] LLVMLinux: Remove warning about returning an uninitialized
 variable
Date: Mon, 31 Mar 2014 15:19:54 -0700
Message-ID: <5339EA0A.4040200@zytor.com>
References: <1395470329-15065-1-git-send-email-behanw@converseincode.com> <5339D57A.4050504@zytor.com> <5339E7CB.2080001@converseincode.com> <5339E81C.4010901@zytor.com> <5339E946.90903@converseincode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:49781 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026AbaCaWUs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 31 Mar 2014 18:20:48 -0400
In-Reply-To: <5339E946.90903@converseincode.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Behan Webster <behanw@converseincode.com>, arnd@arndb.de
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, dwmw2@infradead.org, pageexec@freemail.hu, Mark Charlebois <charlebm@gmail.com>

On 03/31/2014 03:16 PM, Behan Webster wrote:
>>>
>> __compiletime_error traps at compile time rather than link time, which
>> is what you want.
> The idea is to remove the compile time warning that the return code
> "prev" isn't initialized in the default case. Indicating that
> wrong_size_cmpxchg doesn't return fixes that false positive.
> 

Perhaps __compiletime_error() should have __noreturn built in?

	-hpa
