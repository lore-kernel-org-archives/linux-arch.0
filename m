From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [x86] BUG()/BUG_ON() macros cannot be disabled
Date: Tue, 25 Sep 2018 14:31:05 +0200
Message-ID: <6262522.aGb77nX7K0@ws-140106>
References: <9516e4b3-f9f2-b150-f019-8b1ef465efb3@tu-dortmund.de> <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a1sO9HtJPo0S=s3MFK4TN0s_raNTWRTYCYBTGiyHuXg_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: alexander.lochmann@tu-dortmund.de, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hello Arnd,

On Tuesday, September 25, 2018, 2:06:38 PM CEST Arnd Bergmann wrote:
> We don't really want an empty macro any more, this was used in
> the past, but causes compile-time warnings and undefined behavior
> for no good reason.

Can you elaborate or point me to some other discussion about that undefined behavior?

Best regards,
Alexander
