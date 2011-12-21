From: Pekka Enberg <penberg@kernel.org>
Subject: Re: [GIT PULL] slab fixes for 3.2-rc4
Date: Wed, 21 Dec 2011 10:08:48 +0200
Message-ID: <CAOJsxLE55zXt_PCmvyykP_-W26AHXOJ+zEPs3EVC-Xqazwn2tQ@mail.gmail.com>
References: <alpine.LFD.2.02.1111292001420.4019@tux.localdomain>
	<CA+55aFz23nN4EALZKf1uptn3a+LKU8wehEnxXO7WA8J5WAyPAQ@mail.gmail.com>
	<CAOJsxLEHT4D4rfMvWe5iPFpunOaLWZD9fJxbOJ6_qMwt_rd7eg@mail.gmail.com>
	<20111220162315.GC10752@google.com>
	<CA+55aFwwjAtiiM5V3LfebmtKAOzxZXk-VzJ3U7PJAc1VjxK69Q@mail.gmail.com>
	<20111220202854.GH10752@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:47191 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751138Ab1LUIIs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Dec 2011 03:08:48 -0500
In-Reply-To: <20111220202854.GH10752@google.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>, Christoph Lameter <cl@linux.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On Tue, Dec 20, 2011 at 11:28:25AM -0800, Linus Torvalds wrote:
>> > Description for 7340a0b152 "this_cpu: Introduce this_cpu_ptr() and
>> > generic this_cpu_* operations" should explain the above three.
>>
>> I don't think that's relevant.
>>
>> Sure, they have semantics, but the semantics are stupid and wrong.
>> Whether they are documented or not isn't even the issue.

On Tue, Dec 20, 2011 at 10:28 PM, Tejun Heo <tj@kernel.org> wrote:
> I was trying to point Pekka to documentation so that at least the
> existing semantics are clear.

Sure but well-defined semantics alone are not sufficient for a
reasonable API. It's not at all obvious which one of the four variants
to pick when writing code. I don't see any evidence that people
actually understand the API. On the contrary, I see bugs caused by API
confusion in mm/slub.c itself!

                        Pekka
