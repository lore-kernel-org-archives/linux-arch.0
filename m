From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 11/18] coredump: make coredump_wait wait for mma_sem for
 write killable
Date: Fri, 11 Mar 2016 12:32:55 +0100
Message-ID: <56E2ACE7.50008@suse.cz>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
 <1456752417-9626-12-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1456752417-9626-12-git-send-email-mhocko@kernel.org>
Sender: owner-linux-mm@kvack.org
To: Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Petr
List-Id: linux-arch.vger.kernel.org

On 02/29/2016 02:26 PM, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>
> coredump_wait waits for mmap_sem for write currently which can
> prevent oom_reaper to reclaim the oom victims address space
> asynchronously because that requires mmap_sem for read. This might
> happen if the oom victim is multi threaded and some thread(s) is
> holding mmap_sem for read (e.g. page fault) and it is stuck in
> the page allocator while other thread(s) reached coredump_wait
> already.
>
> This patch simply uses down_write_killable and bails out with EINTR
> if the lock got interrupted by the fatal signal. do_coredump will
> return right away and do_group_exit will take care to zap the whole
> thread group.
>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>   fs/coredump.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 9ea87e9fdccf..6b8aa1629891 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -410,7 +410,9 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
>   	core_state->dumper.task = tsk;
>   	core_state->dumper.next = NULL;
>
> -	down_write(&mm->mmap_sem);
> +	if (down_write_killable(&mm->mmap_sem))
> +		return -EINTR;
> +
>   	if (!mm->core_state)
>   		core_waiters = zap_threads(tsk, mm, core_state, exit_code);
>   	up_write(&mm->mmap_sem);
>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
