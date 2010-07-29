From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Subject: [PATCH -mm 0/2] Documentation: DMA API updates
Date: Thu, 29 Jul 2010 19:45:06 +0900
Message-ID: <1280400308-16114-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, fujita.tomonori@lab.ntt.co.jp
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

The first patch adds the description of how to support multiple types
of IOMMUs (i.e. include/asm-generic/dma-mapping-common.h).

The second patch adds PCI DMA unamp state API to
feature-removal-schedule.txt. It was replaced with the DMA unamp state
API (which can be used for any bus). There is no users of PCI DMA
unamp state API in linux-next. August 2012 is long enough, I suppose.

=
 Documentation/DMA-API-HOWTO.txt            |   10 ++++++++++
 Documentation/feature-removal-schedule.txt |    9 +++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)
