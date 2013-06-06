From: David Rientjes <rientjes@google.com>
Subject: Re: [patch 1/2] arch: invoke oom-killer from page fault
Date: Wed, 5 Jun 2013 20:57:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1306052053360.25115@chino.kir.corp.google.com>
References: <1370488193-4747-1-git-send-email-hannes@cmpxchg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1370488193-4747-1-git-send-email-hannes@cmpxchg.org>
Sender: owner-linux-mm@kvack.org
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.cz>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, 5 Jun 2013, Johannes Weiner wrote:

> Since '1c0fe6e mm: invoke oom-killer from page fault', page fault
> handlers should not directly kill faulting tasks in an out of memory
> condition.

I have no objection to the patch, but there's no explanation given here 
why exiting with a kill shouldn't be done.  Is it because of memory 
reserves and there is no guarantee that current will be able to exit?  Or 
is it just for consistency with other archs?

> Instead, they should be invoking the OOM killer to pick
> the right task.  Convert the remaining architectures.
> 

If this is a matter of memory reserves, I guess you could point people who 
want the current behavior (avoiding the expensiveness of the tasklist scan 
in the oom killer for example) to /proc/sys/vm/oom_kill_allocating_task?

This changelog is a bit cryptic in its motivation.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
