Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:48668 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799Ab3E0QTy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 27 May 2013 12:19:54 -0400
MIME-Version: 1.0
In-Reply-To: <51A34A0D.5070407@asianux.com>
References: <51A34A0D.5070407@asianux.com>
Date: Mon, 27 May 2013 20:19:53 +0400
Message-ID: <CAMo8BfKmZjH5ysA=d9xpDAR8kb_WoXFinBQ9nMMGRLmnpjQYcA@mail.gmail.com>
Subject: Re: [PATCH] arch: xtensa: include: asm: compiling issue, need
 cmpxchg64() defined.
From: Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: chris@zankel.net, linux-xtensa@linux-xtensa.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20130527161953.zsF1MNqRY0e-d4ltGPmUmhG6HB1_zs2UC4wl5JQpOPs@z>

On Mon, May 27, 2013 at 3:57 PM, Chen Gang <gang.chen@asianux.com> wrote:
>
> When compiling with 'allmodconfig', some of drivers need cmpxchg64(),
> xtensa does not supply 64-bit implementation for 'xchg', so use the
> 'generic' implementation.
>
> e.g. (for next-20130527 tree):
>   drivers/block/blockconsole.c:164:2: error: implicit declaration of function ‘cmpxchg64’ [-Werror=implicit-function-declaration]
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/xtensa/include/asm/cmpxchg.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Taken to the xtensa-fixes tree. Thanks.

-- Max
