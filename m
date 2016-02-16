From: Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH RFC] Introduce atomic and per-cpu add-max and sub-min
 operations
Date: Tue, 16 Feb 2016 10:10:55 -0600 (CST)
Message-ID: <alpine.DEB.2.20.1602161010280.3986@east.gentwo.org>
References: <145544094056.28219.12239469516497703482.stgit@zurg> <20160214165133.GB3965@htj.duckdns.org> <CALYGNiOpnVSpmL0smMu7xCT78GJ4J02LGeiuZBdVxROEpfrH+Q@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <CALYGNiOpnVSpmL0smMu7xCT78GJ4J02LGeiuZBdVxROEpfrH+Q@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
To: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Sun, 14 Feb 2016, Konstantin Khlebnikov wrote:

> Yep, they are just abstraction around cmpxchg, as well as a half of atomic
> operations. Probably some architectures could implement this differently.

Ok then use this_cpu_cmpxchg and cmpxchg to implement it instead?

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
