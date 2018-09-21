Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:46584 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeIUSXo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Sep 2018 14:23:44 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <87y3bzk6yv.fsf@xmission.com>
        <20180918000546.12552-12-ebiederm@xmission.com>
        <alpine.DEB.2.21.1809182242380.1468@nanos.tec.linutronix.de>
        <ed6d5892-4a05-40b7-0ebd-58efc5cc7d3e@linux.intel.com>
Date: Fri, 21 Sep 2018 14:34:49 +0200
In-Reply-To: <ed6d5892-4a05-40b7-0ebd-58efc5cc7d3e@linux.intel.com> (Dave
        Hansen's message of "Wed, 19 Sep 2018 09:33:42 -0700")
Message-ID: <87sh2358ra.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [REVIEW][PATCH 12/20] signal/x86: Remove pkey parameter from bad_area_nosemaphore
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180921123449.KfUK6Bqf26cwz0JDEyVFLN3OyA-NGbQT2EpLJBI8CA8@z>

Dave Hansen <dave.hansen@linux.intel.com> writes:

> On 09/18/2018 01:44 PM, Thomas Gleixner wrote:
>> On Tue, 18 Sep 2018, Eric W. Biederman wrote:
>>> The function bad_area_nosemaphore always sets si_code to SEGV_MAPERR
>>> and as such can never return a pkey parameter.  Therefore remove the
>>> unusable pkey parameter from bad_area_nosemaphore.
>
> The result of this looks nice to me.  It's especially nice to see the
> scope where we have to pass around the pkey get reduced.
>
> I also ran the pkey selftests against the current version of your
> siginfo-testing branch.  Everything passes fine on my pkey-enabled
> system.

Thank you for testing.  I was quite pleased myself when I saw that the
pkey scope was reduced.

Did you by any chance test powerpc?  As I also reduced the scope of pkey
there as well and that is also in my siginfo-testing branch.

Eric
