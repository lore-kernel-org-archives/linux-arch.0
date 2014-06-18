From: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Subject: [REPOST PATCH 0/8] fence synchronization patches
Date: Wed, 18 Jun 2014 12:36:46 +0200
Message-ID: <20140618102957.15728.43525.stgit@patser>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: gregkh@linuxfoundation.org
Cc: linux-arch@vger.kernel.org, thellstrom@vmware.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, ccross@google.com, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The following series implements fence and converts dma-buf and
android sync to use it. Patch 5 and 6 add support for polling
to dma-buf, blocking until all fences are signaled.
Patch 7 and 8 provide some helpers, and allow use of RCU in the
reservation api. The helpers make it easier to convert ttm, and
make dealing with rcu less painful.

Patches slightly updated to fix compilation with armada and
new atomic primitives, but otherwise identical.

---

Maarten Lankhorst (8):
      fence: dma-buf cross-device synchronization (v17)
      seqno-fence: Hardware dma-buf implementation of fencing (v5)
      dma-buf: use reservation objects
      android: convert sync to fence api, v5
      reservation: add support for fences to enable cross-device synchronisation
      dma-buf: add poll support, v3
      reservation: update api and add some helpers
      reservation: add suppport for read-only access using rcu


 Documentation/DocBook/device-drivers.tmpl      |    3 
 drivers/base/Kconfig                           |    9 
 drivers/base/Makefile                          |    2 
 drivers/base/dma-buf.c                         |  168 ++++
 drivers/base/fence.c                           |  468 ++++++++++++
 drivers/base/reservation.c                     |  440 ++++++++++++
 drivers/gpu/drm/armada/armada_gem.c            |    2 
 drivers/gpu/drm/drm_prime.c                    |    8 
 drivers/gpu/drm/exynos/exynos_drm_dmabuf.c     |    2 
 drivers/gpu/drm/i915/i915_gem_dmabuf.c         |    3 
 drivers/gpu/drm/nouveau/nouveau_drm.c          |    1 
 drivers/gpu/drm/nouveau/nouveau_gem.h          |    1 
 drivers/gpu/drm/nouveau/nouveau_prime.c        |    7 
 drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c      |    2 
 drivers/gpu/drm/radeon/radeon_drv.c            |    2 
 drivers/gpu/drm/radeon/radeon_prime.c          |    8 
 drivers/gpu/drm/tegra/gem.c                    |    2 
 drivers/gpu/drm/ttm/ttm_object.c               |    2 
 drivers/media/v4l2-core/videobuf2-dma-contig.c |    2 
 drivers/staging/android/Kconfig                |    1 
 drivers/staging/android/Makefile               |    2 
 drivers/staging/android/ion/ion.c              |    3 
 drivers/staging/android/sw_sync.c              |    6 
 drivers/staging/android/sync.c                 |  913 ++++++++----------------
 drivers/staging/android/sync.h                 |   79 +-
 drivers/staging/android/sync_debug.c           |  247 ++++++
 drivers/staging/android/trace/sync.h           |   12 
 include/drm/drmP.h                             |    3 
 include/linux/dma-buf.h                        |   21 -
 include/linux/fence.h                          |  355 +++++++++
 include/linux/reservation.h                    |   82 ++
 include/linux/seqno-fence.h                    |  119 +++
 include/trace/events/fence.h                   |  128 +++
 33 files changed, 2435 insertions(+), 668 deletions(-)
 create mode 100644 drivers/base/fence.c
 create mode 100644 drivers/staging/android/sync_debug.c
 create mode 100644 include/linux/fence.h
 create mode 100644 include/linux/seqno-fence.h
 create mode 100644 include/trace/events/fence.h

-- 
Signature
