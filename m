From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH] ARC: fix broken noncoherent cache ops
Date: Thu, 26 Jul 2018 19:00:10 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B084089@us01wembx1.internal.synopsys.com>
References: <20180724141302.4305-1-Eugeniy.Paltsev@synopsys.com>
 <20180726091155.GA24209@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Alexey Brodkin <Alexey.Brodkin@synopsys.com>
List-Id: linux-arch.vger.kernel.org

On 07/26/2018 02:08 AM, Christoph Hellwig wrote:=0A=
> On Tue, Jul 24, 2018 at 05:13:02PM +0300, Eugeniy Paltsev wrote:=0A=
>> All DMA devices on ARC haven't worked with SW cache control=0A=
>> since commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")=0A=
>> This happens because we don't check direction argument at all in=0A=
>> new implementation. Fix that.=0A=
>>=0A=
>> Fixies: commit a8eb92d02dd7 ("arc: fix arc_dma_{map,unmap}_page")=0A=
>> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> Looks sensible.  Might be worth explaining that ARC can speculate=0A=
> into the areas under DMA, which is why this is required.=0A=
>=0A=
=0A=
ARC CPUs do prefetch, but I doubt if they are doing so, so aggressively, sp=
ecially=0A=
when the region around DMA buffers is unlikely to be used for normal LD/ST=
=0A=
bleeding into DMA buffers. The issue here seems to be less technical and a =
bit of=0A=
snafu in implementation details.=0A=
=0A=
1. originally=0A=
    dma_map_single(@dir)  =3D> honored @dir, and did inv, wback or both dep=
ending on it=0A=
=0A=
    sync_for_device(@dir) =3D> forced @dir DMA_TO_DEV =3D > cache wback=0A=
    sync_for_cpu(@dir)     =3D> forced @dir DMA_FROM_DEV =3D > cache inv=0A=
=0A=
2. After commit a8eb92d02dd7, dma_map_single() starting callingsync_for_dev=
ice( )=0A=
which as noted above didn't respect @dir, only doing cache wback, and thus =
would=0A=
fail for DMA_FROM_DEV/BIDIR cases where cpu needs to read from buffer and t=
hus=0A=
requires cache inv as well. Likewise dma_unmap_single() would unconditional=
ly do=0A=
cache inv, given usage of sync_for_cpu() which would be wrong for the TO_DE=
VICE cases.=0A=
=0A=
Too bad I didn't spot this in the code review myself at the time.=0A=
=0A=
-Vineet=0A=
=0A=
=0A=
=0A=
=0A=
