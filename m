From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 59/73] drivers/gpio: delete non-required instances of
 include <linux/init.h>
Date: Fri, 24 Jan 2014 09:44:18 +0100
Message-ID: <CACRpkda7qbYnz6r6Z3qdRzEVwN4nXdGLhREAcsL8T28yemPVEA@mail.gmail.com>
References: <1390339396-3479-1-git-send-email-paul.gortmaker@windriver.com>
	<1390339396-3479-60-git-send-email-paul.gortmaker@windriver.com>
	<CACRpkdYk6cOO-JZbe887ihJaWE5JMjuXm3EVcZmE1jCeL2BODQ@mail.gmail.com>
	<20140124095827.1ee8ddcfed8d1c8e0a6d3dbd@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140124095827.1ee8ddcfed8d1c8e0a6d3dbd@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Jan 23, 2014 at 11:58 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> I have no problem with that particular patch being sent to Linus during
> this merge window (in fact Paul intends to send whatever is left of the
> series at the end of the merge window), but it makes me wonder about the
> other commits that you have added to the gpio tree (and the pinctrl tree)
> today.  Are they intended for this merge window or v3.15?

Sorry, my bad. I took this out now and I have a much smaller/stricter
subset of patches in for-next today.

Yours,
Linus Walleij
