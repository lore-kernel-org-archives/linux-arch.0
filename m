Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752322AbdKVMP1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Nov 2017 07:15:27 -0500
Subject: Re: MPK: removing a pkey
References: <0f006ef4-a7b5-c0cf-5f58-d0fd1f911a54@redhat.com>
 <8741e4d6-6ac0-9c07-99f3-95d8d04940b4@suse.cz>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <813f9736-36dd-b2e5-c850-9f2d5f94514a@redhat.com>
Date: Wed, 22 Nov 2017 13:15:24 +0100
MIME-Version: 1.0
In-Reply-To: <8741e4d6-6ac0-9c07-99f3-95d8d04940b4@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Dave Hansen <dave.hansen@linux.intel.com>, linux-x86_64@vger.kernel.org, linux-arch@vger.kernel.org
Cc: linux-mm <linux-mm@kvack.org>, Linux API <linux-api@vger.kernel.org>
Message-ID: <20171122121524.IAYm_dSx2IEg07SJfswKmT-evOdfcSHiQkr6gSTxbM0@z>

On 11/22/2017 09:18 AM, Vlastimil Babka wrote:
> And, was the pkey == -1 internal wiring supposed to be exposed to the
> pkey_mprotect() signal, or should there have been a pre-check returning
> EINVAL in SYSCALL_DEFINE4(pkey_mprotect), before calling
> do_mprotect_pkey())? I assume it's too late to change it now anyway (or
> not?), so should we also document it?

I think the -1 case to the set the default key is useful because it 
allows you to use a key value of -1 to mean “MPK is not supported”, and 
still call pkey_mprotect.

I plan to document this behavior on the glibc side, and glibc will call 
mprotect (not pkey_mprotect) for key -1, so that you won't get ENOSYS 
with kernels which do not support pkey_mprotect.

Thanks,
Florian
