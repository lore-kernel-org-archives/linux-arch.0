From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [REVIEW][PATCH 00/15] signal/arm64: siginfo cleanups
Date: Wed, 26 Sep 2018 18:38:42 +0100
Message-ID: <20180926173841.GD175719@arrakis.emea.arm.com>
References: <871s9j462u.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <871s9j462u.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Hi Eric,

On Mon, Sep 24, 2018 at 11:07:05AM +0200, Eric W. Biederman wrote:
> This is the continuation of my work to sort out signaling of exceptions
> with siginfo.  The old signal sending functions by taking a siginfo
> argument resulted in their callers having to deal with the fiddly nature
> of siginfo directly.  In small numbers of callers this is not a problem
> but in the number of callers in the kernel this resulted in cases
> where fields were not initialized or improperly initialized before
> being passed to userspace.
> 
> To avoid having to worry about those issues I have added new signal
> sending functions that each deal wit a different siginfo case.  When
> using these functions there is no room for the fiddly nature of siginfo
> to cause mistakes.
> 
> This is my set of changes to update arm64 to use those functions.
> Along with some refactoring so those functions can be cleanly used.
> 
> Folks please review and double check me.  I think I have kept these
> changes simple and obviously correct but I am human and mess up
> sometimes.

Nice clean-up, thanks. I started reviewing the patches, I should finish
by tomorrow (I also applied them locally to give some testing).

> After these patches have had a chance to be reviewed I plan to merge
> them by my siginfo tree.  If you would rather take them in the arm64
> tree let me know.   All of the prerequisites should have been merged
> through Linus's tree several releases ago.

Either way works for me. There is a trivial conflict in
force_signal_inject() with the arm64 for-next/core tree so I could as
well put them on top of this branch and send them during the 4.20
merging window.

-- 
Catalin
