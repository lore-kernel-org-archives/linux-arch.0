From: James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: Re: [PATCH] unaligned: delete 1-byte accessors
Date: Mon, 22 Jul 2019 08:08:33 +0900
Message-ID: <1563750513.2898.4.camel@HansenPartnership.com>
References: <20190721215253.GA18177@avx2>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190721215253.GA18177@avx2>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, axboe@kernel.dk, kvalo@codeaurora.org, john.johansen@canonical.com, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 2019-07-22 at 00:52 +0300, Alexey Dobriyan wrote:
> Each and every 1-byte access is aligned!

The design idea of this is for parsing descriptors.  We simply chunk up
the describing structure using get_unaligned for everything.  The
reason is because a lot of these structures come with reserved areas
which we may make use of later.  If we're using get_unaligned for
everything we can simply change a u8 to a u16 in the structure
absorbing the reserved padding.  With your change now I'd have to chase
down every byte access and replace it with get_unaligned instead of
simply changing the structure.

What's the significant advantage of this change that compensates for
the problems the above causes?

James
