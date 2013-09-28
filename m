Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:56878 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab3I1Kdv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 28 Sep 2013 06:33:51 -0400
MIME-Version: 1.0
In-Reply-To: <CACRpkdbhywp7_wAhOSzdMe==YoCo0mAcy1mJrdW3bURKWLxQeQ@mail.gmail.com>
References: <1380179668-32288-1-git-send-email-acourbot@nvidia.com> <CACRpkdbhywp7_wAhOSzdMe==YoCo0mAcy1mJrdW3bURKWLxQeQ@mail.gmail.com>
From: Alexandre Courbot <gnurou@gmail.com>
Date: Sat, 28 Sep 2013 19:33:30 +0900
Message-ID: <CAAVeFuLfUGsmOssWDtm8kf9av=3A_O9Fk8M8HGYF=xqtX8772Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] New descriptor-based GPIO interface
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Grant Likely <grant.likely@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Mathias Nyman <mathias.nyman@linux.intel.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20130928103330.MpoECMuu4kAA9ar9BIP6BQWO-RUeZz-1SXHUe_gezZk@z>

On Fri, Sep 27, 2013 at 9:06 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Sep 26, 2013 at 9:14 AM, Alexandre Courbot <acourbot@nvidia.com> wrote:
>
>> Here is a proper patch series for the descriptor-based GPIO interface to be
>> merged into -next. It is rebased on your for-next branch and only slightly
>> changed with respect to the RFC I posted earlier, only more thoroughly tested.
>> The documentation part is missing because I need some more time to rework it
>> (I'm on holidays this week but wanted to get the code into -next before 28th),
>> and anyway at this point I just want to make sure that the extra refactoring
>> does not break any existing code.
>>
>> My hope is to get this into -next before the 28th so this patchset can be
>> effectively tested, even if the new interfaces are not used yet. Since the old
>> integer-based interface now relies on top of gpiod_, this should provide good
>> coverage for both.
>
> I've applied it now, but no idea whether it will hit the last -next tree in
> time, hopefully at the very last second ...

Crap, looks like it did not make it. :( I hope we can still merge this for 3.13.

Alex.
