From: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 5/5] arch/xtensa, termios: use <asm-generic/termbits.h>
Date: Thu, 4 Oct 2018 15:35:33 -0700
Message-ID: <CAMo8BfJRvmNu=oHb4MaB_M7mdR5dMZRgfHb-Me8En3OoUe5m8g@mail.gmail.com>
References: <20181004222953.2229-1-hpa@zytor.com> <20181004222953.2229-6-hpa@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004222953.2229-6-hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, linux-serial@vger.kernel.org, Chris Zankel <chris@zankel.net>, Thomas Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, pombredanne@nexb.com, kstewart@linuxfoundation.org, linux-xtensa@linux-xtensa.org, Jiri Slaby <jslaby@suse.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 4, 2018 at 3:30 PM H. Peter Anvin (Intel) <hpa@zytor.com> wrote:
>
> The Xtensa definition of termbits.h is identical to the generic one.
>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: <linux-xtensa@linux-xtensa.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> ---
>  arch/xtensa/include/uapi/asm/termbits.h | 222 +-------------------------------
>  1 file changed, 1 insertion(+), 221 deletions(-)

Looks good. But why not removing the header entirely and adding
generic-y += termbits.h
to arch/xtensa/include/uapi/asm/Kbuild?

-- 
Thanks.
-- Max
