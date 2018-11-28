From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Wed, 28 Nov 2018 21:02:51 +0100
Message-ID: <7B91760F-AFC3-4C8C-9B9F-FA0E9AD76B0C@xenosoft.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de> <87zhttfonk.fsf@concordia.ellerman.id.au> <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

I will compile and test the kernel from the following Git on my PowerPC mach=
ines.

http://git.infradead.org/users/hch/misc.git

On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
Nothing specific yet.

I'm a bit worried it might break one of the many old obscure platforms
we have that aren't well tested.
