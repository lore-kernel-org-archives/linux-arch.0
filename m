From: Matthew Wilcox <willy@infradead.org>
Subject: Re: Function pointer alignment
Date: Fri, 22 Dec 2017 05:09:36 -0800
Message-ID: <20171222130936.GC6401@bombadil.infradead.org>
References: <20171222035518.GC23624@bombadil.infradead.org>
 <CAMuHMdVNF66QSnRvJxkNowMuVKeSoc7PHa+Ep-ojYmA2ywPRxQ@mail.gmail.com>
 <CAMuHMdWM-1VepP2fDxAwG6m+WC33UqPWN=DL7JEYVwSbtU8Xkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:36788 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbdLVNJh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 22 Dec 2017 08:09:37 -0500
Content-Disposition: inline
In-Reply-To: <CAMuHMdWM-1VepP2fDxAwG6m+WC33UqPWN=DL7JEYVwSbtU8Xkg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>

On Fri, Dec 22, 2017 at 01:30:51PM +0100, Geert Uytterhoeven wrote:
> On Fri, Dec 22, 2017 at 1:28 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Fri, Dec 22, 2017 at 4:55 AM, Matthew Wilcox <willy@infradead.org> wrote:
> >> What alignment can we rely on for function pointers?
> >
> > Only one bit to steal on m68k...
> 
> Same on SH.

How much damage would we do by adding -falign-functions=4 to CFLAGS
on m68k?  Can you measure that for me?
