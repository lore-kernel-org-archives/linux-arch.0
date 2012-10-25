From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] asm-generic/io.h: remove asm/cacheflush.h
	include
Date: Thu, 25 Oct 2012 15:07:27 +0100
Message-ID: <5089479F.6070608@imgtec.com>
References: <1350984117-17369-1-git-send-email-james.hogan@imgtec.com>
	<1351172416.6232.70.camel@jerome.southpole.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-bounces@lists.openrisc.net>
In-Reply-To: <1351172416.6232.70.camel@jerome.southpole.se>
List-Unsubscribe: <http://lists.openrisc.net/options/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=unsubscribe>
List-Archive: <http://lists.openrisc.net/pipermail/linux>
List-Post: <mailto:linux@lists.openrisc.net>
List-Help: <mailto:linux-request@lists.openrisc.net?subject=help>
List-Subscribe: <http://lists.openrisc.net/listinfo/linux>,
	<mailto:linux-request@lists.openrisc.net?subject=subscribe>
Sender: linux-bounces@lists.openrisc.net
Errors-To: linux-bounces@lists.openrisc.net
To: Jonas Bonn <jonas@southpole.se>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Mike Frysinger <vapier@gentoo.org>, Arnd Bergmann <arnd@arndb.de>, Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>, linux@lists.openrisc.net, uclinux-dist-devel@blackfin.uclinux.org, Chen Liqin <liqin.chen@sunplusct.com>, Lennox Wu <lennox.wu@gmail.com>
List-Id: linux-arch.vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 25/10/12 14:40, Jonas Bonn wrote:
> On Tue, 2012-10-23 at 10:21 +0100, James Hogan wrote:
>> Including <asm/cacheflush.h> from <asm-generic/io.h> prevents 
>> cacheflush.h being able to use I/O functions like readl and
>> writel due to circular include dependencies. It doesn't appear as
>> if anything from cacheflush.h is actually used by the generic
>> io.h, so remove the include.
>> 
>> I've compile tested a defconfig compilation of blackfin, openrisc
>> (which needed <asm/pgtable.h> including from it's <asm/io.h> to
>> get the PAGE_* definitions), and xtensa.
>> 
>> Other architectures which use asm-generic/io.h are score and
>> unicore32, and looking at their io.h I don't see any obvious
>> problems.
> 
> Acked-by: Jonas Bonn <jonas@southpole.se> for OpenRISC

Thanks Jonas

> Who's tree should this go via.  I can take it via the openrisc
> tree, but it would be good to get some Ack's that this isn't going
> to break things for the other arch's (in particular score and
> unicore32, since they are untested).

Yeh I'd like some acks from score and unicore32 if possible, since I
didn't notice I needed the openrisc bit until I tried compiling it.

Cheers
James
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiUefAAoJEKHZs+irPybfly0P/3RZDS5sxivx513plCPNMucV
rXmZnEGh87Iw9c8htjV0WFH5dAtmUQ88wkExGEWPdK57AYhMLwKN+soycq3XGS6E
156EFDpp602K9bwZ5bTodJco2FalaQrUh+GQqWOBGhi0NPwnt0pwEpUC/F5Vn71d
rekQ9er/fKWhF74ONKh+/K3fSTHl6/S2Krt3izsPH9a+7aYpWNVNvfrhyS43A+AR
xa3tE0Q5sHvaRTYp+42p/7CHwOzAerXs3Cvp7QYrwErV8cB6IvkVh+b7RYkawYAq
czVIjbi45ouJlRek7EO3ZlcDFtiuoQZxzdVDNUwMuKWv7e9ASQ1StTHbh67DDlGK
cZsFMnuO0ddkdzs8ya/HWdA9+hZmrigPmst4rKUvM4idJ/N7zpO4G74fCwVDLng1
GIUrPrZTbcgpZyGepJfH9jGmwRJBcS8nYiep3quz21p3oGafeIVdv7WsPcHC0/HA
BOW2NcGDihtiJjooVWAiRhEPO4jxBCpY187YuoKJXCFdm5CfJ7ZdCIjeEt/cWVQs
yNfoGeVtHgRxKEJFsKAIto92iT18JY0qZWJL7WAqFDD4qB13RmJbmUOE4LCChFKK
Jui/Fi46j6uWdau6mujMlYKx3RMHjB/Lw09WRL78gEB6JaxpzVh4iShu4BI8G50P
Ye3bZ/gyfOLBRBky14FJ
=xH4e
-----END PGP SIGNATURE-----
