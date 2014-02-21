From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RESEND 14/14] x86: locks: remove redundant arch_*_relax
 operations
Date: Fri, 21 Feb 2014 09:39:14 -0800
Message-ID: <53078F42.9080305@zytor.com>
References: <1393004101-25382-1-git-send-email-will.deacon@arm.com> <1393004101-25382-15-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:56662 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753687AbaBURjc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 21 Feb 2014 12:39:32 -0500
In-Reply-To: <1393004101-25382-15-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>

On 02/21/2014 09:35 AM, Will Deacon wrote:
> Now that the arch_{spin,read,write}_relax macros default to cpu_relax(),
> remove the redundant definitions for x86.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: H. Peter Anvin <hpa@zytor.com>
