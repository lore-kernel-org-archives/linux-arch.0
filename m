From: Tejun Heo <tj@kernel.org>
Subject: Re: [GIT PULL] percpu fix for v4.10-rc6
Date: Tue, 31 Jan 2017 17:11:41 -0500
Message-ID: <20170131221141.GA5379@htj.duckdns.org>
References: <20170131165537.GC23970@htj.duckdns.org>
 <CA+55aFyiEO8o=1y_FaWjUr5C1JMCoN2h5aMJuPTG=7AexEZLLQ@mail.gmail.com>
 <CA+55aFx0u8SpEYOkNymXBu7_q5uF-MitrjmpDx9+Uj3fgnxgRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFx0u8SpEYOkNymXBu7_q5uF-MitrjmpDx9+Uj3fgnxgRg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dougmill@linux.vnet.ibm.com
List-Id: linux-arch.vger.kernel.org

Hello, Linus.

On Tue, Jan 31, 2017 at 01:41:17PM -0800, Linus Torvalds wrote:
> On Tue, Jan 31, 2017 at 1:32 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I've pulled this, but I really think it's papering over the real
> > issue. Adding "linux-arch" mailing list to ask architecture
> > maintainers to check their implementation of the atomic ops that
> > return a truth value.

Yeah, for sure.

> For example, looking at the x86-32 version, I see this:
> 
>   static inline int atomic64_add_unless(atomic64_t *v, long long a, long long u)
>   ...
>         return (int)a;
> 
> which looks really horribly wrong, but the assembly implementation
> actually returns 0/1 in %eax so it ends up being right - just
> confusingly so.
> 
> Also, to make things more confusing, the underscore version
> (__atomic_add_unless()) actually returns the old value, not the truth
> value of the comparison.
> 
> So this area definitely is messy. The x86-64 versions actually look
> fairly clean and return nice boolean values.

We have a similar mess with bitops too.  x86 is cleaned up to have
bool returns but the generic implementation and a lot of other archs
return the tested bit instead of 1/0.  It'd be great to make all the
boolean functions actually return bool.

Thanks.

-- 
tejun
