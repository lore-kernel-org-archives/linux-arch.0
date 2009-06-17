From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 2/9] percpu: use dynamic percpu allocator as the default
 percpu allocator
Date: Wed, 17 Jun 2009 22:15:18 +0900
Message-ID: <4A38EC66.5000504@kernel.org>
References: <1245210060-24344-1-git-send-email-tj@kernel.org>	 <1245210060-24344-3-git-send-email-tj@kernel.org> <1245242459.4503.4.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50823 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752409AbZFQNQX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Jun 2009 09:16:23 -0400
In-Reply-To: <1245242459.4503.4.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, cl@linux-foundation.org, Jesper.Nilsson@axis.com, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, Paul Mundt <lethal@linux-sh.org>, Russell King <rmk@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>, Ralf Baechle <ralf@linux-mips.org>, Bryan Wu <cooloney@kernel.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Hirokazu Takata <takata@linux-m32r.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Heiko Carstens <heiko.carstens@de.ibm.com>, Parisc List <linux-parisc@vger.kernel.org>

James Bottomley wrote:
> On Wed, 2009-06-17 at 12:40 +0900, Tejun Heo wrote:
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
> I haven't seen anything of this on the parisc list ... what's the
> problem?  and do you need systems or any other help to fix it?

I really don't know what's wrong as nothing should be different from
the old percpu allocator as seen from the arch code.

Kyle reported that the system didn't boot with the patch applied.
Access to a system would be nice but boot debugging usually is done
much easier with local access, so I was hoping he would follow up.
Kyle, do you have any details?

Thanks.

-- 
tejun
