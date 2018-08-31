From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/6] x86/alternatives: text_poke() fixes
Date: Fri, 31 Aug 2018 13:49:16 +0900
Message-ID: <20180831134916.f8c409da94baa492008b188e@kernel.org>
References: <20180830173218.238900-1-namit@vmware.com>
        <20180831134635.35b6c2a919449adf4b63a133@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831134635.35b6c2a919449adf4b63a133@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nadav Amit <namit@vmware.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-arch.vger.kernel.org

On Fri, 31 Aug 2018 13:46:35 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Thu, 30 Aug 2018 10:32:12 -0700
> Nadav Amit <namit@vmware.com> wrote:
> 
> > This patch-set addresses some issues that were raised in a recent
> > correspondence and might affect the security and the correctness of code
> > patching. (Note that patching performance is not addressed by this
> > patch-set).
> > 
> > The main issue that the patches deal with is the fact that the fixmap
> > PTEs that are used for patching are available for access from other
> > cores and might be exploited. They are not even flushed from the TLB in
> > remote cores, so the risk is even higher. Address this issue by
> > introducing a temporary mm that is only used during patching.
> > Unfortunately, due to init ordering, fixmap is still used during
> > boot-time patching. Future patches can eliminate the need for it.
> > 
> > The second issue is the missing lockdep assertion to ensure text_mutex
> > is taken. It is actually not always taken, so fix the instances that
> > were found not to take the lock (although they should be safe even
> > without taking the lock).
> > 
> > Finally, try to be more conservative and to map a single page, instead
> > of two, when possible. This helps both security and performance.
> > 
> > In addition, there is some cleanup of the patching code to make it more
> > readable.
> 
> OK, this series looks good to me, and tested with ftracetest, kprobe testsets.
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> Tested-by: Masami Hiramatsu <mhiramat@kernel.org>

Oh, I missed a note.

To apply this series on -tip tree, we have to revert Jiri's text_mutex
checker.

9222f606506c ("x86/alternatives: Lockdep-enforce text_mutex in text_poke*()")

Thanks!



-- 
Masami Hiramatsu <mhiramat@kernel.org>
