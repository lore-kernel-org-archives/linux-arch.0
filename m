From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 19/28] gpu/drm: remove the powerpc hack in
 drm_legacy_sg_alloc
Date: Fri, 10 Apr 2020 08:56:41 +1000
Message-ID: <0f360b9cb72b80bae0d0db8150f65598c2776268.camel@kernel.crashing.org>
References: <20200408115926.1467567-1-hch@lst.de>
 <20200408115926.1467567-20-hch@lst.de>
 <20200408122504.GO3456981@phenom.ffwll.local>
 <eb48f7b6327e482ea9911b129210c0417ab48345.camel@kernel.crashing.org>
 <CAKMK7uHtkLvdsWFGiAtkzVa5mpnDvXkn3CHZQ6bgJ_enbyAc8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <CAKMK7uHtkLvdsWFGiAtkzVa5mpnDvXkn3CHZQ6bgJ_enbyAc8A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Daniel Vetter <daniel@ffwll.ch>
Cc: linux-hyperv@vger.kernel.org, David Airlie <airlied@linux.ie>, dri-devel <dri-devel@lists.freedesktop.org>, Linux MM <linux-mm@kvack.org>, "K. Y. Srinivasan" <kys@microsoft.com>, Sumit Semwal <sumit.semwal@linaro.org>, "open list:GENERIC INCLUDE/A..." <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, X86 ML <x86@kernel.org>, Christoph Hellwig <hch@lst.de>, Peter Zijlstra <peterz@infradead.org>, Laura Abbott <labbott@redhat.com>, Nitin Gupta <ngupta@vflare.org>, Haiyang Zhang <haiyangz@microsoft.com>, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, bpf <bpf@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Christophe Leroy <christophe.leroy@c-s.fr>, Robin Murphy <robin.murphy@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, 2020-04-09 at 11:41 +0200, Daniel Vetter wrote:
> Now if these boxes didn't ever have agp then I think we can get away
> with deleting this, since we've already deleted the legacy radeon
> driver. And that one used vmalloc for everything. The new kms one does
> use the dma-api if the gpu isn't connected through agp

Definitely no AGP there.

Cheers
Ben.
