Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from imap1.codethink.co.uk ([176.9.8.82]:50558 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeCHQNt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Mar 2018 11:13:49 -0500
Message-ID: <1520525627.23626.53.camel@codethink.co.uk>
Subject: [stable] nospec: Kill array_index_nospec_mask_check()
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Thu, 08 Mar 2018 16:13:47 +0000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org

Based on the commit message, I think this needs to be backported to
stable branches:

commit 1d91c1d2c80cb70e2e553845e278b87a960c04da
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Fri Feb 16 13:20:42 2018 -0800

    nospec: Kill array_index_nospec_mask_check()

Is that right?

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
