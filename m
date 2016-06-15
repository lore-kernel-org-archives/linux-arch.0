Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0132.outbound.protection.outlook.com ([207.46.100.132]:39005
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933133AbcFOTV3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 15 Jun 2016 15:21:29 -0400
Message-ID: <5761AAA9.1080406@hpe.com>
Date: Wed, 15 Jun 2016 15:21:13 -0400
From: Waiman Long <waiman.long@hpe.com>
MIME-Version: 1.0
Subject: Re: [RFC PATCH-tip v2 4/6] locking/rwsem: move down rwsem_down_read_failed
 function
References: <1465944489-43440-1-git-send-email-Waiman.Long@hpe.com> <1465944489-43440-5-git-send-email-Waiman.Long@hpe.com> <20160615174055.GS30921@twins.programming.kicks-ass.net>
In-Reply-To: <20160615174055.GS30921@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, Jason Low <jason.low2@hp.com>, Dave Chinner <david@fromorbit.com>, Scott J Norton <scott.norton@hpe.com>, Douglas Hatch <doug.hatch@hpe.com>
Message-ID: <20160615192113.O9rmNrrMwFgpnf3hk3ICVNfYjeS9HbYy384E5soxXpY@z>

On 06/15/2016 01:40 PM, Peter Zijlstra wrote:
> On Tue, Jun 14, 2016 at 06:48:07PM -0400, Waiman Long wrote:
>> Move the rwsem_down_read_failed() function down to below the optimistic
>> spinning section before enabling optimistic spinning for the readers.
> newline
>
>> There is no change in code.
> Changelog fails to explain the why part.

Thanks for pointing this out. I will update the changelog to mention 
that the movement is needed because it is going to call 
rwsem_optimistic_spin() in later patch.

Cheers,
Longman
