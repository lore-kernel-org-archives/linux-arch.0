From: Tejun Heo <tj@kernel.org>
Subject: Re: [GIT PULL] percpu fix for v4.10-rc6
Date: Tue, 31 Jan 2017 17:27:07 -0500
Message-ID: <20170131222707.GA5919@htj.duckdns.org>
References: <20170131165537.GC23970@htj.duckdns.org>
 <CA+55aFyiEO8o=1y_FaWjUr5C1JMCoN2h5aMJuPTG=7AexEZLLQ@mail.gmail.com>
 <CA+55aFx0u8SpEYOkNymXBu7_q5uF-MitrjmpDx9+Uj3fgnxgRg@mail.gmail.com>
 <20170131221141.GA5379@htj.duckdns.org>
 <CA+55aFyn+pVeZKA1wEdbBMku_2UCL7BuUX1O_RvHpH5LJXEy5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36839 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdAaW1P (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2017 17:27:15 -0500
Content-Disposition: inline
In-Reply-To: <CA+55aFyn+pVeZKA1wEdbBMku_2UCL7BuUX1O_RvHpH5LJXEy5Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dougmill@linux.vnet.ibm.com

On Tue, Jan 31, 2017 at 02:17:10PM -0800, Linus Torvalds wrote:
> Because there definitely have been users of the bitop routines that
> assign the result to an "int", and I have some dim memory of us also
> having had things like drivers that made their own "bool" variables
> and use "char" for them.
> 
> But I'm not seeing it. The generic bitop pattern seems to be
> 
>     static inline int test_and_change_bit(int nr, volatile unsigned long *addr)
>     ...
>         return (old & mask) != 0;
> 
> which is fine.
> 
> Just exactly what code did you look at?

My bad.  I misread the generic test_bit() code and was reading the
inner helper of ppc, DEFINE_TESTOP macro, which returns the masked
value.  We used to have this problem, right?  I seem to have a memory
of hitting this issue.

Is there a reason we don't make these functions explicitly return
bool?  To avoid unnecessary boolean conversion by the compiler?  If
so, there gotta be a way to avoid that.

Thanks.

-- 
tejun
