Return-Path: <SRS0=oaWr=BD=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35287 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726083AbgGXVKN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 Jul 2020 17:10:13 -0400
Subject: Re: [PATCH v4 6/6] powerpc: implement smp_cond_load_relaxed
References: <20200724131423.1362108-1-npiggin@gmail.com>
 <20200724131423.1362108-7-npiggin@gmail.com>
From: Waiman Long <longman@redhat.com>
Message-ID: <1d24ef18-963b-4e26-2798-68bfe1350167@redhat.com>
Date: Fri, 24 Jul 2020 17:10:02 -0400
MIME-Version: 1.0
In-Reply-To: <20200724131423.1362108-7-npiggin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@ozlabs.org>, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20200724211002.XANOTA6zDX-8ugF3VibYHBK8xNeNRqWV6nByMCWV8FA@z>

On 7/24/20 9:14 AM, Nicholas Piggin wrote:
> This implements smp_cond_load_relaed with the slowpath busy loop using the

Nit: "smp_cond_load_relaxed"

Cheers,
Longman
