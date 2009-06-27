From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH 01/10] percpu: use dynamic percpu allocator as the default
 percpu allocator
Date: Sat, 27 Jun 2009 12:21:26 +0900
Message-ID: <4A459036.6000508@kernel.org>
References: <1245825924-30412-1-git-send-email-tj@kernel.org>	 <1245825924-30412-2-git-send-email-tj@kernel.org>	 <1245887275.4022.619.camel@mulgrave.site>  <4A42E72D.2060904@kernel.org> <1246029229.3925.20.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35250 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbZF0DXH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Jun 2009 23:23:07 -0400
In-Reply-To: <1246029229.3925.20.camel@mulgrave.site>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, cl@linux-foundation.org, Jesper.Nilsson@axis.com, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, torvalds@linux-foundation.org, akpm@linux-foundation.org, Paul Mundt <lethal@linux-sh.org>, Russell King <rmk@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>, Ralf Baechle <ralf@linux-mips.org>, Bryan Wu <cooloney@kernel.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Hirokazu Takata <takata@linux-m32r.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Heiko Carstens <heiko.carstens@de.ibm.com>

James Bottomley wrote:
> It still fails with the above error.
> 
> If you look at your own file:
> 
> http://git.kernel.org/?p=linux/kernel/git/tj/percpu.git;a=blob;f=mm/percpu.c;h=b11ae7af3f7a214717d6670edb2985368efa8391;hb=for-james
> 
> on line 1456 pcpu_embed_first_chunk is defined with *three* arguments
> 
> on line 2006 it's used with *four* arguments
> 
> This is what the compiler doesn't like.

Oops, I was somehow completely forgetting about the default
setup_per_cpu_areas().  Fixed.  The new commit is
a3152acc226ec4859235e521286c9ca45c4b0683.

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/percpu.git for-next

Thanks.

-- 
tejun
