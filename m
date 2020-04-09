Return-Path: <SRS0=Usf8=5Z=kvack.org=owner-linux-mm@kernel.org>
Date: Thu, 9 Apr 2020 08:45:46 +0100
From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 03/35] docs: fix broken references to text files
Message-ID: <20200409084546.51ecb701@why>
In-Reply-To: <2e12bf13355bd06748fed5d135fd4de3d94ad5fd.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
	<2e12bf13355bd06748fed5d135fd4de3d94ad5fd.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Alan Stern <stern@rowland.harvard.edu>, Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>, Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Daniel Lustig <dlustig@nvidia.com>, Federico Vaga <federico.vaga@vaga.pv.it>, Harry Wei <harryxiyou@gmail.com>, Alex Shi <alex.shi@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>, Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Miklos Szeredi <miklos@szeredi.hu>, Andrew Morton <akpm@linux-foundation.org>, Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, linux-mm@kvack.org, linux-rdma@vger.kernel.org, kvmarm@lists.cs.columbia.edu
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200409074546.7K_-DOfUAVV9L6lTkglaa1SUuVpaTYbRjSM9Je4vfBQ@z>

On Wed,  8 Apr 2020 17:45:55 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Several references got broken due to txt to ReST conversion.
> 
> Several of them can be automatically fixed with:
> 
> 	scripts/documentation-file-ref-check --fix
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org> # hwtracing/coresight/Kconfig
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/virt/kvm/arm/pvtime.rst                |  2 +-
>  virt/kvm/arm/vgic/vgic-mmio-v3.c                     |  2 +-
>  virt/kvm/arm/vgic/vgic.h                             |  4 ++--

Acked-by: Marc Zyngier <maz@kernel.org> # kvm/arm64

	M.
-- 
Jazz is not dead. It just smells funny...
