From: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>
Subject: Re: [PATCH 03/14] docs: fix references for DMA*.txt files
Date: Fri, 15 May 2020 11:54:38 -0600
Message-ID: <20200515115438.52c119d7@lwn.net>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
 <0539f4b4b442dba92358b6c8d9e8fb5eafcec693.1588345503.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <0539f4b4b442dba92358b6c8d9e8fb5eafcec693.1588345503.git.mchehab+huawei-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: Mauro Carvalho Chehab <mchehab+huawei-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, linux-ia64-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Doc Mailing List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Akira Yokosawa <akiyks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Safonov <0x7f454c46-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "H. Peter Anvin" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, Joel Fernandes <joel-QYYGw3jwrUn5owFQY34kdNi2O/JbrIOy@public.gmane.org>, Will Deacon <will-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>, Logan Gunthorpe <logang-OTvnGxWRz7hWk0Htik3J/w@public.gmane.org>, Helge Deller <deller-Mmb7MZpHnFY@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Allison Randal <allison-wcfNWazeolPR7s880joybQ@public.gmane.org>, Jade Alglave <j.alglave-hclig2XLE9Zaa/9Udqfwiw@public.gmane.org>, Daniel Lustig <dlustig-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Andrea Parri <parri.andrea-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fenghua Yu <fenghua.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Fri,  1 May 2020 17:37:47 +0200
Mauro Carvalho Chehab <mchehab+huawei-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> As we moved those files to core-api, fix references to point
> to their newer locations.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  Documentation/PCI/pci.rst                          |  6 +++---
>  Documentation/block/biodoc.rst                     |  2 +-
>  Documentation/core-api/bus-virt-phys-mapping.rst   |  2 +-
>  Documentation/core-api/dma-api.rst                 |  6 +++---
>  Documentation/core-api/dma-isa-lpc.rst             |  2 +-
>  Documentation/driver-api/usb/dma.rst               |  6 +++---
>  Documentation/memory-barriers.txt                  |  6 +++---
>  .../translations/ko_KR/memory-barriers.txt         |  6 +++---
>  arch/ia64/hp/common/sba_iommu.c                    | 12 ++++++------
>  arch/parisc/kernel/pci-dma.c                       |  2 +-
>  arch/x86/include/asm/dma-mapping.h                 |  4 ++--
>  arch/x86/kernel/amd_gart_64.c                      |  2 +-
>  drivers/parisc/sba_iommu.c                         | 14 +++++++-------
>  include/linux/dma-mapping.h                        |  2 +-
>  include/media/videobuf-dma-sg.h                    |  2 +-
>  kernel/dma/debug.c                                 |  2 +-
>  16 files changed, 38 insertions(+), 38 deletions(-)

...of course, not applying patch 2 causes this one to not apply, so
holding off for now...

jon
