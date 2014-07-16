From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v2 29/29] nios2: Build infrastructure
Date: Wed, 16 Jul 2014 21:50:24 +0200
Message-ID: <1405540224.4408.55.camel@x220>
References: <1405413956-2772-1-git-send-email-lftan@altera.com>
	 <1405413956-2772-30-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1405413956-2772-30-git-send-email-lftan@altera.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

Ley Foon,

On Tue, 2014-07-15 at 16:45 +0800, Ley Foon Tan wrote:
> This patch adds Makefile and Kconfig files required for building a
> nios2 kernel.
> 
> Signed-off-by: Ley Foon Tan <lftan@altera.com>

For what it's worth, this v2 indeed cleans up the few things I noted in
the related 01/28 of v1.

So this series doesn't introduce any new Kconfig related oddities
anymore; ie, oddities of the obvious type that my local script spots.
That can't qualify as a review but I do think it's nice to see.

Thanks,


Paul Bolle

