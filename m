From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [REVIEW][PATCH 00/15] signal/arm64: siginfo cleanups
Date: Thu, 27 Sep 2018 14:50:18 +0100
Message-ID: <20180927135017.GC44459@arrakis.emea.arm.com>
References: <871s9j462u.fsf@xmission.com>
 <20180926173841.GD175719@arrakis.emea.arm.com>
 <87ftxvs2i0.fsf@xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87ftxvs2i0.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-arch@vger.kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 27, 2018 at 11:39:35AM +0200, Eric W. Biederman wrote:
> Catalin Marinas <catalin.marinas@arm.com> writes:
> > On Mon, Sep 24, 2018 at 11:07:05AM +0200, Eric W. Biederman wrote:
> >> After these patches have had a chance to be reviewed I plan to merge
> >> them by my siginfo tree.  If you would rather take them in the arm64
> >> tree let me know.   All of the prerequisites should have been merged
> >> through Linus's tree several releases ago.
> >
> > Either way works for me. There is a trivial conflict in
> > force_signal_inject() with the arm64 for-next/core tree so I could as
> > well put them on top of this branch and send them during the 4.20
> > merging window.
> 
> As long as there is a trivial conflict I would like to keep everything
> in one tree.
> 
> There is a following patchset that manages to reduce the size of struct
> siginfo in the kernel that I have also posted for review.    With
> everything in one tree I can make that change now, and just cross it off
> my list of things to worry about.

Fine by me:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Tested-by: Catalin Marinas <catalin.marinas@arm.com>

The conflict will appear in -next but the resolution is simple:

diff --cc arch/arm64/kernel/traps.c
index 21689c6a985f,856b32aa03d8..adb0a32c1568
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@@ -353,12 -366,6 +368,9 @@@ void force_signal_inject(int signal, in
  	const char *desc;
  	struct pt_regs *regs = current_pt_regs();
  
 +	if (WARN_ON(!user_mode(regs)))
 +		return;
 +
- 	clear_siginfo(&info);
- 
  	switch (signal) {
  	case SIGILL:
  		desc = "undefined instruction";

-- 
Catalin
