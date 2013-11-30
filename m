From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] arch: include/asm/Kbuild: fix preempt.h sort order
Date: Sat, 30 Nov 2013 10:20:31 +0100
Message-ID: <20131130092031.GG16796@laptop.programming.kicks-ass.net>
References: <1385736191-31862-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1385736191-31862-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

On Fri, Nov 29, 2013 at 02:43:11PM +0000, James Hogan wrote:
> Commit a787870924db (sched, arch: Create asm/preempt.h) added the
> generic asm/preempt.h header, but took no notice of the sort order of
> various architecture's include/asm/Kbuild files. Move preempt.h into the
> correct sort position in files which are mostly already sorted.

Oh, I completely failed to notice they're sorted.

Thanks for fixing it up.
