From: Linas Vepstas <linasvepstas@gmail.com>
Subject: Re: [PATCH 4/6] Hexagon: check to if we will overflow the signal stack
Date: Thu, 4 Apr 2013 11:25:50 -0500
Message-ID: <CAHrUA37oTkv-x5f4zZVwqjWAqvyMdwXAokw1EDBHiGv8ozWxVQ@mail.gmail.com>
References: <1365033776-21804-1-git-send-email-rkuo@codeaurora.org> <1365033776-21804-5-git-send-email-rkuo@codeaurora.org>
Reply-To: linasvepstas@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <1365033776-21804-5-git-send-email-rkuo@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
List-Id: linux-arch.vger.kernel.org

On 3 April 2013 19:02, Richard Kuo <rkuo@codeaurora.org> wrote:

> +       /* check if we would overflow the alt stack */
> +       if (on_sig_stack(sp) && !likely(on_sig_stack(sp - frame_size)))
> +               return (void __user __force *)-1UL;

I found the !likely construction confusing, as its doing both a
'unlikely' (right?) and inverting the argument. It seems clearer,
to idiots like me, to write this as:

if (on_sig_stack(sp) && unlikely(!on_sig_stack(sp - frame_size)))

since where checking for overflow, and its unlikely that the overflow happened.

-- Linas
