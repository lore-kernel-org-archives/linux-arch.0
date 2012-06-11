From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 0/6] Bridging PCI to amba
Date: Mon, 11 Jun 2012 15:28:22 +0000
Message-ID: <201206111528.23034.arnd@arndb.de>
References: <cover.1338220457.git.rubini@gnudd.com> <CACRpkdbPtR5MDjd1YZ5GhOdp61HQe2PJusudNPOhDQHUAt1kJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CACRpkdbPtR5MDjd1YZ5GhOdp61HQe2PJusudNPOhDQHUAt1kJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Alessandro Rubini <rubini@gnudd.com>, linux-kernel@vger.kernel.org, Giancarlo Asnaghi <giancarlo.asnaghi@st.com>, Alan Cox <alan@linux.intel.com>, Russell King <linux@arm.linux.org.uk>, x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sunday 10 June 2012, Linus Walleij wrote:
> On Mon, May 28, 2012 at 6:36 PM, Alessandro Rubini <rubini@gnudd.com> wrote:
> 
> > V2: accepted comments I got on V1; rewritten the driver to be generic;
> >    made it tristate instead of boolean. Rebased on new next.
> 
> This looks good to me.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> I think this patch set could go through Arnd as arch maintainer?
> It's fun with these cross-arch things. You'll need an ACK from
> Russell first.

I don't think it has much to do with code I maintain. Russell
as the Primecell maintainer is the right person to take it through
his tree.

	Arnd
