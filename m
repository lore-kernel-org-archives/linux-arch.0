From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 09/11] sysctl: x86 Use the compat_sys_sysctl
Date: Thu, 05 Nov 2009 17:15:16 -0800
Message-ID: <m14op8tpwb.fsf@fess.ebiederm.org>
References: <m1tyx8trik.fsf@fess.ebiederm.org>
	<1257468114-6823-9-git-send-email-ebiederm@xmission.com>
	<4AF37425.9060000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:50375 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757333AbZKFBPP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2009 20:15:15 -0500
In-Reply-To: <4AF37425.9060000@zytor.com> (H. Peter Anvin's message of "Thu\, 05 Nov 2009 16\:56\:05 -0800")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>

"H. Peter Anvin" <hpa@zytor.com> writes:

> On 11/05/2009 04:41 PM, Eric W. Biederman wrote:
>> From: Eric W. Biederman <ebiederm@xmission.com>
>> 
>> Now that we have a generic 32bit compatibility implementation
>> there is no need for x86 to implement it's own.
>> 
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
>
> Acked-by: H. Peter Anvin <hpa@zytor.com>
>
> I'm assuming based on your previous email that you'll hang on to this
> patch and carry it yourself.

That's the plan.

Eric
