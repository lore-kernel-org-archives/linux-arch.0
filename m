Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726751AbfBLBt1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Feb 2019 20:49:27 -0500
Date: Tue, 12 Feb 2019 09:49:19 +0800
From: Guo Ren <guoren@kernel.org>
Subject: Re: [GIT PULL] csky fixes for v5.0-rc6
Message-ID: <20190212014919.GA7332@guoren-Inspiron-7460>
References: <1549861699-11875-1-git-send-email-guoren@kernel.org>
 <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh9kycrBtNOUN1-aOR_JL4scBgs=6NUkGQonfWFyzhvVw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190212014919.Dxy9j-mqnCehwKrpAHdgQCyhcXoUMWgWmdKQ4iEwv-4@z>

On Mon, Feb 11, 2019 at 10:28:26AM -0800, Linus Torvalds wrote:
> On Sun, Feb 10, 2019 at 9:08 PM <guoren@kernel.org> wrote:
> >
> > arch/csky patches for 5.0-rc6
> 
> The bulk of this seems to be new hardware support code.
> 
> Please send it during the 5.1 merge window, not as fixes at post-rc6 time.
Ok, I'll remove:
      irqchip/csky: Support csky,dh7k SOC intc driver
      dt-bindings: csky,apb-intc: Add dh7k SOC support

Best Regards
 Guo Ren
