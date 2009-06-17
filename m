From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH 2/9] percpu: use dynamic percpu allocator as the
 default percpu allocator
Date: Wed, 17 Jun 2009 08:40:59 -0400
Message-ID: <1245242459.4503.4.camel@mulgrave.site>
References: <1245210060-24344-1-git-send-email-tj@kernel.org>
	 <1245210060-24344-3-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-parisc-owner@vger.kernel.org>
In-Reply-To: <1245210060-24344-3-git-send-email-tj@kernel.org>
Sender: linux-parisc-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, cl@linux-foundation.org, Jesper.Nilsson@axis.com, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, Paul Mundt <lethal@linux-sh.org>, Russell King <rmk@arm.linux.org.uk>, Mikael Starvik <starvik@axis.com>, Ralf Baechle <ralf@linux-mips.org>, Bryan Wu <cooloney@kernel.org>, Matthew Wilcox <matthew@wil.cx>, Grant Grundler <grundler@parisc-linux.org>, Hirokazu Takata <takata@linux-m32r.org>, Richard Henderson <rth@twiddle.net>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Heiko Carstens <heiko.carstens@de.ibm.com>, Parisc List <linux-parisc@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Wed, 2009-06-17 at 12:40 +0900, Tejun Heo wrote:
> 
> The following architectures are affected by this change.
> 
> * sh
> * arm
> * cris
> * mips
> * sparc(32)
> * blackfin
> * avr32
> * parisc (broken, under investigation)

I haven't seen anything of this on the parisc list ... what's the
problem?  and do you need systems or any other help to fix it?

James


