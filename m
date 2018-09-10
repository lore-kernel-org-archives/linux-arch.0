From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 8/8] really consolidate INIT_C_CC definitions
Date: Mon, 10 Sep 2018 03:33:45 -1000
Message-ID: <CA+55aFyzNWJJfHRMiEF8=Nto=O=jF6iuFTQEzEqF7rr6v_j8oQ@mail.gmail.com>
References: <20180910044937.GJ19965@ZenIV.linux.org.uk> <20180910045227.9895-1-viro@ZenIV.linux.org.uk>
 <20180910045227.9895-8-viro@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180910045227.9895-8-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sun, Sep 9, 2018 at 6:52 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>  */
> +#ifndef INIT_C_CC_VDISCARD
> +#define INIT_C_CC_VDISCARD 'O'-0x40
> +#endif

Just change everybody to do the same, nobody cares about VDISCARD.

We can change the value of VDISCARD because it doesn't actually have
anything connected to it, so don't worry about "we used to have odd
different values for it".

            Linus
