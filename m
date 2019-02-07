Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfBGUAl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 7 Feb 2019 15:00:41 -0500
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
 <20190207195119.lglz4lb7cnf4ndn2@linux-r8p5>
From: Waiman Long <longman@redhat.com>
Message-ID: <45b7bbb8-c953-9951-ae6f-e2c3202e5cf2@redhat.com>
Date: Thu, 7 Feb 2019 15:00:24 -0500
MIME-Version: 1.0
In-Reply-To: <20190207195119.lglz4lb7cnf4ndn2@linux-r8p5>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <20190207200024.yV7ws6KmHh6eBOZEcsKNAOrLimfWnNu39j6C6TWqiaQ@z>

On 02/07/2019 02:51 PM, Davidlohr Bueso wrote:
> On Thu, 07 Feb 2019, Waiman Long wrote:
>> 30 files changed, 1197 insertions(+), 1594 deletions(-)
>
> Performance numbers on numerous workloads, pretty please.
>
> I'll go and throw this at my mmap_sem intensive workloads
> I've collected.
>
> Thanks,
> Davidlohr

Thanks for getting some of the performance numbers. This is the initial
draft after more than 1 years of hibernation. I will also get other
performance numbers in subsequent revision of the patch.

Cheers,
Longman
