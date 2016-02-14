Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34977 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751476AbcBNRhT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 14 Feb 2016 12:37:19 -0500
MIME-Version: 1.0
In-Reply-To: <20160214165133.GB3965@htj.duckdns.org>
References: <145544094056.28219.12239469516497703482.stgit@zurg>
	<20160214165133.GB3965@htj.duckdns.org>
Date: Sun, 14 Feb 2016 20:37:18 +0300
Message-ID: <CALYGNiOpnVSpmL0smMu7xCT78GJ4J02LGeiuZBdVxROEpfrH+Q@mail.gmail.com>
Subject: Re: [PATCH RFC] Introduce atomic and per-cpu add-max and sub-min operations
From: Konstantin Khlebnikov <koct9i@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Christoph Lameter <cl@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
Message-ID: <20160214173718.Q3KYxkj52TrSZHAK-rJ6zc2hu26vPajYvZ3wg6Jp844@z>

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
