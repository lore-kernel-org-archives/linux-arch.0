From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC] Introduce atomic and per-cpu add-max and sub-min
 operations
Date: Sun, 14 Feb 2016 11:51:33 -0500
Message-ID: <20160214165133.GB3965@htj.duckdns.org>
References: <145544094056.28219.12239469516497703482.stgit@zurg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline
In-Reply-To: <145544094056.28219.12239469516497703482.stgit@zurg>
Sender: owner-linux-mm@kvack.org
To: Konstantin Khlebnikov <koct9i@gmail.com>
Cc: linux-arch@vger.kernel.org, Christoph Lameter <cl@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Hello, Konstantin.

On Sun, Feb 14, 2016 at 12:09:00PM +0300, Konstantin Khlebnikov wrote:
> bool atomic_add_max(atomic_t *var, int add, int max);
> bool atomic_sub_min(atomic_t *var, int sub, int min);
> 
> bool this_cpu_add_max(var, add, max);
> bool this_cpu_sub_min(var, sub, min);
> 
> They add/subtract only if result will be not bigger than max/lower that min.
> Returns true if operation was done and false otherwise.

If I'm reading the code right, all the above functions do is wrapping
the corresponding cmpxchg implementations.  Given that most use cases
would build further abstractions on top, I'm not sure how useful
providing another layer of abstraction is.  For the most part, we
introduce new per-cpu operations to take advantage of capabilities of
underlying hardware which can't be utilized in a different way (like
the x86 128bit atomic ops).

Thanks.

-- 
tejun

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
