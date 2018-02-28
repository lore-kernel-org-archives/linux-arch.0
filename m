From: Florian Weimer <fweimer@redhat.com>
Subject: Re: Removing architectures without upstream gcc support
Date: Wed, 28 Feb 2018 09:59:24 +0100
Message-ID: <6357df10-c3bd-587f-69d1-efb1855aaf85@redhat.com>
References: <CAK8P3a2-6YwRR3j7J78fVHSvDpq8Kf4wRj6d9mnGgAxgkYypxg@mail.gmail.com>
 <20180222160217.GA18243@infradead.org>
 <CAMo8BfLoqat+6CyOM2VV5Wz13NFMj54YisCogiVm95oDwdnTFQ@mail.gmail.com>
 <20180222180420.GA17956@infradead.org>
 <CAK8P3a2VMbAARCFuBjY7TMuAfGM_h4BU3PfQA2C_pUFT34UHAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2VMbAARCFuBjY7TMuAfGM_h4BU3PfQA2C_pUFT34UHAA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@infradead.org>
Cc: Max Filippov <jcmvbkbc@gmail.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Kuo <rkuo@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Guenter Roeck <linux@roeck-us.net>, Al Viro <viro@zeniv.linux.org.uk>, James Hogan <jhogan@kernel.org>, "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, openrisc@lists.librecores.org, David Howells <dhowells@redhat.com>, metcalf@alum.mit.edu
List-Id: linux-arch.vger.kernel.org

On 02/23/2018 12:37 PM, Arnd Bergmann wrote:
> That makes more sense, yes. I'm still unsure about this one though. Chris in
> fact made the suggestion to remove the architecture from both glibc and kernel
> as with his departure from Mellanox there is nobody left from to maintain it.
> 
> I suggested keeping it as 'Orphaned' for the time being, given that the port
> is still in a good shape, much better than many other ports.
> 
> The known customers that sold TileGX based appliances (Cisco, Brocade,
> Checkpoint, Mikrotik, ...) tend to have long support cycles, and there have
> been attempts at getting Debian, OpenWRT and Centos distro support
> at least a few years ago.

Note that there is tilegx-*-linux-gnu and tilepro-*-linux-gnu.  Only the 
latter was removed from glibc.

Thanks,
Florian
