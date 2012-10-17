Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:40310 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752979Ab2JQFzY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Oct 2012 01:55:24 -0400
Message-ID: <507E48ED.8060809@cn.fujitsu.com>
Date: Wed, 17 Oct 2012 13:58:05 +0800
From: Lai Jiangshan <laijs@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] percpu-rwsem: use barrier in unlock path
References: <Pine.LNX.4.64.1210151716310.10685@file.rdu.redhat.com> <Pine.LNX.4.64.1210161924350.20581@file.rdu.redhat.com> <CA+55aFyZ9uq_yfHn9PwpmM77X3xVd+xseEbjJmeCCqbFddtjWA@mail.gmail.com>
In-Reply-To: <CA+55aFyZ9uq_yfHn9PwpmM77X3xVd+xseEbjJmeCCqbFddtjWA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>, Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <20121017055805.sS9leXfkfMaqaFTLbOwF-fs9oYLCAsKYlcilMPR17LI@z>

On 10/17/2012 10:23 AM, Linus Torvalds wrote:
> [ Architecture people, note the potential new SMP barrier! ]
> 
> On Tue, Oct 16, 2012 at 4:30 PM, Mikulas Patocka <mpatocka@redhat.com> wrote:
>> +       /*
>> +        * The lock is considered unlocked when p->locked is set to false.
>> +        * Use barrier prevent reordering of operations around p->locked.
>> +        */
>> +#if defined(CONFIG_X86) && (!defined(CONFIG_X86_PPRO_FENCE) && !defined(CONFIG_X86_OOSTORE))
>> +       barrier();
>> +#else
>> +       smp_mb();
>> +#endif
>>         p->locked = false;
> 
> Ugh. The #if is too ugly to live.

Even the previous patch is applied, percpu_down_read() still
needs mb() to pair with it.

> 
> This is a classic case of "people who write their own serialization
> primitives invariably get them wrong". And this fix is just horrible,
> and code like this should not be allowed.

One of the most major problems of 62ac665ff9fc07497ca524bd20d6a96893d11071 is that
it is merged without Ackeds or Revieweds from Paul or Peter or someone else
who are expert at synchronization/arch memory models.

I suggest any new synchronization should stay in -tip for 2 or more cycles
before merged to mainline.

Thanks,
Lai
