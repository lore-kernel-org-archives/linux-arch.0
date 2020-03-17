From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH 08/12] docs: fix broken references to text files
Date: Tue, 17 Mar 2020 10:25:57 -0300
Message-ID: <20200317132557.GS20941@ziepe.ca>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
 <35dcbefd50875b92aaf5b7671d4c57c50b4274fe.1584450500.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
Content-Disposition: inline
In-Reply-To: <35dcbefd50875b92aaf5b7671d4c57c50b4274fe.1584450500.git.mchehab+huawei@kernel.org>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: kvm@vger.kernel.org, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Akira Yokosawa <akiyks@gmail.com>, dri-devel@lists.freedesktop.org, linux-unionfs@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>, linux-mm@kvack.org, Harry Wei <harryxiyou@gmail.com>, Alex Shi <alex.shi@linux.alibaba.com>, Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-rdma@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org, David Airlie <airlied@linux.ie>, Doug Ledford <dledford@redhat.com>, Alan Stern <stern@rowland.harvard.edu>, linux-arm-kernel@lists.infradead.org, Federico Vaga <federico.vaga@vaga.pv.it>, Jade Alglave <j.alglave@ucl.ac.uk>, Daniel Lustig <dlustig@nvidia.com>, Mike Leach <mike>
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 17, 2020 at 02:10:47PM +0100, Mauro Carvalho Chehab wrote:
> Several references got broken due to txt to ReST conversion.
> 
> Several of them can be automatically fixed with:
> 
> 	scripts/documentation-file-ref-check --fix
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>  Documentation/admin-guide/kernel-parameters.txt      |  2 +-
>  Documentation/memory-barriers.txt                    |  2 +-
>  Documentation/process/submit-checklist.rst           |  2 +-
>  .../translations/it_IT/process/submit-checklist.rst  |  2 +-
>  Documentation/translations/ko_KR/memory-barriers.txt |  2 +-
>  .../translations/zh_CN/filesystems/sysfs.txt         |  2 +-
>  .../translations/zh_CN/process/submit-checklist.rst  |  2 +-
>  Documentation/virt/kvm/arm/pvtime.rst                |  2 +-
>  Documentation/virt/kvm/devices/vcpu.rst              |  2 +-
>  Documentation/virt/kvm/hypercalls.rst                |  4 ++--
>  arch/powerpc/include/uapi/asm/kvm_para.h             |  2 +-
>  drivers/gpu/drm/Kconfig                              |  2 +-
>  drivers/gpu/drm/drm_ioctl.c                          |  2 +-
>  drivers/hwtracing/coresight/Kconfig                  |  2 +-
>  fs/fat/Kconfig                                       |  8 ++++----
>  fs/fuse/Kconfig                                      |  2 +-
>  fs/fuse/dev.c                                        |  2 +-
>  fs/overlayfs/Kconfig                                 |  6 +++---
>  include/linux/mm.h                                   |  4 ++--
>  include/uapi/linux/ethtool_netlink.h                 |  2 +-
>  include/uapi/rdma/rdma_user_ioctl_cmds.h             |  2 +-

For the rdma files

Acked-by: Jason Gunthorpe <jgg@mellanox.com>

Jason
