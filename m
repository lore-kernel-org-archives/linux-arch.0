Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:38623 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752997AbaEWOyT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 May 2014 10:54:19 -0400
Message-ID: <537F60E0.1060307@zytor.com>
Date: Fri, 23 May 2014 07:53:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 16/18] x86: io: implement dummy relaxed accessor macros
 for writes
References: <1400777250-17335-1-git-send-email-will.deacon@arm.com> <1400777250-17335-17-git-send-email-will.deacon@arm.com> <537E30AF.4070501@zytor.com> <20140523144604.GF21319@arm.com>
In-Reply-To: <20140523144604.GF21319@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "monstr@monstr.eu" <monstr@monstr.eu>, "dhowells@redhat.com" <dhowells@redhat.com>, "broonie@linaro.org" <broonie@linaro.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "peterz@infradead.org" <peterz@infradead.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
Message-ID: <20140523145320.8HOC9el1IKh0qvrUZ5UKycY96djSAgtePHLNB1z4mJ0@z>

On 05/23/2014 07:46 AM, Will Deacon wrote:
> 
> I would like the relaxed accessors to be ordered with respect to each other...
> 
> What do you think?
> 

I think "I would like" isn't a very good motivation.  What are the
semantics of these things supposed to be?  It seems more than a bit odd
to require them to be ordered with respect to each other and everything
else (which is what a memory clobber does) and then call them "relaxed".

	-hpa


