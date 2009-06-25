From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 01/10] percpu: use dynamic percpu allocator as the default
 percpu allocator
Date: Thu, 25 Jun 2009 11:55:41 +0900
Message-ID: <4A42E72D.2060904@kernel.org>
References: <1245825924-30412-1-git-send-email-tj@kernel.org>	 <1245825924-30412-2-git-send-email-tj@kernel.org> <1245887275.4022.619.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38779 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbZFYC4y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Jun 2009 22:56:54 -0400
In-Reply-To: <1245887275.4022.619.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, cl@linux-foundation.org, Jesper.Nilsson@axis.com, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Mundt <lethal@linux-sh.org>, Russell King <rmk@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>, Ralf Baechle <ralf@linux-mips.org>, Bryan Wu <cooloney@kernel.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Hirokazu Takata <takata@linux-m32r.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Heiko Carstens <heiko.carstens@de.ibm.com>

James Bottomley wrote:
> On Wed, 2009-06-24 at 15:45 +0900, Tejun Heo wrote:
>> This patch makes most !CONFIG_HAVE_SETUP_PER_CPU_AREA archs use
>> dynamic percpu allocator.  The first chunk is allocated using
>> embedding helper and 8k is reserved for modules.  This ensures that
>> the new allocator behaves almost identically to the original allocator
>> as long as static percpu variables are concerned, so it shouldn't
>> introduce much breakage.
>>
>> s390 and alpha use custom SHIFT_PERCPU_PTR() to work around addressing
>> range limit the addressing model imposes.  Unfortunately, this breaks
>> if the address is specified using a variable, so for now, the two
>> archs aren't converted.
>>
>> The following architectures are affected by this change.
>>
>> * sh
>> * arm
>> * cris
>> * mips
>> * sparc(32)
>> * blackfin
>> * avr32
>> * parisc (broken, under investigation)
> 
> OK, I thought I'd investigate this.  Unfortunately, your git tree
> doesn't build when pulled into head ... could you update?
> 
> mm/percpu.c: In function 'setup_per_cpu_areas':
> mm/percpu.c:2007: error: too many arguments to function 'pcpu_embed_first_chunk'

Hmm... strange.  I don't see such failures.  Can you please try the
following git tree?

  git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu.git for-james

The contains all posted percpu patches and pulls in the current
linus#master (rc1).

Thanks.

-- 
tejun
