Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:10889 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751001AbWIMSNP (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 13 Sep 2006 14:13:15 -0400
Message-ID: <45084A2C.8030804@yahoo.com.au>
Date: Thu, 14 Sep 2006 04:13:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: Why Semaphore Hardware-Dependent?
References: <44F395DE.10804@yahoo.com.au>  <a2ebde260608271222x2b51693fnaa600965fcfaa6d2@mail.gmail.com> <1156750249.3034.155.camel@laptopd505.fenrus.org> <11861.1156845927@warthog.cambridge.redhat.com> <45084833.4040602@yahoo.com.au> <Pine.LNX.4.64.0609131106260.18264@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0609131106260.18264@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: David Howells <dhowells@redhat.com>, Arjan van de Ven <arjan@infradead.org>, Dong Feng <middle.fengdong@gmail.com>, ak@suse.de, Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Christoph Lameter wrote:
> On Thu, 14 Sep 2006, Nick Piggin wrote:
> 
> 
>>Comments?
> 
> 
> You only support 64k waiters. We have had cases of software failing 
> because more than 64k readers were waiting.

Oh really? OK I figured if ppc64 was OK then that would be enough,
but your large Altix systems did slip my mind.

That is a fair criticism... atomic_long it will have to be, then.
That will require a bit of atomic work to get atomic64_cmpxchg
available on all 64-bit architectures.

> Please sent patches inline in order for us to be able to comment.

OK I will for next patchset.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
