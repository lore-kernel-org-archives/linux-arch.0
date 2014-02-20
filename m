Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e28smtp09.in.ibm.com ([122.248.162.9]:39677 "EHLO
	e28smtp09.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaBTT0N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2014 14:26:13 -0500
Received: from /spool/local
	by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <raghavendra.kt@linux.vnet.ibm.com>;
	Fri, 21 Feb 2014 00:56:11 +0530
Message-ID: <53065838.90102@linux.vnet.ibm.com>
Date: Fri, 21 Feb 2014 01:02:08 +0530
From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH v4 0/3] qspinlock: Introducing a 4-byte queue spinlock
References: <1392669684-4807-1-git-send-email-Waiman.Long@hp.com> <53029167.4060109@zytor.com> <20140218073111.GW27965@twins.programming.kicks-ass.net> <5303B4C4.2040907@hp.com> <20140218212827.GR14089@laptop.programming.kicks-ass.net> <5303FDEC.9060001@hp.com> <20140219085107.GG27965@twins.programming.kicks-ass.net> <53050501.3070101@hp.com> <CA+55aFwyVgLJq2OgKZBK7g+T5-_M4o+dnEAr+qtYxA5t_=HSvA@mail.gmail.com> <5306413F.3010106@hp.com>
In-Reply-To: <5306413F.3010106@hp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Michel Lespinasse <walken@google.com>, Andi Kleen <andi@firstfloor.org>, Rik van Riel <riel@redhat.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, George Spelvin <linux@horizon.com>, Tim Chen <tim.c.chen@linux.intel.com>, Daniel J Blueman <daniel@numascale.com>, Alexander Fyodorov <halcy@yandex.ru>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Message-ID: <20140220193208.9zncD6dkD7ONNRFt_qGBlGx33ib7q92O_8bDwRogJiI@z>

On 02/20/2014 11:24 PM, Waiman Long wrote:

> Now the key is how to detect if a kernel is really running in a PV
> environment. I need to ask some virtualization experts on that.
>

For kvm you could just follow,
kvm_spinlock_init_jump() and KVM_FEATURE_* encoding in cpuid
part __do_cpuid_ent().

