From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [REVIEW][PATCH 00/20] siginfo cleanups for x86
Date: Tue, 18 Sep 2018 23:10:06 +0200
Message-ID: <87zhweh5qp.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
        <alpine.DEB.2.21.1809182253220.1468@nanos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1809182253220.1468@nanos.tec.linutronix.de>
        (Thomas Gleixner's message of "Tue, 18 Sep 2018 22:55:08 +0200
        (CEST)")
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> On Tue, 18 Sep 2018, Eric W. Biederman wrote:
>> I have been slowly going thought and reworking the arch specific
>> functions that generate siginfo.  The problems I have been addressing
>> is that using siginfo directly is error prone.  Using siginfo directly
>> makes it easy to leave fields initialized, and get confused about
>> which fields need to be filled in.
>> 
>> To address this I have added a series of helper functions to
>> kernel/signal.c, that are specific to exactly one use of struct siginfo
>> and take the parameters they need.
>> 
>> To use these functions the x86 signal handling needs some cleanups but
>> the net result appears to be less code that is easier to follow.
>> 
>> If while looking over these patches you see anything please let me know.
>
> Only nitpicks.
>
>> I don't think I missed something but to err is human.
>
> I went through the changes a couple of times, but failed to spot
> something. Was pleasure to read that set!
>
>> Likewise if you would like to merge these patches via the tip tree
>> let me know.  Otherwise after the review is complete I plan on merging
>> these into my siginfo tree.  At this point I believe all of the
>> prerequisite patches are merged so it should not make a difference.
>
> Works either way. Ingo?

If I manage to get through all of the architecture specific code I can
shrink the in-kernel version of struct siginfo.    So there is a slight
advantage to having it all in my tree.  But worst case I just have to
wait another cycle which doesn't look like a particularly long wait at
this point.

Eric
