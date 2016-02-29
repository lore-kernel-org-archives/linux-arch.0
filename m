Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1bon0071.outbound.protection.outlook.com ([157.56.111.71]:13088
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750975AbcB2OK3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 29 Feb 2016 09:10:29 -0500
Subject: Re: [PATCH 17/18] drm/radeon: make radeon_mn_get wait for mmap_sem
 killable
References: <1456752417-9626-1-git-send-email-mhocko@kernel.org>
 <1456752417-9626-18-git-send-email-mhocko@kernel.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <56D4493B.7010004@amd.com>
Date: Mon, 29 Feb 2016 14:35:55 +0100
MIME-Version: 1.0
In-Reply-To: <1456752417-9626-18-git-send-email-mhocko@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20160229133555.6b_mpYeTnmbos-H1Lpve_HkfMXS1Cv_EaS_hOajtpOQ@z>

[Dropping CCing the individual people, but adding the dri-devel mailing 
list as well instead].

Am 29.02.2016 um 14:26 schrieb Michal Hocko:
> From: Michal Hocko <mhocko@suse.com>
>
> radeon_mn_get which is called during ioct path relies on mmap_sem for
> write. If the waiting task gets killed by the oom killer it would block
> oom_reaper from asynchronous address space reclaim and reduce the
> chances of timely OOM resolving. Wait for the lock in the killable mode
> and return with EINTR if the task got killed while waiting.
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: David Airlie <airlied@linux.ie>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

This one and patch #18 in this series are Reviewed-by: Christian König 
<christian.koenig@amd.com>.

Nice to see some improvements on this side,
Christian.

> ---
>   drivers/gpu/drm/radeon/radeon_mn.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_mn.c b/drivers/gpu/drm/radeon/radeon_mn.c
> index eef006c48584..896f2cf51e4e 100644
> --- a/drivers/gpu/drm/radeon/radeon_mn.c
> +++ b/drivers/gpu/drm/radeon/radeon_mn.c
> @@ -186,7 +186,9 @@ static struct radeon_mn *radeon_mn_get(struct radeon_device *rdev)
>   	struct radeon_mn *rmn;
>   	int r;
>   
> -	down_write(&mm->mmap_sem);
> +	if (down_write_killable(&mm->mmap_sem))
> +		return ERR_PTR(-EINTR);
> +
>   	mutex_lock(&rdev->mn_lock);
>   
>   	hash_for_each_possible(rdev->mn_hash, rmn, node, (unsigned long)mm)

