From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] arch: xtensa: include: asm: compiling issue, need
 cmpxchg64() defined.
Date: Mon, 27 May 2013 20:19:53 +0400
Message-ID: <CAMo8BfKmZjH5ysA=d9xpDAR8kb_WoXFinBQ9nMMGRLmnpjQYcA@mail.gmail.com>
References: <51A34A0D.5070407@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51A34A0D.5070407@asianux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: chris@zankel.net, linux-xtensa@linux-xtensa.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Mon, May 27, 2013 at 3:57 PM, Chen Gang <gang.chen@asianux.com> wrot=
e:
>
> When compiling with 'allmodconfig', some of drivers need cmpxchg64(),
> xtensa does not supply 64-bit implementation for 'xchg', so use the
> 'generic' implementation.
>
> e.g. (for next-20130527 tree):
>   drivers/block/blockconsole.c:164:2: error: implicit declaration of =
function =E2=80=98cmpxchg64=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/xtensa/include/asm/cmpxchg.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)

Taken to the xtensa-fixes tree. Thanks.

-- Max
