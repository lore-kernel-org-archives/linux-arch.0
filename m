Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750830AbdK3IYH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 Nov 2017 03:24:07 -0500
Date: Thu, 30 Nov 2017 09:24:05 +0100
From: Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v2] mmap.2: document new MAP_FIXED_SAFE flag
Message-ID: <20171130082405.b77eknaiblgmpa4s@dhcp22.suse.cz>
References: <20171129144219.22867-1-mhocko@kernel.org>
 <20171129144524.23518-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129144524.23518-1-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: linux-api@vger.kernel.org, Khalid Aziz <khalid.aziz@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Andrew Morton <akpm@linux-foundation.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Andrea Arcangeli <aarcange@redhat.com>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, Florian Weimer <fweimer@redhat.com>, John Hubbard <jhubbard@nvidia.com>
Message-ID: <20171130082405.-4PJlPq3dv0NHq8cVwRY9CPvV_RF50iLk0Mz3ckRKyc@z>

Updated version based on feedback from John.
---
