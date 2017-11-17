Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17356 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965540AbdKQIpu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Nov 2017 03:45:50 -0500
Subject: Re: [RFC PATCH 0/2] mm: introduce MAP_FIXED_SAFE
References: <20171116101900.13621-1-mhocko@kernel.org>
 <20171116121438.6vegs4wiahod3byl@dhcp22.suse.cz>
From: John Hubbard <jhubbard@nvidia.com>
Message-ID: <b1848e34-7fcd-8ad8-6a6a-3be3dce3fda7@nvidia.com>
Date: Fri, 17 Nov 2017 00:45:49 -0800
MIME-Version: 1.0
In-Reply-To: <20171116121438.6vegs4wiahod3byl@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>, linux-api@vger.kernel.org
Cc: Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Abdul Haleem <abdhalee@linux.vnet.ibm.com>, Joel Stanley <joel@jms.id.au>, Kees Cook <keescook@chromium.org>
Message-ID: <20171117084549.EbUxeb6gCEncskoshnNVMciXgglT-GDRwxmSBKsVhqE@z>

On 11/16/2017 04:14 AM, Michal Hocko wrote:
> [Ups, managed to screw the subject - fix it]
> 
> On Thu 16-11-17 11:18:58, Michal Hocko wrote:
>> Hi,
>> this has started as a follow up discussion [1][2] resulting in the
>> runtime failure caused by hardening patch [3] which removes MAP_FIXED
>> from the elf loader because MAP_FIXED is inherently dangerous as it
>> might silently clobber and existing underlying mapping (e.g. stack). The
>> reason for the failure is that some architectures enforce an alignment
>> for the given address hint without MAP_FIXED used (e.g. for shared or
>> file backed mappings).
>>
>> One way around this would be excluding those archs which do alignment
>> tricks from the hardening [4]. The patch is really trivial but it has
>> been objected, rightfully so, that this screams for a more generic
>> solution. We basically want a non-destructive MAP_FIXED.
>>
>> The first patch introduced MAP_FIXED_SAFE which enforces the given
>> address but unlike MAP_FIXED it fails with ENOMEM if the given range
>> conflicts with an existing one. The flag is introduced as a completely
>> new flag rather than a MAP_FIXED extension because of the backward
>> compatibility. We really want a never-clobber semantic even on older
>> kernels which do not recognize the flag. Unfortunately mmap sucks wrt.
>> flags evaluation because we do not EINVAL on unknown flags. On those
>> kernels we would simply use the traditional hint based semantic so the
>> caller can still get a different address (which sucks) but at least not
>> silently corrupt an existing mapping. I do not see a good way around
>> that. Except we won't export expose the new semantic to the userspace at
>> all. It seems there are users who would like to have something like that
>> [5], though. Atomic address range probing in the multithreaded programs
>> sounds like an interesting thing to me as well, although I do not have
>> any specific usecase in mind.

Hi Michal,
