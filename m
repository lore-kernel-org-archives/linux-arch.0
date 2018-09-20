Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from exmail.andestech.com ([59.124.169.137]:45070 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeITI2J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 04:28:09 -0400
From: Vincent Chen <vincentc@andestech.com>
Subject: [PATCH 2/5] nds32: Support FP emulation
Date: Thu, 20 Sep 2018 10:46:19 +0800
Message-ID: <1537411582-23723-3-git-send-email-vincentc@andestech.com>
In-Reply-To: <1537411582-23723-1-git-send-email-vincentc@andestech.com>
References: <1537411582-23723-1-git-send-email-vincentc@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, deanbo422@gmail.com, vincentc@andestech.com
Message-ID: <20180920024619.tkTpYKXLg7pWoCRNxESAxk6AhzkdTA2NNUVQKndsD-s@z>

  Andes FPU hardware does not support denormalized number handling.
