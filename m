From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 29/29] nios2: Build infrastructure
Date: Thu, 30 Oct 2014 12:33:38 +0100
Message-ID: <11875981.eJaWCbGJJT@wuerfel>
References: <1414139071-3818-1-git-send-email-lftan@altera.com> <2095416.INZmt8AD1y@wuerfel> <CAFiDJ59LZSwKBzVuuzfH_5772-BR74EH=d=FeBbWvEXjfpisug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAFiDJ59LZSwKBzVuuzfH_5772-BR74EH=d=FeBbWvEXjfpisug@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>
List-Id: linux-arch.vger.kernel.org

On Thursday 30 October 2014 18:44:37 Ley Foon Tan wrote:
> >
> > I don't remember what all of these are, but at least some of them seem
> > to be concerned with 64-bit division. By convention, we don't provide those
> > in the Linux kernel but instead require all code to use the do_div()
> > macro instead.
> Do you mean kernel doesn't support 64 bit division result for a 32-bit
> architecture? Because do_div() only support 32-bit division result for
> 32-bit architecture.

Correct. If you need a full 64-bit division on a 32-bit kernel, the
assumption is that your driver has a bug.

	Arnd
