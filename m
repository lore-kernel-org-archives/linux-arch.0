From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: blackfin: kernel: sprintf(), need avoid NUL for
 '%s'
Date: Mon, 17 Jun 2013 09:13:25 +0800
Message-ID: <51BE62B5.1010302@asianux.com>
References: <51A5CDB4.9000204@asianux.com> <CAMjpGUf6rvcjNVqk6bB4RRjOSLQjk3de6CEv7rUm3VcMhzGdag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMjpGUf6rvcjNVqk6bB4RRjOSLQjk3de6CEv7rUm3VcMhzGdag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: anton.vorontsov@linaro.org, Richard Kuo <rkuo@codeaurora.org>, Jesper Nilsson <jesper.nilsson@axis.com>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 06/16/2013 11:02 AM, Mike Frysinger wrote:
> i think you mean NULL instead of NUL
> 
> that said, the kernel is smart enough to replace NULL with "(null)",
> so i don't see much point in this patch

Oh, really it is, it is my fault (originally, I did not know about it).

Thanks.
-- 
Chen Gang

Asianux Corporation
