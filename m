From: Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 03/35] docs: fix broken references to text files
Date: Thu, 9 Apr 2020 08:45:46 +0100
Message-ID: <20200409084546.51ecb701@why>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
 <2e12bf13355bd06748fed5d135fd4de3d94ad5fd.1586359676.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
In-Reply-To: <2e12bf13355bd06748fed5d135fd4de3d94ad5fd.1586359676.git.mchehab+huawei@kernel.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane-mx.org@lists.ozlabs.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: kvm@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Akira Yokosawa <akiyks@gmail.com>, dri-devel@lists.freedesktop.org, linux-unionfs@vger.kernel.org, linux-mm@kvack.org, Harry Wei <harryxiyou@gmail.com>, Alex Shi <alex.shi@linux.alibaba.com>, Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org, kvm-ppc@vger.kernel.org, David Airlie <airlied@linux.ie>, Doug Ledford <dledford@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, linux-arm-kernel@lists.infradead.org, Federico Vaga <federico.vaga@vaga.pv.it>, Jade Alglave <j.alglave@ucl.ac.uk>, Daniel Lustig <dlustig@nvidia.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Mike Leach <mike.leach@linaro.org>, Andrea Parri <parri.andrea>
List-Id: linux-arch.vger.kernel.org

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
