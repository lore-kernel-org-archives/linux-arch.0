From: whitequark <whitequark@whitequark.org>
Subject: Re: [OpenRISC] Removing architectures without upstream gcc support
Date: Mon, 26 Feb 2018 15:24:25 +0000
Message-ID: <9dda26a68c1174933e456227efb6ae01@whitequark.org>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <155284c9-7fd4-2f2c-0216-1c43622f88c3@philipp-wagner.com>
 <CAK8P3a1Pd5+mGocnpQyPNYEqqqwpDJAb+FnWS6OJxuO1d-R=2A@mail.gmail.com>
 <57602e7e-a9c6-3480-7e99-7d274e836ed6@philipp-wagner.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57602e7e-a9c6-3480-7e99-7d274e836ed6@philipp-wagner.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Philipp Wagner <lists@philipp-wagner.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, Chen Liqin <liqin.linux@gmail.com>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, David Howells <dhowells@redhat.com>, openrisc@lists.librecores.org, Lennox Wu <lennox.wu@gmail.com>, James Hogan <jhogan@kernel.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-arch.vger.kernel.org

On 2018-02-26 12:10, Philipp Wagner wrote:
> Actually the LLVM port of or1k isn't upstream either. CCing
> whitequark, who might know more about the (non-)plans of getting the
> backend upstream. I also don't know of anyone having tried to build
> the openrisc kernel with LLVM, would certainly be an interesting thing
> to try.

I keep the OR1K backend up-to-date and generally in good shape (e.g.
I've got exception handling work and added all missing instructions
to the internal assembler) but upstreaming it is many weeks of work
that I personally cannot spare, and the LLVM community requests that
those who upstream backends maintain buildbots running hardware tests
indefinitely, which I personally cannot afford.

-- 
whitequark
