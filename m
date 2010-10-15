From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][GIT PULL] ftrace: Rename config option
 HAVE_C_MCOUNT_RECORD to HAVE_C_RECORDMCOUNT
Date: Fri, 15 Oct 2010 06:13:07 +0200
Message-ID: <20101015041307.GA31764@elte.hu>
References: <1287114319.23682.34.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1287114319.23682.34.camel@gandalf.stny.rr.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Frederic Weisbecker <fweisbec@gmail.com>, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>, linux-kbuild <linux-kbuild@vger.kernel.org>, John Reiser <jreiser@bitwagon.com>
List-Id: linux-arch.vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Ingo,
> 
> Please pull the latest tip/perf/recordmcount-2 tree, which can be found at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git
> tip/perf/recordmcount-2
> 
> 
> Steven Rostedt (1):
>       ftrace: Rename config option HAVE_C_MCOUNT_RECORD to HAVE_C_RECORDMCOUNT
> 
> ----
>  Makefile             |    2 +-
>  arch/x86/Kconfig     |    2 +-
>  kernel/trace/Kconfig |    2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)

The full diffstat (due to the previous commits) was:

 Makefile               |    6 +
 arch/x86/Kconfig       |    1 +
 kernel/trace/Kconfig   |    5 +
 scripts/Makefile       |    1 +
 scripts/Makefile.build |    4 +
 scripts/recordmcount.c |  345 +++++++++++++++++++++++++++++++++++++++++++++
 scripts/recordmcount.h |  366 ++++++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 728 insertions(+), 0 deletions(-)
 create mode 100644 scripts/recordmcount.c
 create mode 100644 scripts/recordmcount.h

Pulled, thanks a lot Steve!

	Ingo
