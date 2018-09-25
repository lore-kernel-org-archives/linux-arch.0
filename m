Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:43169 "EHLO
        webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728289AbeIYSps (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Sep 2018 14:45:48 -0400
From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
Date: Tue, 25 Sep 2018 14:31:05 +0200
Message-ID: <6262522.aGb77nX7K0@ws-140106>
In-Reply-To: <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de> <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: alexander.lochmann@tu-dortmund.de, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180925123105.Fr1-sxelPzeAx8U2GUz-FMg3Eawm6ztSKiBYiidEPoI@z>

Hello Arnd,

On Tuesday, September 25, 2018, 2:06:38 PM CEST Arnd Bergmann wrote:
> We don't really want an empty macro any more, this was used in
> the past, but causes compile-time warnings and undefined behavior
> for no good reason.

Can you elaborate or point me to some other discussion about that undefined behavior?

Best regards,
Alexander
