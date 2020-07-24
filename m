From: Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v4 6/6] powerpc: implement smp_cond_load_relaxed
Date: Fri, 24 Jul 2020 17:10:02 -0400
Message-ID: <1d24ef18-963b-4e26-2798-68bfe1350167@redhat.com>
References: <20200724131423.1362108-1-npiggin@gmail.com>
 <20200724131423.1362108-7-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kvm-ppc-owner@vger.kernel.org>
In-Reply-To: <20200724131423.1362108-7-npiggin@gmail.com>
Content-Language: en-US
Sender: kvm-ppc-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>, Anton Blanchard <anton@ozlabs.org>, =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 7/24/20 9:14 AM, Nicholas Piggin wrote:
> This implements smp_cond_load_relaed with the slowpath busy loop using the

Nit: "smp_cond_load_relaxed"

Cheers,
Longman
