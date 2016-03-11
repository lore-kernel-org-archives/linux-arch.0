From: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 18/18] drm/amdgpu: make amdgpu_mn_get wait for mmap_sem
 killable
Date: Fri, 11 Mar 2016 16:29:23 +0100
Message-ID: <56E2E453.1090305@suse.cz>
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
 <1456752417-9626-19-git-send-email-mhocko@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <1456752417-9626-19-git-send-email-mhocko@kernel.org>
Sender: owner-linux-mm@kvack.org
To: Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Alex Deucher <alexander.deucher@amd.com>, Alex Thorlton <athorlton@sgi.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, Benjamin LaHaise <bcrl@kvack.org>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, David Airlie <airlied@linux.ie>, Davidlohr Bueso <dave@stgolabs.net>, David Rientjes <rientjes@google.com>, "H . Peter Anvin" <hpa@zytor.com>, Hugh Dickins <hughd@google.com>, Ingo Molnar <mingo@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Petr
List-Id: linux-arch.vger.kernel.org

On 02/29/2016 02:26 PM, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
>
> amdgpu_mn_get which is called during ioct path relies on mmap_sem for
> write. If the waiting task gets killed by the oom killer it would block
> oom_reaper from asynchronous address space reclaim and reduce the
> chances of timely OOM resolving. Wait for the lock in the killable mode
> and return with EINTR if the task got killed while waiting.
>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>


Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> index d7ec9bd6755f..6f44f1c23be3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
> @@ -181,7 +181,10 @@ static struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev)
>   	int r;
>
>   	mutex_lock(&adev->mn_lock);
> -	down_write(&mm->mmap_sem);
> +	if (down_write_killable(&mm->mmap_sem)) {
> +		mutex_unlock(&adev->mn_lock);
> +		return -EINTR;
> +	}
>
>   	hash_for_each_possible(adev->mn_hash, rmn, node, (unsigned long)mm)
>   		if (rmn->mm == mm)
>

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
