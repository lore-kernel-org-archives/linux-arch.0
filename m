Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:4233 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750837AbWINPi2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 14 Sep 2006 11:38:28 -0400
Message-ID: <45097767.7010405@yahoo.com.au>
Date: Fri, 15 Sep 2006 01:38:15 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Why Semaphore Hardware-Dependent?
References: <45085B31.3080504@yahoo.com.au>  <45084833.4040602@yahoo.com.au> <44F395DE.10804@yahoo.com.au> <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <22461.1158173455@warthog.cambridge.redhat.com> <21102.1158234082@warthog.cambridge.redhat.com> <450974F2.1020104@yahoo.com.au>
In-Reply-To: <450974F2.1020104@yahoo.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: David Howells <dhowells@redhat.com>, Arjan van de Ven <arjan@infradead.org>, Dong Feng <middle.fengdong@gmail.com>, ak@suse.de, Paul Mackerras <paulus@samba.org>, Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Ahh, my mistake :)

Nick Piggin wrote:

> It is actually larger here.
> 
>    text    data     bss     dec     hex filename
>     970       0       0     970     3ca lib/rwsem-spinlock.o
>     576       0       0     576     240 kernel/spinlock.o
                                            ^^ should be:
        35       0       0      35      23 kernel/rwsem.o

>   =1546
> 
>    text    data     bss     dec     hex filename
>    1310       0       0    1310     51e lib/rwsem.o
>     193       0       0     193      c1 kernel/rwsem.o
>   =1503

Well, it is still larger than the atomic_inc_return variant
after my patch.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
