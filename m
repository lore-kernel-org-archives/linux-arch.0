From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 59/73] drivers/gpio: delete non-required instances of
 include <linux/init.h>
Date: Wed, 5 Feb 2014 14:02:52 +0100
Message-ID: <CACRpkdYF2f1Ekp6JYwntj+UhbceWtMN==yKC7emsXHfktcZZsg@mail.gmail.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
	<1390339396-3479-60-git-send-email-paul.gortmaker@windriver.com>
	<CACRpkdYk6cOO-JZbe887ihJaWE5JMjuXm3EVcZmE1jCeL2BODQ@mail.gmail.com>
	<20140124095827.1ee8ddcfed8d1c8e0a6d3dbd@canb.auug.org.au>
	<20140124022154.GA13428@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:45607 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332AbaBENCw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 5 Feb 2014 08:02:52 -0500
Received: by mail-ob0-f179.google.com with SMTP id wo20so360457obc.10
        for <linux-arch@vger.kernel.org>; Wed, 05 Feb 2014 05:02:52 -0800 (PST)
In-Reply-To: <20140124022154.GA13428@windriver.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

On Fri, Jan 24, 2014 at 3:21 AM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> For what it is worth, I'm not removing any patches from my series file
> until they explicitly conflict and/or become redundant.  If a maintainer
> says they are adding the patch, I add a comment in the series file, but
> I don't remove them until I see them come into next via another branch,
> and/or sfr reports a conflict/redundancy.

So I can add these patches to my devel branches now I think?

Yours,
Linus Walleij
