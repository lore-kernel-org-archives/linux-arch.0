Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:45453 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754961AbaBFJd0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 6 Feb 2014 04:33:26 -0500
Received: by mail-oa0-f47.google.com with SMTP id m1so1981248oag.20
        for <linux-arch@vger.kernel.org>; Thu, 06 Feb 2014 01:33:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52F25209.2010506@windriver.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
	<1390339396-3479-60-git-send-email-paul.gortmaker@windriver.com>
	<CACRpkdYk6cOO-JZbe887ihJaWE5JMjuXm3EVcZmE1jCeL2BODQ@mail.gmail.com>
	<20140124095827.1ee8ddcfed8d1c8e0a6d3dbd@canb.auug.org.au>
	<20140124022154.GA13428@windriver.com>
	<CACRpkdYF2f1Ekp6JYwntj+UhbceWtMN==yKC7emsXHfktcZZsg@mail.gmail.com>
	<52F25209.2010506@windriver.com>
Date: Thu, 6 Feb 2014 10:33:25 +0100
Message-ID: <CACRpkdZbam+UcKhBXwwLE+cDDoUgCPUQZ-afOD+qyJt9aJfw4g@mail.gmail.com>
Subject: Re: [PATCH 59/73] drivers/gpio: delete non-required instances of
 include <linux/init.h>
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Message-ID: <20140206093325.Lrc9XYgy28JF8DKK12V-t7DhqmucXGNZ2l7WR9Gfa1g@z>

On Wed, Feb 5, 2014 at 4:00 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> On 14-02-05 08:02 AM, Linus Walleij wrote:

>> So I can add these patches to my devel branches now I think?
>
> The patches that weren't taken by maintainers before 3.14-rc1 were
> encompassed in the cleanup pull request to Linus sent yesterday.

Sweet! Thanks Paul.

Yours,
Linus Walleij
