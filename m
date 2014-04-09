From: Maarten Lankhorst <maarten.lankhorst@canonical.com>
Subject: [PATCH 0/2] Updates to fence api
Date: Wed, 09 Apr 2014 16:48:13 +0200
Message-ID: <20140409144239.26648.57918.stgit@patser>
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
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, ccross@google.com, linux-media@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The following series implements small updates to the fence api.
I've found them useful when implementing the fence API in ttm and i915.

The last patch enables RCU on top of the api. I've found this less
useful, but it was the condition on which Thomas Hellstrom was ok
with converting TTM to fence, so I had to keep it in.

If nobody objects I'll probably merge that patch through drm, because
some care is needed in ttm before it can flip the switch on rcu.

---

Maarten Lankhorst (2):
      reservation: update api and add some helpers
      [RFC] reservation: add suppport for read-only access using rcu
