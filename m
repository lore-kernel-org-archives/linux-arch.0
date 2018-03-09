From: "Xuetao Guan" <gxt@mprc.pku.edu.cn>
Subject: Re: Removing architectures without upstream gcc support
Date: Fri, 9 Mar 2018 22:00:42 +0800 (CST)
Message-ID: <50191.222.29.22.133.1520604042.squirrel@mprc.pku.edu.cn>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
Reply-To: gxt@mprc.pku.edu.cn
Mime-Version: 1.0
Content-Type: text/plain;charset=gb2312
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, linux-hexagon@vger.kernel.org, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, linux-metag@vger.kernel.org, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>
List-Id: linux-arch.vger.kernel.org


> * unicore32 was a research project at Peking University with a SoC
>   based on the Intel PXA design. No gcc source code has ever been
>   published, the only toolchain available is a set of binaries that
> include
>   a gcc-4.4 compiler. The project page at
>   http://mprc.pku.edu.cn/~guanxuetao/linux/ has a TODO list that has
>   not been modified since 2011. The maintainer still Acks patches
>   and has last sent a pull request in 2014 and last sent a patch of
>   his own in 2012 when the project appears to have stalled.
>   I would suggest removing this one.
>
Hi, Arnd.
I am really sorry to reply so late, since I seldom use this email account
in recent years. I will add my new email account to related bits.

Let me clarify the status of UniCore. It's a real cpu-core product,
integrated into PKUnity SoC, and sold in a large amount of embedded boxes,
such as cloud terminals and set top boxes. Surely, we still use the port
internally and keep doing developments in other projects. So, I really
appreciate having unicore32 port in the tree.

As to gnu toolchain of UniCore, I have already discussed it in my group,
and I'll do my best to propel it forward.

Thanks,
Guan Xuetao
