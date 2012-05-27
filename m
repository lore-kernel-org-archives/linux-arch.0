From: Jonas Bonn <jonas@southpole.se>
Subject: Re: Mostly portable strnlen_user()
Date: Sun, 27 May 2012 10:28:05 +0200
Message-ID: <1338107285.3557.64.camel@jerome.southpole.se>
References: <CA+55aFxYO-fb9K-_g8X85tK8-sGxUHy1R8X3Hes3fb-+0bhXLw@mail.gmail.com>
	 <20120525.224318.1418525735588086513.davem@davemloft.net>
	 <CA+55aFxDyPCEFbOFaPbXF556NbtakuC0RcoUKhCa5k2EsqJ8CQ@mail.gmail.com>
	 <20120526.001552.1171433126500742038.davem@davemloft.net>
	 <CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
	 <CACM3HyFDY96F5kfsVCRQbx+8J+BUDCWXPqQVuLwOXRefS0Gcvg@mail.gmail.com>
	 <CA+55aFxpEnd2efoU9S208L9HaOD8cvRZ38uCXr=nrhLmwgHZuw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.southpole.se ([193.12.106.18]:51715 "EHLO
	mail.southpole.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab2E0I2N (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 27 May 2012 04:28:13 -0400
In-Reply-To: <CA+55aFxpEnd2efoU9S208L9HaOD8cvRZ38uCXr=nrhLmwgHZuw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org


On Sat, 2012-05-26 at 11:39 -0700, Linus Torvalds wrote:
> On Sat, May 26, 2012 at 1:32 AM, Jonas Bonn <jonas@southpole.se> wrote:
> >
> > I gave this a try on OpenRISC... works fine here, too.
> 

> Can you guys double-check that everything looks good, and Jonas, I
> assume you could just do a patch to remove the openrisc
> str[n]len_user() functions, and then add the "select
> GENERIC_STRNLEN_USER". Quite frankly, I could probably do it for you,
> but I'm not going to generate a random patch for some architecture
> I've never in my life compiled anything for.

Yes, all tested and looks good.  I'll send you a patch for OpenRISC.

Thanks,
Jonas
