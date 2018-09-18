From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [REVIEW][PATCH 00/20] siginfo cleanups for x86
Date: Tue, 18 Sep 2018 22:55:08 +0200 (CEST)
Message-ID: <alpine.DEB.2.21.1809182253220.1468@nanos.tec.linutronix.de>
References: <87y3bzk6yv.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 18 Sep 2018, Eric W. Biederman wrote:
> I have been slowly going thought and reworking the arch specific
> functions that generate siginfo.  The problems I have been addressing
> is that using siginfo directly is error prone.  Using siginfo directly
> makes it easy to leave fields initialized, and get confused about
> which fields need to be filled in.
> 
> To address this I have added a series of helper functions to
> kernel/signal.c, that are specific to exactly one use of struct siginfo
> and take the parameters they need.
> 
> To use these functions the x86 signal handling needs some cleanups but
> the net result appears to be less code that is easier to follow.
> 
> If while looking over these patches you see anything please let me know.

Only nitpicks.

> I don't think I missed something but to err is human.

I went through the changes a couple of times, but failed to spot
something. Was pleasure to read that set!

> Likewise if you would like to merge these patches via the tip tree
> let me know.  Otherwise after the review is complete I plan on merging
> these into my siginfo tree.  At this point I believe all of the
> prerequisite patches are merged so it should not make a difference.

Works either way. Ingo?

Thanks,

	tglx
