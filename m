Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:39483 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752489AbaBEO74 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2014 09:59:56 -0500
Message-ID: <52F25209.2010506@windriver.com>
Date: Wed, 5 Feb 2014 10:00:25 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
MIME-Version: 1.0
Subject: Re: [PATCH 59/73] drivers/gpio: delete non-required instances of
 include <linux/init.h>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>	<1390339396-3479-60-git-send-email-paul.gortmaker@windriver.com>	<CACRpkdYk6cOO-JZbe887ihJaWE5JMjuXm3EVcZmE1jCeL2BODQ@mail.gmail.com>	<20140124095827.1ee8ddcfed8d1c8e0a6d3dbd@canb.auug.org.au>	<20140124022154.GA13428@windriver.com> <CACRpkdYF2f1Ekp6JYwntj+UhbceWtMN==yKC7emsXHfktcZZsg@mail.gmail.com>
In-Reply-To: <CACRpkdYF2f1Ekp6JYwntj+UhbceWtMN==yKC7emsXHfktcZZsg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Message-ID: <20140205150025.fPbKxiN-cudK9Mv32vmvkvqHHbGkJZScop6uWudRdOI@z>

On 14-02-05 08:02 AM, Linus Walleij wrote:
> On Fri, Jan 24, 2014 at 3:21 AM, Paul Gortmaker
> <paul.gortmaker@windriver.com> wrote:
> 
>> For what it is worth, I'm not removing any patches from my series file
>> until they explicitly conflict and/or become redundant.  If a maintainer
>> says they are adding the patch, I add a comment in the series file, but
>> I don't remove them until I see them come into next via another branch,
>> and/or sfr reports a conflict/redundancy.
> 
> So I can add these patches to my devel branches now I think?

The patches that weren't taken by maintainers before 3.14-rc1 were
encompassed in the cleanup pull request to Linus sent yesterday.

http://www.spinics.net/lists/arm-kernel/msg304864.html

So, assuming he does pull it, you'll not have to do anything.

Thanks,
Paul.
--

> 
> Yours,
> Linus Walleij
> 
