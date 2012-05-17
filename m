From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [RFC PATCH 00/10] Use __kernel_[u]long_t for x32 user space compatibility
Date: Thu, 17 May 2012 16:25:53 -0700
Message-ID: <4FB58901.5060604@gmail.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <4FB584C0.6080807@gmail.com> <4FB585B8.2010607@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60722 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab2EQX0L (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 May 2012 19:26:11 -0400
In-Reply-To: <4FB585B8.2010607@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, torvalds@linux-foundation.org, mingo@kernel.org, tglx@linutronix.de

On 05/17/2012 04:11 PM, H. Peter Anvin wrote:
> On 05/17/2012 04:07 PM, David Daney wrote:
>>
>> Has anybody checked how this affects MIPS n32 userspace?
>>
>> I think it totally breaks it.
>>
>
> Do you have any basis whatsoever for that statement?

You should have asked for a 'solid basis'.

My basis is that the name '__kernel_ulong_t' implies, in my mind, that 
it would have the width of a kernel unsigned long.

Really it should be called something like __abi_alternate_ulong_t.

> This should have
> zero effect on any non-x32 platforms.

After further reflection on this, you are probably right.

Sorry for raising the alarm (or would that be crying Wolf?).

>
>> In addition, 109a1f32 (sysinfo: Use explicit types in<linux/sysinfo.h>)
>> is probably bad.  I think it may need to be reverted, or somebody should
>> fix all the __kernel_{,u}long_t definitions for the ABI that may have
>> been broken by the change.
>
> You realize __kernel_[u]long_t didn't even exist until the 3.4 kernel,
> right?

Yes.

David Daney
