From: Konstantin Khlebnikov <koct9i@gmail.com>
Subject: Re: [PATCH RFC] Introduce atomic and per-cpu add-max and sub-min operations
Date: Sun, 14 Feb 2016 20:37:18 +0300
Message-ID: <CALYGNiOpnVSpmL0smMu7xCT78GJ4J02LGeiuZBdVxROEpfrH+Q@mail.gmail.com>
References: <145544094056.28219.12239469516497703482.stgit@zurg>
	<20160214165133.GB3965@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20160214165133.GB3965@htj.duckdns.org>
Sender: owner-linux-mm@kvack.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Christoph Lameter <cl@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Sun, Feb 14, 2016 at 7:51 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Konstantin.
>
> On Sun, Feb 14, 2016 at 12:09:00PM +0300, Konstantin Khlebnikov wrote:
>> bool atomic_add_max(atomic_t *var, int add, int max);
>> bool atomic_sub_min(atomic_t *var, int sub, int min);
>>
>> bool this_cpu_add_max(var, add, max);
>> bool this_cpu_sub_min(var, sub, min);
>>
>> They add/subtract only if result will be not bigger than max/lower that min.
>> Returns true if operation was done and false otherwise.
>
> If I'm reading the code right, all the above functions do is wrapping
> the corresponding cmpxchg implementations.  Given that most use cases
> would build further abstractions on top, I'm not sure how useful
> providing another layer of abstraction is.  For the most part, we
> introduce new per-cpu operations to take advantage of capabilities of
> underlying hardware which can't be utilized in a different way (like
> the x86 128bit atomic ops).

Yep, they are just abstraction around cmpxchg, as well as a half of atomic
operations. Probably some architectures could implement this differently.

This is basic block with clear interface which performs just one operaion.
without managing memory and logic behind it. Users often already have
per-cpu memory stuctures, so they don't need high level abstractrions
because this will waste memory for unneeded pointers. I think this new
abstraction could replace alot of opencoded hacks in common way.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
