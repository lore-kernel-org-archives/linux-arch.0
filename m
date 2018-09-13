Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from frisell.zx2c4.com ([192.95.5.64]:38403 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730002AbeIMTCu (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Sep 2018 15:02:50 -0400
MIME-Version: 1.0
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-2-Jason@zx2c4.com>
 <20180912061433.GA8484@ip-172-31-15-78> <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com>
 <20180913050301.GA26367@ip-172-31-15-78> <CAHmME9rMg_2eHBnfP6j9Y3O7-At90HF=ToTWeFL_Qc4nGURORg@mail.gmail.com>
In-Reply-To: <CAHmME9rMg_2eHBnfP6j9Y3O7-At90HF=ToTWeFL_Qc4nGURORg@mail.gmail.com>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 13 Sep 2018 15:53:01 +0200
Message-ID: <CAHmME9oURsx=8HY1TRkFPEV1-qPUc03FF8stM20b8WzpnXVnOg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: kevin@guarana.org, Andrew Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
Message-ID: <20180913135301.RpIHna_Bm69MM0oHYKq9WOSTd9jtdf7zMjDrZxRvG7c@z>

On Thu, Sep 13, 2018 at 3:52 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> simd_put();
Rather, simd_put(simd_context);
