From: Konstantin Khlebnikov <khlebnikov@openvz.org>
Subject: Re: [PATCH 1/4] compiler.h: introduce unused_expression() macro
Date: Wed, 25 Apr 2012 15:54:31 +0400
Message-ID: <4F97E5F7.9030305@openvz.org>
References: <20120425112623.26927.43229.stgit@zurg> <4F97E550.4060208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4F97E550.4060208@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Cong Wang wrote:
> On 04/25/2012 07:26 PM, Konstantin Khlebnikov wrote:
>> Sometimes we want to check some expressions correctness in compile-time without
>> generating extra code. "(void)(e)" does not work if expression has side-effects.
>> This patch introduces macro unused_expression() which helps in this situation.
>>
>
> Interesting, I am wondering why gcc doesn't eliminate the code as we
> pass either -O2 or -Os to it.

It cannot do this if expression has some side-effects, for example if it contains BUG().
