Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:57340 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753326Ab3JBKcS (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Oct 2013 06:32:18 -0400
Received: by mail-ie0-f172.google.com with SMTP id x13so1322858ief.17
        for <linux-arch@vger.kernel.org>; Wed, 02 Oct 2013 03:32:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAAVeFuLfUGsmOssWDtm8kf9av=3A_O9Fk8M8HGYF=xqtX8772Q@mail.gmail.com>
References: <1380179668-32288-1-git-send-email-acourbot@nvidia.com>
	<CACRpkdbhywp7_wAhOSzdMe==YoCo0mAcy1mJrdW3bURKWLxQeQ@mail.gmail.com>
	<CAAVeFuLfUGsmOssWDtm8kf9av=3A_O9Fk8M8HGYF=xqtX8772Q@mail.gmail.com>
Date: Wed, 2 Oct 2013 12:32:17 +0200
Message-ID: <CACRpkdZDwKq-3MgY4O5m5_MTfigdcxzHFwXn=KxjvL+AaG+7VQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] New descriptor-based GPIO interface
From: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20131002103217.MCsUkpCrRZZT6ksSZy4kP1XxLU6vER_kMy321_t2XQg@z>

On Sat, Sep 28, 2013 at 12:33 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Fri, Sep 27, 2013 at 9:06 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

>> I've applied it now, but no idea whether it will hit the last -next tree in
>> time, hopefully at the very last second ...
>
> Crap, looks like it did not make it. :( I hope we can still merge this for 3.13.

As you noticed we have pretty extensive build coverage so as long as we're
not patching around in the entire kernel we can be pretty sure that patches
are fine to go if we queue them up in the GPIO tree so don't worry.

Yours,
Linus Walleij
