From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 16/18] x86: io: implement dummy relaxed accessor macros
 for writes
Date: Fri, 23 May 2014 08:43:01 -0700
Message-ID: <537F6C85.107@zytor.com>
References: <1400777250-17335-1-git-send-email-will.deacon@arm.com> <1400777250-17335-17-git-send-email-will.deacon@arm.com> <537E30AF.4070501@zytor.com> <20140523144604.GF21319@arm.com> <537F60E0.1060307@zytor.com> <20140523145758.GG21319@arm.com> <537F6728.3090600@zytor.com> <20140523153409.GI21319@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:39309 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbaEWPnt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 23 May 2014 11:43:49 -0400
In-Reply-To: <20140523153409.GI21319@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "monstr@monstr.eu" <monstr@monstr.eu>, "dhowells@redhat.com" <dhowells@redhat.com>, "broonie@linaro.org" <broonie@linaro.org>, "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "peterz@infradead.org" <peterz@infradead.org>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>

On 05/23/2014 08:34 AM, Will Deacon wrote:
> 
> There is also a documentation patch [1] in this series but, again, I didn't
> CC everybody on it. Sorry, but the level of interest this sort of stuff
> generates amongst kernel developers is close to zero so I only included
> people I thought cared on CC for the entire series. I'm stuck between a rock
> and a hard place trying to CC interested people whilst at the same time
> trying to avoid spamming all the arch maintainers.
> 

If you are sending me a patch, please include me on the cover letter for
the patch series.  You don't have to send me the entire patch series
(although for something like a Documentation patch which affects x86 I
would consider including the union list as well.)

I think regardless of level of interest, the definition of
cross-architectural operations is exactly the arch maintainers job, so
it isn't really out of place to "spam" us...

	-hpa
