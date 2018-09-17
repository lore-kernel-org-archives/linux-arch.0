Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from frisell.zx2c4.com ([192.95.5.64]:42413 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbeIQSmF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Sep 2018 14:42:05 -0400
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-2-Jason@zx2c4.com>
 <20180912061433.GA8484@ip-172-31-15-78> <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com>
 <20180913050301.GA26367@ip-172-31-15-78>
In-Reply-To: <20180913050301.GA26367@ip-172-31-15-78>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Mon, 17 Sep 2018 15:14:32 +0200
Message-ID: <CAHmME9pGCwoS25c7KM+bHAzn5P+nquiwyoLsY-_Nu67RVd6Giw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kevin@guarana.org
Cc: LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
Message-ID: <20180917131432.JYurWabNxIaSpJKiV37OHNVMWDthG6mqpiiq6p9urGY@z>

Hey Kevin,

I found numerous other advantages in doing it the way you suggested
(which also helped squash some bugs), and so this will be part of v5.
Thanks for the suggestion.

Regards,
Jason
