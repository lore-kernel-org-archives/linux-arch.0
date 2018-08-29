Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43539 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeH2R4d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Aug 2018 13:56:33 -0400
MIME-Version: 1.0
References: <20180827194531.3796559-1-arnd@arndb.de>
In-Reply-To: <20180827194531.3796559-1-arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 29 Aug 2018 15:59:11 +0200
Message-ID: <CAK8P3a2vuDRnPzLQU1TeGfdPRjdZ9R2EkbDVerogJ7tJOoy8zg@mail.gmail.com>
Subject: Re: [PATCH 00/14] y2038 syscall changes for 4.20
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux API <linux-api@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Deepa Dinamani <deepa.kernel@gmail.com>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20180829135911.01x-nq8ucieu95hz-O3g5L2S27tH_LuXmXR3edwQ5C8@z>

On Mon, Aug 27, 2018 at 9:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Hi Thomas,
>
> I've rebased the syscall changes on top of 4.19-rc1, and the old_time32
> rename. This is the first set of those patches, the ones that I hope
> are all uncontroversial and obvious now. I'm still in the process of
> reorganizing and testing the next set batch top, and plan to send them
> after you've merged these.
>
> The first three patches are new here, the other ones have been posted
> before a few times.

Update: I've added the patch from the kbuild test robot, and pushed
the series to

git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git y2038

from where it should get picked up into linux-next. If there are
no concerns about the rest of the content, please pull from there.

      Arnd
