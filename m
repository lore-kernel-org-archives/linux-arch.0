Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58744 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbeISCL6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 22:11:58 -0400
Date: Tue, 18 Sep 2018 22:37:38 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 08/20] signal/x86/traps: Move setting error_code
 and trap_nr into do_trap_no_signal
In-Reply-To: <alpine.DEB.2.21.1809182228350.1468@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1809182237130.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com> <20180918000546.12552-8-ebiederm@xmission.com> <alpine.DEB.2.21.1809182228350.1468@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180918203738.sX3UY7nLh67liaPaoFdzBLg_TniBQxjq58kAv5R-HJo@z>

On Tue, 18 Sep 2018, Thomas Gleixner wrote:

> On Tue, 18 Sep 2018, Eric W. Biederman wrote:
> 
> > Half of the times when error_code and trap_nr are set are already in
> 
> s/when// I think
> 
> > do_trap_no_signal.  Move the other time these are set into do_trap_no_signal,
> 
> Please write function as do_trap_no_signal() so it's more obvious what you
> are talking about.

That applies to the other changelogs as well.

Thanks,

	tglx
