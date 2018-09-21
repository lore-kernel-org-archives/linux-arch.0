From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [REVIEW][PATCH 08/20] signal/x86/traps: Move setting error_code and trap_nr into do_trap_no_signal
Date: Fri, 21 Sep 2018 15:39:19 +0200
Message-ID: <87tvmj3r7c.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
        <20180918000546.12552-8-ebiederm@xmission.com>
        <alpine.DEB.2.21.1809182228350.1468@nanos.tec.linutronix.de>
        <877ejf58aa.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <877ejf58aa.fsf@xmission.com> (Eric W. Biederman's message of
        "Fri, 21 Sep 2018 14:45:01 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> I also realized for clarity of the code I could have moved show_signal
> into do_trap_no_signal as well.  I will post a follow up change where I
> do that.

Except of course do_trap_no_signal does not take a signal number show
it can't call show signal.  On second glance I don't see enough gain
to make it worth moving show_signal into do_trap_no_signal.  So I am
just going to skip that for now.

Eric
