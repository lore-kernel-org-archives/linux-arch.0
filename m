From: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Subject: [PATCH 0/7] dma-buf synchronization patches
Date: Mon, 13 Jan 2014 13:31:20 +0100
Message-ID: <20140113122818.20574.34710.stgit@patser>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, ccross@google.com, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The following series implements fence and converts dma-buf and
android sync to use it. Patch 6 and 7 add support for polling
to dma-buf, blocking until all fences are signaled.

---

Maarten Lankhorst (7):
      sched: allow try_to_wake_up to be used internally outside of core.c
      fence: dma-buf cross-device synchronization (v16)
      seqno-fence: Hardware dma-buf implementation of fencing (v4)
      dma-buf: use reservation objects
      android: convert sync to fence api, v3
      reservation: add support for fences to enable cross-device synchronisation
      dma-buf: add poll support


 Documentation/DocBook/device-drivers.tmpl      |    3 
 drivers/base/Kconfig                           |    9 
 drivers/base/Makefile                          |    2 
 drivers/base/dma-buf.c                         |  124 +++
 drivers/base/fence.c                           |  465 ++++++++++++
 drivers/gpu/drm/drm_prime.c                    |    8 
 drivers/gpu/drm/exynos/exynos_drm_dmabuf.c     |    2 
 drivers/gpu/drm/i915/i915_gem_dmabuf.c         |    2 
 drivers/gpu/drm/nouveau/nouveau_drm.c          |    1 
 drivers/gpu/drm/nouveau/nouveau_gem.h          |    1 
 drivers/gpu/drm/nouveau/nouveau_prime.c        |    7 
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c      |    2 
 drivers/gpu/drm/radeon/radeon_drv.c            |    2 
 drivers/gpu/drm/radeon/radeon_prime.c          |    8 
 drivers/gpu/drm/ttm/ttm_object.c               |    2 
 drivers/media/v4l2-core/videobuf2-dma-contig.c |    2 
 drivers/staging/android/Kconfig                |    1 
 drivers/staging/android/Makefile               |    2 
 drivers/staging/android/sw_sync.c              |    4 
 drivers/staging/android/sync.c                 |  895 ++++++++----------------
 drivers/staging/android/sync.h                 |   85 +-
 drivers/staging/android/sync_debug.c           |  245 +++++++
 drivers/staging/android/trace/sync.h           |   12 
 include/drm/drmP.h                             |    2 
 include/linux/dma-buf.h                        |   21 -
 include/linux/fence.h                          |  329 +++++++++
 include/linux/reservation.h                    |   18 
 include/linux/seqno-fence.h                    |  109 +++
 include/linux/wait.h                           |    1 
 include/trace/events/fence.h                   |  125 +++
 kernel/sched/core.c                            |    2 
 31 files changed, 1825 insertions(+), 666 deletions(-)
 create mode 100644 drivers/base/fence.c
 create mode 100644 drivers/staging/android/sync_debug.c
 create mode 100644 include/linux/fence.h
 create mode 100644 include/linux/seqno-fence.h
 create mode 100644 include/trace/events/fence.h

-- 
Signature
