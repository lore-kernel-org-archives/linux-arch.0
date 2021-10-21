Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFF5C433EF
	for <linux-arch@archiver.kernel.org>; Thu, 21 Oct 2021 18:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C15E761AA8
	for <linux-arch@archiver.kernel.org>; Thu, 21 Oct 2021 18:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhJUSRj (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 21 Oct 2021 14:17:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:33015 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229914AbhJUSRi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Oct 2021 14:17:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="229377369"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="229377369"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 11:15:19 -0700
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="527582103"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 11:15:19 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 0/2] Nuke PAGE_KERNEL_IO
Date:   Thu, 21 Oct 2021 11:15:09 -0700
Message-Id: <20211021181511.1533377-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Last user of PAGE_KERNEL_IO is the i915 driver. While removing it from
there as we seek to bring the driver to other architectures, Daniel
suggested that we could finish the cleanup and remove it altogether,
through the tip tree. So here I'm sending both commits needed for that.

Lucas De Marchi (2):
  drm/i915/gem: stop using PAGE_KERNEL_IO
  x86/mm: nuke PAGE_KERNEL_IO

 arch/x86/include/asm/fixmap.h             | 2 +-
 arch/x86/include/asm/pgtable_types.h      | 7 -------
 arch/x86/mm/ioremap.c                     | 2 +-
 arch/x86/xen/setup.c                      | 2 +-
 drivers/gpu/drm/i915/gem/i915_gem_pages.c | 4 ++--
 include/asm-generic/fixmap.h              | 2 +-
 6 files changed, 6 insertions(+), 13 deletions(-)

-- 
2.33.1

