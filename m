From: Christoph Hellwig <hch@lst.de>
Subject: scatterlist arch cleanups
Date: Fri,  9 Nov 2018 10:00:06 +0100
Message-ID: <20181109090008.24150-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Remove leftovers, and switch the default on enabling SG chaining.
