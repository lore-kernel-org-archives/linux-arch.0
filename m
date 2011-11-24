From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH-RFC 02/10] lib: add GENERIC_PCI_IOMAP
Date: Thu, 24 Nov 2011 23:07:57 +0100
Message-ID: <1564173.bLjG0I2D2P@wuerfel>
References: <cover.1322163031.git.mst@redhat.com> <b5a1327dd8bb38f87cba7ae10b308ec3b63de66a.1322163031.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <b5a1327dd8bb38f87cba7ae10b308ec3b63de66a.1322163031.git.mst@redhat.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: linuxppc-dev@lists.ozlabs.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-mips@linux-mips.org, linux-m68k@vger.kernel.org, linux-ia64@vger.kernel.org, linux@openrisc.net, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Chen Liqin <liqin.chen@sunplusct.com>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Lennox Wu <lennox.wu@gmail.com>, Jonas Bonn <jonas@southpole.se>, Jesper Nilsson <jesper.nilsson@axis.com>, Russell King <linux@arm.linux.org.uk>, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, Helge Deller <deller@gmx.de>, x86@kernel.org, "James E.J. Bottomley" <jejb@parisc-linux.org>, Ingo Molnar <mingo@redhat.com>, Geert
List-Id: linux-arch.vger.kernel.org

On Thursday 24 November 2011 22:17:02 Michael S. Tsirkin wrote:
> Many architectures want a generic pci_iomap but
> not the rest of iomap.c. Split that to a separate .c
> file and add a new config symbol. select automatically
> by GENERIC_IOMAP.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Very nice!

Acked-by: Arnd Bergmann <arnd@arndb.de>
